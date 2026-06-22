import aes_pkg::*;

module subBytes(
    input  logic[7:0] arrayIn  [0:3][0:3],
    output logic[7:0] arrayOut [0:3][0:3]
);
    
    genvar i , j;
    generate
        for(i = 0; i < 4 ; i++) begin : row_loop
            for(j = 0; j < 4 ; j++) begin : col_loop
                assign arrayOut[i][j] = aes_sbox(arrayIn[i][j]);
            end 
        end
    endgenerate
endmodule