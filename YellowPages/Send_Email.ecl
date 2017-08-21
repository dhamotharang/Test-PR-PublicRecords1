import VersionControl;
export Send_Email :=
module

	export BuildSuccess	:= fileservices.sendemail(
													Email_Notification_Lists.BuildSuccess,
													'YELLOW PAGES: BUILD SUCCESS '+ YellowPages.YellowPages_Build_Date ,
													'keys: 1) thor_data400::key::targus_bdid_qa(thor_data400::key::yellowpages::'+YellowPages.YellowPages_Build_Date+'::bdid),\n' +
													'      2) thor_data400::key::yellowpages_phone_qa(thor_data400::key::yellowpages::'+YellowPages.YellowPages_Build_Date+'::phone),\n' +
													'      3) thor_data400::key::yellowpages_addr_qa(thor_data400::key::yellowpages::'+YellowPages.YellowPages_Build_Date+'::addr),\n' +
													'         have been built and ready to be deployed to QA.'); 
								
								
																				

	export BuildFailure	:= fileservices.sendemail(
													Email_Notification_Lists.BuildFailure,
													'Yellow Pages Build ' + YellowPages_Build_Date + ' Failed',
													workunit + '\n' + failmessage);

end;