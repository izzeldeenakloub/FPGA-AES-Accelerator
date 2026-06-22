module aesFinalRound(
    input  logic [7:0] stateIn  [0:3][0:3],
    input  logic [127:0] roundKey,
    output logic [7:0] stateOut [0:3][0:3]
);

    logic [7:0] subArray   [0:3][0:3];
    logic [7:0] shiftArray [0:3][0:3];

    subBytes sb (
        .arrayIn(stateIn),
        .arrayOut(subArray)
    );

    shiftRow sr (
        .arrayIn(subArray),
        .arrayOut(shiftArray)
    );

    addRoundKey ark (
        .stateIn(shiftArray),
        .roundKey(roundKey),
        .stateOut(stateOut)
    );

endmodule