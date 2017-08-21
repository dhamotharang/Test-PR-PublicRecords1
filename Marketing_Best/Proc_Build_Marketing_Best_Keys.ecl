//Build keys for Marketing best & Marketing BusTitle List and move to QA.
import ut, RoxieKeyBuild, versioncontrol;

export Proc_Build_Marketing_Best_Keys(string pversion) :=
function

	shared Names		:= keynames(pversion);

	VersionControl.macBuildNewLogicalKeyWithName(Key_Marketing_Best_BDID						,names.Bdid.new										,BDID_Key					);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Marketing_Best_BDID_MrktRes		,names.bdid_MrktRes.new						,BDID_Mkres_Key		);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Best_MrkTitle_BDID_DID					,names.title_bdid_did.new					,Title_BDID_Key		);
	VersionControl.macBuildNewLogicalKeyWithName(Key_Best_MrkTitle_BDID_DID_MrktRes	,names.Title_bdid_did_MrktRes.new	,Title_Mkres_Key	);

	return
	sequential(
		if(not VersionControl.DoAllFilesExist.fNamesBuilds(names.dAll_filenames)
			,parallel(
				 BDID_Key				
				,BDID_Mkres_Key	                                                                  
				,Title_BDID_Key				  
				,Title_Mkres_Key
			))
		,promote(pversion,'key').new2built
	);
	
end;

         