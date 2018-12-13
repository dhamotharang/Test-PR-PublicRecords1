import dops,data_services;
export GetPackageKeys(string dsname,string buildversion='',string envment = 'N', string bool = 'N') := function
	string replacestring := dsname + '_DATE::';
	ds := dops.GetRoxieKeys(dsname,'B',envment,bool);

	string_rec := record
		string superkeys := '';
		string lkeyname := '';
		string onthor := 'N';
	end;

	string_rec prct_recs(ds l) := transform
		self.superkeys := regexreplace('qa',l.superkey,'generation');
        bv1 := regexreplace('generation',l.logicalkey,'qa');
		getbuildversion := regexreplace(replacestring,bv1,buildversion);
		self.lkeyname := getbuildversion;
		self.onthor := if (fileservices.fileexists(data_services.foreign_prod+getbuildversion),'Y','N');
	end;

	return project(ds,prct_recs(left));
	
end;

