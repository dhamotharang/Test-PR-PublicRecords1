EXPORT count_function1(file,f1,result) := macro




  #uniquename(tble)
         %tble% := table(file);
         
         #uniquename(lay)
      
              %lay%:=record
							        string field_name := f1;
      				   	    %tble%.attribute_value;
         		    		 count1:=sum(group,%tble%.count1);
         		      	 end;
          #uniquename(result1)
         	 %result1%:=table(%tble%,%lay%,attribute_value);

 


		
					 
   									 
   									 result:=%result1%;

	 
	 endmacro;