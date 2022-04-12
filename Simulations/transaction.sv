class transaction;
	//INPUT signals of design module
	rand bit          HWRITE;  // Read = 0 and Write = 1
	rand logic [1:0]  HTRANS;  
	rand bit   [2:0]  HSIZE;	  
	rand bit   [2:0]  HBURST; 
	rand logic [3:0]  HPROT;  
	rand bit   [31:0] HWDATA;  //Write Data 32-bits
 	rand bit   [31:0] HADDR;   //Read/write address 	
	//OUTPUT signals of design module
	bit	          HREADY;
	bit 	   	  HRESP; 
	logic	   [31:0] HRDATA;   //Read Data  32-bits(4-bytes)
endclass: transaction
