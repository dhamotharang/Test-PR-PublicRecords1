IMPORT  std, ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, 
		Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, HMS_Medicaid_Common;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE
	SHARED STRING70 Prep_Addr1;		
	EXPORT Base	:= FUNCTION
		//basefile	:= topn(HMS_Medicaid_NY.Files(filedate,pUseProd).SureScripts_input_Raw,100,spi);		// Testing 100 recs - 42 min; 500 recs - 52 min; 10000 recs - 48 min
																																																// 25,000 - 48 min
		baseFile	:= HMS_Medicaid_NY.Files(filedate,pUseProd).Medicaid_file;								//Medicaid_input_raw;
		HMS_Medicaid_Common.layouts.base_NY tMapping(HMS_Medicaid_Common.layouts.Medicaid_NY L) := TRANSFORM
		
			SELF.Dt_vendor_first_reported			:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported			:= (unsigned)filedate;
			SELF.Dt_first_seen								:= 0;
			SELF.Dt_last_seen									:= 0;
			
			SELF.CompanyName := if (std.str.countwords(L.Prov_Name,',') = 1,L.Prov_Name,'');
			// strSet := if (std.str.countwords(L.Provider_Name,',') > 1,std.str.splitwords(L.Provider_Name,','),[]);
			// SELF.FirstName := if(strSet <> [],strSet[2],'');
			// SELF.LastName := if(strSet <> [],strSet[1],'');
			SELF.entity_type_code := 0;
			AddressLine1 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.Prov_Addr_Str)),LEFT, RIGHT);
			AddressLine2 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.PROV_ADDR_LINE_2)),LEFT, RIGHT);
			Prep_Addr1	:= TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(AddressLine1)),LEFT, RIGHT) + 
												' ' + TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(AddressLine2)),LEFT, RIGHT);
			SELF.Prepped_Addr1 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(Prep_Addr1)),LEFT, RIGHT);									
			SELF.Prepped_Addr2 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.PROV_ADDR_CITY)),LEFT, RIGHT) + ', ' + 
														TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.PROV_ADDR_ST)),LEFT, RIGHT) + ' ' + L.POSTAL_CD[..5];									
			SELF.Data_State := 'NY';
			SELF.Clean_Phone     := if(ut.CleanPhone(L.PROV_TELE_NUM)[1] not in ['0','1'],ut.CleanPhone(L.PROV_TELE_NUM), '');
			SELF.NPI :=  TRIM(L.NPI,LEFT,RIGHT);
			//SELF.Taxonomy :=  TRIM(L.Taxonomy,LEFT,RIGHT);
			SELF.src := 'HMS_TODO';
			SELF.record_type := 'C';
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		
		RETURN PROJECT(baseFile, tMapping(LEFT));
				
	END; // Function
	
END;