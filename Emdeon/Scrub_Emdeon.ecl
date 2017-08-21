IMPORT Address, Ut, lib_STRINGlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, emdeon, Scrubs, Scrubs_Emdeon_DRecord, Scrubs_Emdeon_CRecord, Scrubs_Emdeon_SRecord;


EXPORT Scrub_Emdeon (string filedate, boolean pUseProd = false) := MODULE
	
  	EXPORT Scrubit_CRecord := FUNCTION
   			rawFile := Scrubs_Emdeon_CRecord.CRecord_In_CRecord(filedate).In_CRecord;//emdeon.Files(filedate,pUseProd).claims_input;
   			recordsToScrub := PROJECT(rawFile,transform(recordof(rawFile),self := left));//PROJECT(rawFile, emdeon.layouts.input.c_record);
   			Scrub_CRecord := emdeon.fn_scrub_emdeon_crecord(recordsToScrub, filedate, pUseProd);
   	
   			return Scrub_CRecord;
   	END;
   	
   	EXPORT Scrubit_SRecord := FUNCTION
   			rawFile	:= Scrubs_Emdeon_SRecord.SRecord_In_SRecord(filedate).In_SRecord;//emdeon.Files(filedate,pUseProd).splits_input;
   			recordsToScrub := PROJECT(rawFile,transform(recordof(rawFile),self := left));//PROJECT(rawFile, emdeon.layouts.input.s_record);
   			Scrub_SRecord := emdeon.fn_scrub_emdeon_srecord(recordsToScrub, filedate, pUseProd);
   			
   			return Scrub_SRecord;
   	END;

	
	EXPORT Scrubit_DRecord := FUNCTION
			recordsToScrub := Scrubs_Emdeon_DRecord.DRecord_In_DRecord(filedate).In_DRecord;//emdeon.Files(filedate,pUseProd).detail_input;
			Scrub_DRecord := emdeon.fn_scrub_emdeon_drecord(recordsToScrub, filedate, pUseProd);
			
			return Scrub_DRecord;
	END;
	
	
END;