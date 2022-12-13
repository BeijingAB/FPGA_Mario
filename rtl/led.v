module led (
	input clk,
	input rst_n,
	
	input [5:0] num_0,
	input [5:0] num_1,
	input [5:0] num_2,
	input [5:0] num_3,
	
	output reg [3:0] dig,
	output reg [7:0] seg

);

parameter FRESH_CNT_MAX = 28'd10_000;

// cnt to change to next digit
reg [27:0] fresh_cnt;

wire [5:0] num2disp;
assign num2disp = (~dig[0] ? num_0 : (~dig[1] ? num_1 : (~dig[2] ? num_2 : num_3)));


// counter for each digit
always @ (posedge clk) begin
	if (!rst_n)
		fresh_cnt <= 0;
	else begin
		if (fresh_cnt < FRESH_CNT_MAX) 
			fresh_cnt <= fresh_cnt + 1;
		else
			fresh_cnt <= 0;
	end
end

// change each digit
always @ (posedge clk) begin
	if ((!rst_n) || (dig == 0))
		dig <= 4'b1110;
	else begin
		if (fresh_cnt == FRESH_CNT_MAX) 
			dig <= {{dig[2:0]}, {dig[3]}};
		else
			dig <= dig;
	end
end

// Display segment
always @ (posedge clk) begin
	if (!rst_n)
		seg <= 8'b1111_1111;
	else begin
		case (num2disp)
			6'd0: seg <= 8'b1111_1111;
			6'd1: seg <= 8'b1111_1001;
			6'd2: seg <= 8'b1010_0100;
			6'd3: seg <= 8'b1011_0000;
			6'd4: seg <= 8'b1001_1001;
			6'd5: seg <= 8'b1001_0010;
			6'd6: seg <= 8'b1000_0010;
			6'd7: seg <= 8'b1111_1000;
			6'd8: seg <= 8'b1000_0000;
			6'd9: seg <= 8'b1001_0000;
			6'd10: seg <= 8'b1100_0000;
			6'd11: seg <= 8'b1000_1000;
			6'd12: seg <= 8'b1000_0011;
			6'd13: seg <= 8'b1100_0110;
			6'd14: seg <= 8'b1010_0001;
			6'd15: seg <= 8'b1000_0110;
			6'd16: seg <= 8'b1000_1110;
			6'd17: seg <= 8'b1001_0000;
			6'd18: seg <= 8'b1000_1001;
			6'd19: seg <= 8'b1111_1001;
			6'd20: seg <= 8'b1111_0001;
			6'd21: seg <= 8'b1000_0101;
			6'd22: seg <= 8'b1100_0111;
			6'd23: seg <= 8'b1010_1010;
			6'd24: seg <= 8'b1100_1000;
			6'd25: seg <= 8'b1010_0011;
			6'd26: seg <= 8'b1000_1100;
			6'd27: seg <= 8'b1001_1000;
			6'd28: seg <= 8'b1010_1111;
			6'd29: seg <= 8'b1001_0010;
			6'd30: seg <= 8'b1100_1110;
			6'd31: seg <= 8'b1100_0001;
			6'd32: seg <= 8'b1110_0011;
			6'd33: seg <= 8'b1001_0101;
			6'd34: seg <= 8'b1001_1011;
			6'd35: seg <= 8'b1001_0001;
			6'd36: seg <= 8'b1010_0100;
		endcase
	end
end




endmodule