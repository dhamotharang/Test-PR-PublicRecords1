// Function to get keys that are in regular nonfcra but not in prte environment.
// dsname - Dataset name must match regular roxie dataset name
// buildversion - version with which the new prct keys were built.
// envment = 'N' for nonfcra, 'F' for FCRA and 'B' if a dataset is available both in 
// FCRA and nonfcra for example CodesV3Keys.
// dopsenv = 'dev' (default) points to dev DOPS DB, 'prod' points to prod DOPS DB
import dops,ut;
export GetMissingKeys(string dsname,string buildversion,string envment = 'N',string boolKeys='N', string dopsenv = dops.constants.dopsenvironment) := function
	string replacestring := dsname + '_DATE';
	ds := dops.GetRoxieKeys(dsname,'B',envment,boolKeys, dopsenv);
	
	string_rec := record
		string actualkeyname := '';
		string lkeyname := '';
		string onthor := 'N';
	end;
	
	string_rec prct_recs(ds l) := transform
		getbuildversion := regexreplace(replacestring,l.logicalkey,buildversion);
		clustertoreplace := ut.Words(getbuildversion,1,1,':');
		newlkeyname := regexreplace(clustertoreplace,getbuildversion,'prte');
		self.actualkeyname := l.logicalkey;
		self.lkeyname := newlkeyname;
		self.onthor := if (fileservices.fileexists('~'+newlkeyname),'Y','N');
	end;
	
	missing_prct := nothor(project(global(ds,few),prct_recs(left))(onthor = 'N'));
	
	return missing_prct;
	
end;