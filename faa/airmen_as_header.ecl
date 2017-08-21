import property,lib_keylib,lib_fileservices,ut,Business_Header,Header;

export	airmen_as_header(dataset(faa.layout_airmen_data_out) pAirmen = dataset([],faa.layout_airmen_data_out), 
																	boolean pForHeaderBuild=false, 
																	boolean isPRCT=false) :=  function
																	
	dAirmenAsSource	:=	if(pForHeaderBuild, header.Files_SeqdSrc().AM, FAA.Airmen_as_Source(pAirmen,pForHeaderBuild));

	Header.Layout_New_Records Translate_Airmen_to_Header(dAirmenAsSource l) := transform
		self.did := if(isPRCT, (unsigned6)l.did_out, 0);
		self.rid := 0;
		self.pflag1 := '';
		self.pflag2 := '';
		self.pflag3 := '';
		self.dt_first_seen := (unsigned3)(l.date_first_seen[1..6]);
		self.dt_last_seen := (unsigned3)(l.date_last_seen[1..6]);
		self.dt_vendor_first_reported := (unsigned3)(l.date_first_seen[1..6]);
		self.dt_vendor_last_reported := (unsigned3)(l.date_last_seen[1..6]);
		self.dt_nonglb_last_seen := self.dt_last_seen;
		self.rec_type := if(l.current_flag = 'A', '1', '2');
		self.vendor_id := L.unique_id + ',' + L.current_flag + ',' + 
					   l.med_date;
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
		self := L;
	end;


	airmen_project := project(dAirmenAsSource,Translate_Airmen_to_Header(left));

	Airmen_Filtered	:=	airmen_project(lname != '' and prim_name != '' and zip != '');

    return Airmen_Filtered;
  end
 ;
