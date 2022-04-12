

class driver;
	//transaction class (Packet class) instance
	transaction trans;
	mailbox  mb_gen2driver;

	//contructor
	function new(mailbox mb_g2d);
		this.mb_gen2driver = mb_g2d;	
	endfunction
	
	task get_INCR4();
		for (int i=0;i<4;i++) begin
		trans=new;
		mb_gen2driver.get(trans);
		$display("Address:0x%0h recieved",trans.HADDR);
		end	
	endtask
	
	task get_INCR8();
		for (int i=0;i<8;i++) begin
		trans=new;
		mb_gen2driver.get(trans);
		$display("Address:0x%0h recieved",trans.HADDR);
		end	
	endtask

	task get_INCR16();
		for (int i=0;i<16;i++) begin
		trans=new;
		mb_gen2driver.get(trans);
		$display("Address:0x%0h recieved",trans.HADDR);
		end	
	endtask


	task get_SINGLE_BURST(integer beats);
		for (int i=0;i<beats;i++) begin
		trans=new;
		mb_gen2driver.get(trans);
		$display("Address:0x%0h recieved",trans.HADDR);
		end	
	endtask

endclass: driver
