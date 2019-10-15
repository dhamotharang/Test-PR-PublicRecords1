import tools,BIPV2_Files,dcav2,frandx;

export Keys(
	 string													                  pversion							= ''
	,boolean												                  pUseOtherEnvironment	= false
	,dataset(BIPV2_Files.layout_proxid            )   phead                 = BIPV2_Files.files_proxid().DS_PROXID_BASE 
	,dataset(DCAV2.layouts.Base.companies         )   plncad                = BIPV2_Files.files_hrchy.lnca							
	,dataset(recordof(BIPV2_Files.files_hrchy.duns))  pdunsd                = BIPV2_Files.files_hrchy.duns					
	,dataset(Frandx.layouts.Base                  )   pfrand                = BIPV2_Files.files_hrchy.fran
  ,dataset(Layouts.lgidr                        )   pLgidTable            = BIPv2_HRCHY_Platform.mod_Build(phead, plncad, pdunsd, pfrand).lgidtable

) :=
module

	shared knames := keynames(pversion,pUseOtherEnvironment);

  shared kHrchyProxid  := BIPV2_Files.files_hrchy.KEY_HRCY_PROXID_FULL(pLgidTable);
  shared kHrchyLgid    := BIPV2_Files.files_hrchy.KEY_HRCY_LGID_FULL  (pLgidTable);
	
	export HrchyProxid  := tools.macf_FilesIndex('kHrchyProxid'	,knames.HrchyProxid	);
	export HrchyLgid 		:= tools.macf_FilesIndex('kHrchyLgid  '	,knames.HrchyLgid   );

end;
