import BIPV2, ut;

export file_firearms_explosives_keybase :=
function

	dATFBase := dataset('~thor_Data400::base::atf_firearms_explosives_BUILDING',layout_firearms_explosives_out_bip,flat);

	did_integer_lay :=
	record
  bipv2.IDlayouts.l_xlink_ids;	//Added for BIP project
	string2 source := ''; 				//Added for FCRA source project
  unsigned4	seq;
	unsigned1	rec_code;
		string12       bdid;
		string3		bdid_score;
		string3		d_score;
		string9		best_ssn;
		unsigned6	did_out;
		string8 date_first_seen;
		string8 date_last_seen;
		string1 expiration_flag;
		string1 record_type;
		string15 license_number;
		string9 Lic_Regn;
		string9 orig_Lic_Dist;
		string2 Lic_Dist;
		string9 Lic_Cnty;
		string9 Lic_Type;
		string11 Lic_Xprdte;
		string9 Lic_Seqn;
		string51 License_Name;
		string51 Business_Name;
		string51 Premise_Street;
		string24 Premise_City;
		string14 Premise_State;
		string17 Premise_orig_Zip;
		string51 Mail_Street;
		string26 Mail_City;
		string11 Mail_State;
		string14 Mail_Zip_Code;
		string11 Voice_Phone;
		string1 irs_region;
		string5 license1_title;
		string20 license1_fname;
		string20 license1_mname;
		string20 license1_lname;
		string5 license1_name_suffix;
		string3 license1_score;
		string51 license1_cname;
		string5 license2_title;
		string20 license2_fname;
		string20 license2_mname;
		string20 license2_lname;
		string5 license2_name_suffix;
		string3 license2_score;
		string51 license2_cname;
		string51 business_cname;
		string10 premise_prim_range;
		string2 premise_predir;
		string28 premise_prim_name;
		string4 premise_suffix;
		string2 premise_postdir;
		string10 premise_unit_desig;
		string8 premise_sec_range;
		string25 premise_p_city_name;
		string25 premise_v_city_name;
		string2 premise_st;
		string5 premise_zip;
		string4 premise_zip4;
		string4 premise_cart;
		string1 premise_cr_sort_sz;
		string4 premise_lot;
		string1 premise_lot_order;
		string2 premise_dpbc;
		string1 premise_chk_digit;
		string2 premise_rec_type;
		string2 premise_fips_st;
		string3 premise_fips_county;
		string18	premise_fips_County_name;
		string10 premise_geo_lat;
		string11 premise_geo_long;
		string4 premise_msa;
		string7 premise_geo_blk;
		string1 premise_geo_match;
		string4 premise_err_stat;
		string10 mail_prim_range;
		string2 mail_predir;
		string28 mail_prim_name;
		string4 mail_suffix;
		string2 mail_postdir;
		string10 mail_unit_desig;
		string8 mail_sec_range;
		string25 mail_p_city_name;
		string25 mail_v_city_name;
		string2 mail_st;
		string5 mail_zip;
		string4 mail_zip4;
		string4 mail_cart;
		string1 mail_cr_sort_sz;
		string4 mail_lot;
		string1 mail_lot_order;
		string2 mail_dpbc;
		string1 mail_chk_digit;
		string2 mail_rec_type;
		string2 mail_fips_st;
		string3 mail_fips_county;
		string10 mail_geo_lat;
		string11 mail_geo_long;
		string4 mail_msa;
		string7 mail_geo_blk;
		string1 mail_geo_match;
		string4 mail_err_stat;
		string1 lf := '';
		unsigned8 persistent_record_id := 0;
	end;

	dIntegerDID := project(dATFBase, transform(did_integer_lay,self.did_out := (unsigned6)left.did_out, self := left));

	ut.mac_suppress_by_phonetype(dIntegerDID,Voice_Phone,premise_st,dWAPhoneSuppressed,true,did_out);

	dBack2BaseLayout := project(dWAPhoneSuppressed
		,transform(layout_firearms_explosives_out_bip
			,self.did_out := if (left.did_out = 0,'',intformat(left.did_out, 12, 1));
			,self 				:= left;
		)
	);

	return dBack2BaseLayout;

end;
