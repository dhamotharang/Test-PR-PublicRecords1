// Function to update data operations database with a new build version for a specific
// dataset

// Parameters

// Dataset name - Name in the package (ex. BankruptcyV2Keys)
// uversion - Version to update (build version).
// email_t - list of emailids to notify the status of the update
// auto_pkg (optional) - must be used only when there is a business requirement to send
													// production packages automatically
													// For example, we send Bankruptcy packages early in the morning
													// at 5.00 AM and this is done automatically and is based 
													// on this flag. ****** VERY IMPORTANT NOT TO USE THIS FLAG *****
// inenvment - 'N' - nonfcra, 'F' - FCRA, 'BN' - BIP NonFCRA if updating the same dataset
//								 in multiple environment then use "|" for example 'N|F'
// isboolready (optional) - some datasets have boolean keys associated with it.
													// use this option only when auto_pkg = 'Y' and there are a boolean
													// keys associated with this dataset.
// inprod - 'Y' if the dataset version should be included in automated package.
// isprodready - 'Y' if the dataset version should be included in automated package.
// inloc - location to run
// updateflag - 'F' - Full replace; 'D' - Delta Update; 'DR' - Delta Replace
//							Note: Use Delta Replace when you are replacing a delta version with another delta.

import STD,_Control,dops;
export UpdateDev196Version(string datasetname,string uversion,string email_t,
string auto_pkg = 'N',string inenvment = '',string isboolready = 'Y',
string isprodready = 'N',string inloc = 'B',string indaliip = '',string includeboolean = 'Y', 
string updateflag = 'F',
string tagdelta = '',
string dopsenv = dops.constants.dopsenvironment) := function

	emailme_function(string email_t,string datasetname,string cversion, string uversion,
					string emailmessage) := function
		// JIRA: DUS-14
		newcversion := if (regexfind('WARNING',emailmessage)
													,regexreplace('SUCCESS',cversion,'FAILURE')
													,cversion);
		newemailmessage := if (regexfind('WARNING',emailmessage)
													,emailmessage + '. Please note, version must have been updated but it might not be ready for deployment unless the issue is fixed.'
													,emailmessage);
		
		return fileservices.sendemail(
												email_t,
												datasetname + ' DOPS UPDATE ' + newcversion, 
												'Dataset: ' + datasetname + '\n' +
												'Version: ' + uversion + '\n\n' +
												newemailmessage
										);
	end;
	
	
	// email_success := emailme_function(email_t,datasetname,'SUCCESS:'+uversion,uversion,'Build Version updated in Dops');
	// email_failure := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,failmessage);
	invalid_date := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Invalid Build Version');
	
	// update_failed := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Dops Update failed, Contact Anantha.Venkatachalam@lexisnexis.com');
	// zero_rows := emailme_function(email_t,datasetname,'ALERT:'+(string8)STD.Date.Today(),uversion,'No Updates, Invalid dataset name or Same Build version?');
	
	dwhenupdated := (string8)STD.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
	
	
	
	InputRec := record
		string dsname{xpath('dsname')} := datasetname;
		string dversion{xpath('dversion')} := uversion;
		string ddatetime{xpath('ddatetime')} := (STRING8)Std.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		string updatedby{xpath('updatedby')} := thorlib.jobowner();
		string pushtoprod{xpath('pushtoprod')} := auto_pkg;
		string loc{xpath('loc')} := inloc;
		string envment{xpath('envment')} := inenvment;
		string boolready{xpath('boolready')} := isboolready;
		string inprod{xpath('inprod')} := isprodready;
		string updateflag{xpath('updateflag')} := updateflag;
		string tagdelta{xpath('tagdelta')} := tagdelta;
	end;
	

	outrec := record
		string Code{xpath('status/statuscode')};
		string description{xpath('status/statusdescription')};
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,if (regexfind('H',inenvment),'H','')),
				'UpdateDev196Version',
				InputRec,
				outrec,
				xpath('UpdateDev196VersionResponse/UpdateDev196VersionResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateDev196Version'));

	codeval := emailme_function(email_t,datasetname,soapresults.Code+':'+uversion,uversion,soapresults.description);

	string builtkeys := dops.isRoxieKeysBuilt(datasetname,uversion,inloc,inenvment,includeboolean,indaliip,dopsenv); 

	missingkeys := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Missing Keys:' + builtkeys);

								
	return //if(_Control.ThisEnvironment.Name = 'Prod_Thor', 
							if (builtkeys <> '',
									missingkeys,
									if(uversion[1..8] <= (string8)STD.Date.Today(),codeval,invalid_date));/*,
											output('Not a Prod environment'));												*/	

	
end;