import aes_pkg::*;
module mixCol(
	input  logic[7:0] arrayIn  [0:3][0:3],
   output logic[7:0] arrayOut [0:3][0:3]
);
   

   genvar c;
   
   generate
      for(c = 0; c < 4; c++) begin : mix_col
         assign arrayOut[0][c] = mul2(arrayIn[0][c]) ^ mul3(arrayIn[1][c]) ^ arrayIn[2][c]       ^ arrayIn[3][c];
         assign arrayOut[1][c] = arrayIn[0][c]       ^ mul2(arrayIn[1][c]) ^ mul3(arrayIn[2][c]) ^ arrayIn[3][c];
         assign arrayOut[2][c] = arrayIn[0][c]       ^ arrayIn[1][c]       ^ mul2(arrayIn[2][c]) ^ mul3(arrayIn[3][c]);
         assign arrayOut[3][c] = mul3(arrayIn[0][c]) ^ arrayIn[1][c]       ^ arrayIn[2][c]       ^ mul2(arrayIn[3][c]);
      end
   endgenerate

endmodule