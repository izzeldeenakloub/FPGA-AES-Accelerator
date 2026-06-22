module AES(
    input  logic [7:0] plain  [0:3][0:3],
    input  logic [7:0] key    [0:3][0:3],
    output logic [7:0] cipher [0:3][0:3]
);

    logic [127:0] roundKey [0:10];

    
    logic [7:0] state [0:9][0:3][0:3];

    // Generate all 11 round keys
    keyExpansion ke (
        .key(key),
        .roundKey(roundKey)
    );

    // Initial AddRoundKey: state[0] = plain XOR roundKey[0]
    addRoundKey ark0 (
        .stateIn(plain),
        .roundKey(roundKey[0]),
        .stateOut(state[0])
    );

    // Rounds 1 to 9
    genvar r;
    generate
        for (r = 1; r <= 9; r = r + 1) begin : normal_rounds
            aesRound round_inst (
                .stateIn(state[r-1]),
                .roundKey(roundKey[r]),
                .stateOut(state[r])
            );
        end
    endgenerate

    // Final round: no MixColumns
    aesFinalRound final_round (
        .stateIn(state[9]),
        .roundKey(roundKey[10]),
        .stateOut(cipher)
    );

endmodule