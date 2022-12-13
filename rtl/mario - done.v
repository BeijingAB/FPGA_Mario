module mario (
	input clk,
	input rst_n,
	
	// seven segment
	output [3:0] dig,
	output [7:0] seg,
	
	input [3:0] key,
	//	output reg [3:0] led


	// vga
	output vga_hs,
	output vga_vs,
	output [2:0] vga_rgb

);


wire locked;
wire sys_rst_n;
assign sys_rst_n = locked & rst_n;

// clk for vga driver
wire clk_25m;

parameter DELAY_10MS = 30'd500_000;
parameter BRICK_WIDTH = 40;
parameter MAP_MAX_LEN = 1000;
parameter MAX_JMP = 200; // max jmp height
parameter MARIO_SIZE = 32; // mario width and height

wire [31:0] mario_stay_r[31:0];
wire [31:0] mario_stay_g[31:0];
wire [31:0] mario_stay_b[31:0];

// Red color mario

assign mario_stay_r[0]  = 32'b00000000000000111111111111000000;
assign mario_stay_r[1]  = 32'b00000000000000111111111111000000;
assign mario_stay_r[2]  = 32'b00000000111111111111111111110000;
assign mario_stay_r[3]  = 32'b00000000111111111111111111110000;
assign mario_stay_r[4]  = 32'b00000000000011001111000000000000;
assign mario_stay_r[5]  = 32'b00000000000011001111000000000000;
assign mario_stay_r[6]  = 32'b00000000111111001111110011000000;
assign mario_stay_r[7]  = 32'b00000000111111001111110011000000;
assign mario_stay_r[8]  = 32'b00000011111100111111000011000000;
assign mario_stay_r[9]  = 32'b00000011111100111111000011000000;
assign mario_stay_r[10] = 32'b00000000000000001111111100000000;
assign mario_stay_r[11] = 32'b00000000000000001111111100000000;
assign mario_stay_r[12] = 32'b00000000001111111111111111000000;
assign mario_stay_r[13] = 32'b00000000001111111111111111000000;
assign mario_stay_r[14] = 32'b00000000000000000000110000000000;
assign mario_stay_r[15] = 32'b00000000000000000000110000000000;
assign mario_stay_r[16] = 32'b00000000000000110000110000000000;
assign mario_stay_r[17] = 32'b00000000000000110000110000000000;
assign mario_stay_r[18] = 32'b00000000000000111111110000000000;
assign mario_stay_r[19] = 32'b00000000000000111111110000000000;
assign mario_stay_r[20] = 32'b00000011110011111111111100111111;
assign mario_stay_r[21] = 32'b00000011110011111111111100111111;
assign mario_stay_r[22] = 32'b00000011111111111111111111111111;
assign mario_stay_r[23] = 32'b00000011111111111111111111111111;
assign mario_stay_r[24] = 32'b00000011111111111111111111111111;
assign mario_stay_r[25] = 32'b00000011111111111111111111111111;
assign mario_stay_r[26] = 32'b00000000001111111100111111110000;
assign mario_stay_r[27] = 32'b00000000001111111100111111110000;
assign mario_stay_r[28] = 32'b00000000000000000000000000000000;
assign mario_stay_r[29] = 32'b00000000000000000000000000000000;
assign mario_stay_r[30] = 32'b00000000000000000000000000000000;
assign mario_stay_r[31] = 32'b00000000000000000000000000000000;


