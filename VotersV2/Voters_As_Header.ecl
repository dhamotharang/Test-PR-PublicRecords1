import header;

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base;

export Voters_As_Header(dataset(Layout_in) pVoters = dataset([],Layout_in), boolean pForHeaderBuild=false)
 :=
  function
	dVotersAsSource	:=	VotersV2.Voters_as_Source(pVoters,pForHeaderBuild);

	dFiltered	:=	dVotersAsSource(prim_name <> '', 
								    lname <> '',
									length(trim(fname)) > 1,
									zip4 <> '',
									~(regexfind('[0-9]',fname)),
									~(regexfind('[0-9]',lname)),
									~(regexfind(', ',mname))
									);
										
	header.Layout_New_Records header_trans(dFiltered l) := transform
		self.did := 0;
		self.rid := 0;
		self.vendor_id := trim(l.vendor_id);
		self.rec_type  := '2'; 
		self.pflag1    := '';
		self.pflag2    := '';
		self.pflag3    := '';
		self.ssn       := '';
		self.dob := if((integer)l.dob in [19000101,19010101],0,(integer)l.dob);
		self.tnt := '';
		self.dt_first_seen := (integer)(l.date_first_seen[1..6]);
		self.dt_last_seen  := (integer)(l.date_last_seen[1..6]);
		self.dt_vendor_last_reported  := (integer)(l.date_last_seen[1..6]);
		self.dt_vendor_first_reported := (integer)(l.date_first_seen[1..6]);
		self.dt_nonglb_last_seen := 0;
		self.prim_range := l.prim_range;
		self.predir     := l.predir;
		self.prim_name  := l.prim_name;
		self.suffix     := l.addr_suffix;
		self.postdir    := l.postdir;
		self.unit_desig := l.unit_desig;
		self.sec_range  := l.sec_range;
		self.city_name  := l.v_city_name;
		self.st         := l.st;
		self.zip        := l.zip;
		self.zip4       := l.zip4;
		self.county     := l.fips_county;
		self.cbsa       := l.msa + '0';
		self.geo_blk    := l.geo_blk;
		self            := l;
	end;

	voters_projected := project(dFiltered,header_trans(LEFT));

    return voters_projected;
	
  end
 ;

