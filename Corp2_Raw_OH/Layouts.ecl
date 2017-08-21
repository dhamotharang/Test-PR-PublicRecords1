EXPORT Layouts := MODULE;
	
 
		export BusinessLayoutIn	:= Record

			string   Charter_Num;
			string   Processing_Id;                
			string   Business_Name;
			string   Business_Type; 
			string   Original_Business_Type;              
			string   Tran_Code;
			string   Bus_Effective_Date_Time;            
			string   Business_Class;     
			string   Business_Status;         
			string   License_Type;       
			string   Consent_Flag;      
			string   Share_Proportion_Amt;      
			string   Share_Credits;            
			string   Bus_Business_Cnty;         
			string   Business_Location_Name;
			string   Bus_Business_State;
			string   Business_Address_Flag;
			string   Agent_Contact_Flag;
			string   Business_Associate_Flag;
			string   Authorized_Share_Flag;
			string   Old_Name_Flag;
			string   Create_Date_Time;
			string   Create_User_Id;
			string   Last_Update_Date_Time;
			string   Last_Update_User_Id;
			string   Doc_Tran_Count;
			string   Business_Expiry_Date;

		end;
		
		export BusinessLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			BusinessLayoutIn;
			
		end;
	
		export Old_NameLayoutIn	:= Record

			string   Charter_Num; 
			string   Old_Effective_Date_Time;                  
			string   Old_Name ;                

		end;
		
		export Old_NameLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Old_NameLayoutIn;
			
		end;

		export Business_AddressLayoutIn	:= Record

			string  Charter_Num; 
			string  Address_Type;                 
			string  Business_Addr1; 
			string  Business_Addr2; 
			string  Add_Business_City;                 
			string  Add_Business_State;
			string  Business_Zip9;
			string  Business_Cnty;                  

		end;
		
		export Business_AddressLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Business_AddressLayoutIn;
			
		end;
		
		export Agent_ContactLayoutIn	:= Record

			string 	Charter_Num;
			string	Contact_Doc_Id;
			string  Contact_name;
			string	Contact_Addr1;
			string	Contact_Addr2;
			string	Contact_City;
			string	Contact_State;
			string	Contact_Cnty;
			string	Contact_Zip9;
			string	Cont_Effective_Date_Time;
			string	Contact_Status;		

		end;	
		
		export Agent_ContactLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Agent_ContactLayoutIn;
			
		end;
		
		export Business_AssociateLayoutIn	:= Record
		
			string  Charter_Num; 
			string  Business_Assoc_Line_co;                 
			string  Business_Assoc_Name; 
		
		end;
		
		export Business_AssociateLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Business_AssociateLayoutIn;
			
		end;

		export Authorized_ShareLayoutIn	:= Record
		
			string  Charter_Num; 
			string  Share_Code;                 
			string  Par_Value_Amt;
			string  Share_Tot;
			
		end;
		
		export Authorized_ShareLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Authorized_ShareLayoutIn;
			
		end;

		export Text_InformationLayoutIn	:= Record

			string  Charter_Num; 
			string  Doc_Count;
			string  Doc_Text;                   
		 
		end;
		
		export Text_InformationLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Text_InformationLayoutIn;
			
		end;

		export Document_TransactionLayoutIn	:= Record

			string	 Charter_Num;
			string	 Processing_ID;
			string	 Doc_Id;
			string	 Doc_count;
			string	 Tran_Code;
			string	 Tran_Effective_Date_Time;
			string	 Create_Date_Time;
			string	 Create_User_Id;
			string	 Explanation_Flag;
			string	 Text_Information_Flag;

		end;
		
		export Document_TransactionLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			Document_TransactionLayoutIn;
			
		end;

		export ExplanationLayoutIn	:= Record
		
			string	    Charter_Num;
			string	    Doc_Count;
			string	    Explanation_Code;

		end;
		
		export ExplanationLayoutBase	:= Record
			
			string1		action_flag;
			unsigned4	dt_first_received;
			unsigned4	dt_last_received;	
			ExplanationLayoutIn;
			
		end;

		export Temp_Bus_Explanation:= Record
			
			BusinessLayoutIn;
			ExplanationLayoutIn-Charter_Num;
			
		end;
		
		export Temp_Bus_Authorized_Share:= Record
			
			BusinessLayoutIn;
			Authorized_ShareLayoutIn-Charter_Num;
			
		end;
		
		export Temp_Expla_TextDoc := record
				
			ExplanationLayoutIn;
			Text_InformationLayoutIn-Charter_Num;
				
		end;
		
		export Temp_Bus_Association := record
		  	
			BusinessLayoutIn;
			Business_AssociateLayoutIn-Charter_Num;
				
		end;
		
		export Temp_Bus_Old_Name := record
		 
			BusinessLayoutIn;
			Old_NameLayoutIn;		
		     
		end;
		
		export Temp_Bus_DocTran := record
			
			BusinessLayoutIn;
			Document_TransactionLayoutIn-Charter_Num;
			
		end;
		
		export Temp_BusinessAdd:= record
			
			BusinessLayoutIn;
			Business_AddressLayoutIn-Charter_Num;
			
		end;
		
		export Temp_BusinessAddCont:= record
		
			Temp_BusinessAdd;
			Agent_ContactLayoutIn-Charter_Num;
			
		end;
		
				
		export Temp_BusinessAddr_OldName:= record
			
			Temp_BusinessAddCont;
			Old_NameLayoutIn;
			
		end;
		
		export StateCodeLayout :=record
			
			string StateCode;
			string StateDesc;
   			
    end;
		
		export TranCodeLayout :=record
		
			string TranCode;
			string TranDesc;
			
		end;
		
		export CountyCodeLayout :=record
   			
				string CountyCode;
   			string CountyDesc;
   			
    end;
		
		export shareTypeLayout := record
		
			string typeCode;
			string typeDesc;
			
		end;
		
end;
