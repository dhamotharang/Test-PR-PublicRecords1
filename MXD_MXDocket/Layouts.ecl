import mxd_Common;

export Layouts := MODULE

	export PartyType := ENUM(unsigned1, PERSON, ESTATE, BUSINESS, NONPROFIT, COOP, CREDITUNION, GOVERNMENT, UNKNOWN);
	export NatureType := ENUM(unsigned1, PENAL, CONSTRUCTIVE_PENAL, AMBIDEXTROUS, CIVIL, Q, X, UNKNOWN);
	
	export L_MXDocket := RECORD
		unsigned8			rec_id;
		unicode60			geography;
		unsigned4			date_pub;
		unicode100		court;
		unicode100		court_local;
		unicode100		docket;
		unicode50			docket_num;
		unsigned3			docket_year;
		unicode400		caption;
		unicode150		nature;
		NatureType		nature_type;
		unicode250		comment;
		unsigned4			date_hearing;
		unicode400		party1_original;
		unicode400		party1_occ1;
		unicode400		party1_occ2;
		PartyType			party1_type;
		boolean				party1_multiple;
		unicode400		party2_original;
		unicode400		party2_occ1;
		unicode400		party2_occ2;
		PartyType			party2_type;
		boolean				party2_multiple;
		unsigned8			entity_id;
	END;
	
	export L_MXDocketFPos := RECORD
		L_MXDocket;
		unsigned8 		fpos{virtual(fileposition)} := 0;
	END;
	
		export L_MXDocketPerson := RECORD
	RECORDOF(mxd_Common.Layouts.L_MXPerson);
	boolean isParty1 :=false;
	boolean isParty2 :=false;
	END;
	
	
export L_NatureClass := RECORD
	UNICODE		nature;
	STRING		mx_class;
	STRING		us_class;
END;

		export L_MXSynonym := RECORD
		unicode50		term1;
		unicode50		term2;
	END;
	
	export L_MXSynonymFPos := RECORD
		L_MXSynonym;
		unsigned8 		fpos{virtual(fileposition)} := 0;
	END;

	export L_MXSynonymM := RECORD
		string20		term1M1;
		string20		term1M2;
		string20		term2M1;
		string20		term2M2;
		L_MXSynonym;
	END;
	
	export L_MXSynonymMFPos := RECORD
		L_MXSynonymM;
		unsigned8 		fpos{virtual(fileposition)} := 0;
	END;
	
	// export Layout_MXDocketPersonName := RECORD
		// string20			metaphone;
		// unsigned1			metaphone_id;
		// unsigned1			synonym;
		// unsigned8			item_id;
		// unsigned1			name_id;
		// unsigned1			part_id;
		// unsigned3			docket_year;
		// Layout_MXDocket.NatureType nature_type;
		// unsigned8 		fpos{virtual(fileposition)} := 0;
// END;

	// export ValIdType := ENUM(unsigned1, M1, M2, S1, S2, YEAR, NATURE);
	
	// export L_MXSearch := RECORD
		// unsigned8		val;
		// ValIdType		val_id;
		// unsigned8		item_id;
		// unsigned1		name_id;
		// unsigned1		part_id;
		// unsigned8 	fpos{virtual(fileposition)} := 0;
	// END;

	// export ValIdType := ENUM(unsigned1, M1, M2, S1, S2, YEAR, NATURE);
	
	// export L_MXSearch := RECORD
		// unsigned8		val;
		// ValIdType		val_id;
		// unsigned8		item_id;
		// unsigned1		name_id;
		// unsigned1		part_id;
		// unsigned8 	fpos{virtual(fileposition)} := 0;
	// END;

END;
