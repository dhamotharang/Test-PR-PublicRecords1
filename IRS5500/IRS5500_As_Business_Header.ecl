IMPORT Business_Header;

f := File_IRS5500_Base;

Business_Header.Layout_Business_Header Proj(f l) := TRANSFORM
	SELF.source := 'I';          // Source file type
	SELF.source_group := l.document_locator_number;
	SELF.vendor_id := l.document_locator_number; // Vendor key
	SELF.dt_first_seen := (UNSIGNED4) l.trans_date;   // Date record first seen at Seisint
	SELF.dt_last_seen := (UNSIGNED4) l.trans_date;    // Date record last (most recently seen) at Seisint
	SELF.dt_vendor_first_reported := (UNSIGNED4) l.trans_date;
	SELF.dt_vendor_last_reported := (UNSIGNED4) l.trans_date;
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
	SELF.county := l.spons_county;
	SELF.msa := l.spons_msa;
	SELF.geo_lat := l.spons_geo_lat;
	SELF.geo_long := l.spons_geo_long;
	SELF.phone := (UNSIGNED6) ((UNSIGNED8) l.spon_dfe_phone_num);
	SELF.phone_score := IF(SELF.phone = 0, 0, 1);
	SELF.fein := (UNSIGNED4) l.ein;        // Federal Tax ID
	SELF.current := TRUE;          // Current/Historical indicator
END;

as_bh := PROJECT(f, Proj(LEFT));

EXPORT IRS5500_As_Business_Header := as_bh : PERSIST('TEMP::IRS5500_As_Business_Header');