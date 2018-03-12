EXPORT count_function(file,f1,result) := macro



/*  lay:=record
      
      file.f1;
      integer freq:=count(group);
      end;
      
      result1:= table(file,lay,f1);
*/
	 
	


  #uniquename(tble)
         %tble% := table(file);
         
         #uniquename(lay)
      
              %lay%:=record
      				   	   string attribute:='<'+ trim(%tble%.#expand(f1),left,right)+'>';
         		    		 integer field_frequency:=count(group);
         		      	 end;
          #uniquename(result1)
         	 %result1%:=table(%tble%,%lay%,#expand(f1));

   		 

   
 #uniquename(rc)
%rc% := record
string field_name;
STRING50 attribute_value;
integer count1;
end;
                                      #uniquename(func)
                                       %rc% %func%(%result1% l):=TRANSFORM
                                                self.field_name:=f1;
                                                self.attribute_value :=l.attribute;
																								self.count1:=l.field_frequency;
																								
																					end;			
							
#uniquename(Bks_project)
%Bks_project% := PROJECT(%result1%,%func%(left));
		
					 
   									 
   									 result:=%Bks_project%;

	 
	 endmacro;