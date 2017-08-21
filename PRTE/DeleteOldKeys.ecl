import ut;
// Function to copy 0 byte baseline keys if it is missing for the new version built.
// dname - package dataset name same as of nonfcra 
// dversion - version with which new prct keys are built.
// versiontocopy - which version of keys on thor should be copied from.
export DeleteOldKeys(string dname,string dversion,string versiontocopy) := function
ds := PRTE.GetOldKeys(dname,dversion);



dsname := dname + '_DATE';

copy_rec := record
	string fromkeyname;
	string tokeyname;
	// string filecopystring;
end;

copy_rec copy_recs(ds l) := transform
	getbuildversion := regexreplace(dsname,l.actualkeyname,versiontocopy);
	clustertoreplace := ut.Words(getbuildversion,1,1,':');
	self.fromkeyname := trim(regexreplace(clustertoreplace,getbuildversion,'prte'),left,right);
	self.tokeyname := trim(l.lkeyname,left,right);
	// self.filecopystring := 'fileservices.copy(~'+trim(regexreplace(clustertoreplace,getbuildversion,'prte'),left,right)+',thor_200,~'+trim(l.lkeyname,left,right)+',,,,,true,true));';
end;

copyds := project(ds,copy_recs(left));

return apply(copyds,if(fileservices.fileexists('~'+fromkeyname),fileservices.copy('~'+fromkeyname,'thor_200','~'+tokeyname,,,,,true,true)));

end;