import iesp;

EXPORT BusinessRecord_Layout := RECORD
		unsigned6 cluster_id;
		integer link_count;
		real			degree;
		unsigned6 did;
		unsigned8 fp;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring20 cluster_fname;
		qstring20 cluster_mname;
		qstring20 cluster_lname;
		unsigned1 contact_score;
		unsigned6 bdid;
		qstring120 	company_name;
		qstring10 	company_prim_range;
		qstring2 		company_predir;
		qstring28 	company_prim_name;
		qstring4 		company_addr_suffix;
		qstring2 		company_postdir;
		qstring5 		company_unit_desig;
		qstring8 		company_sec_range;
		qstring25 	company_city;
		string2 	company_state;
		unsigned3 company_zip;
		unsigned2 company_zip4;
		unsigned6 company_phone;
		unsigned4 company_fein;
		string1   Standing;
		boolean		IsMedical;
		string30 	corp_key;
		DATASET(iesp.share.t_StringArrayItem) sic_codes {MAXCOUNT(iesp.Constants.SNA.MaxSIC_CODES)};
		
END;
