IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, watchdog,
VersionControl,lib_fileservices,Health_Provider_Services, hxmx, Scrubs, Scrubs_HX,Scrubs_MX;



EXPORT Scrub_HXMX (string filedate, boolean pUseProd = false) := MODULE
	
	EXPORT Scrubit_HX := FUNCTION
			recordsToScrub := DEDUP(Scrubs_HX.HX_In_HX(filedate).In_HX,all);//DEDUP(hxmx.Files(filedate,pUseProd).hx_input, all);
			Scrub_HX := hxmx.fn_scrub_hxmx_hx(recordsToScrub, filedate, pUseProd);
			
			return Scrub_HX;
	END;
	
	EXPORT Scrubit_MX := FUNCTION
			recordsToScrub := Scrubs_MX.MX_In_MX(filedate).In_MX;//hxmx.Files(filedate,pUseProd).mx_input;
			Scrub_MX := hxmx.fn_scrub_hxmx_mx(recordsToScrub, filedate, pUseProd);
			
			return Scrub_MX;
	END;
	

END;