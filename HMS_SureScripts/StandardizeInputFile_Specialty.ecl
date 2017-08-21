IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, 
		Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT StandardizeInputFile_Specialty (string filedate, boolean pUseProd = false):= MODULE
	EXPORT Base	:= FUNCTION
																																																// 25,000 - 48 min
		baseFile	:= HMS_SureScripts.Specialty_Files(filedate,pUseProd).Raw_Specs_File;
		HMS_SureScripts.layouts.Base_Spec_Codes tMapping(HMS_SureScripts.layouts.Spec_Codes L) := TRANSFORM
		
			SELF.Dt_vendor_first_reported			:= (unsigned)filedate;
			SELF.Dt_vendor_last_reported			:= (unsigned)filedate;
			SELF.In_Code := L.In_Code;
			SELF.Out_Code := L.Out_Code;
			SELF.record_type := 'C';
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		
		RETURN PROJECT(baseFile, tMapping(LEFT));
				
	END; // Function
	
END;