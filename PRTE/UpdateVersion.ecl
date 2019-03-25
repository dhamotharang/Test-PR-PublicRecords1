// Function to update data operations database with a new build version for a specific
// dataset

// Parameters

// Dataset name - Name in the package (ex. BankruptcyV2Keys)
// uversion - Version to update (build version).
// email_t - list of emailids to notify the status of the update
// inloc - 'B' - Boca, 'A' - Alpharetta
// inenvment - 'N' - nonfcra, 'F' - FCRA
// isboolready (optional) - some datasets have boolean keys associated with it.
													// use this option only when auto_pkg = 'Y' and there are a boolean
													// keys associated with this dataset.


import ut,_Control,dops,std;
export updateversion(string datasetname,string uversion,string email_t,string inloc = 'B',string inenvment = '',string isboolready = 'Y',string dopsenv = dops.constants.dopsenvironment) := function

	
	emailme_function(string email_t,string datasetname,string cversion, string uversion,
					string emailmessage) := function
		return fileservices.sendemail(
												email_t,
												datasetname + ' PRTE DOPS UPDATE ' + cversion,
												'Dataset: ' + datasetname + '\n' +
												'Version: ' + uversion + '\n\n' +
												emailmessage
										);
	end;
	
	
	email_success := emailme_function(email_t,datasetname,'SUCCESS:'+uversion,uversion,'Build Version updated in PRTE Dops');
	email_failure := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,failmessage);
	invalid_date := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'Invalid Build Version');
	update_failed := emailme_function(email_t,datasetname,'FAILURE:'+(string8)STD.Date.Today(),uversion,'PRTE Dops Update failed, Contact Anantha.Venkatachalam@lexisnexis.com');
	zero_rows := emailme_function(email_t,datasetname,'ALERT:'+(string8)STD.Date.Today(),uversion,'No Updates, Invalid dataset name or Same Build version?');
	
	dwhenupdated := (string8)STD.Date.Today()+ut.getTime();
	
	
	
	InputRec := record
		string dsname{xpath('dsname')} := datasetname;
		string dversion{xpath('dversion')} := uversion;
		string ddatetime{xpath('ddatetime')} := (string8)STD.Date.Today()+Std.Date.SecondsToString(Std.date.CurrentSeconds(true), '%H%M%S');
		string updatedby{xpath('updatedby')} := thorlib.jobowner();
		string pushtoprod{xpath('pushtoprod')} := 'N';
		string loc{xpath('loc')} := inloc;
		string envment{xpath('envment')} := inenvment;
		string boolready{xpath('boolready')} := isboolready;
	end;
	

	outrec := record
		integer Code{xpath('UpdateVersionResponse/UpdateVersionResult')};
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,l_loc := inloc,l_testenv := 'PRTE'),
				'UpdateVersion',
				InputRec,
				dataset(outrec),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/UpdateVersion'));

	codeval := if (soapresults[1].Code = -2,invalid_date,
					if(soapresults[1].code = -1,update_failed,
					if(soapresults[1].code = -3,zero_rows,email_success)));

								
	return if(_Control.ThisEnvironment.Name = 'Prod_Thor', if(uversion[1..8] <= (string8)STD.Date.Today(),codeval,invalid_date),output('Not a Prod environment'));							

	
end;