IMPORT hms_kop_trgt_harv,HC_Shared;

EXPORT Layouts := MODULE

	// Common Address Cleaner fields for Healthcare Base Files
		EXPORT Clean_Location := RECORD
				STRING10		prim_range;
				STRING2		predir;
				STRING28		prim_name;
				STRING4		addr_suffix;
				STRING2		postdir;
				STRING10		unit_desig;
				STRING8		sec_range;
				STRING25		p_city_name;
				STRING25		v_city_name;
				STRING2		st;
				STRING5		zip;
				STRING4		zip4;
				STRING2		rec_type;
				STRING5		county;
				STRING10		geo_lat;
				STRING11		geo_long;
				STRING4		msa;
				STRING7		geo_blk;
				STRING1		geo_match;
				STRING4		err_stat;
				STRING18		county_name;
				// need lid/agid and advo flags
				unsigned6	hms_lid						:= 0;
				unsigned6	hms_agid						:= 0;
				string1		advo_home_or_business	:= '';
		END;

		EXPORT Clean_Indiv_Name := RECORD
			STRING5		title;
			STRING20		fname;
			STRING20		mname;
			STRING20		lname;
			STRING5		name_suffix;
			STRING3		name_score;
		END;

		EXPORT Scores_and_Weights_RAWAID := RECORD
			UNSIGNED8		rawaid;
		END;

		// Linking Fields - Included in Base Files as needed

		// Tri-Company Header / Individuals
		EXPORT Scores_and_Weights_LNPID := RECORD
			unsigned8		lnpid;
			unsigned2		lnpid_score;
			unsigned2		lnpid_weight;
			unsigned2		lnpid_distance;
			unsigned4		lnpid_keysused;
		END;

		// Tri-company Header / Facilities and Organizations
		EXPORT Scores_and_Weights_LNFID := RECORD
			unsigned8		lnfid;
			unsigned2		lnfid_score;
			unsigned2		lnfid_weight;
			unsigned2		lnfid_distance;
			unsigned4		lnfid_keysused;
		END;

		// LexID from Consumer Header
		EXPORT Scores_and_Weights_DID := RECORD  
			unsigned8		did				:= 0;
			unsigned2		did_score		:= 0;
			unsigned2		weight;
			unsigned2		distance;
			unsigned4		keysused;
		END;

		// Business IDs from BIP Header
		EXPORT Scores_and_Weights_PROX := RECORD
			UNSIGNED6		proxid;
			UNSIGNED2		proxscore;
			UNSIGNED2		proxweight;
		END;

		EXPORT Scores_and_Weights_SELE := RECORD
			UNSIGNED6		seleid;
			UNSIGNED2		selescore;
			UNSIGNED2		seleweight;
		END;

		EXPORT Scores_and_Weights_ORG := RECORD
			UNSIGNED6		orgid;
			UNSIGNED2		orgscore;
			UNSIGNED2		orgweight;
		END;

		EXPORT Scores_and_Weights_ULT := RECORD
			UNSIGNED6		ultid;
			UNSIGNED2		ultscore;
			UNSIGNED2		ultweight;
		END;

		EXPORT Scores_and_Weights_POW := RECORD
			UNSIGNED6		powid;
			UNSIGNED2		powscore;
			UNSIGNED2		powweight;
		END;
		EXPORT Scores_and_Weights_DOT := RECORD
			UNSIGNED6		dotid;
			UNSIGNED2		dotscore;
			UNSIGNED2		dotweight;
		END;

		EXPORT Scores_and_Weights_EMP := RECORD
			UNSIGNED6		empid;
			UNSIGNED2		empscore;
			UNSIGNED2		empweight;
		END;

		export Scores_and_Weights_BDID := record
			unsigned8		bdid			:= 0;
			unsigned2		bdid_score	:= 0;
			Scores_and_Weights_PROX;
			Scores_and_Weights_SELE;
			Scores_and_Weights_ORG;
			Scores_and_Weights_ULT;
			Scores_and_Weights_POW;
			Scores_and_Weights_DOT;
			Scores_and_Weights_EMP;
		end;

		EXPORT Scores_and_Weights_All := RECORD
			Scores_and_Weights_RAWAID;
			Scores_and_Weights_LNPID;
			Scores_and_Weights_LNFID;
			Scores_and_Weights_DID;
			Scores_and_Weights_BDID;
		END;

		EXPORT Company_Information := RECORD
			BOOLEAN			is_company_flag;
			STRING40		cname;
		END;

	EXPORT LAYOUT_IN := RECORD
    STRING FIRST;
    STRING MIDDLE;
    STRING LAST;
    STRING SUFFIX;
    STRING CRED;
    STRING PRACTITIONER_TYPE;
    STRING FIRM_NAME;
    STRING ADDRESS1;
    STRING ADDRESS2;
    STRING CITY;
    STRING STATE;
    STRING ZIP;
    STRING PHONE1;
    STRING PHONE2;
    STRING FAX1;
    STRING DATE_BORN;
    STRING DATE_DIED;
    STRING GENDER;
    STRING STLIC_NUMBER;
    STRING STLIC_STATE;
    STRING STLIC_TYPE;
    STRING STLIC_STATUS;
    STRING STLIC_QUALIFIER;
    STRING STLIC_SUBQUALIFIER;
    STRING STLIC_ISSUE_DATE;
    STRING STLIC_EXP_DATE;
    STRING NPI;
    STRING TAXONOMY_CODE;
    STRING DEA1;
    STRING HMS_SPEC1;
    STRING HMS_SPEC2;
	END;
	
	EXPORT LAYOUT_BASE := RECORD
    LAYOUT_IN;
		string append_prep_address1 := '';
		string append_prep_addresslast := '';
		Clean_Indiv_Name;
		Clean_Location;
		Scores_and_Weights_RAWAID;
		unsigned4 clean_stlic_issue_date := 0;
		unsigned4 clean_stlic_exp_date := 0;
		Scores_and_Weights_LNPID;
		// unsigned8		lnpid;
		// unsigned2		lnpid_score;
		// unsigned2		lnpid_weight;
		// unsigned2		lnpid_distance;
		// unsigned4		lnpid_keysused;
		// unsigned6		did := 0;
		// unsigned6 	bdid := 0;
	END;
	
	EXPORT autokey_common	:= RECORD
			LAYOUT_BASE;
			unsigned1 zero:=0;
			string1 blank:='';
	END;


END;