import mxd_Common;

	
export Layouts := MODULE

export NamePartType := ENUM(unsigned1, FirstName,MiddleName1,MiddleName2,MiddleName3,MiddleName4, Matronymic, Patronymic, LastName, GivenName,HusbandsLastName, MiddleName5,MiddleName6,Alias, AKA, Unknown, Title,Suffix);


	export	L_MXNameStats := RECORD
		UNICODE60 name_part_text;
		NamePartType probable_name_part;
		STRING1 probable_gender :='';
		UNSIGNED4 cnt;
		REAL pct;
		UNSIGNED4 firstname_cnt;
		UNSIGNED4 middlename_cnt;
		UNSIGNED4 lastname_cnt;
		UNSIGNED4 fem_cnt;
		UNSIGNED4 male_cnt;
		UNSIGNED4 fem_firstname_cnt;
		UNSIGNED4 fem_middlename_cnt;
		UNSIGNED4 male_firstname_cnt;
		UNSIGNED4 male_middlename_cnt;
		REAL firstname_itf;
		REAL fem_firstname_itf;
		REAL male_firstname_itf;
		REAL middlename_itf;
		REAL fem_middlename_itf;
		REAL male_middlename_itf;
		REAL lastname_itf;
		UNSIGNED8 name_part_hash;
		STRING20 metaphone;
		STRING20 metaphone2;
		UNSIGNED4 total_recs;
		UNSIGNED4 total_fn_recs;
		UNSIGNED4 total_ln_recs;
		UNSIGNED4 total_mn_recs;
		UNSIGNED4 total_fem_recs;
		UNSIGNED4 total_male_recs;
	END;
	
	export L_MXNameStatsFpos := RECORD
	L_MXNameStats;
		unsigned8 		fpos{virtual(fileposition)} := 0;
		END;

/////////////////////////////
//Layouts used for name parsing
////////////////////////////
export L_MXPersonNamePart := RECORD
		string name_format :='';
		unicode60 	  name_part_text;
		unsigned8			item_id;		
		unsigned8			name_id;		
		unsigned1			name_part_position;
		NamePartType	name_part_type;	
		unsigned1			total_parts :=0;		
		unsigned8 name_part_hash :=0;
		string1				probable_gender :='';
		NamePartType	probable_name_part:=0;	
		string20			metaphone;
		string20			metaphone2;
		unsigned1			metaphone_id :=1;
		unsigned1			isSynonym;		
		boolean 			is_connector := false;
		boolean 			possible_hln := false;
		unicode60 		mother_last_name	 := u'';
		unicode60 		mother_matronymic	 := u'';
		unicode60 		father_last_name	 := u'';
		unicode60 		father_matronymic	 := u'';
		unicode60 stripped_name :=u'';
		unicode100 norm_name :=u'';
		unsigned8 mother_item_id:=0; //stash parent rec for parsed rec, in case name parsing requires comparison w other names in same multiple rec
		unsigned8 father_item_id:=0; //stash parent rec for parsed rec, in case name parsing requires comparison w other names in same multiple rec
		boolean is_org:=false;
		unsigned8 term_count:=0;
		
END;

export L_MXPersonNamePartFpos := RECORD
L_MXPersonNamePart;
unsigned8 		fpos{virtual(fileposition)} := 0;
END;

export L_NameHash :=RECORD
	unsigned8 person_uid;
	unsigned8 name_part_hash;
	unsigned1 name_part_type;
	boolean isSynonym:=false;
	boolean isMetaphone:=false;
END;

export L_NameHash_Fpos :=RECORD
	L_NameHash;
		unsigned8 		fpos{virtual(fileposition)} := 0;	
END;

END;