import ut; 

export is_new_header :=  function 

string20 var1 := '' : stored('watchtype');

boolean boolean_new_header := ut.IsNewProdHeaderVersion('watchdog_'+var1) ; 

result := sequential(output(boolean_new_header,named('is_new_header')) , if(boolean_new_header=true , 
             ut.PostDID_HeaderVer_Update('watchdog_'+var1) 
			 )); 
		
return 	result ; 
end ; 				