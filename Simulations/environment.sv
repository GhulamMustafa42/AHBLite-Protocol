`include "interface.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"

class environment;


    mailbox mb_gen2driver,mb_mon2scb;// mb_gen2driver,mb_mon2scb;
    intf f1(clock,HRESTn);
    virtual intf vif;
    generator gen;
    driver dr;
    monitor mon;
    scoreboard scb;
    bit read=0;
    bit write=1;


    mb_gen2driver=new(); //generator - driver mailbox
    mb_mon2scb=new(); //monitor - scoreboard mailbox
 
    gen=new(mb_gen2driver);
    

    dr=new(mb_gen2driver,vif);
    mon=new(mb_mon2scb,vif);
    scb=new(mb_mon2scb);

  task run ();
    fork
       gen.WRAP4(read);
       gen.INCR8(write);
       gen.INCR16(read);
       dr.run();
    join
    
    end
  
endclass: environment


