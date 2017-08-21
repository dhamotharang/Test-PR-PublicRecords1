
   
	   export Layouts_IN_Entity_Information := record
       string     RECORD_HEADER;
       string     Filing_Number;
       string     Status_ID;
       string     Corp_Type_ID;
       string     Address_ID;
       string     Name;
       string     Perpetual_Flag;
       string     Creation_Date;
       string     Expiration_Date;
       string     Inactive_Date;
       string     Formation_Date;
       string     Report_Due_Date;
       string     Tax_ID;
       string     Fictitious_Name;
       string     Foreign_Fein;
       string     Foreign_State;
       string     Foreign_Country;
       string     Foreign_Formation_Date;
       string     Expiration_Type;
       string     Last;
       string     Telephone_Number;
       string     OTC_Suspension_Flag;
       string     Consent_Name_Flag;
			 string     LF;
		 end;
	 
	   export Layouts_Raw_Input_Clean_Address_1  := record
		  string      RECORD_HEADER;
      string      Address_ID;
      string      Address1;
      string      Address2;
      string      City;
      string      State;
      string      Zip_Code;
      string      Zip_Extension;
      string      Country;
			string      LF;
		 end;
		
		 export Clean_Agent  := record
		  string      RECORD_HEADER;
      string      Filing_Number;
      string      Address_ID;
      string      Business_Name;
      string      Agent_Last_Name;
      string      Agent_First_Name;
      string      Agent_Middle_Name;
      string      Agent_Suffix_Id;
      string      Creation_Date;
      string      Inactive_Date;
      string      Normalized_Name;
      string      SOS_RA_Flag;
			string      LF;
     end;
		
		 export Clean_Officer  := record
		  string      RECORD_HEADER;
      string      Filing_Number;
      string      Officer_ID;
      string      Officer_Title;
      string      Business_Name;
      string      Officer_Last_Name;
      string      Officer_First_Name;
      string      Officer_Middle_Name;
      string      Officer_Suffix_ID;
      string      Address_ID;
      string      Creation_Date;
      string      Inactive_Date;
      string      Last_Modified_Date;
      string     	Normalized_Name;
			string      LF;
	   end;
	
	   export Names := record
	    string      RECORD_HEADER;
      string     	Filing_Number;
      string     	Name_ID;
      string     	Name;
      string     	Name_Status_ID;
      string     	Name_Type_ID;
      string     	Creation_Date;
      string     	Inactive_Date;
      string     	Expire_Date;
      string     	All_Counties_Flag;
      string     	Consent_Filing_Number;
      string     	Search_ID;
      string      Transfer_To;
      string    	Received_From;
			string      LF;
     end;
 
     export Associated_Entities  := record
      string      RECORD_HEADER;
      string      Filing_Number;
      string      Document_Number;
      string      Associated_Entity_ID;
      string      Assoc_Ent_Corp_Type_ID;
      string      Primary_Capacity_ID;
      string      Capacity_ID;
      string      Associated_Entity_Name;
      string      Entity_Filing_Number;
      string      Entity_Filing_Date;
      string      Inactive_Date;
      string      Jurisdiction_State;
      string      Jurisdiction_Country;
			string      LF;
     end;
	
	   export Stock_Data := record
      string      RECORD_HEADER;
      string      Stock_ID;
      string      Filing_Number;
      string      Stock_Type_ID;
      string      Stock_Series;
      string      Share_Volume;
      string      Par_Value;
			string      LF;
	   end;
	
	   export Stock_Info := record
      string      RECORD_HEADER;
      string      Filing_Number;
      string      Qualify_Flag;
      string      Unlimited_Flag;
      string      Actual_Amt_Invested;
      string      Pd_On_Credit;
      string      Tot_Auth_Capital;
			string      LF;
     end;	
	
	   export Stock_Type := record
      string      RECORD_HEADER;
      string      Stock_Type_ID;
      string      Stock_Type_Desc;
			string      LF;
	   end;
	
  	 export Filing_Type := record
      string      RECORD_HEADER;
      string      Filing_Type_ID;
      string      Filing_Type;
			string      LF;
	   end;
 
	   export Corp_Status := record
      string      RECORD_HEADER;
      string      Status_ID;
      string      Status_Desc;
			string      LF;
	   end;
	
	   export Corp_Type := record
      string      RECORD_HEADER;
      string      Corp_Type_ID;
      string      Corp_Type_Desc;
			string      LF;
	   end;
	
	   export Name_Status := record
      string      RECORD_HEADER;
      string     	Name_Status_ID;
      string     	Name_Status;
			string      LF;
	   end;
		
		 export Name_Type := record
      string      RECORD_HEADER;
      string     	Name_Type_ID;
      string     	Name_Type;		
			string      LF;
	   end;
		
		 export Capacity := record
      string      RECORD_HEADER;
      string     	Capacity_ID;
      string     	Description;
			string      LF;
	   end;
		
		 export Suffix  := record
      string      RECORD_HEADER;
      string     	Suffix_ID;
      string     	Suffix;
			string      LF;
		 end;
		
		 export Corp_Filing := record
      string      RECORD_HEADER;
      string     	Filing_Number;  
      string     	Document_Number;
      string     	Filing_Type_ID;
      string     	Filing_Type;
      string     	Entry_Date;  
      string     	Filing_Date;
      string     	Effective_Date;
      string     	Effective_Condition_Flag;
      string     	Inactive_Date;
			string      LF;
	   end;
		
	   export Audit_Log := record
      string      RECORD_HEADER;
      string      Reference_Number;  
      string      Audit_Date;
      string      Table_ID;
      string      Field_ID;
      string      Previous_Value;  
      string      Current_Value;
      string      Action;
      string      Audit_Comment;
			string      LF;
	   end;
	 
	   export Trailer_Record := record
      string      RECORD_HEADER;
      string      Some_Number;  
      string      Process_Date;
      string      No_entity_records;  
      string      No_address_records;
      string      No_agent_records;  
      string      No_officer_records;
      string      No_names_records;
      string      No_assoc_entity_records;
      string      No_stock_data_records; 
      string      No_stock_info_records;
      string      No_stock_type_records;
      string      No_filing_type_records;  
      string      No_corp_status_records;
      string      No_corp_type_records;
      string      No_name_status_records;
      string      No_name_type_records;
      string      No_capacity_records;
      string      No_suffix_records;
      string      No_corp_filing_records;
      string      No_audit_log_records;
			string      LF;
	   end;
  end;	 
	 
	 Export Layouts_Output := MODULE;
	 
		 export Entity_Information := record
      string2   RECORD_HEADER;
      string10  Filing_Number;
      string2   Status_ID;
      string2   Corp_Type_ID;
      string13  Address_ID;
      string150 Name;
      string30  Perpetual_Flag;
      string10  Creation_Date;
      string10  Expiration_Date;
      string10  Inactive_Date;
      string10  Formation_Date;
      string10  Report_Due_Date;
      string16  Tax_ID;
      string150 Fictitious_Name;
      string16  Foreign_Fein;
      string4   Foreign_State;
      string3   Foreign_Country;
      string10  Foreign_Formation_Date;
      string16  Expiration_Type;
      string10  Last;
      string25  Telephone_Number;
      string2   OTC_Suspension_Flag;
      string2   Consent_Name_Flag;
      string2   LF;
		end;
    
		export Clean_Address_1 := record
		  string2  RECORD_HEADER;
      string13 Address_ID;
      string50 Address1;
      string50 Address2;
      string64 City;
      string4  State;
      string9  Zip_Code;
      string6  Zip_Extension;
      string3  Country;
      string1  LF;
    end;
	export Clean_Agent := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string13 	Address_ID;
			string150 Business_Name;
			string50 	Agent_Last_Name;
			string50 	Agent_First_Name;
			string50 	Agent_Middle_Name;
			string13 	Agent_Suffix_Id;
			string10 	Creation_Date;
			string10 	Inactive_Date;
			string150 Normalized_Name;
			string2 	SOS_RA_Flag;
			string1 	LF;
		end;

		export Clean_Officer := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string6  	Officer_ID;
			string32	Officer_Title;
			string150 Business_Name;
			string50 	Officer_Last_Name;
			string50 	Officer_First_Name;
			string50 	Officer_Middle_Name;
			string6 	Officer_Suffix_ID;
			string13 	Address_ID;
			string10 	Creation_Date;
			string10 	Inactive_Date;
			string10  Last_Modified_Date;
			string150	Normalized_Name;
			string1 	LF;
		end;

		export Names := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string6 	Name_ID;
			string150 Name;
			string30 	Name_Status_ID;
			string3 	Name_Type_ID;
			string10 	Creation_Date;
			string10 	Inactive_Date;
			string10 	Expire_Date;
			string10 	All_Counties_Flag;
			string12 	Consent_Filing_Number;
			string2 	Search_ID;
			string10  Transfer_To;
			string10	Received_From;
			string2 	LF;
		end;

		export Associated_Entities := record
			string2 	RECORD_HEADER;
			string10 	Filing_Number;
			string13 	Document_Number;
			string6  	Associated_Entity_ID;
			string6  	Assoc_Ent_Corp_Type_ID;
			string4  	Primary_Capacity_ID;
			string4  	Capacity_ID;
			string150	Associated_Entity_Name;
			string12  Entity_Filing_Number;
			string10  Entity_Filing_Date;
			string10  Inactive_Date;
			string10  Jurisdiction_State;
			string3  	Jurisdiction_Country;
			string1 	LF;
		end;

		export Stock_Data := record
			string2 	RECORD_HEADER;
			string13  Stock_ID;
			string13  Filing_Number;
			string13  Stock_Type_ID;
			string256 Stock_Series;
			string40  Share_Volume;
			string40  Par_Value;
			string1   LF;
		end;

		export Stock_Info := record
			string2 	RECORD_HEADER;
			string13	Filing_Number;
			string1		Qualify_Flag;
			string1		Unlimited_Flag;
			string40	Actual_Amt_Invested;
			string40	Pd_On_Credit;
			string40	Tot_Auth_Capital;
			string1		LF;
		end;

		export Stock_Type := record
			string2 	RECORD_HEADER;
			string13 	Stock_Type_ID;
			string64 	Stock_Type_Desc;
			string1 	LF;
		end;

		export Filing_Type := record
			string2 	RECORD_HEADER;
			string13	Filing_Type_ID;
			string96	Filing_Type;
			string1 	LF;
		end;

		export Corp_Status := record
			string2 	RECORD_HEADER;
			string13	Status_ID;
			string24	Status_Desc;
			string1 	LF;
		end;

		export Corp_Type := record
			string2 	RECORD_HEADER;
			string13	Corp_Type_ID;
			string80	Corp_Type_Desc;
			string1 	LF;
		end;

		export Name_Status := record
			string2 	RECORD_HEADER;
			string13	Name_Status_ID;
			string80	Name_Status;
			string1 	LF;
		end;

		export Name_Type := record
			string2 	RECORD_HEADER;
			string13	Name_Type_ID;
			string16	Name_Type;
			string1 	LF;
		end;

		export Capacity := record
			string2 	RECORD_HEADER;
			string13	Capacity_ID;
			string50	Description;
			string1 	LF;
		end;

		export Suffix := record
			string2 	RECORD_HEADER;
			string13	Suffix_ID;
			string50	Suffix;
			string1 	LF;
		end;

		export Corp_Filing := record
			string2 	RECORD_HEADER;
			string10	Filing_Number;  
			string12	Document_Number;
			string12	Filing_Type_ID;
			string96	Filing_Type;
			string10	Entry_Date;  
			string10	Filing_Date;
			string10	Effective_Date;
			string2		Effective_Condition_Flag;
			string10	Inactive_Date;
			string1 	LF;
		end;

		export Audit_Log := record
			string2 	RECORD_HEADER;
			string10	Reference_Number;  
			string10	Audit_Date;
			string4		Table_ID;
			string4		Field_ID;
			string300	Previous_Value;  
			string300	Current_Value;
			string10	Action;
			string256	Audit_Comment;
			string1 	LF;
		end;
	end;		

		
