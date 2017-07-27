import mxd_Common;

export Layouts_build := MODULE

	export PartyType 	:= ENUM(unsigned1, PERSON, ESTATE, BUSINESS, NONPROFIT, COOP, CREDITUNION, GOVERNMENT, UNKNOWN);
	export NatureType := ENUM(unsigned1, PENAL, CONSTRUCTIVE_PENAL, AMBIDEXTROUS, CIVIL, Q, X, UNKNOWN);
	export Ethnicity 	:= ENUM(unsigned1, WESTERN,ASIAN,LATIN_AMERICAN);

	
	export Temp 	:= record
		unsigned8			rec_id;
		unicode60			geography;
		string3				geoCode;
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
		unicode400		OrgName;		
		
	end;
	
	export parsed	:=	record
		Temp;
		unsigned8 		person_id :=0;
		unicode50 		firstName:= u'';
		unicode50 		middleName1:= u'';
		unicode20 		middleName2 := u'';
		unicode20 		middleName3 := u'';
		unicode20 		middleName4 := u'';
		unicode20 		middleName5 := u'';
		unicode50 		lastName :=u'';
		unicode50 		matronymic := u'';
		unicode50 		husbandslastname := u''	;		
		unicode50 		patronymic := u''	;	
		string1 			gender := ''	;	
		unicode200 		full_name :=u'';
		unicode500 		unparsed_name :=u'';
		boolean 			not_parsed :=false;
		boolean 			is_org :=false;
		string20 			name_format :='';
		Ethnicity 		ethnicity :=0;
		boolean 			isParty1 :=false;
		boolean 			isParty2 :=false;	
	END;
	
	export base	:=	record
		unsigned8			rec_id;
		unicode60			geography;
		string3				geoCode;
		unsigned4			date_pub;
		unicode100		court;
		unicode100		court_local;
		unicode100		docket;
		unicode50			docket_num;
		unsigned3			docket_year;
		unicode400		caption;
		unicode150		nature;
		unsigned1			nature_type;
		string20			natureTypeDesc;
		unicode250		comment;
		unsigned4			date_hearing;
		unicode400		partyOriginal;
		unicode400		partyName;
		unicode100		partyAlias;
		string1				partyNumber;
		string1				PartyOcc;
		unsigned1			partyType;
		string30			partyTypeDesc;	
		unsigned8			entity_id;
		unicode400		OrgName;		
		unsigned8 		person_id :=0;
		unicode50 		firstName:= u'';
		unicode50 		middleName1:= u'';
		unicode20 		middleName2 := u'';
		unicode20 		middleName3 := u'';
		unicode20 		middleName4 := u'';
		unicode20 		middleName5 := u'';
		unicode50 		lastName :=u'';
		unicode50 		matronymic := u'';
		unicode50 		husbandslastname := u''	;		
		unicode50 		patronymic := u''	;	
		string1 			gender := ''	;	
		unicode200 		full_name :=u'';
		string20 			name_format :='';
		unsigned1 		ethnicity;
		string30			ethnicityDesc;
		string8				process_Date;
		string8				dt_first_seen;
		string8				dt_last_seen;
	end;
	
	export NewChg	:=	record
		unicode				item_id := u'';
		unicode				geography := u'';
		unicode				date_pub := u'';
		unicode				court := u'';
		unicode				court_local := u'';
		unicode				docket := u'';
		unicode				caption := u'';
		unicode				nature := u'';
		unicode				comment := u'';
		unicode				date_hearing := u'';
		unicode				party1 := u'';
		unicode				party2 := u'';
	end;
	
	export Delete	:=	record 
		unicode				item_id := u'';
	end;
	
	export NatureClass := RECORD,maxlength(10000)
		UNICODE		nature;
		STRING		mx_class;
		STRING		us_class;
	END;	
	
	export DocketPerson := RECORD
	RECORDOF(mxd_Common.Layouts.L_MXPerson);
	boolean isParty1 :=false;
	boolean isParty2 :=false;
	END;
	
	end;