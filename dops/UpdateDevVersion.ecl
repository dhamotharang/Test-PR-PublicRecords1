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

import ut,_Control,dops;
export updatedevversion(string datasetname,string uversion,string email_t,
string auto_pkg = 'N',string inenvment = '',string isboolready = 'Y',
string isprodready = 'N',string inloc = 'B',string indaliip = '',string inesp = '', 
string pullfromroxiecluster = '',
string l_updateflag = 'F') := function

	emailme_function(string email_t,string datasetname,string cversion, string uversion,
					string emailmessage,string cluster = '') := function
		return if (regexfind(pullfromroxiecluster,cluster),
									fileservices.sendemail(
												email_t + ',bocaroxiepackageteam@lexisnexis.com',
												datasetname + ' DOPS DEV UPDATE ' + cversion + ':PULL FROM CERT ROXIE',
												'Dataset: ' + datasetname + '\n' +
												'Version: ' + uversion + '\n\n' +
												emailmessage
										),
										fileservices.sendemail(
												email_t,
												datasetname + ' DOPS DEV UPDATE ' + cversion,
												'Dataset: ' + datasetname + '\n' +
												'Version: ' + uversion + '\n\n' +
												emailmessage
										)
								);
	end;
	
	
	
	// email_success := emailme_function(email_t,datasetname,'SUCCESS:'+uversion,uversion,'Build Version updated in Dops');
	// email_failure := emailme_function(email_t,datasetname,'FAILURE:'+ut.GetDate,uversion,failmessage);
	invalid_date := emailme_function(email_t,datasetname,'FAILURE:'+ut.GetDate,uversion,'Invalid Build Version');
	
	// update_failed := emailme_function(email_t,datasetname,'FAILURE:'+ut.GetDate,uversion,'Dops Update failed, Contact Anantha.Venkatachalam@lexisnexis.com');
	// zero_rows := emailme_function(email_t,datasetname,'ALERT:'+ut.GetDate,uversion,'No Updates, Invalid dataset name or Same Build version?');
	
	dwhenupdated := ut.GetDate+ut.getTime();
	
	builtlocation :=  if (indaliip = _control.IPAddress.dataland_dali, 'D','P');
	
	InputRec := record
		string dsname{xpath('dsname')} := datasetname;
		string dversion{xpath('dversion')} := uversion;
		string ddatetime{xpath('ddatetime')} := ut.GetDate+ut.getTime();
		string builtvalue{xpath('builtvalue')} := builtlocation;
		string updatedby{xpath('updatedby')} := thorlib.jobowner();
		string pushtoprod{xpath('pushtoprod')} := auto_pkg;
		string loc{xpath('loc')} := inloc;
		string dstatus{xpath('dstatus')} := 'New';
		string envflag{xpath('envflag')} := inenvment;
		string updateflag{xpath('updateflag')} := l_updateflag;
	end;
	

	outrec := record
		string Code{xpath('status/statuscode')};
		string description{xpath('status/statusdescription')};
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl,
				'UpdateDevVersion',
				InputRec,
				outrec,
				xpath('UpdateDevVersionResponse/UpdateDevVersionResult'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateDevVersion'));

	

	string builtkeys := dops.isRoxieKeysBuilt(datasetname,uversion,inloc,inenvment,,indaliip,inesp); 

	missingkeys := emailme_function(email_t,datasetname,'FAILURE:'+ut.GetDate,uversion,'Missing Keys:' + builtkeys);

	codeval := emailme_function(email_t,datasetname,soapresults.Code+':'+uversion,uversion,soapresults.description,builtkeys);
								
	return 		if (regexfind('hthor',thorlib.cluster()),
						if (regexfind('::',builtkeys),
									missingkeys,
									if(uversion[1..8] <= ut.GetDate,codeval,invalid_date)),
									fail('Run on hthor')
									);				

	
end;