import Header;

export	OKC_Student_List_as_header(dataset(OKC_Student_List.Layout_Base.base) pASL = dataset([],OKC_Student_List.Layout_Base.base), boolean pForHeaderBuild=false)
 :=
  function
	dOSLAsSource	:=	header.Files_SeqdSrc().S1;

	Header.Layout_New_Records Translate_OSL_to_Header(dOSLAsSource l) := transform
	
	  // string8 v_dob      := l.dob_formatted;
		
		// string4 v_dob_yyyy := v_dob[1..4];
		// string2 v_dob_mm   := if(v_dob[5..6]='00','01',v_dob[5..6]);
		// string2 v_dob_dd   := if(v_dob[7..8]='00','01',v_dob[7..8]);
		
		//don't even populate vendor dates because they can eventually get used in watchdog.bestaddress
		// self.did                      := 0;
		self.rid                      := 0;
		self.dt_first_seen            := 0;
		self.dt_last_seen             := 0;
		self.dt_vendor_first_reported := (unsigned3)(l.date_vendor_first_reported[1..6]);
		self.dt_vendor_last_reported  := (unsigned3)(l.date_vendor_last_reported[1..6]);
		self.dt_nonglb_last_seen      := self.dt_last_seen;
		// self.rec_type                 := '';
		// self.vendor_id                := (string)L.key;
       self.vendor_id                := '';
		// self.phone                    := l.telephone;
		   self.phone                    := '';
		// self.ssn                      := '';
		//dob_formatted cleans up the birth_date field
		// self.dob                      := if(l.dob_formatted<>'',(integer)(v_dob_yyyy+v_dob_mm+v_dob_dd),0);
		   self.dob                      := 0;
		// self.suffix                   := l.addr_suffix;
		// self.city_name                := l.v_city_name;
		   self.city_name                := '';
		// self.county                   := l.fips_county;
		// self.cbsa                     := if(l.msa!='',l.msa + '0','');
		self                          := L;
	end;


	osl_project := project(dOSLAsSource,Translate_OSL_to_Header(left));

	// asl_filtered	:=	asl_project(fname<>'' and length(trim(lname))>1 and prim_name<>'' and zip<>'');
	asl_filtered	:=	osl_project(fname<>'' and length(trim(lname))>1 and prim_name<>'' and zip<>'');

    return asl_filtered;
  end
 ;