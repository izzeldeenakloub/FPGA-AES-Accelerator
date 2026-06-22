`timescale 1ns/1ps

module tb_AES;

    logic [7:0] plain  [0:3][0:3];
    logic [7:0] key    [0:3][0:3];
    logic [7:0] cipher [0:3][0:3];

    AES dut (
        .plain(plain),
        .key(key),
        .cipher(cipher)
    );

    initial begin
        // AES known test vector:
        // Plaintext = 00112233445566778899aabbccddeeff
        // Key       = 000102030405060708090a0b0c0d0e0f
        // Expected  = 69c4e0d86a7b0430d8cdb78070b4c55a

        // Load plaintext into AES state column-by-column
        plain[0][0] = 8'h00; plain[1][0] = 8'h11; plain[2][0] = 8'h22; plain[3][0] = 8'h33;
        plain[0][1] = 8'h44; plain[1][1] = 8'h55; plain[2][1] = 8'h66; plain[3][1] = 8'h77;
        plain[0][2] = 8'h88; plain[1][2] = 8'h99; plain[2][2] = 8'haa; plain[3][2] = 8'hbb;
        plain[0][3] = 8'hcc; plain[1][3] = 8'hdd; plain[2][3] = 8'hee; plain[3][3] = 8'hff;

        // Load key into AES key matrix column-by-column
        key[0][0] = 8'h00; key[1][0] = 8'h01; key[2][0] = 8'h02; key[3][0] = 8'h03;
        key[0][1] = 8'h04; key[1][1] = 8'h05; key[2][1] = 8'h06; key[3][1] = 8'h07;
        key[0][2] = 8'h08; key[1][2] = 8'h09; key[2][2] = 8'h0a; key[3][2] = 8'h0b;
        key[0][3] = 8'h0c; key[1][3] = 8'h0d; key[2][3] = 8'h0e; key[3][3] = 8'h0f;

        // Wait for combinational logic to settle
        #100;

        $display("Cipher output matrix:");
        $display("%02h %02h %02h %02h", cipher[0][0], cipher[0][1], cipher[0][2], cipher[0][3]);
        $display("%02h %02h %02h %02h", cipher[1][0], cipher[1][1], cipher[1][2], cipher[1][3]);
        $display("%02h %02h %02h %02h", cipher[2][0], cipher[2][1], cipher[2][2], cipher[2][3]);
        $display("%02h %02h %02h %02h", cipher[3][0], cipher[3][1], cipher[3][2], cipher[3][3]);

        $display("");
        $display("Cipher as 128-bit AES order:");
        $display("%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h%02h",
            cipher[0][0], cipher[1][0], cipher[2][0], cipher[3][0],
            cipher[0][1], cipher[1][1], cipher[2][1], cipher[3][1],
            cipher[0][2], cipher[1][2], cipher[2][2], cipher[3][2],
            cipher[0][3], cipher[1][3], cipher[2][3], cipher[3][3]
        );

        $display("");
        $display("Expected:");
        $display("69c4e0d86a7b0430d8cdb78070b4c55a");

        if ({
            cipher[0][0], cipher[1][0], cipher[2][0], cipher[3][0],
            cipher[0][1], cipher[1][1], cipher[2][1], cipher[3][1],
            cipher[0][2], cipher[1][2], cipher[2][2], cipher[3][2],
            cipher[0][3], cipher[1][3], cipher[2][3], cipher[3][3]
        } == 128'h69c4e0d86a7b0430d8cdb78070b4c55a) begin
            $display("TEST PASSED");
        end
        else begin
            $display("TEST FAILED");
        end

        $stop;
    end

endmodule