import	Header,Header_Slimsort;

export	Layouts	:=
module
	
	// Death master plus base layout
	export	Base	:=
	record
		Header.layout_death_master_plus;
	end;
	
	// Deletes file layout
	export	Deletes	:=
	record
		string8		filedate;
		string1		rec_type;
		string1		rec_type_orig;
		string9		ssn;
		string20	lname;
		string4		name_suffix;
		string15	fname;
		string15	mname;
		string1		VorP_code;
		string8		dod8;
		string8		dob8;
		string2		st_country_code;
		string5		zip_lastres;
		string5		zip_lastpayment;
		string2		state;
		string3		fipscounty;
		string2		crlf;
	end;
	
	// DID layout
	export	DID	:=
	record(Base)
		unsigned6	did					:=	0;
		unsigned1	did_score		:=	0;
		string12	strDID			:=	'';
		string5		zip5				:=	'';
	end;
	
	// V1 DID layout
	export	DID_V1	:=
	record
		string12	did;
		unsigned1	did_score;
		Header.layout_death_master;
	end;
	
	// V2 DID layout
	export	DID_V2	:= record
		DID_V1;
		string16	state_death_id;
	end;

	// V3 DID layout
	export	DID_V3	:=
	record
		DID_V2;
		string2	src				:=	'DE';
		string1	glb_flag	:=	'N';
	end;

  export Expanded := 
	record(DID)
		string2		source_state	:=	'';
		string3		death_rec_src :=	'';
		string10	prim_range		:=	'';
		string28	prim_name			:=	'';
		string8		sec_range			:=	'';
		UNSIGNED4	xadl2_keys_used			:=	0 ;
		STRING		xadl2_keys_desc			:=	'';
		INTEGER2	xadl2_weight				:=	0 ;
		UNSIGNED2	xadl2_Score					:=	0 ;
		UNSIGNED2	xadl2_distance			:=	0 ;
		STRING22	xadl2_matches				:=	'';
		STRING		xadl2_matches_desc	:=	'';
	end;
	
	// Layout for adding header source code
	export	DeathHeaderSource	:=
	record(Expanded)
		header_slimsort.Layout_Source;
	end;
	
end;