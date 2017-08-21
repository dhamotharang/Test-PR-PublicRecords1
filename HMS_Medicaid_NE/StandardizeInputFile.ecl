IMPORT  std, ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, 
		Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID,HMS_Medicaid_Common;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE
	EXPORT Base	:= FUNCTION
		//basefile	:= topn(HMS_Medicaid_NE.Files(filedate,pUseProd).SureScripts_input_Raw,100,spi);		// Testing 100 recs - 42 min; 500 recs - 52 min; 10000 recs - 48 min
		baseFile	:= HMS_Medicaid_NE.Files(filedate,pUseProd).Medicaid_Input;								
		HMS_Medicaid_Common.layouts.base_NE tMapping(HMS_Medicaid_Common.layouts.Medicaid_NE L) := TRANSFORM
		
			SELF.Dt_vendor_first_reported			:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported			:= (unsigned)filedate;
			SELF.Dt_first_seen								:= 0;
			SELF.Dt_last_seen									:= 0;
			Raw_Addr1 := if (TRIM(StringLib.StringCleanSpaces(L.Address1),LEFT, RIGHT) = '~Missing', '',TRIM(StringLib.StringCleanSpaces(L.Address1),LEFT, RIGHT));                                          
			Raw_Addr2 := if (TRIM(StringLib.StringCleanSpaces(L.Address2),LEFT, RIGHT) = '~Missing', '',TRIM(StringLib.StringCleanSpaces(L.Address2),LEFT, RIGHT));                                          
			Raw_Addr3 := if (TRIM(StringLib.StringCleanSpaces(L.Address3),LEFT, RIGHT) = '~Missing', '',TRIM(StringLib.StringCleanSpaces(L.Address3),LEFT, RIGHT));                                          

			SELF.CompanyName := TRIM(StringLib.StringCleanSpaces(L.Name),LEFT, RIGHT);
			SELF.Prepped_Addr1 := Raw_Addr1 + ' ' + Raw_Addr2 + ' '+Raw_Addr3;
			SELF.Prepped_Addr2 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.OfficeCity+ ' ' + L.OfficeState + ' ' + L.OfficeZipCode[..5])),LEFT, RIGHT); 
			SELF.Data_State := 'NE';

			SELF.Clean_Phone     := '';   //if(ut.CleanPhone(L.phone) [1] not in ['0','1'],ut.CleanPhone(L.phone), '');
			SELF.NPI :=  TRIM(L.NPI,LEFT,RIGHT);
			SELF.src := 'HMS_TODO_NE';
			SELF.record_type := 'C';
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		
		RETURN PROJECT(baseFile, tMapping(LEFT));
				
	END; // Function
	
END;