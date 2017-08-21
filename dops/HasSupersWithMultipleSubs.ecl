EXPORT HasSupersWithMultipleSubs(string filename) := function
	
	getfile := if (regexfind('~',filename),filename,'~'+filename);

	ds := fileservices.LogicalFileSuperOwners(getfile);

	owners := record
		string name;
		integer scount;
	end;

	owners proj_recs(ds l) := transform
		self.name :=  l.name;
		self.scount := fileservices.getsuperfilesubcount('~'+l.name);
	end;

	ownersubcount := project(ds,proj_recs(left));

	return if(fileservices.fileexists(getfile),if (count(ownersubcount(scount > 1)) > 0,true,false),false);
end;