IMPORT PRTE2_UCC, UCCV2;

EXPORT Layouts := MODULE

	EXPORT Main_in := RECORD
		UCCV2.Layout_UCC_Common.Layout_UCC_new - [static_value,date_vendor_removed,continuious_expiration,amount];
		STRING10	bug_num;
		STRING20	cust_name;
	END;
	
	EXPORT Party_in := RECORD
		UCCV2.Layout_UCC_Common.Layout_party_With_AID - [orig_province, bdid_score, source_rec_id,dotid,dotscore,dotweight,empid,empscore,empweight,prep_addr_line1,prep_addr_last_line,rawaid,aceaid];
		STRING20	cust_name;
		STRING10	bug_num;
		STRING8 	link_dob;
		STRING8		link_inc_date;
		STRING9		link_fein;
		STRING9		link_ssn;
	END;
	
	EXPORT Main_ext	:= RECORD, MAXLENGTH(32767)
		UCCV2.Layout_UCC_Common.Layout_UCC_new;
		STRING10	bug_num;
		STRING20	cust_name;
	END;
	
	EXPORT Main	:= RECORD, MAXLENGTH(32767)
		UCCV2.Layout_UCC_Common.Layout_UCC_new;
	END;
	
	EXPORT Party_ext := RECORD, MAXLENGTH(32767)
		UCCV2.Layout_UCC_Common.Layout_party_With_AID;
		STRING20	cust_name;
		STRING10	bug_num;
		STRING8 	link_dob;
		STRING8		link_inc_date;
		STRING9		link_fein;
		STRING9		link_ssn;
	END;

	EXPORT Party := RECORD, MAXLENGTH(32767)
		UCCV2.Layout_UCC_Common.Layout_party_With_AID;
	END;
	
	END;
	