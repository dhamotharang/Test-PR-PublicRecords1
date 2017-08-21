export Layouts_Salt_Ingest  := MODULE

	export SourceType :=	ENUM(unsigned1, DOCKET, PROFESSIONS, CHI_PROPERTY, TAM_BIRTH_RECORD);

	export Base_Slim := RECORD
			string50		firstName;
			string50		middleName1;
			string20		middleName2;
			string20		middleName3;
			string20		middleName4;
			string20		middleName5;
			string50		lastName;
			string50		matronymic;
			string1			gender;
			string1			not_parsed;
			string1 		is_org;
			unsigned8		entity_id;
			SourceType	rec_type;
			unsigned1		party_id;
			unsigned8		rec_id;
			unsigned8 	orig_rec_id;
			string60 		geography;
			unsigned4 	date_pub;
			string100 	court;
			unsigned3 	docket_year;
			string280 	caption;
			string120 	nature;
			unsigned1 	nature_type;
			string200 	comment;
	end;
	
end;