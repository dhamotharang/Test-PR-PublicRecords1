import Business_Header, ut;

export fACF_As_Business_Header(dataset(recordof(File_ACF_Base)) pFile_ACF) :=
function

	Business_Header.Layout_Business_Header_New  Translate_ACF_to_BHF(pFile_ACF pInput) := 
	TRANSFORM
      SELF.vl_id            := '';
			SELF.rcid 						:= 0;
			SELF.bdid 						:= 0;
			SELF.source_group 				:= (STRING) hash(pInput.company_name);
			SELF.group1_id 					:= 0;
			SELF.vendor_id 					:= pInput.vendor_id + hash(pInput.company_name);
			SELF.dt_vendor_first_reported 	:=  pInput.dt_first_seen ;
			SELF.dt_vendor_last_reported 	:=  pInput.dt_last_seen;
			SELF.current 					:= true;
			SELF.prim_range 					:= pInput.company_prim_range ;
			SELF.predir 					:= pInput.company_predir ;
			SELF.prim_name 					:= pInput.company_prim_name ;
			SELF.addr_suffix					:= pInput.company_addr_suffix;
			SELF.postdir 					:= pInput.company_postdir ;
			SELF.unit_desig 					:= pInput.company_unit_desig; 
			SELF.sec_range 					:= pInput.company_sec_range; 
			SELF.city						:= pInput.company_city;
			SELF.state						:= pInput.company_state;
			SELF.zip 						:= pInput.company_zip ;
			SELF.zip4 						:= pInput.company_zip4 ;
			SELF.geo_lat 					:= pInput.geo_lat ;
			SELF.geo_long 					:= pInput.geo_long ;
			SELF.msa 						:= pInput.msa ;
			SELF.county						:= pInput.county;
			SELF.phone 						:= pInput.company_phone ;
			SELF 				            := pInput;
		
		
	END;
	
	ACF_as_BHF := Dedup(project(pFile_ACF(company_name <> ''),Translate_ACF_to_BHF(left)),all
	                    ,except dt_last_seen,
						        dt_first_seen,
								dt_vendor_first_reported, 
								dt_vendor_last_reported );
	return ACF_as_BHF;

end; 