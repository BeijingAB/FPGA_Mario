module key (
	input clk,
	input rst_n,
	
	// when key_in is 1, key is up
	input [3:0] key_in,
	// whey key_out is 1, key is activated
	output reg [3:0] key_out
);


// consider 50 MHz
parameter KEY_DELAY = 30'd500_000;
reg [29:0] delay_cnt;

// detect key state change
reg [3:0] key_in_d1;
reg [3:0] key_in_d2;

// detection key changed
reg key_changed;

// generate two delays
always @ (posedge clk) begin
	if (!rst_n) begin
		key_in_d1 <= 4'b0000;
		key_in_d2 <= 4'b0000;
	end
	else begin
		key_in_d1 <= key_in;
		key_in_d2 <= key_in_d1;
	end
end

// detect if key changes
always @ (posedge clk) begin
	if (!rst_n)
		key_changed <= 0;
	else begin
		if (key_in_d1 != key_in_d2)
			key_changed <= 1;
		else
			key_changed <= 0;
	end	
end

// delay timer count down when key presses
always @ (posedge clk) begin
	if (!rst_n)
		delay_cnt <= 0;
	else begin
		if (key_changed)
			delay_cnt <= KEY_DELAY;
		else if (delay_cnt > 0)
			delay_cnt <= delay_cnt - 1;
		else
			delay_cnt <= delay_cnt;
	end	
end

always @ (posedge clk) begin
	if (!rst_n)
		key_out <= 4'b0000;
	else begin
		if (delay_cnt == 1)
			key_out <= ~key_in;
		else
			key_out <= key_out;
	end
end

endmodule 