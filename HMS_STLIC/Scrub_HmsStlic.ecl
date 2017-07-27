IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services,Health_Facility_Services,
BIPV2_Company_Names, HealthCareFacility,HMS_STLIC,Scrubs_HMS_STLIC,Scrubs;

EXPORT Scrub_HmsStlic (string filedate, boolean pUseProd = false) := MODULE
	
	EXPORT Scrubit := FUNCTION
			recordsToScrub := HMS_STLIC.StandardizeInputFile(filedate,pUseProd).StLicense;
			Scrub_Result := HMS_STLIC.fn_scrub_hmsstlic(recordsToScrub, filedate);
			
			return Scrub_Result;
	END;
	
END;