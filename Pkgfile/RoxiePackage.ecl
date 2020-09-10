// Module to Build Roxie Package File
EXPORT RoxiePackage(string clustername = '') := module

	// Flat file that holds all Package Meta
	shared flatpackage := distribute(pkgfile.files('flat',clustername).getflatpackage,hash(pkgcode));

	////////////  Keys Package ////////////////////

	// Macro to get child datasets for superfiles
	shared getsubfileds(string l_pid, string l_superfileid) := function
		// Get all records related to a superfile
		Sfile_DS := flatpackage(id = l_pid and superfileid = l_superfileid);
		layouts.xml_layouts.superfile prepsuper(Sfile_DS l) := transform
			self.subfiles := dataset([{l.subfilevalue}],layouts.xml_layouts.subfile);
			self.id := l_superfileid;
		end;

		preppedsuper := project(Sfile_DS,prepsuper(left));
		// Rollup by superfile to create subfile child dataset
		layouts.xml_layouts.superfile rollsuper(preppedsuper l, preppedsuper r) := transform
			self.subfiles := l.subfiles + row({r.subfiles[1].value},layouts.xml_layouts.subfile);
			self := l;
		end;
		
		rolledsuper := rollup(preppedsuper,id,rollsuper(left,right));
		
		return rolledsuper;		
	end;
	
	// Function that returns the Key Package id Package
	export GetKeysPackage() := function
		sfile_ds := dedup(sort(flatpackage(pkgcode = 'K'),id, superfileid, -daliip), id, superfileid);
		layouts.xml_layouts.packageid prepsuper(sfile_ds l) := transform
			self.superfiles := getsubfileds(l.id, l.superfileid);
			self := l;
			self := [];
		end;

		preppedsuper := project(Sfile_DS,prepsuper(left));
		layouts.xml_layouts.packageid rollsuper(preppedsuper l, preppedsuper r) := transform
			self.superfiles := l.superfiles + row({r.superfiles[1].id,r.superfiles[1].subfiles},layouts.xml_layouts.superfile);
			self := l;
			self := [];
		end;
		
		rolledsuper := rollup(preppedsuper,id,rollsuper(left,right));
		
		return rolledsuper;
	end;
	
		
	////////////  End Keys Package ////////////////////
	
	
	////////////  Queries Package ////////////////////
	
	// Get all base ids for a Query
	shared getbaseids(string l_pid) := function
		KeyIDs := dedup(flatpackage(pkgcode = 'K'),id,all);
		layouts.xml_layouts.base getAllBases(KeyIDs l) := transform
			self.id := l.id;
		end;
		// If the query has empty base id then get all Key Package ID's
		// will be included as a part of query
		getAllIDs := sort(project(KeyIDs,getAllBases(left)),id);
		
		
		QueriesBaseIDs := flatpackage(pkgcode = 'Q' and baseid <> '' and id = l_pid);
		layouts.xml_layouts.base getSelectedBases(QueriesBaseIDs l) := transform
			self.id := l.baseid;
		end;
		// get all the base ids associated to query
		getSelectedIDs := project(QueriesBaseIDs,getSelectedBases(left));
		
		Base_DS := if ( count(flatpackage(id = 'EnvironmentVariables')) > 0,
											sort(if (count(flatpackage(id = l_pid and baseid = '')) > 0,
												// include all baseids
												getAllIDs,
												// include only existing baseids;
												getSelectedIDs
												) + dataset([{'EnvironmentVariables'}],layouts.xml_layouts.base),id),
											sort(if (count(flatpackage(id = l_pid and baseid = '')) > 0,
												// include all baseids
												getAllIDs,
												// include only existing baseids;
												getSelectedIDs
												),id)
												
										);
		
		return Base_DS;		
	end;
	
	//////////// Get Queries Package //////////////////
	shared GetQueriesPackage() := function
		Queries_DS := dedup(sort(flatpackage(pkgcode = 'Q'),-whenupdated),id,all,keep(1));
		
		pkgfile.layouts.xml_layouts.packageid prepqueries(Queries_DS l) := transform
			self.bases := getbaseids(l.id);
			self := l;
			self := [];
		end;

		querieswithbase := project(Queries_DS,prepqueries(left));
	
		return querieswithbase;
	end;
	
	////////////  End Queries Package ////////////////////
	
	////////////  Environment Package ////////////////////

	//////////// Get Environment Package //////////////////
	export GetEnvironmentPackage() := function
		Env_DS := flatpackage(pkgcode = 'E' and environmentid <> '');
		pkgfile.layouts.xml_layouts.packageid prepenvironment(Env_DS l) := transform
			self.environments := dataset([{l.environmentid,l.environmentval}],layouts.xml_layouts.environment);
			self := l;
			self := [];
		end;

		environmentprepped := project(Env_DS,prepenvironment(left));

		pkgfile.layouts.xml_layouts.packageid rollupenvironments(environmentprepped l, environmentprepped r) := transform
			self.environments := l.environments + row({r.environments[1].id,r.environments[1].val},layouts.xml_layouts.environment);
			self := l;
		end;

		environmentpackage := rollup(environmentprepped,id,rollupenvironments(left,right));
		return environmentpackage;
	
	end;
	
	////////////  End Environment Package ////////////////////
	
	
	///// Build and Promote Package //////
	
	export BuildPromotePackage(string pkgfileversion = WORKUNIT[2..]) := function
	
		fullpackage := sort(GetEnvironmentPackage() + GetQueriesPackage() + GetKeysPackage(),pkgcode,id);

		pkgfile.Promote(clustername).New(fullpackage,'xml',filepromoted,pkgfileversion);
		
		return filepromoted;
	end;
	
	///// Build and Promote Package //////
	
	///// Get Package //////
	
	export GetPackage(string destip = 'databuilddev01.risk.regn.net', string destlocation = '/home/rpt_srv_acct/public_html/pkgfiles/dev194pkg.txt') := function

		return fileservices.Despray(pkgfile.files('xml',clustername).pfile,destip,destlocation,,,,TRUE);
	end;
	
	///// Get Package //////
end;