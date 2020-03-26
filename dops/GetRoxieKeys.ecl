// Function to getroxie keys from dops database
// Function will return a dataset with superkey name and logical key name
// The logical key name is a template for example
		// ~thor_data400::key::lnproperty::LNPropertyV2Keys_DATE::did
		// LNPropertyV2Keys_DATE - should be replaced with the respective version of the key.
		
// Parameters

// datasetname - same as dataset name in the package
// location - B for Boca, A for Alpharetta
// eflag - F for FCRA, N for nonFCRA
// bool - Y to get the boolean keys in addition to nonfcra keys, N to get only nonfcra keys
import dops;
export GetRoxieKeys(string datasetname,string location,string eflag, string bool = 'N',string template = 'Y'
											,string dopsenv = dops.constants.dopsenvironment
											,string l_testenv = 'NA') := function
	InputRec := record
		string datasetname{xpath('datasetname')} := datasetname;
		string location{xpath('location')} := location;
		string environment{xpath('environment')} := eflag;
		string gettemplate{xpath('gettemplate')} := template;
		string getboolkeys{xpath('getboolkeys')} := bool;
		
	end;
	
	outrec := record,maxlength(50000)
		string superkey {xpath('superkey')};
		string logicalkey {xpath('logicalkey')};
	end;
	
	soapresults := SOAPCALL(
				dops.constants.prboca.serviceurl(dopsenv,eflag,location,l_testenv),
				'GetRoxieKeys',
				InputRec,
				dataset(outrec),
				xpath('GetRoxieKeysResponse/GetRoxieKeysResult/roxielist'),
				NAMESPACE('http://lexisnexis.com/'),
				LITERAL,
				SOAPACTION('http://lexisnexis.com/GetRoxieKeys'));
	
	// xmlout_rec := record,maxlength(50000)
		// string xmlline;
	// end;
	
	// xmlds := dataset([{soapresults[1].keysxml}],xmlout_rec);

	 // string_Rec := record
		 // string superkeys := trim(regexreplace('\n',regexreplace('\r',xmltext('superkey'),''),''),left,right);
		 // string logicalkeys := trim(regexreplace('\n',regexreplace('\r',xmltext('logicalkey'),''),''),left,right);
	 // end;
	 
	

	// xmlout := parse(xmlds,xmlline,string_rec,xml('Keys/Key'));

	return soapresults;
	

	
end;