IMPORT BIPV2, ut, mdr, _Validate, header;

EXPORT MS_Workers_As_Business_Linking_Contact (
	  DATASET(govdata.Layout_MS_Workers_Comp_base) pBase  = govdata.File_MS_Workers_Comp_BDID) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(govdata.Layout_MS_Workers_Comp_base l) := TRANSFORM																							 
				SELF.source                      := MDR.sourceTools.src_MS_Worker_Comp;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid(l.date_claim_filed), (UNSIGNED4)l.date_claim_filed,
                                               IF(_Validate.date.fIsValid(l.date_of_injury), (UNSIGNED4)l.date_of_injury,
                                                  IF(_Validate.date.fIsValid(l.date_first_seen), (UNSIGNED4)l.date_first_seen, 0)));
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid(l.date_last_seen), (UNSIGNED4)l.date_last_seen, 0);
				SELF.dt_vendor_first_reported    := SELF.dt_first_seen;
				SELF.dt_vendor_last_reported     := SELF.dt_last_seen;
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.employer_name;
				SELF.company_address.prim_range  := l.emp_prim_range;
				SELF.company_address.predir      := l.emp_predir;
				SELF.company_address.prim_name   := l.emp_prim_name;
				SELF.company_address.addr_suffix := l.emp_addr_suffix;
				SELF.company_address.postdir     := l.emp_postdir;
				SELF.company_address.unit_desig  := l.emp_unit_desig;
				SELF.company_address.sec_range   := l.emp_sec_range;
				SELF.company_address.p_city_name := l.emp_p_city_name;
				SELF.company_address.v_city_name := l.emp_v_city_name;
				SELF.company_address.st          := l.emp_st;
				SELF.company_address.zip	       := l.emp_zip5;
				SELF.company_address.zip4        := l.emp_zip4;
				SELF.company_fein 			         := l.employer_fein;
				// SELF.company_phone 			         := (STRING)l.company_phone;
				// SELF.phone_type   			         := 'T';
				SELF.contact_name.title          := l.claim_name_prefix;
				SELF.contact_name.fname          := l.claim_name_first;
				SELF.contact_name.mname          := l.claim_name_middle;
				SELF.contact_name.lname          := l.claim_name_last;
				SELF.contact_name.name_suffix		 := l.claim_name_suffix;
				SELF.contact_ssn                 := IF(header.ssn_length(l.claimant_ssn) = 9, l.claimant_ssn, '');
				// SELF.contact_email               := l.email_address;
				// SELF.contact_phone               := (STRING)l.phone;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_ms_work_proj	:= PROJECT(pBase, trfMAPBLInterface(LEFT));
																	
		from_ms_work_dedp  := DEDUP(SORT(DISTRIBUTE(from_ms_work_proj,HASH(company_bdid, company_name, company_fein)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_ms_work_dedp;
END;