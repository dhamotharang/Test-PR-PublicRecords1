EXPORT Layouts := module

	export CorpDataLayoutIn := record
	
		string Filing_Number;                
		string Corp_Type_ID ;                  	
		string Corp_Status;              	
		string Date_Filed;                		
		string Date_Incorporated;             	
		string Corporation_Name;              	
		string Registered_Agent;            	
		string Agent_First_Name; 	      	
		string Agent_Middle_Name;	           	
		string Agent_Last_Name;           	
		string Agent_Suffix_ID;       	                         
		string Agent_Address1;             		
		string Agent_Address2;               		
		string Agent_City;                			
		string Agent_State;                  		
		string Agent_Zip;                    			
		string Agent_Zip_Extension;            			
		string Agent_Country; 	           			                 
		string State_of_Organization;          	
		string Foreign_Country;	      				            
		string Name_of_Organization;       		
		string FHO_Name;     			
		string FHO_Address1;          		
		string FHO_Address2;              		
		string FHO_City;            			
		string FHO_State;               	
		string FHO_Zip;              			
		string FHO_Zip_Extension;              		
		string FHO_Country;            	
		string Act;      		                         
		string Duration_of_Existence;          	
		string Tax_Type_ID; 
		
	end;

	export CorpDataLayoutBase := Record 
	
			string1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
      CorpDataLayoutIn;
			
	end;

	export CorpNamesLayoutIn := Record
	
		string 	Filing_Number;                  	
		string	Fictitious_Name;						
		string 	Real_Name;						
		string 	Agent_City;						
		string 	Agent_State;			
		
	end;

	export CorpNamesLayoutBase := Record 
	
			string1		action_flag;
			UNSIGNED4	dt_first_received;
			UNSIGNED4	dt_last_received;
		  CorpNamesLayoutIn;
			
	end;
	
	export CorpOfficerLayoutIn := Record
	
		string	Filing_Number;                  	
		string	Officer_ID;		
		string	Address_ID;		
		string	Officer_Title;						
		string	Business_Name;					
		string	Date_Created;		
		string	Date_Inactivated;	
		string	Last_Name;					
		string	First_Name;					
		string	Middle_Name;					
		string	Suffix_ID;		
		string	Date_Last_Modified;	
		string	Normalized_Name;				
		string	Title_ID;	
		
	end;

	export CorpOfficerLayoutBase := Record 
	
		string1		action_flag;
		UNSIGNED4	dt_first_received;
		UNSIGNED4	dt_last_received;
		CorpOfficerLayoutIn;
			
	end;
	
	export CorpDataWithOfficerTiles := record
		
			CorpDataLayoutIn.Corporation_Name;
			CorpDataLayoutIn.Filing_Number;
			CorpOfficerLayoutIn;
			
	end;
	
	export CorpNames_TempLay    := record
			CorpNamesLayoutIn;
			CorpDataLayoutIn.corp_type_id;
			CorpDataLayoutIn.Date_Incorporated;
	end;

end;