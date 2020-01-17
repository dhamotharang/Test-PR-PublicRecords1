import  Lib_FileServices,paw, versioncontrol,corp2,SCRUBS,Scrubs_PAW;

export Proc_Build_All(

		 string																						pversion
		,dataset(corp2.Layout_Corporate_Direct_Corp_Base)	pInactiveCorps				= PAW.fCorpInactives(pPersistname	:= persistnames().f_CorpInactives + '::paw')
		,boolean																					pShouldPromote2QA			= true
		,boolean																					pShouldSendToStrata		= true
		,boolean																					pShouldSendRoxieEmail	= true

) :=
FUNCTION

  buildBasefiles := 
	sequential(
		 Proc_Build_Base				  (pversion,pCorpInactives := pInactiveCorps)
		,Scrubs.ScrubsPlus('PAW','Scrubs_PAW','Scrubs_PAW_Base', 'Base', pversion,Email_Notificaton_Lists.BuildFailure,false)
		,Proc_build_cleanAddr_base()
	);
	
	buildfiles := 
	parallel(
		 paw.proc_Build_Autokey	(pversion,File_base_CleanAddr_Keybuild)
		,paw.Proc_Build_Keys		(pversion)
		// ,Stats									(pversion)
		,if(pShouldPromote2QA = true,promote(pversion).built2qa)

	) :  success(SendEmail(pversion,,pShouldPromote2QA,pShouldSendRoxieEmail).Roxie), failure(SendEmail(pversion,,pShouldPromote2QA).buildfailure);

	buildprocess := 
	sequential(
		 nothor(apply(keynames().dall_filenames, apply(dSuperfiles, versioncontrol.mUtilities.createsuper(name))))
		,
		buildBasefiles
		,Buildfiles
		,Strata_Pop_Base(pversion,,,pShouldSendToStrata)
		,Output(choosen(sort(paw.File_Base(bdid > 0),-dt_last_seen),1000))
	
	): success(SendEmail(pversion).buildsuccess), failure(SendEmail(pversion).buildfailure);
							
	return buildprocess;
 
end;