// Green color mario 
assign mario_stay_g[0]  = 32'b11111111111111000000000000111111;
assign mario_stay_g[1]  = 32'b11111111111111000000000000111111;
assign mario_stay_g[2]  = 32'b11111111000000000000000000001111;
assign mario_stay_g[3]  = 32'b11111111000000000000000000001111;
assign mario_stay_g[4]  = 32'b11111111111111111111111111111111;
assign mario_stay_g[5]  = 32'b11111111111111111111111111111111;
assign mario_stay_g[6]  = 32'b11111111111111111111111111111111;
assign mario_stay_g[7]  = 32'b11111111111111111111111111111111;
assign mario_stay_g[8]  = 32'b11111111111111111111111111111111;
assign mario_stay_g[9]  = 32'b11111111111111111111111111111111;
assign mario_stay_g[10] = 32'b11111111111111111111111111111111;
assign mario_stay_g[11] = 32'b11111111111111111111111111111111;
assign mario_stay_g[12] = 32'b11111111111111111111111111111111;
assign mario_stay_g[13] = 32'b11111111111111111111111111111111;
assign mario_stay_g[14] = 32'b11111111111111111111001111111111;
assign mario_stay_g[15] = 32'b11111111111111111111001111111111;
assign mario_stay_g[16] = 32'b11111111111111001111001111111111;
assign mario_stay_g[17] = 32'b11111111111111001111001111111111;
assign mario_stay_g[18] = 32'b11111111111111000000001111111111;
assign mario_stay_g[19] = 32'b11111111111111000000001111111111;
assign mario_stay_g[20] = 32'b11111111111100110000110011111111;
assign mario_stay_g[21] = 32'b11111111111100110000110011111111;
assign mario_stay_g[22] = 32'b11111111111100000000000011111111;
assign mario_stay_g[23] = 32'b11111111111100000000000011111111;
assign mario_stay_g[24] = 32'b11111111110000000000000000111111;
assign mario_stay_g[25] = 32'b11111111110000000000000000111111;
assign mario_stay_g[26] = 32'b11111111110000000011000000001111;
assign mario_stay_g[27] = 32'b11111111110000000011000000001111;
assign mario_stay_g[28] = 32'b11111111111111111111111111111111;
assign mario_stay_g[29] = 32'b11111111111111111111111111111111;
assign mario_stay_g[30] = 32'b11111111111111111111111111111111;
assign mario_stay_g[31] = 32'b11111111111111111111111111111111;

// Blue color mario 
assign mario_stay_b[0]  = 32'b11111111111111000000000000111111;
assign mario_stay_b[1]  = 32'b11111111111111000000000000111111;
assign mario_stay_b[2]  = 32'b11111111000000000000000000001111;
assign mario_stay_b[3]  = 32'b11111111000000000000000000001111;
assign mario_stay_b[4]  = 32'b11111111111100000000000000001111;
assign mario_stay_b[5]  = 32'b11111111111100000000000000001111;
assign mario_stay_b[6]  = 32'b11111111000000000000000000000011;
assign mario_stay_b[7]  = 32'b11111111000000000000000000000011;
assign mario_stay_b[8]  = 32'b11111100000000000000000000000011;
assign mario_stay_b[9]  = 32'b11111100000000000000000000000011;
assign mario_stay_b[10] = 32'b11111111000000000000000000000011;
assign mario_stay_b[11] = 32'b11111111000000000000000000000011;
assign mario_stay_b[12] = 32'b11111111110000000000000000111111;
assign mario_stay_b[13] = 32'b11111111110000000000000000111111;
assign mario_stay_b[14] = 32'b11111111111111000000000000001111;
assign mario_stay_b[15] = 32'b11111111111111000000000000001111;
assign mario_stay_b[16] = 32'b11111111000000000000000000000011;
assign mario_stay_b[17] = 32'b11111111000000000000000000000011;
assign mario_stay_b[18] = 32'b11111100000000000000000000000000;
assign mario_stay_b[19] = 32'b11111100000000000000000000000000;
assign mario_stay_b[20] = 32'b11111100000000000000000000000000;
assign mario_stay_b[21] = 32'b11111100000000000000000000000000;
assign mario_stay_b[22] = 32'b11111100000000000000000000000000;
assign mario_stay_b[23] = 32'b11111100000000000000000000000000;
assign mario_stay_b[24] = 32'b11111100000000000000000000000000;
assign mario_stay_b[25] = 32'b11111100000000000000000000000000;
assign mario_stay_b[26] = 32'b11111111110000000011000000001111;
assign mario_stay_b[27] = 32'b11111111110000000011000000001111;
assign mario_stay_b[28] = 32'b11111111000000001111110000000011;
assign mario_stay_b[29] = 32'b11111111000000001111110000000011;
assign mario_stay_b[30] = 32'b11111100000000001111110000000000;
assign mario_stay_b[31] = 32'b11111100000000001111110000000000;


