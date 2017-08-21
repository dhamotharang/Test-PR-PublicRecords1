IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,HMS_CSR,Scrubs_HMS_Csr,Scrubs;

EXPORT Scrub_HmsCsr (string filedate, boolean pUseProd = false) := MODULE
	
	EXPORT Scrubit := FUNCTION
			recordsToScrub := HMS_CSR.StandardizeInputFile(filedate,pUseProd).CsrCredential;
			Scrub_Result := HMS_CSR.fn_scrub_hmscsr(recordsToScrub, filedate);
			
			return Scrub_Result;
	END;
	
END;