// ***************************************************************************************
// Function to copy 0 byte baseline keys if it is missing for the new version built.
// dname - package dataset name same as of nonfcra 
// dversion - version with which new prct keys are built.
// versiontocopy - which version of keys on thor should be copied from.
// environment is either 'N' for non-FCRA or 'F' for FCRA keys.
// boolKeys tells GetMissingKeys if it should include boolean keys or not.
// ***************************************************************************************
IMPORT ut, dops;

EXPORT CopyMissingKeys(string dname,string dversion,string versiontocopy,string environment='N',string boolKeys='N', string dopsenv = dops.constants.dopsenvironment) := FUNCTION
		ds := PRTE.GetMissingKeys(dname,dversion,environment,boolKeys, dopsenv);

		ThorName := ThorLib.Cluster();
		dsname := dname + '_DATE';

		copy_rec := record
			string fromkeyname;
			string tokeyname;
		end;

		copy_rec copy_recs(ds l) := transform
			getbuildversion := regexreplace(dsname,l.actualkeyname,versiontocopy);
			clustertoreplace := ut.Words(getbuildversion,1,1,':');
			self.fromkeyname := trim(regexreplace(clustertoreplace,getbuildversion,'prte'),left,right);
			self.tokeyname := trim(l.lkeyname,left,right);
		end;

		copyds := project(ds,copy_recs(left));

		// adding NOTHOR for new release 
		// NOTE: this overwrites so it depends on GetMissingKeys to only send missing keys
		return nothor(apply(global(copyds,few),if(fileservices.fileexists('~'+fromkeyname),fileservices.copy('~'+fromkeyname,ThorName,'~'+tokeyname,,,,,true,true))));
END;