reg [2:0] rgb;
wire [9:0] x_loc;
wire [9:0] y_loc;

// x location to move mario
reg [9:0] base_x;
// fresh 100 times / sec to detect left and right
reg [29:0] key_tgr_cnt_dir;
// fresh 100 times / sec to detect jump
reg [29:0] key_tgr_cnt_jmp;
// jmp height
reg [9:0] jmp_height;
// if mario was jmp prev clk
reg was_jmp;
// mario reached heighest
reg reached_highest;
// mario x offset and y offset
wire [9:0] mario_x; // screen most left to right
wire [9:0] mario_y; // ground to up

assign mario_x = 160 + base_x + gnd_dist; // 160 mario initial position
assign mario_y = jmp_height;

// mario jump on a brick with offset height
reg [9:0] jmp_offset;
reg [9:0] jmp_offset_buf;

// stop mario to move forward certain direction
wire left_obstacle; // gnd_left, base_x
wire right_obstacle; // gnd_right, base_x
wire up_obstacle; // as release jmp key when jmp, jump not reached the highest point
wire down_obstacle; // start decreasing height, release jmp while increasing

assign left_obstacle = (mario_x == 8 * BRICK_WIDTH - MARIO_SIZE) && (mario_y >= 2 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 3 * BRICK_WIDTH) ||
							(mario_x == 10 * BRICK_WIDTH - MARIO_SIZE) && (mario_y >= 2 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 3 * BRICK_WIDTH) ||
							(mario_x == 12 * BRICK_WIDTH - MARIO_SIZE) && (mario_y >= 5 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 6 * BRICK_WIDTH) ||
							(mario_x == 19 * BRICK_WIDTH - MARIO_SIZE) && (mario_y >= 0 * BRICK_WIDTH) && (mario_y < 1 * BRICK_WIDTH) ||
							(mario_x == 20 * BRICK_WIDTH - MARIO_SIZE) && (mario_y >= 1 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 2 * BRICK_WIDTH) ||
							(mario_x == 21 * BRICK_WIDTH - MARIO_SIZE) && (mario_y >= 2 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 3 * BRICK_WIDTH);
							
assign right_obstacle = (mario_x == 9 * BRICK_WIDTH) && (mario_y >= 2 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 3 * BRICK_WIDTH) ||
								(mario_x == 13 * BRICK_WIDTH) && (mario_y >= 5 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 6 * BRICK_WIDTH) ||
								(mario_x == 15 * BRICK_WIDTH) && (mario_y >= 2 * BRICK_WIDTH - MARIO_SIZE) && (mario_y < 3 * BRICK_WIDTH) ||
								(mario_x == 22 * BRICK_WIDTH) && (mario_y >= 0 * BRICK_WIDTH) && (mario_y < 3 * BRICK_WIDTH);

assign up_obstacle = (mario_x >= 8 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 9 * BRICK_WIDTH) && (mario_y == 2 * BRICK_WIDTH - MARIO_SIZE)  ||
							(mario_x >= 10 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 15 * BRICK_WIDTH) && (mario_y == 2 * BRICK_WIDTH - MARIO_SIZE) ||
							(mario_x >= 12 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 13 * BRICK_WIDTH) && (mario_y == 5 * BRICK_WIDTH - MARIO_SIZE);

assign down_obstacle = (mario_x >= 8 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 9 * BRICK_WIDTH) && (mario_y == 3 * BRICK_WIDTH) ||
								(mario_x >= 10 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 15 * BRICK_WIDTH) && (mario_y == 3 * BRICK_WIDTH) ||
								(mario_x >= 12 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 13 * BRICK_WIDTH) && (mario_y == 6 * BRICK_WIDTH) ||
								(mario_x >= 19 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 20 * BRICK_WIDTH) && (mario_y == 1 * BRICK_WIDTH) ||
								(mario_x >= 20 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 21 * BRICK_WIDTH) && (mario_y == 2 * BRICK_WIDTH) ||
								(mario_x >= 21 * BRICK_WIDTH - MARIO_SIZE) && (mario_x < 22 * BRICK_WIDTH) && (mario_y == 3 * BRICK_WIDTH) ||
								(mario_x >= 0 * BRICK_WIDTH ) && (mario_x < 25 * BRICK_WIDTH) && (mario_y ==  0);
							
