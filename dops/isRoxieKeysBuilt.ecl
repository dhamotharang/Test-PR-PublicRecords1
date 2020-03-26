// Parameters

// datasetname - same as dataset name in the package
// buildversion - version used to build the roxie keys
// location - B for Boca, A for Alpharetta
// eflag - F for FCRA, N for nonFCRA
// bool - Y to get the boolean keys in addition to nonfcra keys, N to get only nonfcra keys
// daliip - check for file existance in remote dali by default it will use local thor
// Function - to check if the keys are built on thor
import dops,_Control;
EXPORT isRoxieKeysBuilt(string datasetname,string buildversion, string location,string eflag,string bool = 'N', string daliip = ''
													,string dopsenv = dops.constants.dopsenvironment
													,string l_testenv = 'NA') := function
	keysds := dops.GetRoxieKeys(datasetname,location,eflag,bool,'Y',dopsenv,l_testenv := l_testenv);
	
	recwithflag := record
		string dsname;
		string superkey;
		string logicalkey := '';
		integer isavailable;
		string missingkeys := '';
	end;
	
	recwithflag getflag(keysds l) := transform
		string replacedkey := if (daliip = '',regexreplace(datasetname+'_DATE',l.logicalkey,buildversion,nocase),'~foreign::'+daliip+'::'+regexreplace(datasetname+'_DATE',l.logicalkey,buildversion,nocase));
		self.superkey := l.superkey;
		self.logicalkey := replacedkey;
		self.isavailable := if (fileservices.fileexists('~'+replacedkey),0,1);
		self.dsname := datasetname;
		self := l;
	end;
	
	recordswithflag := nothor(project(global(keysds,few),getflag(left)));// : persist('~dops::persist::'+datasetname+'_'+location+'_'+eflag,_Control.ThisEnvironment.HThor_Name);
	
	mrecords := record
		//string dsname := '';
		string missingkeys := '';
	end;
	
	//emptyds := dataset([{datasetname,''}],mrecords);
	
	recwithflag GetMissingKeys(recordswithflag l,recordswithflag r) := transform
		//self.dsname := l.dsname;
		self.missingkeys := l.missingkeys + '\n' + r.logicalkey;
		self := l;
	end;
	
	keysnotbuilt := rollup(recordswithflag(isavailable > 0)
																			,left.dsname = right.dsname
																			,GetMissingKeys(left,right)
																								);
	
	
	return if (count(recordswithflag(isavailable > 0)) > 1,keysnotbuilt[1].missingkeys,recordswithflag(isavailable > 0)[1].logicalkey);
end;