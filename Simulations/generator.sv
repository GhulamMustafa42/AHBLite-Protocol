
//`include "transaction.sv"

class generator;
	
	bit [31:0]addr;
	bit [31:0]data;
	bit readwrite;

	transaction trans;
	mailbox mb_gen2driver;
	
	//mailbox constructor
	function new(mailbox mb_gen2driver);	
		this.mb_gen2driver = mb_gen2driver;	
	endfunction

	
	task automatic INCR4(bit readwrite);
		bit check;
		bit [2:0] index; //increment in addresses
		bit [2:0] size; //HSIZE
		trans = new; 
		
		this.trans.HWRITE.rand_mode(0);
		this.trans.HWRITE = readwrite; 

		this.trans.HBURST.rand_mode(0);
		this.trans.HBURST = 3'b011; //4 beat Incrementing Burst
		
		this.trans.HTRANS.rand_mode(0);
		this.trans.HTRANS= 2'b10; //NONSEQ
     		
		check = trans.randomize();	
		
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to mailbox",trans.HADDR);
		size = this.trans.HSIZE;
		addr = this.trans.HADDR;
		

		repeat(3)	
      			begin
			trans=new;
			this.trans.HADDR.rand_mode(0);
			this.trans.HADDR=addr;	

			this.trans.HWRITE.rand_mode(0);
			this.trans.HWRITE = readwrite; 			

			this.trans.HBURST.rand_mode(0);
			this.trans.HBURST = 3'b011; //4 beat Incrementing Burst
      			
			this.trans.HSIZE.rand_mode(0);
			this.trans.HSIZE = size; 

			check=trans.randomize();
	
			case(trans.HSIZE)
				3'b000 : index = 1;
              			3'b001 : index = 2;
          			3'b010 : index = 4;
        		endcase 

			mb_gen2driver.put(trans);	
			addr=addr+index;
			this.trans.HADDR = addr;
			$display("Address:0x%0h HSIZE:%0d sent to mailbox",trans.HADDR, trans.HSIZE);
			end
	
		$display("All 4-beats in INCR4 burst sent to driver\n");
		endtask

	
	task automatic INCR8(bit readwrite);
		bit check;
		bit [2:0] index; //increment in addresses
		bit [2:0] size; //HSIZE
		trans=new; 
		
		this.trans.HWRITE.rand_mode(0);
		this.trans.HWRITE = readwrite; 

		this.trans.HBURST.rand_mode(0);
		this.trans.HBURST = 3'b101; //8 beat Incrementing Burst
		
		this.trans.HTRANS.rand_mode(0);
		this.trans.HTRANS= 2'b10; //NONSEQ
     		
		check=trans.randomize();	
		
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to mailbox",trans.HADDR);
		size=this.trans.HSIZE;
		addr=this.trans.HADDR;
		

		repeat(7)	
      			begin
			trans=new;
			this.trans.HADDR.rand_mode(0);
			this.trans.HADDR=addr;	

			this.trans.HWRITE.rand_mode(0);
			this.trans.HWRITE = readwrite; 			

			this.trans.HBURST.rand_mode(0);
			this.trans.HBURST = 3'b101; //8 beat Incrementing Burst
      			
			this.trans.HSIZE.rand_mode(0);
			this.trans.HSIZE = size; 
			
			check=trans.randomize();

			case(trans.HSIZE)
				3'b000 : index = 1;
              			3'b001 : index = 2;
          			3'b010 : index = 4;
        		endcase 

			mb_gen2driver.put(trans);	
			addr=addr+index;
			this.trans.HADDR = addr;
			$display("Address:0x%0h HSIZE:%0d sent to mailbox",trans.HADDR, trans.HSIZE);
			end
	
		$display("All 8-beats in INCR4 burst sent to driver\n");
		endtask

	task automatic INCR16(bit  readwrite);		
		bit check;
		bit [2:0] index; //increment in addresses
		bit [2:0] size; //HSIZE
		trans=new;  
		
		this.trans.HWRITE.rand_mode(0);
		this.trans.HWRITE = readwrite; 

		this.trans.HBURST.rand_mode(0);
		this.trans.HBURST = 3'b111; //16 beat Incrementing Burst
		
		this.trans.HTRANS.rand_mode(0);
		this.trans.HTRANS= 2'b10; //NONSEQ
     		
		check=trans.randomize();	
		
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to mailbox",trans.HADDR);
		size=this.trans.HSIZE;
		addr=this.trans.HADDR;

		repeat(15)	
      			begin
			trans=new;
			this.trans.HADDR.rand_mode(0);
			this.trans.HADDR=addr;	

			this.trans.HWRITE.rand_mode(0);
			this.trans.HWRITE = readwrite; 			

			this.trans.HBURST.rand_mode(0);
			this.trans.HBURST = 3'b111; //16 beat Incrementing Burst
      			
			this.trans.HSIZE.rand_mode(0);
			this.trans.HSIZE = size; 
			
			check=trans.randomize();

			case(trans.HSIZE)
				3'b000 : index = 1;
              			3'b001 : index = 2;
          			3'b010 : index = 4;
        		endcase 

			mb_gen2driver.put(trans);	
			addr=addr+index;
			this.trans.HADDR = addr;
			$display("Address:0x%0h HSIZE:%0d sent to mailbox",trans.HADDR, trans.HSIZE);
			end
	
		$display("All 16-beats in INCR16 burst sent to driver\n");
		endtask

	task automatic SINGLE_BURST(bit  readwrite);
		bit check;
		bit [2:0] index;
		trans=new; 
		
		this.trans.HWRITE.rand_mode(0);
		this.trans.HWRITE = readwrite; 

		this.trans.HBURST.rand_mode(0);
		this.trans.HBURST = 3'b000; //Single Burst
		
		this.trans.HTRANS.rand_mode(0);
		this.trans.HTRANS= 2'b10; //NONSEQ
     		
		check=trans.randomize();	
	       	 		
		mb_gen2driver.put(trans);

		$display("Address:0x%0h sent to mailbox\n",trans.HADDR);
		
		$display("Single Burst sent to driver\n");
		endtask
	

endclass: generator
