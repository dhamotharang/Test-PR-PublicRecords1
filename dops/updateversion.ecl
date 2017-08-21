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
// tagdelta = allows users to pass "previous/already existing" delta version to tag to the new 
//						"full" version that is pass in uversion parameter
//	Example: DOPS.updateversion('ABCKeys','20170516','abc@lexisnexis.com',,'N',,,,,,'F','20170514')

import STD,dops;
export updateversion(string l_datasetname,string l_uversion,string l_email_t,
string l_auto_pkg = 'N',string l_inenvment = '',string l_isboolready = 'Y',
string l_isprodready = 'N',string l_inloc = dops.constants.location,string l_indaliip = '',string l_includeboolean = 'Y', 
string l_updateflag = 'F',
string l_tagdelta = '',
string l_dopsenv = dops.constants.dopsenvironment) := function

	// trim all string variables when a value is passed from a deprecated function/macro
	// the values are being padded with space
	string owner := if (length(trim(l_email_t)) < 100,trim(l_email_t), trim(l_email_t)[1..99]);
	string datasetname := trim(l_datasetname);
	string uversion := trim(l_uversion);
	string email_t := trim(l_email_t);
	string auto_pkg := trim(l_auto_pkg);
	string inenvment := trim(l_inenvment);
	string isboolready := trim(l_isprodready);
	string isprodready := trim(l_isprodready);
	string inloc := trim(l_inloc);
	string indaliip := trim(l_indaliip);
	string includeboolean := trim(l_includeboolean);
	string updateflag := trim(l_updateflag);
	string tagdelta := trim(l_tagdelta);
	string dopsenv := trim(l_dopsenv);
	string subjectprefixstring := if (dopsenv = 'dev', '**WARNING UPDATING DOPS DEV DB**','');

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
												subjectprefixstring + datasetname + ' DOPS UPDATE ' + newcversion, 
												'Dataset: ' + datasetname + '\n' +
												'Version: ' + uversion + '\n' +
												'HPCC Build Owner/User: ' + dops.constants.jobowner + '\n\n' +
												'DOPS ENVIRONMENT: ' + dopsenv + if (dopsenv = 'dev', '. Updating DOPS DEV DB because the ECL code is running on dev, dops.constants.daliip is pointing to dev dali.', '') + '\n\n' +
												newemailmessage
										);
	end;
	
	
	// email_success := emailme_function(email_t,datasetname,'SUCCESS:'+uversion,uversion,'Build Version updated in Dops');
	// email_failure := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,failmessage);
	invalid_date := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today()+':'+inenvment,uversion,'Invalid Build Version');
	
	// update_failed := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Dops Update failed, Contact Anantha.Venkatachalam@lexisnexis.com');
	// zero_rows := emailme_function(email_t,datasetname,'ALERT:'+(string8)STD.Date.Today(),uversion,'No Updates, Invalid dataset name or Same Build version?');
	
	dwhenupdated := (string8)STD.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
	
	
	
	InputRec := record
		string dsname{xpath('dsname')} := datasetname;
		string dversion{xpath('dversion')} := uversion;
		string ddatetime{xpath('ddatetime')} := (STRING8)Std.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		string updatedby{xpath('updatedby')} := owner;
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
				'iUpdateVersion',
				InputRec,
				outrec,
				xpath('iUpdateVersionResponse/iUpdateVersionResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/iUpdateVersion'));

	codeval := emailme_function(email_t,datasetname,soapresults.Code+':'+uversion,uversion,soapresults.description);

	string builtkeys := dops.isRoxieKeysBuilt(datasetname,uversion,inloc,inenvment,includeboolean,indaliip,dopsenv); 

	missingkeys := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Missing Keys:' + builtkeys);

	invaliddaliip := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Dali IP Mismatch: lib_thorlib.thorlib.daliServers() = ' + dops.constants.daliip + ' does not match with ' + dops.constants.devdaliip + ' or ' + dops.constants.proddaliip);
								
	return if(dops.constants.dopsenvironment <> 'na'
							,if (builtkeys <> ''
									,missingkeys
									,if(uversion[1..8] <= (string8)STD.Date.Today(),codeval,invalid_date))
							,invaliddaliip);

	
end;