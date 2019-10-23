import ut,tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

export Promote(

	 string								pversion				= 	''
	,string								pFilter					= 	''
	,boolean							pDelete					= 	false
	,boolean							pIsTesting			= 	false
	,dataset(lay_inputs)	pInputFilenames = 	Filenames	(pversion).Input.dAll_filenames
	,dataset(lay_builds)	pBuildFilenames = 	Filenames	(pversion).dAll_filenames
																					+ Keynames  (pversion).dAll_filenames

) :=
module
	
	export inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	export buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);
  export Used2In    := sequential(	
                         fileservices.addsuperfile('~thor_data400::in::fdn::cfna'    ,'~thor_data400::in::fdn::used::cfna',addcontents := true),
                         fileservices.addsuperfile('~thor_data400::in::fdn::tiger'   ,'~thor_data400::in::fdn::used::tiger',addcontents := true),
                       //  fileservices.addsuperfile('~thor_data400::in::fdn::glb5'      ,ut.foreign_logs+'thor_data400::in::fdn::sprayed::glb5',addcontents := true);
                         fileservices.addsuperfile('~thor_data400::in::fdn::SuspectIP'  ,'~thor_data400::in::fdn::used::SuspectIP',addcontents := true),
                         fileservices.addsuperfile('~thor_data400::in::fdn::Erie'  ,'~thor_data400::in::fdn::used::Erie',addcontents := true),
                         fileservices.addsuperfile('~thor_data400::in::fdn::ErieWatchList'  ,'~thor_data400::in::fdn::used::ErieWatchList',addcontents := true),
												 FraudDefenseNetwork.fn_promote_GLB5,
												 fileservices.clearsuperfile('~thor_data400::in::fdn::used::SuspectIP'),
												 fileservices.clearsuperfile('~thor_data400::in::fdn::used::Erie'),
												 fileservices.clearsuperfile('~thor_data400::in::fdn::used::ErieWatchList')
												 );

end;
