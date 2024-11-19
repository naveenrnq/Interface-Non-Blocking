interface add_if;

  logic [3:0] a;// we are using logic because it supports both reg or wire.
  logic [3:0] b;
  logic [4:0] sum;
  logic clk;

endinterface


module tb;

  add_if aif(); // paranthesis mandatory

  //add dut(aif.a,aif.b,aif.sum);  //positional assignment

  add dut(.b(aif.b),.a(aif.a), .sum(aif.sum),.clk(aif.clk)); // mapping by name

  initial begin 
    aif.clk = 0;
  end

  always #10 aif.clk = ~ aif.clk;

  initial begin  // We will prefer non-blocking
    aif.a <= 4;
    aif.b <= 4;
    repeat(3)@(posedge aif.clk); //this value stays for specified clock cycles
    aif.a <= 3;
    #20;
    aif.a <= 4;
    #8;
    aif.a <= 5;
    #20;
    aif.a <= 6;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #100;
    $finish();
  end

endmodule
