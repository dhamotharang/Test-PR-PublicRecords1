import business_header,doxie,ut;

export layout_biz_search := module

	export result_with_input := record
		unsigned6 group_id := 0;
		Business_Header.Layout_BH_Best;
		Business_Header.Layout_Business_Contact_Plus.ssn;
		Business_Header.Layout_Business_Contact_Plus.lname;
		Business_Header.Layout_Business_Contact_Plus.fname;
		Business_Header.Layout_Business_Contact_Plus.mname;
		Business_Header.Layout_Business_Contact_Plus.name_suffix;
		Business_Header.Layout_Business_Contact_Plus.title;
		Business_Header.Layout_Business_Contact_Plus.company_title;
		string4 timezone;
		boolean verified;
		unsigned1 seq;
		unsigned1 score;
		string6 CBRS := 'report';
		string6 CBRS_Raw := 'report';
		string6 Profile := 'report';
		string6 Profile_Raw := 'report';
		
		string120 input_company_name_value;
		string25 input_city_value;
		string2 input_state_value;
		string5 input_zip_value;
		unsigned2 input_mile_radius_value;
	end;

	EXPORT result_with_input_and_dt_first_seen := RECORD
	  result_with_input;
		UNSIGNED4 dt_first_seen := 0;
	END;

	export result := record
		unsigned6 group_id;
		unsigned6 bdl;
		Business_Header.Layout_BH_Best;
		string4 timezone;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5 name_suffix;
		string9 ssn;
		qstring35 company_title;
		unsigned1 seq;
		// unsigned pts;
		unsigned1 score;
		unsigned2 contact_score;
	end;
	
	export result_dateRange := record
		unsigned4 firstSeenDate;
		unsigned4 lastSeenDate;
	  result;
  end;				

	SHARED Layout_BH_BestAlt := RECORD(Business_Header.Layout_BH_Best - fein)
		STRING9			fein := '';
	END;

	EXPORT resultAlt := RECORD(result - Business_Header.Layout_BH_Best)
		Layout_BH_BestAlt;
	END;

	EXPORT resultAlt fromResultToResultAlt(result_dateRange input) := TRANSFORM
		SELF.fein := IF(input.fein <> 0, INTFORMAT(input.fein, 9, 1), '');
		SELF := input;
	END;

	export bdid_rec := record
		result.bdid;
	end;
	
	export bdid_rec_ext := record
		result.group_id;
		result.bdl;
		result.score;
		result.best_flags;
		bdid_rec b;
	end;
	
	export name_rec := record
		result.company_name;
		result.score;
		result.best_flags;
	end;
	
	export name_rec_ext := record
		result.group_id;
		result.bdl;
		name_rec n;
	end;		
	
	export phone_rec := record
		result.phone;
		string4 timezone;
		boolean verified;
	end;
	
	export address_rec := record
	  unsigned4 firstSeenDate;
		unsigned4 lastSeenDate;
		result.prim_range;
		result.predir;
		result.prim_name;
		result.addr_suffix;
		result.postdir;
		result.unit_desig;
		result.sec_range;
		result.city;
		result.state;
		string5 zip;
		string4 zip4;	
		result.dt_last_seen;
		dataset(phone_rec) phoneRecs{maxcount(50)};
		result.score;
		result.best_flags;
	end;
	
	export address_rec_ext := record
		result.group_id;
		result.bdl;
		address_rec a;
	end;
	
	export address_rec_extPhone := record
		address_rec_ext;
		boolean phoneExists;
	end;
	
	export fein_rec := record
		result.fein;
	end;

	EXPORT fein_recAlt := RECORD
		resultAlt.fein;
	END;

	export fein_rec_ext := record
		result.group_id;
		result.bdl;
		fein_rec f;
	end;
	
	export title_rec := record
		result.company_title;
	end;
	
	export contact_rec := record
		result.fname;
		result.mname;
		result.lname;
		result.name_suffix;
		result.ssn;
		dataset(title_rec) company_titles{maxcount(25)};
	end;
	
	export contact_rec_ext := record
		result.group_id;
		result.bdl;
		result.contact_score;
		contact_rec c;
	end;
	
  export src_rec := record
		string50  src_desc;
	  unsigned6 docCnt;
  end;
	
  export sic_rec := record
		string4  sic_code;
		string97 sic_descriptions;
  end;
	
	export no_group_info := record
		boolean multi_bdid_flag;
		unsigned6	group_id;
		unsigned6 bdl;
		string bdid_list;
		// result.pts;
		result.score;
		result.best_flags;
		result.contact_score;
		dataset(bdid_rec) bdidRecs{maxcount(2000)};
		dataset(name_rec) nameRecs{maxcount(200)};
		dataset(address_rec) addressRecs{maxcount(200)};
		dataset(fein_rec) feinRecs{maxcount(50)};
		dataset(contact_rec) contactRecs{maxcount(100)};
		dataset(src_rec) sourceRecs {maxcount(ut.limits.BHEADER_PER_GID)};
		string src_cnt;
	  string src_doc_cnt;
		dataset(src_rec) groupsourceRecs {maxcount(ut.limits.BHEADER_PER_GID)};
		string group_id_src_cnt;
	  string group_id_src_doc_cnt;
		dataset(sic_rec) sicRecs{maxcount(ut.limits.SICS_PER_GID)};
	end;

	EXPORT final := RECORD
		no_group_info;
		boolean pos_sos := false;
		boolean pos_ucc := false;
		boolean pos_ucc_v2 := false;
		boolean pos_prop := false;
		boolean pos_mvr := false;
		boolean pos_cont := false;
		boolean group_id_fromdca := false;
		qstring120 group_id_company_name := '';
		qstring10 group_id_prim_range := '';
		string2 group_id_predir := '';
		qstring28 group_id_prim_name := '';
		qstring4 group_id_addr_suffix := '';
		string2 group_id_postdir := '';
		qstring5 group_id_unit_desig := '';
		qstring8 group_id_sec_range := '';
		qstring25 group_id_city := '';
		string2 group_id_state := '';
		unsigned3 group_id_zip := 0;
		unsigned2 group_id_zip4 := 0;
		unsigned6 group_id_phone := 0;
		string4 group_id_timezone := '';
		unsigned4 group_id_fein := 0;
		boolean group_id_pos_sos := false;
		boolean group_id_pos_ucc := false;
		boolean group_id_pos_ucc_v2 := false;
		boolean group_id_pos_prop := false;
		boolean group_id_pos_mvr := false;
		boolean group_id_pos_cont := false;
	end;

	EXPORT finalAlt := RECORD(final - feinRecs)
		dataset(fein_recAlt) feinRecs{maxcount(50)};
	END;

	EXPORT finalAlt fromFinalToFinalAlt(final input) := TRANSFORM
		fein_recAlt cnv(fein_rec input) := TRANSFORM
			SELF.fein := IF(input.fein <> 0, INTFORMAT(input.fein, 9, 1), '');
		END;

		SELF.feinRecs := PROJECT(input.feinRecs, cnv(LEFT));
		SELF := input;
	END;

end;
