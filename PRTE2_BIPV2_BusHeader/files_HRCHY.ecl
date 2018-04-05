import BIPV2, BIPV2_Files, bipv2_hrchy, PRTE2_DCA, PRTE2_DNB, PRTE2_Frandx, DCAV2;


EXPORT files_HRCHY := module

	shared ref := bipv2_hrchy;

	/*----------------- Other Inputs to Hrchy Build ------------------------------------------ */
	export lnca := project(PRTE2_DCA.Files.file_linkids, transform(DCAV2.layouts.Base.companies, self := left));						
	export duns := PRTE2_DNB.Files.dnb_linkids;					
	export fran := PRTE2_Frandx.files.header_frandx;//** NEED TO INCORPORATE THIS FILE TOO
	export DS_PROXID_BASE := PROJECT(PRTE2_BIPV2_BusHeader.CommonBase.ds_xlink, TRANSFORM(BIPV2_Files.layout_proxid, SELF:=LEFT, SELF:=[]));
	
	EXPORT KEY_HRCY_PROXID_FULL(dataset(ref.Layouts.lgidr) lt = dataset([], ref.Layouts.lgidr)) :=
	INDEX(
		dedup(lt(lgid > 0, proxid > 0), proxid, lgid, lgid_level, proxid_level_within_lgid, src, all),
		{proxid},
		{lgid, lgid_level, proxid_level_within_lgid, src, biz_type},		//src not here yet, and pretty sure the full build still uses the code below to build the index.  this is just for reading it.
		keynames().HrchyProxid.qa
	);


	EXPORT KEY_HRCY_LGID_FULL(dataset(ref.Layouts.lgidr) lt = dataset([], ref.Layouts.lgidr)) :=
	INDEX(
		lt(lgid > 0),
		{lgid},
		{lt},		
		keynames().HrchyLgid.qa
	);
	
END;