EXPORT IntermediaryLayoutWorldBank := MODULE

	EXPORT Baselayout := RECORD
		string7 	ent_key;
		string27 	source;
		string8 	lst_vend_up;
		string200 lstd_entity;
		string200 lstd_aka;
		string3		aka_type;
		string200 address;
		string30 	country;
		string28 	ineligible_st_dt;
		string16 	ineligible_end_dt;
		string100 grounds;
		string10 	rep_date;
		string80 	comments;
		string		orig_raw_name;
	END;

END;