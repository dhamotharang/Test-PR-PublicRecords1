import doxie, tools, BIPV2, VersionControl, Roxiekeybuild, wk_ut;

export Build_Keys (string 		pversion
									 ,boolean 	pIsTesting = false
									) :=
module

	VersionControl.macBuildNewLogicalKeyWithName(BIPV2_WAF.Key_BIPV2_WAF.key,	'~thor_data400::key::BIPV2_WAF::'+pversion+'::proxid::efr', BuildWAFKey);
	
	
	fileitems         := '';//wk_ut.get_StringFilesRead(workunit,'^(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$');  
	SendOrbitItemList := BIPV2_WAF.Send_Emails(pversion,pBuildName := 'BIPV2 WAF Build Orbit Item List',pBuildMessage := fileitems).BuildNote;
	
	//Get file items for orbit, send email including them to make easier to populate item list in orbit instance
	//shared regexfilterout := '^(?=.*?[[:digit:]]{8}.*).*?(base|biz|out).*$';
  //export SendOrbitItemList  := wk_ut.Strata_Orbit_Item_list(workunit,'BIPV2','BIPV2 WAF Key'  ,pversion ,pEmailNotifyList := Email_Notification_Lists(not pIsTesting).Roxie     ,pFileRegex := regexfilterout,pIsTesting := false);
																	  
	export full_build :=
	
	sequential(
						  PARALLEL(Mod_Corps().BuildAll,Mod_UCC().BuildAll,Mod_Vehicle().BuildAll,Mod_PropertyV2().BuildAll,Mod_BizContacts().BuildAll)
						 ,BuildWAFKey
						 ,Promote(pversion).BuildKeyFiles.New2Built
						 ,SendOrbitItemList
						 ,Promote(pversion).BuildKeyFiles.Built2QA
						): success(Send_Emails(pversion,,not pIsTesting).Roxie), failure(send_emails(pversion,,not pIsTesting).buildfailure);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping BIPV2_WAF.Build_Keys atribute')
	);

end;

