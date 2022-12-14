module disp (
	input clk,
	input rst_n,
	
	input [5:0] state_no,
	
	output [3:0] dig,
	output [7:0] seg

);

parameter IDLE = 6'd0;
parameter JUMP = 6'd1;
parameter SPEED = 6'd2;
parameter LEFT = 6'd3;
parameter RIGHT = 6'd4;

// indicate four seg
reg [5:0] num_0;
reg [5:0] num_1;
reg [5:0] num_2;
reg [5:0] num_3;

// display different char in seg
always @ (*) begin
	case (state_no)
		IDLE: begin
			num_3 <= 6'd19;
			num_2 <= 6'd14;
			num_1 <= 6'd22;
			num_0 <= 6'd15;
		end
		
		JUMP: begin
			num_3 <= 6'd20;
			num_2 <= 6'd31;
			num_1 <= 6'd23;
			num_0 <= 6'd26;
		end
		
		SPEED: begin
			num_3 <= 6'd29;
			num_2 <= 6'd26;
			num_1 <= 6'd15;
			num_0 <= 6'd14;
		end
		
		LEFT: begin
			num_3 <= 6'd22;
			num_2 <= 6'd15;
			num_1 <= 6'd16;
			num_0 <= 6'd30;
		end
		
		RIGHT: begin
			num_3 <= 6'd28;
			num_2 <= 6'd19;
			num_1 <= 6'd17;
			num_0 <= 6'd30;
		end
		
		default: begin
			num_3 <= 0;
			num_2 <= 0;
			num_1 <= 0;
			num_0 <= 0;
		end
	
	endcase
end



led u_led (
	.clk (clk),
	.rst_n (rst_n),
	
	.num_0 (num_0),
	.num_1 (num_1),
	.num_2 (num_2),
	.num_3 (num_3),
	
	.dig (dig),
	.seg (seg)
);

endmodule