import property,lib_keylib,lib_fileservices,ut,Business_Header,Header;

export	aircraft_as_header(dataset(faa.layout_aircraft_registration_out) pAircraft = dataset([],faa.layout_aircraft_registration_out), boolean pForHeaderBuild=false)
 :=
  function
	dAircraftAsSource	:=	Aircraft_as_Source(pAircraft,pForHeaderBuild);

	Header.Layout_New_Records Translate_Aircraft_to_Header(dAircraftAsSource l) := transform
		self.did := 0;
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';
		self.dt_first_seen := if(l.cert_issue_date = '', (unsigned3)(l.date_first_seen[1..6]),
							(unsigned3)(l.cert_issue_date[1..6]));
		self.dt_last_seen := if(l.last_action_date = '', (unsigned3)(l.date_last_seen[1..6]),
							(unsigned3)(l.last_action_date[1..6]));
		self.dt_vendor_first_reported := (unsigned3)(l.date_first_seen[1..6]);
		self.dt_vendor_last_reported := (unsigned3)(l.date_last_seen[1..6]);
		self.dt_nonglb_last_seen := self.dt_last_seen;
		self.rec_type := if(l.current_flag = 'A', '1', '2');
		self.vendor_id := L.name[1..6] + L.zip_code[1..5] + l.type_registrant + L.n_number;
		self.phone := '';
		self.ssn := '';
		self.dob := 0;
		self.city_name := l.v_city_name;
		self.cbsa := if(l.msa!='',l.msa + '0','');
		self.tnt := '';
		self.valid_ssn := '';
		self.jflag1 := '';
		self.jflag2 := '';
		self.jflag3 := '';
		self.suffix := l.addr_suffix;
		self.zip4 := l.z4;
		self := L;
	end;

	aircraft_project := project(dAircraftAsSource,Translate_Aircraft_to_Header(left));

	aircraft_in := aircraft_project(lname != '' and prim_name != '' and zip != '');

    return aircraft_in;
  end
 ;
