import BIPV2_Files,bipv2_hrchy,tools;

EXPORT Proc_Build_HRCY_Keys(
   string   pversion
  ,boolean  pPromote2QA = true
	,boolean  puseotherenvironment = false
	,dataset(BIPV2_Files.layout_proxid            )   phead                 = files_hrchy.DS_PROXID_BASE
	,dataset(recordof(files_hrchy.lnca)    		    )   plncad                = files_hrchy.lnca							
	,dataset(recordof(files_hrchy.duns)						)  	pdunsd                = files_hrchy.duns					
	,dataset(recordof(files_hrchy.fran)           )   pfrand                = files_hrchy.fran
  ,dataset(BIPV2_HRCHY.Layouts.lgidr            )   pLgidTable            = BIPV2_HRCHY.mod_Build(phead, plncad, pdunsd, pfrand).lgidtable

) :=
function

	shared knames := keynames(pversion,pUseOtherEnvironment);

	//*** HRCHY Keys ******
	shared kHrchyProxid  := PRTE2_BIPV2_BusHeader.files_hrchy.KEY_HRCY_PROXID_FULL(pLgidTable);
  shared kHrchyLgid    := PRTE2_BIPV2_BusHeader.files_hrchy.KEY_HRCY_LGID_FULL  (pLgidTable);
	
	BuildHrchyProxid  := tools.macf_writeindex('kHrchyProxid	,knames.HrchyProxid.new'	);
	BuildHrchyLgid 		:= tools.macf_writeindex('kHrchyLgid  	,knames.HrchyLgid.new'    );
		
	returnresult := sequential(
											BuildHrchyProxid
										 ,BuildHrchyLgid
										 ,Promote(pversion).New2Built
										 ,if(pPromote2QA = true  ,Promote(pversion).Built2QA)
									);
	return returnresult;
end;
