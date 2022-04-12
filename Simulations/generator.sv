

class generator;
	
	logic [31:0] addr;
	logic [31:0] data;
	logic wr_signal;

	transaction trans;
	mailbox  mb_gen2driver;
	
	//mailbox handler generator to driver
	function new(mailbox  mb_g2d);	
		this.mb_gen2driver = mb_g2d;	
	endfunction
	
	task INCR4(bit wr_data);		
		bit [2:0] add_size;
		trans=new; 
		this.trans.HADDR=addr;
		this.trans.HWDATA=data;
		this.trans.HBURST = 3'b011; //Incrementing Burst (4-beat)
       	 	this.trans.HWRITE = wr_data; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to driver\n",trans.HADDR);
	 		
		repeat(3)	
      			begin
			trans=new;
       			this.trans.HWRITE = wr_data; 
       			this.trans.HBURST = 3'b011; //Incrementing Burst (4-beat)
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = 3'b010; // HSIZE=word (04-bytes)
      			case(trans.HSIZE)
				3'b000 : add_size = 1;
              			3'b001 : add_size = 2;
          			3'b010 : add_size = 4;
        		endcase 
       			mb_gen2driver.put(trans);	
			addr=addr+add_size;
			this.trans.HADDR = addr;
			$display("Address:0x%0h sent to mailbox",trans.HADDR);
			end
	
		$display("All 4-beats in INCR4 burst sent to driver\n");
		endtask


	task INCR8(bit wr_data);		
		bit [2:0] add_size;
		trans=new; 
		this.trans.HADDR=addr;
		this.trans.HWDATA=data;
		this.trans.HBURST = 3'b101; //8 beat Incrementing Burst
       	 	this.trans.HWRITE = wr_data; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to driver\n",trans.HADDR);
	 		
		repeat(7)	
      			begin
			trans=new;
       			this.trans.HWRITE = wr_data; 
       			this.trans.HBURST = 3'b101; //8 beat Incrementing Burst
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = 3'b010; // HSIZE=word (32-bits)
      			case(trans.HSIZE)
				3'b000 : add_size = 1;
              			3'b001 : add_size = 2;
          			3'b010 : add_size = 4;
        		endcase 
       			mb_gen2driver.put(trans);	
			addr=addr+add_size;
			this.trans.HADDR = addr;
			$display("Address:0x%0h sent to mailbox",trans.HADDR);
			end
	
		$display("All 8-beats in INCR8 burst sent to driver\n");
		endtask

	task INCR16(bit wr_data);		
		bit [2:0] add_size;
		trans=new; 
		this.trans.HADDR=addr;
		this.trans.HWDATA=data;
		this.trans.HBURST = 3'b111; //16 Beat Incrementing Burst
       	 	this.trans.HWRITE = wr_data; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to driver\n",trans.HADDR);
	 		
		repeat(15)	
      			begin
			trans=new;
       			this.trans.HWRITE = wr_data; 
       			this.trans.HBURST = 3'b111; //16 Beat Incrementing Burst
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = 3'b010; // HSIZE=word (32-bits)
      			case(trans.HSIZE)
				3'b000 : add_size = 1;
              			3'b001 : add_size = 2;
          			3'b010 : add_size = 4;
        		endcase 
       			mb_gen2driver.put(trans);	
			addr=addr+add_size;
			this.trans.HADDR = addr;
			$display("Address:0x%0h sent to mailbox",trans.HADDR);
			end
	
		$display("All 16-beats in INCR16 burst sent to driver\n");
		endtask


	task SINGLE_BURST(bit wr_data, integer beats);
		bit [2:0] add_size;
		trans=new; 
		this.trans.HADDR=addr;
		this.trans.HWDATA=data;
		this.trans.HBURST = 3'b000; //Single Burst
       	 	this.trans.HWRITE = wr_data; 
     		this.trans.HTRANS = 3'b010; // Non-Sequential 
		mb_gen2driver.put(trans);
		$display("Address:0x%0h sent to driver\n",trans.HADDR);
	 	beats=beats-1; //because remainign are sequential
		repeat(beats)	
      			begin
			trans=new;
       			this.trans.HWRITE = wr_data; 
       			this.trans.HBURST = 3'b000; //Single Burst
      			this.trans.HTRANS = 3'b011; // SEQ for the remaining beats
      			this.trans.HSIZE = 3'b010; // HSIZE=word (32-bits)
      			case(trans.HSIZE)
				3'b000 : add_size = 1;
              			3'b001 : add_size = 2;
          			3'b010 : add_size = 4;
        		endcase 
       			mb_gen2driver.put(trans);	
			addr=addr+add_size;
			this.trans.HADDR = addr;
			$display("Address:0x%0h sent to mailbox",trans.HADDR);
			end
	
		$display("All beats in Single Burst sent to driver\n");
	endtask


endclass: generator
