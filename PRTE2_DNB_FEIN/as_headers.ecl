IMPORT header, business_header, mdr, _Validate, Address, PRTE2_DNB_FEIN, DNB_FEINV2, Experian_FEIN, _validate, STD;

EXPORT as_headers := MODULE
		//For People Records
		//This data does not contain DID records so no people header created

		//For Business Records DNB FEIN
	SHARED	NewDNB	:= PROJECT(PRTE2_DNB_FEIN.Files.Main_di_ref, TRANSFORM(DNB_FEINV2.layout_DNB_fein_base_main_new, SELF := LEFT));
	
	EXPORT business_header_dnbfein := FUNCTION
		RETURN	DNB_FEINV2.As_Business_Header.fDnbFeinV2(NewDNB((unsigned)bdid>0), true);
	END;
																					
	//New Business Header with Contacts
	EXPORT new_business_header_dnbfein := FUNCTION
		RETURN DNB_FEINV2.fDNB_FEIN_As_Business_Linking(NewDNB((unsigned)bdid>0));
	END;
	
	//For Business Records Experian FEIN
	Process_date	:= Std.Date.Today();
	
	business_header.Layout_Business_Header_New tAsBusinessHeader(Experian_FEIN.Layouts.base l) := TRANSFORM
			SELF.bdid  										:= (integer)l.BDID;
			SELF.group1_id 								:= l.source_rec_id;
			SELF.vl_id 								    := trim(l.Business_Identification_Number) + trim(l.Norm_Tax_ID);
			SELF.vendor_id 								:= trim(l.Business_Identification_Number) + trim(l.Norm_Tax_ID);
			SELF.phone 										:= 0;
			SELF.phone_score 							:= IF(self.Phone = 0, 0, 1);
			SELF.source 									:= l.source;
			SELF.source_group 						:= trim(l.Business_Identification_Number) + trim(l.Norm_Tax_ID);
			SELF.company_name 						:= l.Business_Name;
			SELF.dt_first_seen 						:= (unsigned4)l.dt_vendor_first_reported;
			SELF.dt_last_seen 						:= (unsigned4)Process_date;
			SELF.dt_vendor_first_reported	:= (UNSIGNED4)l.dt_vendor_first_reported;
			SELF.dt_vendor_last_reported	:= (UNSIGNED4)l.dt_vendor_last_reported;
			SELF.fein 										:= (UNSIGNED4)l.Norm_Tax_ID;
			SELF.current 									:= true;
			SELF.prim_range 							:= L.prim_range;
			SELF.predir 									:= L.predir;
			SELF.prim_name 								:= L.prim_name;
			SELF.addr_suffix 							:= L.addr_suffix;
			SELF.postdir 									:= L.postdir;
			SELF.unit_desig 							:= L.unit_desig;
			SELF.sec_range 								:= L.sec_range;
			SELF.city 										:= L.v_city_name;
			SELF.state 										:= L.st;
			SELF.zip 											:= (UNSIGNED3)L.zip;
			SELF.zip4 										:= (UNSIGNED2)L.zip4;
			SELF.county 									:= L.fips_county;
			SELF.msa 											:= L.msa;
			SELF.geo_lat 									:= L.geo_lat;
			SELF.geo_long 								:= L.geo_long;
			SELF.dppa											:= false;
		END;
		
	EXPORT business_header_experianfein := PROJECT(PRTE2_DNB_FEIN.Files.Experian_base((unsigned)bdid>0),tAsBusinessHeader(LEFT)); 
		
	//New Business Header with Contacts
	EXPORT new_business_header_experianfein := FUNCTION
		RETURN Experian_FEIN.As_Business_Linking(,PRTE2_DNB_FEIN.Files.Experian_base((unsigned)bdid>0), true);
	END;
	
END;