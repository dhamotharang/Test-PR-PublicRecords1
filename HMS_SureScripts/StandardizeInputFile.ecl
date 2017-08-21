IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, 
		Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT StandardizeInputFile (string filedate, boolean pUseProd = false):= MODULE
	SHARED STRING70 Prep_Addr1;
	EXPORT Base	:= FUNCTION
		//basefile	:= topn(HMS_SureScripts.Files(filedate,pUseProd).SureScripts_input_Raw,100,spi);		// Testing 100 recs - 42 min; 500 recs - 52 min; 10000 recs - 48 min
																																																// 25,000 - 48 min
		baseFile	:= HMS_SureScripts.Files(filedate,pUseProd).SureScripts_input_raw;
		HMS_SureScripts.layouts.base tMapping(HMS_SureScripts.layouts.SureScripts_in_raw L) := TRANSFORM
		
			SELF.Dt_vendor_first_reported			:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported			:= (unsigned)filedate;
			SELF.Dt_first_seen								:= 0;
			SELF.Dt_last_seen									:= 0;
			
			SELF.firstname := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.firstname)), LEFT, RIGHT);
			SELF.lastname := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.lastname)), LEFT, RIGHT);
			SELF.AddressLine1 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.AddressLine1)),LEFT, RIGHT);
			SELF.AddressLine2 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.AddressLine2)),LEFT, RIGHT);
			Prep_Addr1	:= TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.AddressLine1)),LEFT, RIGHT) + 
												' ' + TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.AddressLine2)),LEFT, RIGHT);
			SELF.Prepped_Addr1 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(Prep_Addr1)),LEFT, RIGHT);									
			SELF.Prepped_Addr2 := TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.City)),LEFT, RIGHT) + ', ' + 
														TRIM(Stringlib.StringToUpperCase(StringLib.StringCleanSpaces(L.State)),LEFT, RIGHT) + ' ' + L.ZipCode[..5];									
			SELF.ClinicName		 := TRIM(Stringlib.StringToUpperCase(L.ClinicName), LEFT, RIGHT);
			SELF.city					 := TRIM(Stringlib.StringToUpperCase(L.city), LEFT, RIGHT);
			SELF.state				 := TRIM(Stringlib.StringToUpperCase(L.state), LEFT, RIGHT);
			SELF.zipCode			 := TRIM(L.zipCode, LEFT, RIGHT);
			SELF.StateLicenseNumber := TRIM(L.StateLicenseNumber,LEFT,RIGHT);
			SELF.Spec_Code := '';				// Specialty Code derived from SpecialtyCodePrimary in the input file
			SELF.Spec_Desc := '';				// Specialty Code description
			SELF.Activity_Code := '';
			SELF.Practice_Type_Code := '';
			SELF.Practice_Type_Desc := '';
			SELF.Taxonomy := '';
			SELF.phonePrimary	 := TRIM(L.phonePrimary, LEFT, RIGHT);
			SELF.PhoneAlt1			:= TRIM(L.PhoneAlt1, LEFT, RIGHT);
			SELF.PhoneAlt2			:= TRIM(L.PhoneAlt2, LEFT, RIGHT);
			SELF.PhoneAlt3			:= TRIM(L.PhoneAlt3, LEFT, RIGHT);
			SELF.PhoneAlt4			:= TRIM(L.PhoneAlt4, LEFT, RIGHT);
			SELF.PhoneAlt5			:= TRIM(L.PhoneAlt5, LEFT, RIGHT);			
			SELF.fax						:= TRIM(L.Fax, LEFT, RIGHT);
			SELF.clean_Clinic_name 		:= if(ut.CleanCompany(L.ClinicName)<> '', ut.CleanCompany(L.ClinicName), datalib.companyclean(L.ClinicName));
			SELF.Clean_Phone     := if(ut.CleanPhone(L.phonePrimary) [1] not in ['0','1'],ut.CleanPhone(L.phonePrimary), '');
			ssn	 := if(length(regexreplace('[^0-9]',l.SocialSecurity,''))=9,l.SocialSecurity,'');
			SELF.SocialSecurity  := if((unsigned)ssn > 0,if(ssn in ut.Set_BadSSN ,'',ssn), '');
			SELF.NPI :=  TRIM(L.NPI,LEFT,RIGHT);
			SELF.MedicareNumber :=  TRIM(L.MedicareNumber,LEFT,RIGHT);
			SELF.MedicaidNumber :=   TRIM(L.MedicaidNumber,LEFT,RIGHT);
			SELF.DentistLicenseNumber := 	 TRIM(L.DentistLicenseNumber,LEFT,RIGHT);
			SELF.src := 'HMS_CSR_1216';
			SELF.record_type := 'C';
			//SELF.taxonomy_code := ''; // Not available at this time. Will be used to link it later
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		
		RETURN PROJECT(baseFile, tMapping(LEFT));
				
	END; // Function
	
END;