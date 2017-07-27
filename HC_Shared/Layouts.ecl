EXPORT Layouts := module

// Common Base File reference fields - present in all base files
EXPORT Common := RECORD
		UNSIGNED8		source_rid;
		STRING20			persistent_rid;
		STRING15			source_name;
		STRING10			src;
		// these dates reflect the build dates when the data was seen
		UNSIGNED4 		dt_vendor_first_reported;
		UNSIGNED4 		dt_vendor_last_reported;
		// these date reflect logical dates from the data, but default to vendor dates
		UNSIGNED4		dt_first_seen;
		UNSIGNED4		dt_last_seen;
		// following dates are used for Point In Time processing
		UNSIGNED4 		startdate;
		UNSIGNED4 		enddate;
		// 'C' for new in current build, 'H' for last updated in prior build
		STRING1			history_or_current;
END;


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

export Scores_and_Weights_BDID := record
	unsigned8		bdid			:= 0;
	unsigned2		bdid_score	:= 0;
	Scores_and_Weights_PROX;
	Scores_and_Weights_SELE;
end;

EXPORT Scores_and_Weights_All := RECORD
	Scores_and_Weights_RAWAID;
	Scores_and_Weights_LNPID;
	Scores_and_Weights_LNFID;
	Scores_and_Weights_DID;
	Scores_and_Weights_BDID;
END;

// Sample Facility Layout -> this should be in the source build's layout attribute
//  EXPORT Source_name_base	:= record
//		source-specific-infile-layout
//		HC_Shared.Layouts.Common;
//		HC_Shared.Layouts.Clean_Location pay_center_location;
//		HC_Shared.Layouts.Clean_Location prov_info_location;                          
//		clean_company_name
//		source-specific-clean_fields
//		HC_Shared.Layouts.Scores_and_Weights_RAWAID;
//		HC_Shared.Layouts.Scores_and_Weights_LNFID;
//		HC_Shared.Layouts.Scores_and_Weights_BDID;
//	end;

//  not sure we need the rest of this...
/*
EXPORT Scores_and_Weights_NID := RECORD
	UNSIGNED8		nid;
END;

// Does Score go here?
EXPORT Scores_and_Weights_DID := RECORD
	STRING12		did;
	STRING3			score;
END;

EXPORT Scores_and_Weights_BDID := RECORD
	STRING12		bdid;
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

EXPORT Scores_and_Weights_POW := RECORD
	UNSIGNED6		powid;
	UNSIGNED2		powscore;
	UNSIGNED2		powweight;
END;

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
*/

END;
