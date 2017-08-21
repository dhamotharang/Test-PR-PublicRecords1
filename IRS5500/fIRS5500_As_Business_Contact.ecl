IMPORT Business_Header, ut,mdr;

export fIRS5500_As_Business_Contact(dataset(Layout_IRS5500_AID) pIRRS5500)
 :=
  function

	F:=ffixedDate(pIRRS5500);

	// Project to business contact format, then do some filtering.
	Business_Header.Layout_Business_Contact_Full_New Proj(f l) := TRANSFORM
	  SELF.vl_id := l.document_locator_number; // Vendor key
		SELF.vendor_id := l.document_locator_number; // Vendor key
		SELF.dt_first_seen := (UNSIGNED4) l.form_plan_year_begin_date;   // Date record first seen at Seisint
		SELF.dt_last_seen := (UNSIGNED4) l.trans_date;    // Date record last (most recently seen) at Seisint
		SELF.source := MDR.sourceTools.src_IRS_5500;          // Source file type
		SELF.record_type := 'C';     // 'C' = Current, 'H' = Historical
		SELF.company_title := '';   // Title of Contact at Company if available
		SELF.title := l.spons_sign_title;
		SELF.fname := l.spons_sign_fname;
		SELF.mname := l.spons_sign_mname;
		SELF.lname := l.spons_sign_lname;
		SELF.name_suffix := l.spons_sign_suffix;
		SELF.name_score := (STRING1) ((100 - l.spons_sign_name_score) div 10);
		
		SELF.prim_range := l.spons_prim_range;
		SELF.predir := l.spons_predir;
		SELF.prim_name := l.spons_prim_name;
		SELF.addr_suffix := l.spons_addr_suffix;
		SELF.postdir := l.spons_postdir;
		SELF.unit_desig := l.spons_unit_desig;
		SELF.sec_range := l.spons_sec_range;
		SELF.city := l.spons_p_city_name;
		SELF.state := l.spons_st;
		SELF.zip := (UNSIGNED4) l.spons_zip5;
		SELF.zip4 := (UNSIGNED3) l.spons_zip4;
		SELF.county := l.spons_county[3..5];
		SELF.msa := l.spons_msa;
		SELF.geo_lat := l.spons_geo_lat;
		SELF.geo_long := l.spons_geo_long;
		SELF.phone := (UNSIGNED6) ((UNSIGNED8) l.spon_dfe_phone_num);
		SELF.email_address := '';
		SELF.ssn := 0;
		SELF.company_source_group := l.document_locator_number; // Source group
		SELF.company_name := l.sponsor_dfe_name;
		
		SELF.company_prim_range := l.spons_prim_range;
		SELF.company_predir := l.spons_predir;
		SELF.company_prim_name := l.spons_prim_name;
		SELF.company_addr_suffix := l.spons_addr_suffix;
		SELF.company_postdir := l.spons_postdir;
		SELF.company_unit_desig := l.spons_unit_desig;
		SELF.company_sec_range := l.spons_sec_range;
		SELF.company_city := l.spons_p_city_name;
		SELF.company_state := l.spons_st;
		SELF.company_zip := (UNSIGNED4) l.spons_zip5;
		SELF.company_zip4 := (UNSIGNED3) l.spons_zip4;
		SELF.company_phone := (UNSIGNED6) ((UNSIGNED8) l.spon_dfe_phone_num);
		SELF.company_fein := (UNSIGNED4) l.ein;
		SELF.rawaid	:= l.raw_aid;
		SELF.company_rawaid	:= l.raw_aid;
	END;

	contacts := PROJECT(f, Proj(LEFT));
	
	return contacts;
  end
 ;
