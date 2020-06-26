import Header;

export	As_header(dataset(layouts.base) pCertegy = dataset([],layouts.base), boolean pForHeaderBuild=false)
 :=
  function
	dCertegyAsSource	:=	As_source(pCertegy,pForHeaderBuild);

	Header.Layout_New_Records Translate_certegy_to_Header(dCertegyAsSource l) := transform

	    string8 v_dob      := l.clean_dob;

		string4 v_dob_yyyy := v_dob[1..4];
		string2 v_dob_mm   := if(v_dob[5..6]='00','01',v_dob[5..6]);
		string2 v_dob_dd   := if(v_dob[7..8]='00','01',v_dob[7..8]);

		//don't even populate vendor dates because they can eventually get used in watchdog bestaddress
		self.did                      := 0;
		self.rid                      := 0;
		self.dt_first_seen            := (unsigned3)l.date_first_seen[1..6];
		self.dt_last_seen             := (unsigned3)l.date_last_seen[1..6];
		self.dt_vendor_first_reported := (unsigned3)l.date_vendor_first_reported[1..6];
		self.dt_vendor_last_reported  := (unsigned3)l.date_vendor_last_reported[1..6];
		self.dt_nonglb_last_seen      := 0;
		self.rec_type                 := '';
		self.ssn		              := l.clean_ssn;
		self.vendor_id                := (string)l.orig_DL_Num;
		self.phone                    := l.clean_hphone;
		//dob_formatted cleans up the birth_date field
		self.dob                      := if(l.clean_dob<>'',(integer)(v_dob_yyyy+v_dob_mm+v_dob_dd),0);
		self.suffix                   := l.addr_suffix;
		self.city_name                := l.v_city_name;
		self.county                   := l.fips_county;
		self.cbsa                     := if(l.msa!='',l.msa + '0','');
		self                          := L;
	end;

	certegy_project := project(dCertegyAsSource,Translate_certegy_to_Header(left));

	certegy_filtered	:=	certegy_project(fname<>'' and length(trim(lname))>1 and prim_name<>'' and zip<>'');

    return certegy_filtered;
  end;