reg test_color;
// calculate mario move direction
always @ (posedge clk) begin
	if (!rst_n) begin
		test_color <= 0;
	end else begin
		if (was_jmp && (jmp_height < MAX_JMP + jmp_offset))
			test_color <= 0;
		else
			test_color <= 0;
	end
end


// use key 0 1 to control mario left and right
always @ (posedge clk) begin
	if (~rst_n) begin
		base_x <= 0;
		key_tgr_cnt_dir <= 0;
	end else begin
		if (key_tgr_cnt_dir == DELAY_10MS) begin
			key_tgr_cnt_dir <= 0;
			base_x <= (key_out[1] && (base_x < 320) && ~left_obstacle)
							? base_x + 1 : 
							((key_out[0] && (base_x > 0) && ~right_obstacle)
							? base_x - 1 : base_x);
		end else
			key_tgr_cnt_dir <= key_tgr_cnt_dir + 1;
	end
end

// use key 3 to jump mario
always @ (posedge clk) begin
	if (!rst_n) begin
		key_tgr_cnt_jmp <= 0;
		jmp_height <= 0;
		was_jmp <= 0;
		reached_highest <= 0;
		jmp_offset <= 0;
		jmp_offset_buf <= 0;
	end else begin
		if (key_tgr_cnt_jmp == DELAY_10MS) begin
			key_tgr_cnt_jmp <= 0;
			if (!was_jmp && jmp_height == jmp_offset && key_out[3])  begin // start jmp
				jmp_height <= jmp_height + 1;
				was_jmp <= 1;
			end else if (was_jmp && key_out[3] && (jmp_height < MAX_JMP + jmp_offset) && (~reached_highest) && ~up_obstacle) begin // increasing height not reach highest point
				jmp_height <= jmp_height + 1;
			end else if ((!key_out[3] || up_obstacle)) begin // release jmp button while increasing
				reached_highest <= 1;
				was_jmp <= 0;
				if (down_obstacle) begin
					if (key_out[3] && reached_highest == 0) begin
						jmp_offset <= jmp_offset_buf;
						
						
					end else begin
						
						
					end
					jmp_offset_buf <= jmp_height;
					jmp_height <= jmp_height;
				end else begin
					jmp_offset <= jmp_offset_buf;
					jmp_height <= jmp_height - 1;
					reached_highest <= 1;
				end
			end else if (key_out[3] && jmp_height == MAX_JMP + jmp_offset) begin // reach the highest point
				reached_highest <= 1;
				jmp_height <= jmp_height - 1;
			end else if (reached_highest) begin // start decreasing height
				if (down_obstacle) begin
					if (key_out[3]) begin
						jmp_offset <= jmp_offset_buf;
						reached_highest <= 0;
					end else begin
						
						reached_highest <= reached_highest;
					end
					jmp_offset_buf <= jmp_height;
					jmp_height <= jmp_height;
				end else begin
					jmp_offset <= jmp_offset_buf;	
					jmp_height <= jmp_height - 1;
				end
			end else if (reached_highest && jmp_height == jmp_offset) begin // decrease to the ground
				reached_highest <= 0;
			end else if (!key_out[3]) begin// release jmp button
				was_jmp <= 0;
			end
		end else
			key_tgr_cnt_jmp <= key_tgr_cnt_jmp + 1;
	end
end

// ground move left
wire gnd_left;
// ground move right
wire gnd_right;

assign gnd_left = key_out[1] && (base_x == 320) && ~left_obstacle;
assign gnd_right = key_out[0] && (base_x == 0) && ~right_obstacle;

// x direction offset of the brick, to move the background
reg [5:0] brick_offset;
// create interval of moving the brick
reg [29:0] brick_mov_cnt;
// distance gnd move to left
reg [9:0] gnd_dist;

