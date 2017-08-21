// Function to get keys that are in regular nonfcra but not in prte environment.
// dsname - Dataset name must match regular roxie dataset name
// buildversion - version with which the new prct keys were built.
// envment = 'N' for nonfcra, 'F' for FCRA and 'B' if a dataset is available both in 
// FCRA and nonfcra for example CodesV3Keys.
import dops,ut;
export GetOldKeys(string dsname,string buildversion,string envment = 'N') := function
	string replacestring := dsname + '_DATE';
	ds := dops.GetRoxieKeys(dsname,'B',envment,'N');
	
	string_rec := record
		string actualkeyname := '';
		string lkeyname := '';
		string onthor := 'N';
	end;
	
	string_rec prct_recs(ds l) := transform
		getbuildversion := regexreplace(replacestring,l.logicalkeys,buildversion);
		clustertoreplace := ut.Words(getbuildversion,1,1,':');
		newlkeyname := regexreplace(clustertoreplace,getbuildversion,'prte');
		self.actualkeyname := l.logicalkeys;
		self.lkeyname := newlkeyname;
		self.onthor := if (fileservices.fileexists('~'+newlkeyname),'Y','N');
	end;
	
	missing_prct := project(ds,prct_recs(left))(onthor = 'Y');
	
	return missing_prct;
	
end;