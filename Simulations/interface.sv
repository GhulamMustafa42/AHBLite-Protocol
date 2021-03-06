interface intf(input logic HCLK, HRESTn);
	
	bit            HWRITE; 
	logic 	       HRESP; 
	logic	       HREADY;
	logic   [1:0]  HTRANS;
	logic   [2:0]  HSIZE;	  
	logic   [2:0]  HBURST; 
    	logic   [3:0]  HPROT; 
	logic   [31:0] HWDATA; 
 	logic   [31:0] HADDR; 	 
	logic	[31:0] HRDATA;   

modport driver();
modport monitor();

endinterface
