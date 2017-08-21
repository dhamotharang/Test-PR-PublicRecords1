// DELETE ENTRIES FROM ROXIE PACKAGE
EXPORT delete(string clustername = '') := module
	
	export packageid(set of string name, string pkgfileversion = WORKUNIT[2..]) := function
		deleted := pkgfile.files('flat',clustername).getflatpackage(~(id in name or baseid in name));
		pkgfile.Promote(clustername).New(deleted,'flat',returndeleted,pkgfileversion);
		return returndeleted;
	end;

	export superfile(set of string name, string pkgfileversion = WORKUNIT[2..]) := function
		deleted := pkgfile.files('flat',clustername).getflatpackage(superfileid not in name);
		pkgfile.Promote(clustername).New(deleted,'flat',returndeleted,pkgfileversion);
		return returndeleted;
	end;
	
	export subfile(set of string name, string pkgfileversion = WORKUNIT[2..]) := function
		deleted := pkgfile.files('flat',clustername).getflatpackage(subfilevalue not in name);
		pkgfile.Promote(clustername).New(deleted,'flat',returndeleted,pkgfileversion);
		return returndeleted;
	end;
	
	export environment(set of string name, string pkgfileversion = WORKUNIT[2..]) := function
		deleted := pkgfile.files('flat',clustername).getflatpackage(environmentid not in name);
		pkgfile.Promote(clustername).New(deleted,'flat',returndeleted,pkgfileversion);
		return returndeleted;
	end;
end;