// move brick gaps left or right by the offset of x direction of brick
always @ (posedge clk) begin
	if (!rst_n) begin
		brick_mov_cnt <= 0;
		gnd_dist <= 0;
	end else begin
		if (brick_mov_cnt == DELAY_10MS) begin
			brick_mov_cnt <= 0;
			if (gnd_right && gnd_dist > 0) begin
				if (gnd_dist > 0)
					gnd_dist <= gnd_dist - 1;
				else
					gnd_dist <= gnd_dist;
				if (brick_offset < BRICK_WIDTH - 1) // -1 to align with the block
					brick_offset <= brick_offset + 1;
				else
					brick_offset <= 0;
			end else if (gnd_left && gnd_dist < MAP_MAX_LEN -640 + 120 ) begin // 640 screen length, 120 mario intial offset
				if (gnd_dist < MAP_MAX_LEN - 640 + 120)
					gnd_dist <= gnd_dist + 1;
				else
					gnd_dist <= gnd_dist;
				if (brick_offset > 0 + 1)
					brick_offset <= brick_offset - 1;
				else
					brick_offset <= BRICK_WIDTH;
			end else
				brick_offset <= brick_offset;
		end else begin
			brick_mov_cnt <= brick_mov_cnt + 1;
			brick_offset <= brick_offset;
		end
	end
end


