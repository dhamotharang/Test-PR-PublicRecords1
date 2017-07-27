IMPORT _Validate, Business_Header,mdr;

export fIRS5500_As_Business_Header(dataset(Layout_IRS5500_AID) pIRRS5500)
 :=
  function

	f := pIRRS5500;

	Business_Header.Layout_Business_Header_New Proj(f l) := TRANSFORM
		SELF.source := MDR.sourceTools.src_IRS_5500;          // Source file type
		SELF.source_group := l.document_locator_number;
		SELF.vl_id := l.document_locator_number; // Vendor key
		SELF.vendor_id := l.document_locator_number; // Vendor key
		// trans_date only exists for old data and date_received only exists for the newer data
		the_date := IF(l.trans_date != '', l.trans_date, l.date_received);
		the_valid_date := IF(_Validate.Date.fIsValid(the_date), the_date, '');
		SELF.dt_first_seen := (UNSIGNED4) the_valid_date;   // Date record first seen at Seisint
		SELF.dt_last_seen := (UNSIGNED4) the_valid_date;    // Date record last (most recently seen) at Seisint
		SELF.dt_vendor_first_reported := (UNSIGNED4) the_valid_date;
		SELF.dt_vendor_last_reported := (UNSIGNED4) the_valid_date;
		SELF.company_name := l.sponsor_dfe_name;
		SELF.prim_range := l.spons_prim_range;
		SELF.predir := l.spons_predir;
		SELF.prim_name := l.spons_prim_name;
		SELF.addr_suffix := l.spons_addr_suffix;
		SELF.postdir := l.spons_postdir;
		SELF.unit_desig := l.spons_unit_desig;
		SELF.sec_range := l.spons_sec_range;
		SELF.city := l.spons_p_city_name;
		SELF.state := l.spons_st;
		SELF.zip := (UNSIGNED3) l.spons_zip5;
		SELF.zip4 := (UNSIGNED2) l.spons_zip4;
		SELF.county := l.spons_county[3..5];
		SELF.msa := l.spons_msa;
		SELF.geo_lat := l.spons_geo_lat;
		SELF.geo_long := l.spons_geo_long;
		SELF.phone := (UNSIGNED6) ((UNSIGNED8) l.spon_dfe_phone_num);
		SELF.phone_score := IF(SELF.phone = 0, 0, 1);
		SELF.fein := (UNSIGNED4) l.ein;        // Federal Tax ID
		SELF.current := TRUE;          // Current/Historical indicator
		SELF.rawaid := l.raw_aid;
	END;

	as_bh := PROJECT(f, Proj(LEFT));

	return as_bh;
  end
 ;
