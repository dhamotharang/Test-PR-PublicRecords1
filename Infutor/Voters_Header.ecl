import header, votersV2, mdr;

/* CODE TAKEN FROM VOTERS V2 AS HEADER AND AS SOURCE */

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new;
//DF-26350: Remove MS from the state set
	state_set := ['AK','AL','AR','CO','CT','DC','DE','DL','FL','LA','MA','MI','NC','NV','NY','OH','OK','RI','UT','WI']; // bug 78034
	dSourceData	:=	distribute(VotersV2.File_Voters_Base(source_state in state_set and did > 0), hash(did));

	src_rec := record
	 header.Layout_Source_ID;
	 Layout_in;
	end;

	header.Mac_Set_Header_Source(dSourceData,Layout_in,src_rec,mdr.sourceTools.src_Voters_v2,withUID)

	// dVotersAsSource	:=	Infutor.Voters_as_Source(pVoters,pForHeaderBuild);
	dFiltered	:=	withUID(lname <> '',
									length(trim(fname)) > 1,
									~(regexfind('[0-9]',fname)),
									~(regexfind('[0-9]',lname)),
									~(regexfind(', ',mname))
									);
										
	header.layout_header header_trans(dFiltered l, integer c) := transform
		self.did := (unsigned6)l.did;
		self.rid := 0;
		self.vendor_id := trim(l.vendor_id);
		self.rec_type  := ''; 
		self.pflag1    := '';
		self.pflag2    := '';
		self.pflag3    := '';
		self.ssn       := '';
		self.dob       := if((integer)l.dob in [19000101,19010101],0,(integer)l.dob);
		self.tnt       := '';
		self.dt_first_seen            := (integer)l.lastdatevote[1..6];
		self.dt_last_seen             := (integer)l.lastdatevote[1..6];
		self.dt_vendor_last_reported  := (integer)(l.date_last_seen[1..6]);
		self.dt_vendor_first_reported := (integer)(l.date_first_seen[1..6]);
		self.dt_nonglb_last_seen      := 0;
		self.prim_range := choose(c,l.prim_range, l.mail_prim_range);
		self.predir     := choose(c,l.predir,     l.mail_predir);
		self.prim_name  := choose(c,l.prim_name,  l.mail_prim_name);
		self.suffix     := choose(c,l.addr_suffix,l.mail_addr_suffix);
		self.postdir    := choose(c,l.postdir,    l.mail_postdir);
		self.unit_desig := choose(c,l.unit_desig, l.mail_unit_desig);
		self.sec_range  := choose(c,l.sec_range,  l.mail_sec_range);
		self.city_name  := choose(c,l.v_city_name,l.mail_v_city_name);
		self.st         := choose(c,l.st,         l.mail_st);
		self.zip        := choose(c,l.zip,        l.mail_zip);
		self.zip4       := choose(c,l.zip4,       l.mail_zip4);
		self.county     := choose(c,l.fips_county,l.mail_fips_county);
		self.cbsa       := choose(c,l.msa + '0',  l.mail_msa + '0');
		self.geo_blk    := choose(c,l.geo_blk,    l.mail_geo_blk);
		self            := l;
	end;

	voters_projected := dedup(sort(normalize(dFiltered,2,header_trans(left,counter), local), record, local), record, local);

	dFiltered2	:=	project(voters_projected(prim_name<>'' and zip4<>''),
							transform(recordof(voters_projected), self.rid := (18 * 1000000000000) + counter; self := left));

export Voters_Header :=  dFiltered2;