// draw the picture on the screen
always @ (*) begin
	if ((x_loc >= 160 + base_x) && (x_loc < 192 + base_x) && (y_loc >= 328 - jmp_height) && (y_loc < 360 - jmp_height)) begin // draw mario
		rgb[2] = mario_stay_r[y_loc - 328 + jmp_height ][x_loc - 160 - base_x];
		rgb[1] = mario_stay_g[y_loc - 328 + jmp_height ][x_loc - 160 - base_x];
		rgb[0] = mario_stay_b[y_loc - 328 + jmp_height ][x_loc - 160 - base_x];
		
		
		
	end else if (y_loc == 440 || y_loc == 400) begin// draw brick gaps, vertical
		rgb[2] = 0;
		rgb[1] = 1;
		rgb[0] = 0;
	end else if (((x_loc == 1 * BRICK_WIDTH+brick_offset) || (x_loc == 2 * BRICK_WIDTH+brick_offset) || (x_loc == 3 * BRICK_WIDTH+brick_offset) || (x_loc == 4 * BRICK_WIDTH+brick_offset) || 
					(x_loc == 5 * BRICK_WIDTH+brick_offset) || (x_loc == 6 * BRICK_WIDTH+brick_offset) || (x_loc == 7 * BRICK_WIDTH+brick_offset) || (x_loc == 8 * BRICK_WIDTH+brick_offset) || 
					(x_loc == 9 * BRICK_WIDTH+brick_offset) || (x_loc == 10 * BRICK_WIDTH+brick_offset) || (x_loc == 11 * BRICK_WIDTH+brick_offset) || (x_loc == 12 * BRICK_WIDTH+brick_offset) || 
					(x_loc == 13 * BRICK_WIDTH+brick_offset) || (x_loc == 14 * BRICK_WIDTH+brick_offset) || (x_loc == 15 * BRICK_WIDTH+brick_offset) || (x_loc == brick_offset)) && y_loc > 360 ) begin // draw brick gaps, horizontal
		rgb[2] = 0;
		rgb[1] = 1;
		rgb[0] = 0;	

		// draw brick in the air
	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;

	end else if ((x_loc >= 400 - gnd_dist) && (x_loc < 400 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
	end else if ((x_loc >= 440 - gnd_dist) && (x_loc < 440 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
	end else if ((x_loc >= 480 - gnd_dist) && (x_loc < 480 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
	end else if ((x_loc >= 520 - gnd_dist) && (x_loc < 520 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
	end else if ((x_loc >= 560 - gnd_dist) && (x_loc < 560 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;

	end else if ((x_loc >= 480 - gnd_dist) && (x_loc < 480 + BRICK_WIDTH - gnd_dist) && (y_loc >= 120) && (y_loc < 120 + BRICK_WIDTH)) begin rgb = 3'b100;

	end else if ((x_loc >= 760 - gnd_dist) && (x_loc < 760 + BRICK_WIDTH - gnd_dist) && (y_loc >= 320) && (y_loc < 320 + BRICK_WIDTH)) begin rgb = 3'b110;
	end else if ((x_loc >= 800 - gnd_dist) && (x_loc < 800 + BRICK_WIDTH - gnd_dist) && (y_loc >= 320) && (y_loc < 320 + BRICK_WIDTH)) begin rgb = 3'b110;
	end else if ((x_loc >= 800 - gnd_dist) && (x_loc < 800 + BRICK_WIDTH - gnd_dist) && (y_loc >= 280) && (y_loc < 280 + BRICK_WIDTH)) begin rgb = 3'b110;
	end else if ((x_loc >= 840 - gnd_dist) && (x_loc < 840 + BRICK_WIDTH - gnd_dist) && (y_loc >= 320) && (y_loc < 320 + BRICK_WIDTH)) begin rgb = 3'b110;
	end else if ((x_loc >= 840 - gnd_dist) && (x_loc < 840 + BRICK_WIDTH - gnd_dist) && (y_loc >= 280) && (y_loc < 280 + BRICK_WIDTH)) begin rgb = 3'b110;
	end else if ((x_loc >= 840 - gnd_dist) && (x_loc < 840 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b110;

//	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
//	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
//	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
//	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
//	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;
//	end else if ((x_loc >= 320 - gnd_dist) && (x_loc < 320 + BRICK_WIDTH - gnd_dist) && (y_loc >= 240) && (y_loc < 240 + BRICK_WIDTH)) begin rgb = 3'b100;

	// win flag
	end else if ((x_loc >= 995 - gnd_dist) && (x_loc < 1000 - gnd_dist) && (y_loc >= 120) && (y_loc < 360)) begin rgb = 3'b010;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	end else if (y_loc >= 360) begin // draw the ground
		rgb[2] = 1;
		rgb[1] = 0;
		rgb[0] = 0;
	end else begin // draw the sky
		rgb[2] = test_color;
		rgb[1] = 1;
		rgb[0] = 1;
	end
end

reg [30:0] cnt;
wire [5:0] num;

wire [3:0] key_out;
assign num = (key_out[0] ? 3 : (key_out[1] ? 4 : (key_out[2] ? 2 : (key_out[3] ? 1 : 0))));

reg [3:0] key_out_d; 
always @ (posedge clk) begin
	key_out_d <= key_out;
end
//always @ (posedge clk) begin
//	if (key_out_d != key_out)
//		led[0] <= ~led[0];
//	else
//		led[0] <= led[0];
//end


always @ (posedge clk) begin
	if (!rst_n)
		cnt <= 0;
	else begin
		if (cnt <= 31'd100_000_000)
			cnt <= cnt + 1;
		else
			cnt <= 0;
	end
end



disp u_disp (
	.clk (clk),
	.rst_n (rst_n),
	
	.state_no (num),
	
	.dig (dig),
	.seg (seg)
);

key u_key (
	.clk (clk),
	.rst_n (rst_n),
	
	.key_in (key),
	.key_out (key_out)
);

pll	pll_inst (
	.areset ( ~rst_n ),
	.inclk0 ( clk ),
	.c0 ( c0_sig ),
	.c1 ( clk_25m ),
	.locked ( locked )
	);
	


//assign rgb[0] = x_loc >= 320 ? 1 : 0;
//assign rgb[1] = ((x_loc >= 160) && (x_loc < 320)) || ((x_loc >= 480) && (x_loc < 640)) ? 1 : 0; 
//assign rgb[2] = ((x_loc >= 80) && (x_loc < 160)) || ((x_loc >= 240) && (x_loc < 320)) ||
//					((x_loc >= 400) && (x_loc < 480)) || ((x_loc >= 560) && (x_loc < 640))? 1 : 0; 



// ground
//assign rgb[2] = (y_loc >= 360) ? 1 : 0;

vga_driver u_vga_driver (
	.clk_vga (clk_25m),
	.rst_n (sys_rst_n),
	
	.rgb (rgb),
	.x (x_loc),
	.y (y_loc),
	
	.vga_hs (vga_hs),
	.vga_vs (vga_vs),
	.vga_rgb (vga_rgb)
);



endmodule