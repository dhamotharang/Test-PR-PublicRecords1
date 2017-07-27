export Layout_In_InfoUSA_Flat := record
string30 			InfoUSA_FBN_Key				;
string8 			process_date				;
string8				date_first_updated_app := '00000000'			;
string8				date_last_updated_app	:='00000000'		;
string25	   	    lni							;  	
string5				minrev						; 	 
string4             src							;
string3 			f 							;
string8             Date_last_updated  			;
qstring120          StateDesc    				;  
qstring120          BusinessName				;         				
string3             BusinessTelephone_AreaCode 	;  
string8             BusinessTelephone_Number  	; 
//string12			BusinessTelephone_full		;
string2				FilingDate_mm				;  
string2				FilingDate_dd				;    
string4				FilingDate_yy				;  
string8             FilingDate  				;   
qstring120          BusinessCounty_Name  		;				
qstring200          BusinessDesc 				;	
string6             SIC							;
string5             FileCode 				    ;        	
qstring120	     	File 						;    
string120           BusinessAddress_S1   		; 
string50            BusinessAddress_CY   		;										
string50            BusinessAddress_ST  		;										
string10            BusinessAddress_ZP   		; 									
string120           ContactPersonAddress_S1		;							
string50            ContactPersonAddress_CY		;							
string50            ContactPersonAddress_ST		;							
string10            ContactPersonAddress_ZP		;							
string3             Telephone_AreaCode			;
string8             Telephone_Number	        ;
//string12			ContactTelephone_full		;												
qstring150 	     	CCT_lastname                ;      											 
string30            CCT_Suffix                  ;        											
qstring150		    CCT_firstname               ;  
string150			CCT_fullname				;     						
string10            Filing_Type                 ;	
				
end;








































