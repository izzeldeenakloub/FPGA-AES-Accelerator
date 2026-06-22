module addRoundKey(
    input  logic [7:0] stateIn  [0:3][0:3],
    input  logic [127:0] roundKey,
    output logic [7:0] stateOut [0:3][0:3]
);

    genvar row, col;

    generate
        for (col = 0; col < 4; col = col + 1) begin : col_loop
            for (row = 0; row < 4; row = row + 1) begin : row_loop

                assign stateOut[row][col] =
                    stateIn[row][col] ^
                    roundKey[127 - (32*col + 8*row) -: 8];

            end
        end
    endgenerate

endmodule