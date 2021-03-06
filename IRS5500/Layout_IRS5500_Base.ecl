import bipv2;

EXPORT Layout_IRS5500_Base := RECORD
	UNSIGNED6 bdid := 0;
	UNSIGNED8 did := 0;
	Layout_In;
	BOOLEAN   mail_addr;
	QSTRING10 spons_prim_range := '';
	STRING2   spons_predir := '';
	QSTRING28 spons_prim_name := '';
	QSTRING4  spons_addr_suffix := '';
	STRING2   spons_postdir := '';
	QSTRING10 spons_unit_desig := '';
	QSTRING8  spons_sec_range := '';
	QSTRING25 spons_p_city_name := '';
	QSTRING25 spons_v_city_name := '';
	STRING2   spons_st := '';
	QSTRING5  spons_zip5 := '';
	QSTRING4  spons_zip4 := '';
	QSTRING4  spons_cart := '';
	STRING1   spons_cr_sort_sz := '';
	QSTRING4  spons_lot := '';
	STRING1   spons_lot_order := '';
	STRING2   spons_dpbc := '';
	STRING1   spons_chk_digit := '';
	STRING2   spons_rec_type := '';
	QSTRING5  spons_county := '';
	QSTRING10 spons_geo_lat := '';
	QSTRING11 spons_geo_long := '';
	QSTRING4  spons_msa := '';
	QSTRING7  spons_geo_blk := '';
	STRING1   spons_geo_match := '';
	QSTRING4  spons_err_stat := '';

	QSTRING5  spons_sign_title;
	QSTRING20 spons_sign_fname;
	QSTRING20 spons_sign_mname;
	QSTRING20 spons_sign_lname;
	QSTRING5  spons_sign_suffix;
	UNSIGNED1 spons_sign_name_score;
END;