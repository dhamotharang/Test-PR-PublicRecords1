// ***************************************************************************************
//Just like copyMissingKeys except it renames the old key so it doesn't leave old keys sitting around.
// dname - package dataset name same as of nonfcra 
// dversion - version with which new prct keys are built.
// versiontocopy - which version of keys on thor should be copied from.
// envment is either 'N' for non-FCRA or 'F' for FCRA keys.
// ***************************************************************************************
IMPORT PRTE, ut;

EXPORT RenameMissingKeys(string dname,string dversion,string versiontocopy,string envment = 'N',string boolKeys='N') := function
		ds := PRTE.GetMissingKeys(dname,dversion,envment);

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

		renameds := project(ds,copy_recs(left));

		//* adding NOTHOR for new release
		return NOTHOR(apply(renameds,if(fileservices.fileexists('~'+fromkeyname),fileservices.RenameLogicalFile('~'+fromkeyname,ThorName,'~'+tokeyname,,,,,true,true))));
END;