`line 2 "eleven_towers.tlv" 0
`line 114 "eleven_towers.tlv" 1



// Compete!
// This defines the competition to simulate (for development).
// When this file is included as a library (for competition), this code is ignored.
//_\SV
   // Include the Eleven Towers framework.
   // Included URL: "https://raw.githubusercontent.com/rweda/showdown-2026-eleven-towers/a7a75ffde289282804aae012bd1dcbef179adb78/eleven_towers_lib.tlv"
   // Include other opponent files (based on eleven_towers_[verilog_]template.tlv) using GitHub raw URLs (similar to eleven_towers_lib.tlv, above).
   // ...

   module top(input wire clk, input wire reset, input wire [31:0] cyc_cnt, output wire passed, output wire failed);    /* verilator lint_save */ /* verilator lint_off UNOPTFLAT */  bit [256:0] RW_rand_raw; bit [256+63:0] RW_rand_vect; pseudo_rand #(.WIDTH(257)) pseudo_rand (clk, reset, RW_rand_raw[256:0]); assign RW_rand_vect[256+63:0] = {RW_rand_raw[62:0], RW_rand_raw};  /* verilator lint_restore */  /* verilator lint_off WIDTH */ /* verilator lint_off UNOPTFLAT */
`include "eleven_towers_gen.sv" //_\TLV
   // Enlist players for the game.

   

   // Choose your opponent(s) (up to you + 4 opponents).
   // "random" and "seven" are example opponents defined in eleven_towers_lib.tlv.
   // To include code for other opponents, add a `include_lib` above.
   // Note that inactive players must be commented with "

   

   // Instantiate the Eleven Towers game.
   `line 296 "eleventowerslib.tlv" 1
      //_|game
         //_@1
            `line 303 "eleventowerslib.tlv" 1
               
            
               assign GAME_reset_a1 = reset;
            
               /*SV_plus*/
                  logic[3:0] max[12:2] = {4'd2, 4'd4, 4'd6, 4'd8, 4'd10, 4'd12, 4'd10, 4'd8, 4'd6, 4'd4, 4'd2};
                  logic[23:0] colors[0:4] = {24'hd01010, 24'hd0d010, 24'h109010, 24'h1010d0, 24'hd06010};
            
            
               // -------------------------
               // Game State
            
               // Which player's turn is it?
               assign GAME_next_player_a1[0:0] =
                    GAME_Player_a1 == 1 ? 1'd0 :
                                               GAME_Player_a1 + 1'd1;
               assign GAME_Player_a0[0:0] =
                    GAME_reset_a1                   ? 1'b0 :
                    GAME_ActivePlayer_turn_over_a1 ? GAME_next_player_a1 :
                                               GAME_Player_a1[0:0];
            
               //_/active_player
                  assign GAME_ActivePlayer_color_a1[23:0] = colors[GAME_Player_a1];
            
                  // Track rolls this turn
                  assign GAME_ActivePlayer_RollCnt_a0[7:0] = GAME_ActivePlayer_reset_a1 ? 8'b0 :
                                   GAME_ActivePlayer_turn_over_a1 ? 8'b0 :
                                                GAME_ActivePlayer_RollCnt_a1 + 8'b1;
            
                  for (tower = 2; tower <= 12; tower++) begin : L1_GAME_ActivePlayer_Tower //_/tower
                     /* Viz omitted here */






























































































































                     end
                  /* Viz omitted here */


            
               for (player = 0; player <= 1; player++) begin : L1_GAME_Player logic [3:0] L1_Tower_TurnStartFloor_a0 [12:2], L1_Tower_TurnStartFloor_a1 [12:2]; //_/player
                  for (tower = 2; tower <= 12; tower++) begin : L2_Tower logic L2_claimed_a1; logic [3:0] L2_tower_height_a1; //_/tower
                     assign GAME_Player_Tower_max_a1[player][tower][3:0] = max[tower];
                     assign L2_tower_height_a1[3:0] = max[tower] + 1;
                     // Track height at turn start (for progress assessment)
                     assign L1_Tower_TurnStartFloor_a0[tower][3:0] =
                          GAME_reset_a1 ? 4'b0 :
                          GAME_ActivePlayer_turn_over_a1 && GAME_next_player_a1 == player ? GAME_Player_Tower_Floor_a1[player][tower] :
                                        L1_Tower_TurnStartFloor_a1[tower][3:0];
                     assign GAME_Player_Tower_Floor_a0[player][tower][3:0] =
                          GAME_reset_a1 ? 4'b0 :
                          ! GAME_ActivePlayer_end_turn_a1 || GAME_ActivePlayer_bust_a1
                                      ? GAME_Player_Tower_Floor_a1[player][tower][3:0] :
                          // successful end-of-turn
                          GAME_Player_a1 == player  // for me
                                      ? L1b_GAME_ActivePlayer_Tower[tower].L1_my_next_climb_floor_a1 :
                          // for my opponent
                          L1b_GAME_ActivePlayer_Tower[tower].L1_my_next_climb_floor_a1 >= L2_tower_height_a1
                                      // and this tower is complete for them
                                      ? 4'b0 :
                          // and they did not complete this tower
                                        GAME_Player_Tower_Floor_a1[player][tower][3:0];
                     assign GAME_Player_Tower_floor_a1[player][tower][3:0] = GAME_Player_Tower_Floor_a1[player][tower];  // Just to avoid the need for users to understand state signals.
                     // Reached the max (claimed the tower).
                     assign L2_claimed_a1 = GAME_Player_Tower_Floor_a1[player][tower] == L2_tower_height_a1; end end
            
               // -------------------------
               // Dice
            
               // Four rolled dice values.
               for (die = 0; die <= 3; die++) begin : L1_GAME_Die logic [31:0] L1_rand_a1; //_/die
                  /*SV_plus*/
                     always_ff @(posedge clk) begin
                        L1_rand_a1[31:0] <= $random;
                     end
                  assign GAME_Die_value_a1[die][2:0] = L1_rand_a1[31:0] % 6 + 1;
                  /* Viz omitted here */






                  end
            
               // Possible die pairings:
               //   Pair: 0       1
               //   Die:0  1    0  1
               //   0: [0, 1], [2, 3]
               //   1: [0, 2], [1, 3]
               //   2: [0, 3], [1, 2]
               for (pairing = 0; pairing <= 2; pairing++) begin : L1_GAME_Pairing //_/pairing
                  for (pair = 0; pair <= 1; pair++) begin : L2_Pair logic [3:0] L2_climb_floor_a1; logic [3:0] L2_start_floor_a1; logic [3:0] L2_sum_a1; logic [3:0] L2_tower_height_a1; //_/pair
                     assign L2_sum_a1[3:0] = L3_Die[0].L3_value_a1 + L3_Die[1].L3_value_a1;
                     // Locked-in floor.
                     assign L2_start_floor_a1[3:0] = GAME_Player_Tower_Floor_a1[GAME_Player_a1][L2_sum_a1];
                     // Floor within turn.
                     assign L2_climb_floor_a1[3:0] = GAME_ActivePlayer_Tower_ClimbFloor_a1[L2_sum_a1];
                     assign L2_tower_height_a1[3:0] = max[L2_sum_a1] + 1;
                     // These may or may not be used by the players.
                     `BOGUS_USE(L2_start_floor_a1 L2_climb_floor_a1 L2_tower_height_a1)
                     for (die = 0; die <= 1; die++) begin : L3_Die logic [2:0] L3_value_a1; //_/die
                        assign L3_value_a1[2:0] = GAME_Die_value_a1[
                             pair == 0 ? pairing * die + die :
                             die == 0  ? (pairing == 0 ? 2 : 1) :
                                          (pairing == 2 ? 2 : 3)
                           ]; end end end
            
               /* Viz omitted here */
















































               `line 287 "eleventowerslib.tlv" 1
                  `line 252 "eleventowerslib.tlv" 1
                     //_/player0
                        assign GAME_Player0_reset_a1 = GAME_reset_a1;
                        // Game context (providing consistent access as pipesignals)
                        assign GAME_Player0_num_players_a1[2:0] = 2;
                        assign GAME_Player0_my_player_index_a1[0:0] = 0;
                        assign GAME_Player0_current_player_a1[0:0] = GAME_Player_a1;
                  
                        assign GAME_Player0_my_turn_a1 = 0 == GAME_Player_a1;
                        //_?$my_turn
                           assign {GAME_Player0_claimed_cnt_a1[2:0], GAME_Player0_climbing_cnt_a1[1:0], GAME_Player0_color_a1[23:0]} = {GAME_ActivePlayer_claimed_cnt_a1, GAME_ActivePlayer_climbing_cnt_a1, GAME_ActivePlayer_color_a1};
                           assign GAME_Player0_rolls_this_turn_a1[7:0] = GAME_ActivePlayer_RollCnt_a1;  // (pipesignal variant for consistency)
                        for (tower = 2; tower <= 12; tower++) begin : L1_GAME_Player0_Tower logic L1_claimed_a1; logic [3:0] L1_climb_floor_a1; logic L1_climbing_a1; logic [3:0] L1_floor_a1; logic L1_my_turn_a1; logic [3:0] L1_tower_height_a1; logic [3:0] L1_turn_start_floor_a1; //_/tower
                           assign L1_my_turn_a1 = GAME_Player0_my_turn_a1;
                           assign L1_turn_start_floor_a1[3:0] = L1_GAME_Player[0].L1_Tower_TurnStartFloor_a1[tower];  // (pipesignal variant for consistency)
                           //_?$my_turn
                              assign {L1_claimed_a1, L1_climbing_a1, L1_floor_a1[3:0], L1_tower_height_a1[3:0]} = {GAME_ActivePlayer_Tower_claimed_a1[tower], GAME_ActivePlayer_Tower_climbing_a1[tower], GAME_ActivePlayer_Tower_floor_a1[tower], GAME_ActivePlayer_Tower_tower_height_a1[tower]};
                              assign L1_climb_floor_a1[3:0] = GAME_ActivePlayer_Tower_ClimbFloor_a1[tower];
                              `BOGUS_USE(L1_floor_a1 L1_climb_floor_a1 L1_climbing_a1 L1_tower_height_a1 L1_turn_start_floor_a1 L1_claimed_a1) end   // (to make visible in DIAGRAM and avoid no-use warnings)
                        `BOGUS_USE(GAME_Player0_climbing_cnt_a1 GAME_Player0_claimed_cnt_a1 GAME_Player0_color_a1 GAME_Player0_rolls_this_turn_a1 GAME_Player0_num_players_a1 GAME_Player0_my_player_index_a1 GAME_Player0_current_player_a1)
                        `BOGUS_USE(GAME_Player0_reset_a1 GAME_Player0_my_turn_a1)
                        for (pairing = 0; pairing <= 2; pairing++) begin : L1_GAME_Player0_Pairing logic [15:0] L1_score16_a1; //_/pairing
                           //$ANY = |game/pairing$ANY;
                           for (pair = 0; pair <= 1; pair++) begin : L2_Pair logic [3:0] L2_sum_a1; //_/pair
                              assign {L2_sum_a1[3:0]} = {L1_GAME_Pairing[pairing].L2_Pair[pair].L2_sum_a1};
                              for (die = 0; die <= 1; die++) begin : L3_Die logic [2:0] L3_value_a1; //_/die
                                 assign {L3_value_a1[2:0]} = {L1_GAME_Pairing[pairing].L2_Pair[pair].L3_Die[die].L3_value_a1};
                                 `BOGUS_USE(L3_value_a1) end end
                           /* verilator lint_save */
                           /* verilator lint_off width */
                           assign L1_score16_a1[15:0] = L1b_GAME_Player0_Pairing[pairing].L1_score_a1; end
                           /* verilator lint_restore */
                        
                        `line 74 "eleven_towers.tlv" 1
                        
                           //-----------------------\
                           //  Your Code Goes Here  |
                           //-----------------------/
                        
                           // Example: Score each pairing randomly and end turn after 5 rolls
                           for (pairing = 0; pairing <= 2; pairing++) begin : L1b_GAME_Player0_Pairing logic [0:0] L1_priority_pair_a1; logic [15:0] L1_score_a1; //_/pairing
                              // Assign a score to each pairing (higher = better)
                              assign L1_score_a1[15:0] = 16'd0;  // Replace with your scoring logic
                        
                              // Which pair gets priority when only one can build
                              assign L1_priority_pair_a1[0:0] = 1'b0; end
                        
                           // Decide whether to end the turn
                           assign GAME_Player0_end_turn_a1 = 1'b1;  // Replace with your strategy
                        
                        
                           // [Optional]
                           // Custom visualization for debugging (appears to the right of game board)
                           /* Viz omitted here */




















                        //_\end_source
                        `line 285 "eleventowerslib.tlv" 2
                  
                  //_\end_source
                  `line 288 "eleventowerslib.tlv" 2
                  `line 252 "eleventowerslib.tlv" 1
                     //_/player1
                        assign GAME_Player1_reset_a1 = GAME_reset_a1;
                        // Game context (providing consistent access as pipesignals)
                        assign GAME_Player1_num_players_a1[2:0] = 2;
                        assign GAME_Player1_my_player_index_a1[0:0] = 1;
                        assign GAME_Player1_current_player_a1[0:0] = GAME_Player_a1;
                  
                        assign GAME_Player1_my_turn_a1 = 1 == GAME_Player_a1;
                        //_?$my_turn
                           assign {GAME_Player1_claimed_cnt_a1[2:0], GAME_Player1_climbing_cnt_a1[1:0], GAME_Player1_color_a1[23:0]} = {GAME_ActivePlayer_claimed_cnt_a1, GAME_ActivePlayer_climbing_cnt_a1, GAME_ActivePlayer_color_a1};
                           assign GAME_Player1_rolls_this_turn_a1[7:0] = GAME_ActivePlayer_RollCnt_a1;  // (pipesignal variant for consistency)
                        for (tower = 2; tower <= 12; tower++) begin : L1_GAME_Player1_Tower logic L1_claimed_a1; logic [3:0] L1_climb_floor_a1; logic L1_climbing_a1; logic [3:0] L1_floor_a1; logic L1_my_turn_a1; logic [3:0] L1_tower_height_a1; logic [3:0] L1_turn_start_floor_a1; //_/tower
                           assign L1_my_turn_a1 = GAME_Player1_my_turn_a1;
                           assign L1_turn_start_floor_a1[3:0] = L1_GAME_Player[1].L1_Tower_TurnStartFloor_a1[tower];  // (pipesignal variant for consistency)
                           //_?$my_turn
                              assign {L1_claimed_a1, L1_climbing_a1, L1_floor_a1[3:0], L1_tower_height_a1[3:0]} = {GAME_ActivePlayer_Tower_claimed_a1[tower], GAME_ActivePlayer_Tower_climbing_a1[tower], GAME_ActivePlayer_Tower_floor_a1[tower], GAME_ActivePlayer_Tower_tower_height_a1[tower]};
                              assign L1_climb_floor_a1[3:0] = GAME_ActivePlayer_Tower_ClimbFloor_a1[tower];
                              `BOGUS_USE(L1_floor_a1 L1_climb_floor_a1 L1_climbing_a1 L1_tower_height_a1 L1_turn_start_floor_a1 L1_claimed_a1) end   // (to make visible in DIAGRAM and avoid no-use warnings)
                        `BOGUS_USE(GAME_Player1_climbing_cnt_a1 GAME_Player1_claimed_cnt_a1 GAME_Player1_color_a1 GAME_Player1_rolls_this_turn_a1 GAME_Player1_num_players_a1 GAME_Player1_my_player_index_a1 GAME_Player1_current_player_a1)
                        `BOGUS_USE(GAME_Player1_reset_a1 GAME_Player1_my_turn_a1)
                        for (pairing = 0; pairing <= 2; pairing++) begin : L1_GAME_Player1_Pairing logic [15:0] L1_score16_a1; //_/pairing
                           //$ANY = |game/pairing$ANY;
                           for (pair = 0; pair <= 1; pair++) begin : L2_Pair logic [3:0] L2_sum_a1; //_/pair
                              assign {L2_sum_a1[3:0]} = {L1_GAME_Pairing[pairing].L2_Pair[pair].L2_sum_a1};
                              for (die = 0; die <= 1; die++) begin : L3_Die logic [2:0] L3_value_a1; //_/die
                                 assign {L3_value_a1[2:0]} = {L1_GAME_Pairing[pairing].L2_Pair[pair].L3_Die[die].L3_value_a1};
                                 `BOGUS_USE(L3_value_a1) end end
                           /* verilator lint_save */
                           /* verilator lint_off width */
                           assign L1_score16_a1[15:0] = L1b_GAME_Player1_Pairing[pairing].L1_score_a1; end
                           /* verilator lint_restore */
                        
                        `line 198 "eleventowerslib.tlv" 1
                           // Has any player claimed tower 7?
                           //_?$my_turn
                              assign GAME_Player1_claimed7_a1 = L1_GAME_Player1_Tower[7].L1_claimed_a1;
                              // Have I rolled a 7 pairing?
                              for (pairing = 0; pairing <= 2; pairing++) begin : L1b_GAME_Player1_Pairing logic [0:0] L1_priority_pair_a1; logic [0:0] L1_score_a1; logic [1:0] L1_Pair_is7_a1; //_/pairing
                                 for (pair = 0; pair <= 1; pair++) begin : L2b_Pair //_/pair
                                    assign L1_Pair_is7_a1[pair] = L1_GAME_Player1_Pairing[pairing].L2_Pair[pair].L2_sum_a1 == 4'd7; end
                                 assign L1_score_a1[0:0] = | L1_Pair_is7_a1 ^ GAME_Player1_claimed7_a1;
                                 assign L1_priority_pair_a1[0:0] = 1'b0; end
                              assign GAME_Player1_limit_a1[7:0] = GAME_Player1_claimed7_a1 ? 8'd3 : 8'd5;
                              assign GAME_Player1_end_turn_a1 = GAME_Player1_rolls_this_turn_a1 >= GAME_Player1_limit_a1 || (GAME_Player1_claimed7_a1 && L1_GAME_Player1_Tower[7].L1_climbing_a1);
                        
                           // Example custom visualization
                           /* Viz omitted here */




































                        //_\end_source
                        `line 285 "eleventowerslib.tlv" 2
                  
                  //_\end_source
                  `line 289 "eleventowerslib.tlv" 2
                  
                  
                  
               
               
               //_\end_source
               `line 583 "eleventowerslib.tlv" 2
            
               //_/active_player
                  assign {GAME_ActivePlayer_end_turn_a1, GAME_ActivePlayer_reset_a1} = GAME_Player_a1 == 0 ? {GAME_Player0_end_turn_a1, GAME_Player0_reset_a1} :  {GAME_Player1_end_turn_a1, GAME_Player1_reset_a1};
                  for (pairing = 0; pairing <= 2; pairing++) begin : L1_GAME_ActivePlayer_Pairing logic L1_better_than_next_a1; logic L1_equal_to_next_a1; //_/pairing
                     /* Viz omitted here */











                     assign {GAME_ActivePlayer_Pairing_priority_pair_a1[pairing][0:0], GAME_ActivePlayer_Pairing_score16_a1[pairing][15:0]} = GAME_Player_a1 == 0 ? {L1b_GAME_Player0_Pairing[pairing].L1_priority_pair_a1, L1_GAME_Player0_Pairing[pairing].L1_score16_a1} :  {L1b_GAME_Player1_Pairing[pairing].L1_priority_pair_a1, L1_GAME_Player1_Pairing[pairing].L1_score16_a1};
                     `BOGUS_USE(GAME_ActivePlayer_Pairing_score16_a1[pairing] GAME_ActivePlayer_Pairing_priority_pair_a1[pairing])
                     // Compare with next, giving priority
                     assign L1_better_than_next_a1 = GAME_ActivePlayer_Pairing_score16_a1[pairing] >  GAME_ActivePlayer_Pairing_score16_a1[(pairing + 1) % 3];
                     assign L1_equal_to_next_a1    = GAME_ActivePlayer_Pairing_score16_a1[pairing] == GAME_ActivePlayer_Pairing_score16_a1[(pairing + 1) % 3];
                     // Choice, prioritizing 0.
                     assign GAME_ActivePlayer_Pairing_chosen_a1[pairing] =
                        pairing == 0 ? (L1_GAME_ActivePlayer_Pairing[0].L1_better_than_next_a1 ||
                                         L1_GAME_ActivePlayer_Pairing[0].L1_equal_to_next_a1) &&
                                        ! L1_GAME_ActivePlayer_Pairing[2].L1_better_than_next_a1 :
                        pairing == 1 ? ! GAME_ActivePlayer_Pairing_chosen_a1[0] &&
                                        (L1_GAME_ActivePlayer_Pairing[1].L1_better_than_next_a1 ||
                                         L1_GAME_ActivePlayer_Pairing[1].L1_equal_to_next_a1) :
                                        ! GAME_ActivePlayer_Pairing_chosen_a1[0] &&
                                        ! GAME_ActivePlayer_Pairing_chosen_a1[1];
                     for (pair = 0; pair <= 1; pair++) begin : L2_Pair //_/pair
                        /* Viz omitted here */



                        assign {GAME_ActivePlayer_Pairing_Pair_sum_a1[pairing][pair][3:0]} = GAME_Player_a1 == 0 ? {L1_GAME_Player0_Pairing[pairing].L2_Pair[pair].L2_sum_a1} :  {L1_GAME_Player1_Pairing[pairing].L2_Pair[pair].L2_sum_a1};
                        `BOGUS_USE(GAME_ActivePlayer_Pairing_Pair_sum_a1[pairing][pair])
                        for (die = 0; die <= 1; die++) begin : L3_Die logic [2:0] L3_value_a1; //_/die
                           assign {L3_value_a1[2:0]} = GAME_Player_a1 == 0 ? {L1_GAME_Player0_Pairing[pairing].L2_Pair[pair].L3_Die[die].L3_value_a1} :  {L1_GAME_Player1_Pairing[pairing].L2_Pair[pair].L3_Die[die].L3_value_a1};
                           /* Viz omitted here */






                           end end end
                  assign GAME_ActivePlayer_chosen_pairing_a1[1:0] = GAME_ActivePlayer_Pairing_chosen_a1[0] ? 2'd0 :
                                         GAME_ActivePlayer_Pairing_chosen_a1[1] ? 2'd1 :
                                                                            2'd2;
                  //_/chosen_pairing
                     assign {GAME_ActivePlayer_ChosenPairing_priority_pair_a1[0:0]} = {GAME_ActivePlayer_Pairing_priority_pair_a1[GAME_ActivePlayer_chosen_pairing_a1]};
                     for (pair = 0; pair <= 1; pair++) begin : L1_GAME_ActivePlayer_ChosenPairing_Pair //_/pair
                        assign {GAME_ActivePlayer_ChosenPairing_Pair_sum_a1[pair][3:0]} = {GAME_ActivePlayer_Pairing_Pair_sum_a1[GAME_ActivePlayer_chosen_pairing_a1][pair]};
                        `BOGUS_USE(GAME_ActivePlayer_ChosenPairing_Pair_sum_a1[pair]) end
                  for (tower = 2; tower <= 12; tower++) begin : L1b_GAME_ActivePlayer_Tower logic L1_claim_a1; logic [3:0] L1_delta_a1; logic [3:0] L1_floor_plus_delta_a1; logic [3:0] L1_my_next_climb_floor_a1; logic L1_next_climbing_a1; logic [1:0] L1_ChosenPair_climb_a1; logic [1:0] L1_ChosenPair_new_priority_tower_a1; logic [1:0] L1_Player_claimed_a1; //_/tower
                     assign {GAME_ActivePlayer_Tower_Floor_a1[tower][3:0], GAME_ActivePlayer_Tower_floor_a1[tower][3:0], GAME_ActivePlayer_Tower_max_a1[tower][3:0]} = {GAME_Player_Tower_Floor_a1[GAME_Player_a1][tower], GAME_Player_Tower_floor_a1[GAME_Player_a1][tower], GAME_Player_Tower_max_a1[GAME_Player_a1][tower]};
                     assign GAME_ActivePlayer_Tower_tower_height_a1[tower][3:0] = max[tower] + 1;
                     // Blocked if any player has claimed it.
                     // Specifically for 2-player.
            
                     //   $ANY = |game/player[! |game$Player]/tower$ANY;
                     // Determine whether this tower is claimed.
                     for (player = 0; player <= 1; player++) begin : L2_Player //_/player
                        assign L1_Player_claimed_a1[player] = L1_GAME_Player[player].L2_Tower[tower].L2_claimed_a1; end
                     assign GAME_ActivePlayer_Tower_claimed_a1[tower] = | L1_Player_claimed_a1;
                     // TODO: Consider exposing $climb signal for bust prediction per pairing
                     // TODO: Could automatically exclude pairings that would bust
                     // Update height, incrementing +1 for each matching pair,
                     // then capping at max and switching on end turn.
                     for (chosen_pair = 0; chosen_pair <= 1; chosen_pair++) begin : L2_ChosenPair logic [3:0] L2_delta_a1; logic L2_matches_a1; logic L2_priority_a1; //_/chosen_pair
                        assign L2_matches_a1 = GAME_ActivePlayer_ChosenPairing_Pair_sum_a1[chosen_pair] == tower;
                        assign L2_delta_a1[3:0] = {3'b0, L2_matches_a1};
                        assign L2_priority_a1 = GAME_ActivePlayer_ChosenPairing_priority_pair_a1 == chosen_pair;
                        // This is a priority pair that claims a new tower.
                        assign L1_ChosenPair_new_priority_tower_a1[chosen_pair] =   L2_priority_a1 && L2_matches_a1 && ! GAME_ActivePlayer_Tower_claimed_a1[tower] && ! GAME_ActivePlayer_Tower_climbing_a1[tower] && GAME_ActivePlayer_climbing_cnt_a1                  != 2'd3;
                        // This pair causes this tower to grow.
                        assign L1_ChosenPair_climb_a1[chosen_pair] = L2_matches_a1 && ! GAME_ActivePlayer_Tower_claimed_a1[tower] &&
                                (GAME_ActivePlayer_Tower_climbing_a1[tower] || L1_ChosenPair_new_priority_tower_a1[chosen_pair] || GAME_ActivePlayer_active_climb_cnt_for_low_priority_a1 != 2'd3); end
                     assign GAME_ActivePlayer_Tower_new_priority_tower_a1[tower] = | L1_ChosenPair_new_priority_tower_a1;
                     assign GAME_ActivePlayer_Tower_climb_a1[tower] = | L1_ChosenPair_climb_a1;   // Either pair results in climbing.
                     assign L1_delta_a1[3:0] = L2_ChosenPair[0].L2_delta_a1 +
                                   L2_ChosenPair[1].L2_delta_a1;
                     assign L1_floor_plus_delta_a1[3:0] = GAME_ActivePlayer_Tower_ClimbFloor_a1[tower] + L1_delta_a1;
                     assign L1_my_next_climb_floor_a1[3:0] =
                          //$claimed
                          //     ? 4'b0 :
                          ! GAME_ActivePlayer_Tower_climb_a1[tower]
                               ? GAME_ActivePlayer_Tower_ClimbFloor_a1[tower] :
                          L1_floor_plus_delta_a1 >= GAME_ActivePlayer_Tower_tower_height_a1[tower]
                               ? GAME_ActivePlayer_Tower_tower_height_a1[tower] :
                                 L1_floor_plus_delta_a1;
                     assign L1_claim_a1 = L1_my_next_climb_floor_a1 == GAME_ActivePlayer_Tower_tower_height_a1[tower];
                     assign GAME_ActivePlayer_Tower_ClimbFloor_a0[tower][3:0] =
                          GAME_reset_a1              ? 4'b0 :
                          // If end turn, set floor for next player.
                          GAME_ActivePlayer_turn_over_a1 ? GAME_Player_Tower_Floor_a0[(GAME_Player_a1 + 1'd1) % 2][tower] :
                                                     L1_my_next_climb_floor_a1;
                     assign GAME_ActivePlayer_Tower_climbing_a1[tower] = GAME_ActivePlayer_Tower_ClimbFloor_a1[tower] != GAME_ActivePlayer_Tower_Floor_a1[tower];
                     assign L1_next_climbing_a1 = L1_my_next_climb_floor_a1 != GAME_ActivePlayer_Tower_Floor_a1[tower];   // (for VIZ only)
                     `BOGUS_USE(L1_next_climbing_a1)
                     // Count towers being actively built (max 3) and towers that are claimed (max 4), accumulating from tower 2 upward
                     assign GAME_ActivePlayer_Tower_active_climb_cnt_accum_a1[tower][1:0] =
                          {1'b0, GAME_ActivePlayer_Tower_climbing_a1[tower]} +
                          (tower == 2 ? 2'b0 : GAME_ActivePlayer_Tower_active_climb_cnt_accum_a1[tower == 2 ? 12 : tower - 1]);
                     assign GAME_ActivePlayer_Tower_claimed_tower_cnt_accum_a1[tower][2:0] =
                          {2'b0, L1_claim_a1} +
                          (tower == 2 ? 3'b0 : GAME_ActivePlayer_Tower_claimed_tower_cnt_accum_a1[tower == 2 ? 12 : tower - 1]); end
                  assign GAME_ActivePlayer_climbing_cnt_a1[1:0] = GAME_ActivePlayer_Tower_active_climb_cnt_accum_a1[12];
                  assign GAME_ActivePlayer_claimed_cnt_a1[2:0] = GAME_ActivePlayer_Tower_claimed_tower_cnt_accum_a1[12];
                  assign GAME_ActivePlayer_new_priority_tower_a1 = | GAME_ActivePlayer_Tower_new_priority_tower_a1;
                  // Active tower count including the current high-priority pair (for consideration by the low-priority pair).
                  assign GAME_ActivePlayer_active_climb_cnt_for_low_priority_a1[1:0] = GAME_ActivePlayer_climbing_cnt_a1 + {1'b0, GAME_ActivePlayer_new_priority_tower_a1};
                  assign GAME_ActivePlayer_win_a1 = GAME_ActivePlayer_claimed_cnt_a1[2:0] >= 3;
            
                  // Bust if no tower heights change.
                  assign GAME_ActivePlayer_bust_a1 = ! | GAME_ActivePlayer_Tower_climb_a1;
                  assign GAME_ActivePlayer_turn_over_a1 = GAME_ActivePlayer_end_turn_a1 || GAME_ActivePlayer_bust_a1;
            
                  /* Viz omitted here */


















            
               // --------------------
               // VIZ-Only
            
               for (header_player = 0; header_player <= 1; header_player++) begin : L1_GAME_HeaderPlayer //_/header_player
                  /* Viz omitted here */



























                  end
            
               //_/winner
                  // Determine which player won
                  assign GAME_Winner_won_a1 = GAME_ActivePlayer_win_a1;
                  assign GAME_Winner_winning_color_a1[23:0] = GAME_ActivePlayer_color_a1;
            
                  /* Viz omitted here */





















































            
               assign GAME_passed_a1 = GAME_Winner_won_a1;
               assign GAME_failed_a1 = cyc_cnt > 400;
            //_\end_source
            `line 299 "eleventowerslib.tlv" 2
            assign passed = GAME_passed_a1;
            assign failed = GAME_failed_a1;
   //_\end_source
   `line 141 "eleven_towers.tlv" 2
//_\SV
   endmodule

// This file must not exceed 6,000 lines. The expanded NAV-TLV code must not exceed 9,000 lines.


// Undefine macros defined by SandPiper (in "eleven_towers_gen.sv").
`undef BOGUS_USE
