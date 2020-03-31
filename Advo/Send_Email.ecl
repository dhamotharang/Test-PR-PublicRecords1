import versioncontrol,_control,uspis_hotlist;

export Send_Email(
	
	 string		pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

):= module

	export notificationlist := if(VersionControl._Flags.IsDataland
																,_Control.myinfo.EmailAddressNotify
																,'Angela.Herzberg@LexisNexis.com; Sudhir.Kasavajjala@LexisNexis.com; Book_Retro_Team@choicepoint.com;RISBCTQualityAssurance@lexisnexis.com '+ _Control.myinfo.EmailAddressNotify
															);
							
	export build_success := fileservices.sendemail(
													notificationlist,
													'Advo Build Succeeded ' + pversion,
													'Sample records are in WUID:' + workunit);

	export build_failure := fileservices.sendemail(
												notificationlist,
												'Advo '+pversion+' Build FAILED',
												workunit + '\n' + failmessage);						

	export dall_CDSKEYS	:= 
			keynames							(pversion,pUseOtherEnvironment).dAll_reg_filenames
		+ Uspis_hotlist.keynames(pversion,pUseOtherEnvironment).dAll_filenames
		;
		
	export dall_FCRA_CDSKEYS	:= 
			keynames							(pversion,pUseOtherEnvironment).dAll_fcra_filenames
		;
	// This function checks to make sure all keys in package are the correct version
	// if so, it updates the roxie package, if not, it sends you an email telling you
	// that there is a version mismatch
	export Roxie :=
	module
		export CDSKeys := VersionControl.fCheckRoxiePackage(
					 notificationlist
					,'CDSKeys'	
					,dall_CDSKEYS	
					,pversion
					,,pShouldUpdateRoxiePage,
					'N'
			);
		 export FCRA_CDSKeys := VersionControl.fCheckRoxiePackage(
					 notificationlist
					,'FCRA_CDSKeys'	
					,dall_FCRA_CDSKEYS	
					,pversion
					,,pShouldUpdateRoxiePage
					,'F'
					);
		export all_packages := sequential(CDSKeys,FCRA_CDSKeys);
	end;

end;