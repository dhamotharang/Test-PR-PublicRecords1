export Layouts_build := MODULE

	export Ethnicity := ENUM(unsigned1, WESTERN,ASIAN,LATIN_AMERICAN);

	export professionTemp	:=	record
			unsigned8 	person_id :=0;
			unicode50 	firstName:= u'';
			unicode50 	middleName1:= u'';
			unicode20 	middleName2 := u'';
			unicode20 	middleName3 := u'';
			unicode20 	middleName4 := u'';
			unicode20 	middleName5 := u'';
			unicode50 	lastName :=u'';
			unicode50 	matronymic := u'';
			unicode50 	husbandslastname := u''	;		
			unicode50 	patronymic := u''	;	
			string1 		gender := ''	;	
			unicode200 	full_name :=u'';
			unicode500 	unparsed_name :=u'';
			boolean 		not_parsed :=false;
			boolean 		is_org :=false;
			string20 		name_format :='';
			Ethnicity 	ethnicity :=0;
			unsigned8 	rec_id :=0;
			unsigned8 	entity_id :=0;		
			UNSIGNED8 	external_rec_id;
			string10 		PROFNO;
			STRING100 	profession;
			STRING100 	education_level;
			boolean 		is_military :=false;
			boolean 		is_pilot :=false;
			boolean 		is_law_enforcement :=false;
			boolean 		is_lawyer :=false;
			boolean 		is_government :=false;
	end;

	export	base	:=	RECORD
			professionTemp;
			string8				process_Date;
			string8				dt_first_seen;
			string8				dt_last_seen;
	END;

	export Raw	:=	record
		string20 			Item_ID;
		string10 			profNo;
		string100 		education_level;
		string100 		profession;
		unicode50 		first_name;
		unicode30 		last_name;
		unicode30 		matronymic;
	end;

end;