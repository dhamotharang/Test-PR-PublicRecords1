IMPORT bipv2, address;

EXPORT Layouts := module

 // -----------------------------
 // Input Layout 
 // -----------------------------
 EXPORT Input := module  
  EXPORT Sprayed := record
		string9 	Business_Identification_Number;		 
		string40 	Business_Name;
		string30 	Business_Address;
		string28 	Business_City;
		string2 	Business_State;
		string5 	Business_Zip;
		string9 	Tax_ID_1;
		string1 	Confidence_Level_1;
		string1 	Display_Configuration_1;
		string9 	Tax_ID_2;
		string1 	Confidence_Level_2;
		string1 	Display_Configuration_2;
		string9 	Tax_ID_3;
		string1 	Confidence_Level_3;
		string1	 	Display_Configuration_3;
		string9 	Tax_ID_4;
		string1 	Confidence_Level_4;
		string1 	Display_Configuration_4;
		string9 	Tax_ID_5;
		string1 	Confidence_Level_5;
		string1 	Display_Configuration_5;
		string120 Long_Name;
		string2   crlf;
  END;
END;

 EXPORT TempRec := RECORD
	unsigned8	unique_id;
	Input.Sprayed;
 END;
 
 EXPORT NormRec	:=	RECORD 
		/* Normalize the records to split records into one for each FEIN */
		unsigned8	unique_id;
		string9 	Business_Identification_Number;		 
		string40 	Business_Name;
		string30 	Business_Address;
		string28 	Business_City;
		string2 	Business_State;
		string5 	Business_Zip;
		string1		Norm_Type;           /* '1' through '5' for the 5 normalized FEINs */
		string9   Norm_Tax_ID;   
		string1   Norm_Confidence_Level;       
		string1		Norm_Display_Configuration;
		string120 Long_Name;
	END;
	
 // -----------------------------
 // Base Layout 
 // -----------------------------
 EXPORT base:= record
	NormRec - unique_id;
	BIPV2.IDlayouts.l_xlink_ids;
	string2 												source											:='';
	unsigned8												source_rec_id								:= 0;
  unsigned6												Bdid												:= 0;
	unsigned1												bdid_score									:= 0;		
	unsigned4 											dt_vendor_first_reported		:= 0;
	unsigned4 											dt_vendor_last_reported			:= 0;
	Address.Layout_Clean182_fips       															;
	unsigned8												raw_aid											:= 0;
	unsigned8												ace_aid										 	:= 0;
	string100												prep_addr_line1						 	:='';
	string50												prep_addr_line_last				 	:='';
 end;
 	
  // ---------------------------------
  // Temporary Layouts for Processing
  // ---------------------------------
	export Temporary := module
	
		export StandardizeInput := record
			unsigned8		unique_id			;
			base 					 						;
	  end;
			  
	  export BdidSlim := record
			unsigned8		unique_id					;
			string100 	company_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25 		p_City_name				;   		 
			string2			state		 					;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			string2 		source				:='';
			unsigned8   source_rec_id := 0;
			BIPV2.IDlayouts.l_xlink_ids		;
	  end;
		
	  export UniqueId := record
 		  unsigned8		unique_id	;
		  Base									;
		end;
	end;

end;