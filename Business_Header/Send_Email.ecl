import VersionControl, govdata, paw, risk_indicators,aca,tools;
export Send_Email(
	
	 string		pversion
	,boolean	pUseOtherEnvironment 		= false
	,boolean	pShouldUpdateRoxiePage	= true

) :=
module

	export BuildSuccess	:= tools.fun_SendEmail(
													Email_Notificaton_Lists.BuildSuccess,
													'Business Header Build ' + pversion + ' Completed\n',
													'Don\'t forget to build the hri key on unix\n' +
													'Execute edata12:/thor_back5/local_data/hri/landing_zone/despray_hri.ksh\n' +
													'Then ihdr and build the key on edata12:/thor_back5/local_data/hri/hri.d00\n' +
													'Then login as hozed on rigel and execute: localdist -d hri\n' +
													workunit);

	export BuildFailure	:= tools.fun_SendEmail(
													Email_Notificaton_Lists.BuildFailure,
													'Business Header Build ' + pversion + ' Failed',
													workunit + '\n' + failmessage);
	export BasesFinished := tools.fun_SendEmail(
													Email_Notificaton_Lists.BuildSuccess,
													'Business Header Build Base Files Created ' + pversion,
													workunit);

	export Roxie :=
	module
		
		shared lpackage := Roxie_Packages(pversion,pUseOtherEnvironment);
		shared lemails	:= Email_Notificaton_Lists.Roxie;
		
		/////////////////////////////////////////////////////////////
		// -- Send 6 roxie emails, update 6 roxie packages
		/////////////////////////////////////////////////////////////
		export BusinessEmail	:= VersionControl.fCheckRoxiePackage(lemails,'BusinessHeaderKeys'	,lpackage.BusinessHeaderKeys	,pversion,,pShouldUpdateRoxiePage,'N');

		//Jira# DF-28406, Marketing_Best - Remove deprecated key; Commented the Marketing_Best code since the keys are deprecated from roxie.
		export All := sequential(
			 BusinessEmail
			,ACA.Send_Emails(pversion,,pShouldUpdateRoxiePage).Roxie				
			,Risk_Indicators.Send_Emails(pversion,,pShouldUpdateRoxiePage).FCRAAddressHRIEmail				
			,Risk_Indicators.Send_Emails(pversion,,pShouldUpdateRoxiePage).NonFCRAAddressHRIEmail			
			,paw.SendEmail(pversion,,pShouldUpdateRoxiePage).Roxie				
			,govdata.Send_Emails(pversion,pShouldUpdateRoxiePage)
			//,Marketing_Best.Send_Emails(pversion,,pShouldUpdateRoxiePage).Roxie
		);
	end;
	

end;