export Files_Raw_Input := MODULE; 

			export ds_Entity_Information (string fileDate)      := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Entity_Information,
																													 CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\r\n']))) (trim(RECORD_HEADER,left,right)='01' and trim(Filing_Number,left,right) !='FILING_NUMBER');										 
      export ds_Clean_Address_1 (string fileDate)         := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Clean_Address_1,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='02' and  trim(Address_ID,left,right) !='ADDRESS_ID');    																													 
      export ds_Clean_Agent (string fileDate)             := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Clean_Agent,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='03' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Clean_Officer (string fileDate)           := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Clean_Officer,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='04' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Names (string fileDate)                   := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Names,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='05' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Associated_Entities (string fileDate)     := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Associated_Entities,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='06' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Stock_Data (string fileDate)              := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Stock_Data,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='07' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Stock_Info (string fileDate)              := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Stock_Info,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='08' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Stock_Type (string fileDate)              := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Stock_Type,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='09' and  trim(Stock_Type_ID,left,right) !='STOCK_TYPE_ID');    																													 
      export ds_Filing_Type (string fileDate)             := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Filing_Type,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='10' and  trim(Filing_Type_ID,left,right) !='FILING_NUMBER');    																													 
      export ds_Corp_Status (string fileDate)             := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Corp_Status,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='11' and  trim(Status_ID,left,right) !='STATUS_ID');    																													 
      export ds_Corp_Type (string fileDate)               := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Corp_Type,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='12' and  trim(Corp_Type_ID,left,right) !='CORP_TYPE_ID');    																													 
      export ds_Name_Status (string fileDate)             := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Name_Status,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='13' and  trim(Name_Status_ID,left,right) !='NAME_STATUS_ID');    																													 
      export ds_Name_Type (string fileDate)               := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Name_Type,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='14' and  trim(Name_Type_ID,left,right) !='NAME_TYPE_ID');    																													 
      export ds_Capacity (string fileDate)                := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Capacity,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='15' and  trim(Capacity_ID,left,right) !='CAPACITY_ID');    																													 
      export ds_Suffix (string fileDate)                  := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Suffix,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='16' and  trim(Suffix_ID,left,right) !='SUFFIX_ID');    																													 
      export ds_Corp_Filing (string fileDate)             := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Corp_Filing,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='17' and  trim(Filing_Number,left,right) !='FILING_NUMBER');    																													 
      export ds_Audit_Log (string fileDate)               := dataset('~thor_data400::temp::in::corp2::'+fileDate+'::ok', Layouts_Raw_Input.Audit_Log,
																													  CSV(SEPARATOR(['~']), quote(''),TERMINATOR(['\n']))) (trim(RECORD_HEADER,left,right)='18' and  trim(Reference_Number,left,right) !='REFERENCE_NUMBER');    																													 
	end;		
	
	
Layouts_Output.Entity_Information toentitynewlayout(Files_Raw_Input.ds_Entity_Information l) := transform
     self := l;
end;

ds_Entity_Information_new := project(Files_Raw_Input.ds_Entity_Information,toentitynewlayout(left));

	
// fWriteAndDespray ( STRING fileDate, STRING FileName, DATASET File ) := FUNCTION
// OUTPUT ( File ,,  '~thor_data400::temp::out::corp2::'+fileDate+ '::' + FileName ,	NAMED ( FileName ) , CSV ,	OVERWRITE	)	;
	// RETURN fileservices.Despray('~thor_data::temp::out::corp2::'+fileDate+ '::' + FileName , 'edata10-bld.br.seisint.com', '/data_build_4/corporate_filings/sources/ok/' + fileDate +'/'+FileName + '_'+fileDate+'.d00' ,,,, TRUE ) ;
// END	;
	
// fWriteAndDespray ( fileDate, 'agent','agent') ;	
// fWriteAndDespray ( fileDate, 'associated_entities','associated_entities') ;		
	
end;	  
	  
 




		
     
end;