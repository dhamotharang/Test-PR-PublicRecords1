import iesp;
export Layouts := MODULE

	export MXNameInput := record
		unicode100 name;
		unsigned2 uid := 0; // only used for testing
	end;
		
	export MXPersonNamePart := RECORD
		unsigned2			name_id;		
		unicode20 	  name_part_text;
		string20 			stripped_name :='';		
		unsigned1			name_part_position;
		MX_Services.Constants.NamePartType name_part_type;
		string30			name_part_desc := '';		
		unsigned1			total_parts :=0;		
		MX_Services.Constants.NamePartType probable_name_part:=0;	
	END;

	export MXEntityIds := record
		unsigned8 		entity_id;
		unsigned8 		rec_id := 0;
	end;
	
  export MXCommonPrepOut := record
		unsigned8 		entity_id;
		unsigned1			penalty;
		unsigned8 		rec_id;
		unicode20 		firstName;
		unicode20 		middleName;
		unicode20 		lastName;
		unicode20 		matronymic;
		unicode5			suffix := u'';
		unicode3			prefix := u'';
		unicode100 		fullName;
		string1 			gender;	
	end;
	
	export MXDocketsPrepOut := record		
		MXCommonPrepOut;		
		unicode40			geography;
		string3				state;
		unsigned4			date_pub;
		unicode50			court;
		unicode50			court_local;
		unicode100		docket;
		unicode30			docket_num;
		unsigned3			docket_year;
		unicode250		caption;
		unicode150		nature;
		unsigned1			nature_type;		
	end;
	
	export MXProfessionPrepOut := record
		MXCommonPrepOut;
		unsigned1 prof_cat;
		string10 	profno;
		string100 profession;
		string100 education_level;	
	end;
	
	export AKAName := record
			unsigned8 entity_id;
			integer 	cnt;
			iesp.internationaldocket.t_InternationalName;
	end;
	
	export MXCourtDocket := record
			unsigned4 	date_pub;
			iesp.internationaldocket.t_InternationalDocket  - [FilingDate];
	end;
	
	export MXDocketRecord := record
		unsigned8 	entity_id;
		unsigned1		_penalty;
		string1 		gender;			
		unicode100 	fullName;
		dataset(AKAName) 			 akas;
		dataset(MXCourtDocket) dockets;		
	end;

	export MXProfessionalCertification := record
		iesp.internationalprofcert.t_InternationalProfCertification;
	end;

	export MXProfessionRecord := record
		unsigned8 	entity_id;
		unsigned1		_penalty;
		string1 		gender;			
		unicode100 	fullName;
		dataset(AKAName) 			 akas;
		dataset(MXProfessionalCertification) certifications;		
	end;
	
	export MXNameVariant := record		
		string20 	name;
		string20	variant;
		unicode20 uvariant;
		unsigned1 nameMatch := 0;
		unsigned 	score := 0;
	end;
	
END;