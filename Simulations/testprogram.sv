// Currently Working on it to remove errors
`include "environment.sv"

program test(intf vif);
    Environment envir;
      initial begin
        envir = new(vif);
        envir.run();
    end
endprogram
