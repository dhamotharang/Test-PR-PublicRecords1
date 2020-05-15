import ut;
EXPORT GetRoxiePackage(string roxieesp, string roxieport, string roxietarget
													,string roxieprocess = '*') := module

	export rPackageFile := record, maxlength(5000000)
			string packagemaps := '';
			string partid := '';
			string PackageXMLAsString := '';
	end;

	export rBase := record
		string baseid {xpath('@id')};
	end;

	export rSubFile := record
		string subfile {xpath('@value')};
	end;
		
	export	rSuperFile := record
			string superfile {xpath('@id')};
			dataset(rSubFile) subfiles {xpath('SubFile')};
	end;
		
	export	rPackage := record
			string pid {xpath('@id')};
			dataset(rSuperFile) superfiles {xpath('SuperFile')};
	end;

	////////////////////////// with queries
	export	rPackageWithQueries := record
			string pid {xpath('@id')};
			dataset(rBase) baseids {xpath('Base')};
			dataset(rSuperFile) superfiles {xpath('SuperFile')};
	end;
	
	// 6.x platforms have part id in the package file
	export	rPart := RECORD
			string partid {XPATH('@id')};
			dataset(rPackage) pkgs {xpath('Package')};
	END;
	////////////////////////// with queries
	export	rPartWithQueries := RECORD
			string partid {XPATH('@id')};
			dataset(rPackageWithQueries) pkgs {xpath('Package')};
	END;
	
	//////////////////////
	export	rPackageMap := RECORD
			string pkgmaps {XPATH('@id')};
			dataset(rPart) parts {xpath('Part')};
	END;

	////////////////////////// with queries
	export	rPackageMapWithQueries := RECORD
			string pkgmaps {XPATH('@id')};
			dataset(rPartWithQueries) parts {xpath('Part')};
	END;

	export rPackageKeyInfo := record
			string packagename := '';
			string packageid := '';
			string superfile := '';
			string subfile := '';
	end;
	
	////////////////////////// with queries
	
	export rPackageKeyInfoWithQueries := record
			string packagename {xpath('PackageMaps/@id')};
			string partid {xpath('Part/@id')};
			string packageid {xpath('Package/@id')};
			string baseid {xpath('Base/@id')};
			string superfile {xpath('SuperFile/@id')};
			string subfile {xpath('SubFile/@value')};
	end;

	export PackageFromXML() := function
		InputRec := record
			string datasetname{xpath('Target')} := roxietarget;
			string location{xpath('Process')} := roxieprocess;
		end;
	
		outrec := record,maxlength(5000000)
			string Info {xpath('Info')};
		end;
	
		soapresults := SOAPCALL(
				'http://'+roxieesp+':'+roxieport+'/WsPackageProcess',
				'GetPackage',
				InputRec
				,dataset(outrec),
				xpath('GetPackageResponse')
				,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues()));
	
		xmlout_rec := record,maxlength(5000000)
			string xmlline;
		end;
	
		xmlds := dataset([{soapresults[1].Info}],xmlout_rec);

		dFromXML := fromxml(rPackageMap,soapresults[1].Info);

		dFromXMLtoDataset := if (count(soapresults(info <> '')) > 0
															,dataset([dFromXML],recordof(dFromXML))
															,dataset([],rPackageMap)
															);
		
		return dFromXMLtoDataset;
		
	end;
	
	export Keys() := function

		rNormPackage := record
			string pkgmapid := '';
			string partid := '';
			string pid := '';
			string superfileid := '';
			string subfileid := '';
			dataset(rPackage) pkgs;
			dataset(rSuperFile) superfiles;
			dataset(rSubFile) subfiles;
		end;
		
		rNormPackage xNormParts(rPackageMap l, rPart r) := transform
			self.pkgmapid := l.pkgmaps;
			self.partid := r.partid;
			self.pkgs := r.pkgs;
			self.superfiles := [];
			self.subfiles := [];
			self := l;
		end;

		dNormPart := normalize(PackageFromXML(),left.parts,xNormParts(left,right));
	
		rNormPackage xNormPackage(dNormPart l, rPackage r) := transform
			//self.pkgmapid := l.pkgmaps;
			self.pid := r.pid;
			self.superfiles := r.superfiles;
			self.subfiles := [];
			self := l;
		end;

		dNormPackage := normalize(dNormPart,left.pkgs,xNormPackage(left,right));


		rNormPackage xNormSuperFile(dNormPackage l, rSuperFile r) := transform
			self.superfileid := r.superfile;
			self.subfiles := r.subfiles;
			self := l;
		end;

		dNormSuperFile := normalize(dNormPackage,left.superfiles,xNormSuperFile(left,right));

		rNormPackage xNormSubFile(dNormSuperFile l, rSubFile r) := transform
			self.subfileid := r.subfile;
			self := l;
		end;

		dNormSubFile := normalize(dNormSuperFile,left.subfiles,xNormSubFile(left,right));

		rPackageKeyInfo xPackageInfo(dNormSubFile l) := transform
			self.packagename := l.pkgmapid;
			self.packageid := l.pid;
			self.superfile := l.superfileid;
			self.subfile := l.subfileid;
		end;

		dPackageInfo := project(dNormSubFile,xPackageInfo(left))(~regexfind('GENERATION[0-9]+$',packageid));

		return dPackageInfo;

	end;
	
	export XMLPackageWithQueries() := function
		InputRec := record
			string datasetname{xpath('Target')} := roxietarget;
			string location{xpath('Process')} := roxieprocess;
		end;
	
		outrec := record,maxlength(5000000)
			string Info {xpath('Info')};
		end;
	
		soapresults := SOAPCALL(
				'http://'+roxieesp+':'+roxieport+'/WsPackageProcess',
				'GetPackage',
				InputRec
				,dataset(outrec),
				xpath('GetPackageResponse')
				,HTTPHEADER('Authorization', 'Basic ' + ut.Credentials().fGetEncodedValues()));
	
		xmlout_rec := record,maxlength(5000000)
			string xmlline;
		end;
	
		xmlds := dataset([{soapresults[1].Info}],xmlout_rec);

		dFromXML := fromxml(rPackageMapWithQueries,soapresults[1].Info);

		dFromXMLtoDataset := if (count(soapresults(info <> '')) > 0
															,dataset([dFromXML],recordof(dFromXML))
															,dataset([],rPackageMapWithQueries)
															);
		
		return dFromXMLtoDataset;
	end;
	
	export fXMLPackageAsDataset() := function

		rNormPackage := record
			string pkgmapid := '';
			string partid := '';
			string pid := '';
			string baseid := '';
			string superfileid := '';
			string subfileid := '';
			dataset(rPackageWithQueries) pkgs;
			dataset(rSuperFile) superfiles;
			dataset(rSubFile) subfiles;
			dataset(rBase) baseids;
		end;
		
		rNormPackage xNormParts(rPackageMapWithQueries l, rPartWithQueries r) := transform
			self.pkgmapid := l.pkgmaps;
			self.partid := r.partid;
			self.pkgs := r.pkgs;
			self.superfiles := [];
			self.subfiles := [];
			self.baseids := [];
			self := l;
		end;

		dNormPart := normalize(XMLPackageWithQueries(),left.parts,xNormParts(left,right));
	
		rNormPackage xNormPackage(dNormPart l, rPackageWithQueries r) := transform
			//self.pkgmapid := l.pkgmaps;
			self.pid := r.pid;
			self.superfiles := r.superfiles;
			self.baseids := r.baseids;
			self.subfiles := [];
			self := l;
		end;

		dNormPackage := normalize(dNormPart,left.pkgs,xNormPackage(left,right));
		
		rNormPackage xNormBase(dNormPackage l, rBase r) := transform
			self.baseid := r.baseid;
			self := l;
		end;

		dNormBase := normalize(dNormPackage,left.baseids,xNormBase(left,right));

		rNormPackage xNormSuperFile(dNormPackage l, rSuperFile r) := transform
			self.superfileid := r.superfile;
			self.subfiles := r.subfiles;
			self := l;
		end;

		dNormSuperFile := normalize(dNormPackage,left.superfiles,xNormSuperFile(left,right));

		rNormPackage xNormSubFile(dNormSuperFile l, rSubFile r) := transform
			self.subfileid := r.subfile;
			self := l;
		end;

		dNormSubFile := normalize(dNormSuperFile,left.subfiles,xNormSubFile(left,right));

		dFull := dNormBase + dNormSubFile;

		rPackageKeyInfoWithQueries xPackageInfo(dNormBase l) := transform
			self.packagename := l.pkgmapid;
			self.packageid := l.pid;
			self.partid := l.partid;
			self.baseid := l.baseid;
			self.superfile := l.superfileid;
			self.subfile := l.subfileid;
		end;

		dPackageInfo := project(dFull,xPackageInfo(left))(~regexfind('GENERATION[0-9]+$',packageid));

		return dPackageInfo;

	end;
	
	
	export fDatasetAsXMLPackage(dataset(rPackageKeyInfoWithQueries) pGetPackageAsDataset = dataset([],rPackageKeyInfoWithQueries)) := function
		
		dGetPackageAsDataset := if (count(pGetPackageAsDataset) = 0
															,sort(fXMLPackageAsDataset(),packagename,partid,packageid,baseid,superfile)
															,sort(pGetPackageAsDataset,packagename,partid,packageid,baseid,superfile)
															): independent;
		
		dGetPackageBase := dGetPackageAsDataset(baseid <> '');
		
		dGetPackageSubFiles := dGetPackageAsDataset(subfile <> '');
		
		rPackageWithSubFiles := record
			rPackageKeyInfoWithQueries;
			rPartWithQueries;
			rPackageWithQueries;
			dataset(rSubFile) subfiles;
		end;
		// base ids
		rPackageWithSubFiles xProjectBase(dGetPackageBase l) := transform
			self.pid := l.packageid;
			self.baseids := dataset([{l.baseid}],rBase);
			self.superfiles := [];
			self.subfiles := [];
			self.pkgs := [];
			self := l;
		end;

		dProjectBase := project(dGetPackageBase,xProjectBase(left));
		
		rPackageWithSubFiles xRollupBase(dProjectBase l, dProjectBase r) := transform
			self.baseids := l.baseids + row({r.baseids[1].baseid},rBase);
			self := l;
		end;
		
		dRollupBase := sort(rollup(dProjectBase,packagename+partid+packageid,xRollupBase(left,right)),partid,packageid,baseid);
		
		// subfiles
		rPackageWithSubFiles xProjectSubFiles(dGetPackageSubFiles l) := transform
			self.pid := l.packageid;
			self.baseids := [];
			self.superfiles := [];
			self.pkgs := [];
			self.subfiles := dataset([{l.subfile}],rSubFile);
			self := l;
		end;

		dProjectSubFiles := project(dGetPackageSubFiles,xProjectSubFiles(left));
		
		rPackageWithSubFiles xRollupSubFiles(dProjectSubFiles l, dProjectSubFiles r) := transform
			self.subfiles := l.subfiles + row({r.subfiles[1].subfile},rSubFile);
			self := l;
		end;
		
		dRollupSubFiles := sort(rollup(dProjectSubFiles,partid+packageid+superfile,xRollupSubFiles(left,right)),partid,packageid,superfile);
		
		rPackageWithSubFiles xPopulateSubFiles(dGetPackageSubFiles l, dRollupSubFiles r) := transform
			self.pid := l.packageid;
			self.baseids := [];
			self.superfiles := [];
			self.pkgs := [];
			self.subfiles  := r.subfiles;
			self := l;
		end;
		
		dPopulateSubFiles := dedup(sort(join(dGetPackageSubFiles
															,dRollupSubFiles
															,left.partid = right.partid
																and left.packageid = right.packageid
																and left.superfile = right.superfile
															,xPopulateSubFiles(left,right)
															,left outer
															),partid,packageid,superfile),partid,packageid,superfile);
		
		
		// superfiles
		rPackageWithSubFiles xProjectSuperFiles(dPopulateSubFiles l) := transform
			self.superfiles := dataset([{l.superfile,l.subfiles}],rSuperFile);
			self := l;
		end;

		dProjectSuperFiles := project(dPopulateSubFiles,xProjectSuperFiles(left));
		
		rPackageWithSubFiles xRollupSuperFiles(dProjectSuperFiles l, dProjectSuperFiles r) := transform
			self.superfiles := l.superfiles + row({r.superfiles[1].superfile,r.superfiles[1].subfiles},rSuperFile);
			self := l;
		end;
		
		dRollupSuperFiles := rollup(dProjectSuperFiles,partid+packageid,xRollupSuperFiles(left,right));
		
		// combine base + supers
		dCombine := sort(dRollupBase + dRollupSuperFiles,packagename,partid);
		
		rPackageWithSubFiles xProjectPackage(dCombine l) := transform
			self.pkgs := dataset([{l.pid,l.baseids,l.superfiles}],rPackageWithQueries);
			self := l;
		end;

		dProjectPackages := project(dCombine,xProjectPackage(left));
		
		rPartWithQueries xConvertToPackageLayout(dProjectPackages l) := transform
			self := l;
		end;
		
		dConvertToPackageLayout := project(dProjectPackages,xConvertToPackageLayout(left));
		
		rPartWithQueries xRollupParts(dConvertToPackageLayout l, dConvertToPackageLayout r) := transform
			self.pkgs := l.pkgs + dataset([{r.pkgs[1].pid,r.pkgs[1].baseids,r.pkgs[1].superfiles}],rPackageWithQueries);
			self := l;
		end;
		
		dRollupParts := rollup(dConvertToPackageLayout,partid,xRollupParts(left,right));
		
		return dRollupParts;
		
	end;
	
	shared fRemovePartFromXML(dataset(rPartWithQueries) p_dPartWithQueries, string p_partid) := function
		rPartWithQueriesSlim := record
			rPartWithQueries - partid;
		end;

		dSlim := p_dPartWithQueries(partid = p_partid);
		
		rPartWithQueriesSlim xConvertToPackageLayout(dSlim l) := transform
			self := l;
		end;
		
		dConvertToPackageLayout := project(dSlim,xConvertToPackageLayout(left));
		
		rPackageFile := record, maxlength(5000000)
			string partid := '';
			string PackageXMLAsString := '';
		end;
		
		rPackageFile xGetPackageString(dConvertToPackageLayout l) := transform
			self.PackageXMLAsString := (string)TOXML(row(l,recordof(dConvertToPackageLayout)));
			self := l;
		end;
		
		dGetPackageString := project(dConvertToPackageLayout,xGetPackageString(left));
		
		return dGetPackageString[1].PackageXMLAsString;
		
	end;
	
	export fGetXMLPackageAsString(dataset(rPackageKeyInfoWithQueries) pGetPackageAsDataset = dataset([],rPackageKeyInfoWithQueries)
																	,string pPackageMapName = ''
																	,boolean pGetPartPackageAsString = false) := function
	
		string lPackageMapName := if (pPackageMapName <> '',pPackageMapName, 'roxie');
	
		dDatasetAsXMLPackage := fDatasetAsXMLPackage(pGetPackageAsDataset);
		
		rPartWithQueriesSlim := record
			rPartWithQueries - partid;
		end;
		
		rPartWithQueriesSlim xConvertToPackageLayout(dDatasetAsXMLPackage l) := transform
			self := l;
		end;
		
		dConvertToPackageLayout := project(dDatasetAsXMLPackage,xConvertToPackageLayout(left));
		
		// rPackageFile xGetPackageString(dDatasetAsXMLPackage l) := transform
			// self.PackageXMLAsString := (string)TOXML(row(l,recordof(dDatasetAsXMLPackage)));
			// self := l;
		// end;
		
		rPackageFile xGetPackageString(dDatasetAsXMLPackage l) := transform
			self.packagemaps := lPackageMapName;
			self.PackageXMLAsString := '<Part id=\"'+trim(l.partid,left,right)+'\">'+fRemovePartFromXML(dDatasetAsXMLPackage,l.partid)+'</Part>';
			self := l;
		end;
		
		
		dGetPackageString := project(dDatasetAsXMLPackage,xGetPackageString(left));
		
		rPackageFile xRollupPackageString(dGetPackageString l, dGetPackageString r) := transform
			self.PackageXMLAsString := l.PackageXMLAsString + r.PackageXMLAsString;
			self := l;
		end;
		
		dRollupPackageString := rollup(dGetPackageString,packagemaps,xRollupPackageString(left,right));
		
		return if (pGetPartPackageAsString, dGetPackageString, dRollupPackageString);
	end;

	
end;