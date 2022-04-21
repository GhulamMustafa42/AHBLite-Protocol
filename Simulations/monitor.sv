`include "transaction.sv"


class monitor;
	transaction trans;
	mailbox mb_mon2scb;
	virtual intf.mon_port vif;

	//mailbox and virtual interface construct
	function new(mailbox mb_mon2scb,virtual intf vif);
		this.mb_mon2scb=mb_mon2scb;
		this.vif=vif;
	endfunction

        task run();
 
       		forever begin
      		trans = new();
		@(posedge vif.HCLK)begin 
      			 this.trans.HADDR      <=  vif.HADDR;
     			 this.trans.HWRITE    <=   vif.HWRITE;
     			 this.trans.HSIZE      <=   vif.HSIZE;
     			 this.trans.HTRANS     <=   vif.HTRANS;
    			 this.trans.HPROT     <=   vif.HPROT;
    			 this.trans.HSEL       <=   vif.HSEL;
     		 	 this.trans.HBURST    <=   vif.HBURST;
     		 	 this.trans.HWDATA    <=   vif.HWDATA;
    		 	 this.trans.HRDATA    <=  vif.HRDATA;
     		 	 this.trans.HRESP      <=   vif.HRESP;
     			 this.trans.HREADY     <=   vif.HREADY;
			 this.trans.HREADYOUT  <=  vif.HREADYOUT;
      		 	 mb_mon2scb.put(trans);
  			 end
		$display("Received from DUT and sent to scoreboard");
	         end
  	endtask 

endclass: monitor