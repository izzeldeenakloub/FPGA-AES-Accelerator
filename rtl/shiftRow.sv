module shiftRow(
    input  logic[7:0] arrayIn  [0:3][0:3],
    output logic[7:0] arrayOut [0:3][0:3]
);
	
	assign arrayOut[0][0] = arrayIn[0][0];
	assign arrayOut[0][1] = arrayIn[0][1];
	assign arrayOut[0][2] = arrayIn[0][2];
   assign arrayOut[0][3] = arrayIn[0][3];

   assign arrayOut[1][0] = arrayIn[1][1];
	assign arrayOut[1][1] = arrayIn[1][2];
	assign arrayOut[1][2] = arrayIn[1][3];
   assign arrayOut[1][3] = arrayIn[1][0];

   assign arrayOut[2][0] = arrayIn[2][2];
	assign arrayOut[2][1] = arrayIn[2][3];
	assign arrayOut[2][2] = arrayIn[2][0];
   assign arrayOut[2][3] = arrayIn[2][1];

   assign arrayOut[3][0] = arrayIn[3][3];
	assign arrayOut[3][1] = arrayIn[3][0];
	assign arrayOut[3][2] = arrayIn[3][1];
   assign arrayOut[3][3] = arrayIn[3][2];
	
endmodule