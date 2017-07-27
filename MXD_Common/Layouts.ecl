import mxd_Names;

export Layouts := MODULE


	export Ethnicity := ENUM(unsigned1, WESTERN,ASIAN,LATIN_AMERICAN);
	
	export ValIdType := ENUM(unsigned1, M1, M2, S1, S2, YEAR, NATURE,DATE_OF_BIRTH, STATE_OF_BIRTH,CITY_OF_BIRTH, NAME);
	
	export RelationshipType := ENUM(unsigned1, MOTHER_OF, FATHER_OF, CHILD_OF, SPOUSE_OF, EX_SPOUSE_OF, SIBLING_OF, EMPLOYER_OF, EMPLOYEE_OF, ASSOCIATE_OF, PROPERTY_CO_OWNER, IN_COURT_WITH,ASSOC_WITH_BUSINESS,BUSINESS_ASSOC_WITH_PERSON);

	export SourceType :=	ENUM(unsigned1, DOCKET, PROFESSIONS, CHI_PROPERTY, TAM_BIRTH_RECORD);
		
export L_MXWords := RECORD
UNICODE30 word;
END;


export L_MXWordsFpos := RECORD
UNICODE30 word;
unsigned8 		fpos{virtual(fileposition)} := 0;
END;


	 
		export L_String := RECORD
		string		str;
		unsigned8	rec_id;
		unsigned8	entity_id;
	END;
	
export L_MXPerson := record
	unsigned8 person_id :=0;
	unicode50 firstName:= u'';
	unicode50 middleName1:= u'';
	unicode20 middleName2 := u'';
	unicode20 middleName3 := u'';
	unicode20 middleName4 := u'';
	unicode20 middleName5 := u'';
	unicode50 lastName :=u'';
	unicode50 matronymic := u'';
	unicode50 husbandslastname := u''	;		
	unicode50 patronymic := u''	;	
	string1 gender := ''	;	
	unicode200 full_name :=u'';
	//boolean isAlias :=false; handle with alias name part type
	//unsigned8 aliasParentUID:=0;
	unicode500 unparsed_name :=u'';
	boolean not_parsed :=false;
	boolean is_org :=false;
	string20 name_format :='';
	Ethnicity ethnicity :=0;
	unsigned8 rec_id :=0;
	unsigned8 entity_id :=0;
	END;

export L_MXPersonFpos :=RECORD
L_MXPerson;
unsigned8 		fpos{virtual(fileposition)} := 0;
END;

export L_PersonRelationship := RECORD
	unsigned8					person_id;
	unicode100				person_name :=u'';
	RelationshipType 	relation_type;	
	unsigned8					related_to_person_id;	
	unicode100				related_to_person_name:=u'';
	unsigned8 				rec_id :=0;
END;	

export L_MXRelationship := RECORD
	unsigned8					person_entity_id:=0;
	unsigned8					person_rec_id;	
	unicode100				person_name :=u'';
	RelationshipType 	relation_type;	
	unsigned8					related_to_person_entity_id:=0;	
	unsigned8					related_to_person_rec_id;	
	unicode100				related_to_person_name:=u'';	
	SourceType rec_Type:=-1; //0=DOCKET, 1=PROFESSION, 2=PROPERTY, 3=BIRTH
END;	

export L_MXRelationshipB := RECORD
 L_MXPerson;
	unicode100				mother:=u'';
	unicode100				father:=u'';
	unicode100				child:=u'';
	unsigned8					person_rec_id;	
	SourceType rec_Type:=3; //0=DOCKET, 1=PROFESSION, 2=PROPERTY, 3=BIRTH
END;

export L_MXRelationshipFpos :=RECORD
L_MXRelationship;
unsigned8 		fpos{virtual(fileposition)} := 0;
END;

export L_Person_BirthRecord :=RECORD
unsigned8 person_id :=0;
unsigned8 birthrecord_id :=0;
END;

export L_Token := RECORD
	string full_string :='';
	string token_string := '';
	unsigned5 rec_id :=0;
	unsigned1 part_id:=1;
	unsigned1 totalparts := 1;
	unsigned8 		fpos{virtual(fileposition)} := 0;
END;

export L_UToken := RECORD
	unicode full_string :=u'';
	unicode token_string := u'';
	unsigned5 rec_id :=0;
	unsigned1 part_id:=1;
	unsigned1 totalparts := 1;	
	unsigned8 		fpos{virtual(fileposition)} := 0;
END;

//////////////////////////////////////////////////
// Layouts used for location parsing
/////////////////////////////////////////////////
export L_MXState := RECORD
	unicode20 state_name :=u'';
	unicode20 standard_state_name := u'';	
	STRING20	country_name :='';
	unsigned8 		fpos{virtual(fileposition)} := 0;
END;

export L_Logging := RECORD
STRING message;
END;

export L_MXCity := RECORD
//	unicode60 city_name_u :=u'';
	unicode60 city_name :=u'';
	unicode20 state_name :=u'';
	//string5 city_size :='';
	unicode60 standard_name := u'';	
	STRING20 country_name := '';
	unsigned8 		fpos{virtual(fileposition)} := 0;
END;

export L_MXRawCity := RECORD
	unicode60 city_name_u :=u'';
	unicode20 state_name :=u'';
  string5 city_size :='';
	unicode60 city_name :=u'';
	unicode60 standard_name := u'';	
	STRING20 country_name := '';
	unsigned8 		fpos{virtual(fileposition)} := 0;
END;
		
	export L_MXSearch := RECORD
		unsigned8		val;
		ValIdType		val_id;
		unsigned8		item_id;
		unsigned1		name_id;
		unsigned1		part_id;
		real	term_frequency :=0;
		mxd_Names.Layouts.NamePartType	name_part_type :=0;	
		real	npt_term_frequency :=0;
		unsigned8 	fpos{virtual(fileposition)} := 0;
	END;
	
		export L_MXSynonym := RECORD
		unicode40		term1;
		unicode40		term2;
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
	
		// Graph function results record.
	export L_SearchResults := RECORD
		unsigned8		item_id;
		unsigned1		name_id;
		unsigned1		part_id;
		unsigned2		quality := 0;
		unsigned1		matches := 1;
		real	term_frequency :=0;
	END;
	


END;