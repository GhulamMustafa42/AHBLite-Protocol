
class scoreboard;
  
 	 input bit[31:0]data;
 	 mailbox mb_mon2scb;
      
 	 function new(mailbox mb_mon2scb);
      		this.mb_mon2scb = mb_mon2scb;
       	 endfunction
  
 	 task score(data);
   		 mb_mon2scb.get(tr);
   		 if(tr.HWRITE == 1)
	  	 	saved_data = tr.HWDATA;
       if(tr.HWRITE == 0) begin
         if (tr.HRDATA == data)
				$display("Receipt is okay");
			else 
				$error("Receipt is Not okay"); 
        	 end
      	end
	endtask

   	 task run();
    		  score(32'b0); 
    	endtask

endclass: scoreboard
