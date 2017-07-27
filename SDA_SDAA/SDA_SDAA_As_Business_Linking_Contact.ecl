IMPORT BIPV2, ut, mdr, _Validate;

EXPORT SDA_SDAA_As_Business_Linking_Contact (
	  DATASET(SDA_SDAA.Layouts.base) pSDA  = SDA_SDAA.File_SDA_Base,
    DATASET(SDA_SDAA.Layouts.base) pSDAA = SDA_SDAA.File_SDAA_Base) := FUNCTION
  	
	  //CONTACT MAPPING
		BIPV2.Layout_Business_Linking_Full trfMAPBLInterface(SDA_SDAA.Layouts.base l) := TRANSFORM																							 
				SELF.source                      := l.source;       
				SELF.dt_first_seen               := IF(_Validate.date.fIsValid((STRING)l.dt_first_seen), l.dt_first_seen, 0);
				SELF.dt_last_seen                := IF(_Validate.date.fIsValid((STRING)l.dt_last_seen), l.dt_last_seen, 0);
// 				SELF.dt_vendor_first_reported    := IF(_Validate.date.fIsValid(l.dt_vendor_first_reported), (UNSIGNED4)l.dt_vendor_first_reported, 0);
//				SELF.dt_vendor_last_reported     := IF(_Validate.date.fIsValid(l.dt_vendor_last_reported), (UNSIGNED4)l.dt_vendor_last_reported, 0);
				SELF.company_bdid			   	       := l.bdid;
				SELF.company_name 			         := l.company_name;
				SELF.company_address.prim_range  := l.prim_range;
				SELF.company_address.predir      := l.predir;
				SELF.company_address.prim_name   := l.prim_name;
				SELF.company_address.addr_suffix := l.addr_suffix;
				SELF.company_address.postdir     := l.postdir;
				SELF.company_address.unit_desig  := l.unit_desig;
				SELF.company_address.sec_range   := l.sec_range;
				SELF.company_address.p_city_name := l.city;
				SELF.company_address.v_city_name := l.city;
				SELF.company_address.st          := l.state;
				SELF.company_address.zip	       := (STRING)l.zip;
				SELF.company_address.zip4        := (STRING)l.zip4;
				SELF.company_fein 			         := (STRING)l.company_fein;
				SELF.company_phone 			         := (STRING)l.company_phone;
				SELF.phone_type   			         := 'T';
				SELF.contact_name.title          := l.title;
				SELF.contact_name.fname          := l.fname;
				SELF.contact_name.mname          := l.mname;
				SELF.contact_name.lname          := l.lname;
				SELF.contact_name.name_suffix		 := l.name_suffix;
				SELF.contact_ssn                 := (STRING)l.ssn;
				SELF.contact_email               := l.email_address;
				SELF.contact_phone               := (STRING)l.phone;
				SELF 							   						 := l;
				SELF 							   						 := [];
		end;
																										
		from_sda_sdaa_proj	:= PROJECT(pSDA + pSDAA, trfMAPBLInterface(LEFT));
																	
		from_sda_sdaa_dedp  := DEDUP(SORT(DISTRIBUTE(from_sda_sdaa_proj,HASH(company_bdid,company_name, company_fein)),RECORD, LOCAL),RECORD, LOCAL);

		RETURN from_sda_sdaa_dedp;
END;