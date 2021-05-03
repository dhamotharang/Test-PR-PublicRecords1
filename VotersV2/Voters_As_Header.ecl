import header,ut,Std,prte2_VotersV2,MDR;

Layout_in := VotersV2.Layouts_Voters.Layout_Voters_Base_new;

export Voters_As_Header(dataset(Layout_in) pVoters = dataset([],Layout_in), boolean pForHeaderBuild=false, boolean IsPrct=false)
 :=
  function
	//dVotersAsSource	:=	header.Files_SeqdSrc().VO;
	dVotersAsSource:=if (isprct,prte2_Votersv2.files.HeaderSource,header.Files_SeqdSrc().VO);

	dFiltered	:=	dVotersAsSource(lname <> '',
									length(trim(fname)) > 1,
									~(regexfind('[0-9]',fname)),
									~(regexfind('[0-9]',lname)),
									~(regexfind(', ',mname))
									);
										
	header.Layout_New_Records header_trans(dFiltered l, integer c) := transform
	  SELF.did  := If(IsPRCT,(integer)l.DID,0); 
		//self.did := 0;
		self.rid := 0;
		self.vendor_id := trim(l.vendor_id);
		self.rec_type  := '2'; 
		self.pflag1    := '';
		self.pflag2    := '';
		self.pflag3 	 := If(l.source_state='HI' or l.source_state='NJ','V','');  // Legal constraints require us to filter HI & NJ out of the FCRA header. 
																																							// See Header.File_FCRA_Header_prep for filter statement.
		self.ssn       := '';
		//check for bogus or underage dob
		dob            := if(l.dob > (ut.date_math ((STRING8)Std.Date.Today(), -((18 * 365.00) + 2.00))),0,(integer)l.dob);
		self.dob       := if(dob in [19000101,19010101],0,dob);
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
  self.src        := IF (
                         (l.source_state in ['IN','MN','MT','TN'] OR 
                          l.source_state = 'UT' AND l.date_first_seen > '20180114'),
                         MDR.sourceTools.src_Voters_v2_block,
                         l.src );
                         
		self            := l;
	end;

	voters_projected := normalize(dFiltered,2,header_trans(left,counter));

	dFiltered2	:=	voters_projected(prim_name<>'' and zip4<>'');

    return dFiltered2;
	
  end
 ;

