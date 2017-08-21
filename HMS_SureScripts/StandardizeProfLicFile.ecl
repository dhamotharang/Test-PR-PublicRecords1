IMPORT  ut, mdr, tools,_validate, Address, Ut, lib_stringlib, _Control, business_header, 
		Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID;

EXPORT StandardizeProfLicFile (string filedate, boolean pUseProd = false):= MODULE
	EXPORT Base	:= FUNCTION
																																																// 25,000 - 48 min
		baseFile	:= HMS_SureScripts.Files(filedate,pUseProd).Proc_Lic_File_Input;
		HMS_SureScripts.layouts.Prof_lic_Taxonomy_Mapping tMapping(HMS_SureScripts.layouts.Prof_lic_Taxonomy_Input L) := TRANSFORM
		
			SELF.Date_Imported			:= (unsigned)filedate;
			
			SELF.Taxonomy := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.Taxonomy)), LEFT, RIGHT);
			SELF.Raw_License_Type := TRIM(Stringlib.StringToUpperCase(stringlib.stringcleanspaces(L.Raw_License_Type)), LEFT, RIGHT);
			SELF  :=  L;
			SELF  :=  [];
		END; // Transform
		
		RETURN PROJECT(baseFile, tMapping(LEFT));
				
	END; // Function
	
END;