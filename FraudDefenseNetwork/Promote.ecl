IMPORT ut,tools;

lay_builds 	:= tools.Layout_FilenameVersions.builds;
lay_inputs	:= tools.Layout_FilenameVersions.Inputs;

EXPORT Promote(

	 STRING								pversion				= 	''
	,STRING								pFilter					= 	''
	,BOOLEAN							pDelete					= 	FALSE
	,BOOLEAN							pIsTesting			= 	FALSE
	,DATASET(lay_inputs)	pInputFilenames = 	Filenames	(pversion).Input.dAll_filenames
	,DATASET(lay_builds)	pBuildFilenames = 	Filenames	(pversion).dAll_filenames

) :=
MODULE
	
	EXPORT inputfiles	:= tools.mod_PromoteInput(pversion,pInputFilenames,pFilter,pDelete,pIsTesting);
	EXPORT buildfiles	:= tools.mod_PromoteBuild(pversion,pBuildFilenames,pFilter,pDelete,pIsTesting);
  EXPORT Used2In    := SEQUENTIAL(	
                         fileservices.addsuperfile('~thor_data400::in::fdn::cfna'    ,'~thor_data400::in::fdn::used::cfna',addcontents := TRUE),
                         fileservices.addsuperfile('~thor_data400::in::fdn::tiger'   ,'~thor_data400::in::fdn::used::tiger',addcontents := TRUE),
                       //  fileservices.addsuperfile('~thor_data400::in::fdn::glb5'      ,ut.foreign_logs+'thor_data400::in::fdn::sprayed::glb5',addcontents := true);
                         fileservices.addsuperfile('~thor_data400::in::fdn::SuspectIP'  ,'~thor_data400::in::fdn::used::SuspectIP',addcontents := TRUE),
                         fileservices.addsuperfile('~thor_data400::in::fdn::Erie'  ,'~thor_data400::in::fdn::used::Erie',addcontents := TRUE),
                         fileservices.addsuperfile('~thor_data400::in::fdn::ErieWatchList'  ,'~thor_data400::in::fdn::used::ErieWatchList',addcontents := TRUE),
												 FraudDefenseNetwork.fn_promote_GLB5,
												 fileservices.clearsuperfile('~thor_data400::in::fdn::used::SuspectIP'),
												 fileservices.clearsuperfile('~thor_data400::in::fdn::used::Erie'),
												 fileservices.clearsuperfile('~thor_data400::in::fdn::used::ErieWatchList')
												 );

END;
