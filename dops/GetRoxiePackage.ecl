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
	
	export rEnvironment := record
		string environmentid {xpath('@id')};
		string environmentvalue {xpath('@val')};
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
			string compulsory {xpath('@compulsory')};
			string enablefieldtranslation {xpath('@enablefieldtranslation')};
			string daliip {xpath('@daliip')};
			dataset(rEnvironment) environmentids {xpath('Environment')};
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
			string packagename {xpath('PackageMaps/@id')} := '';
			string partid {xpath('Part/@id')} := '';
			string packageid {xpath('Package/@id')} := '';
			string daliip {xpath('Package/@dallip')} := '';
			string compulsory {xpath('Package/@compulsory')} := '';
			string enablefieldtranslation {xpath('Package/@enablefieldtranslation')} := '';
			string baseid {xpath('Base/@id')} := '';
			string environmentid {xpath('Environment/@id')} := '';
			string environmentvalue {xpath('Environment/@val')} := '';
			string superfile {xpath('SuperFile/@id')} := '';
			string subfile {xpath('SubFile/@value')} := '';
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
	
	export fXMLPackageAsDataset(dataset(rPackageKeyInfoWithQueries) pGetPackageAsDataset = dataset([],rPackageKeyInfoWithQueries)) := function

		rNormPackage := record
			string pkgmapid := '';
			string partid := '';
			string pid := '';
			string daliip := '';
			string compulsory := '';
			string enablefieldtranslation := '';
			string environmentid := '';
			string environmentvalue := '';
			string baseid := '';
			string superfileid := '';
			string subfileid := '';
			dataset(rPackageWithQueries) pkgs;
			dataset(rSuperFile) superfiles;
			dataset(rSubFile) subfiles;
			dataset(rBase) baseids;
			dataset(rEnvironment) environmentids;
		end;
		
		rNormPackage xNormParts(rPackageMapWithQueries l, rPartWithQueries r) := transform
			self.pkgmapid := l.pkgmaps;
			self.partid := r.partid;
			self.pkgs := r.pkgs;
			self.superfiles := [];
			self.subfiles := [];
			self.baseids := [];
			self.environmentids := [];
			self := l;
		end;

		dNormPart := normalize(XMLPackageWithQueries(),left.parts,xNormParts(left,right));
	
		rNormPackage xNormPackage(dNormPart l, rPackageWithQueries r) := transform
			//self.pkgmapid := l.pkgmaps;
			self.pid := r.pid;
			self.daliip := r.daliip;
			self.compulsory := r.compulsory;
			self.enablefieldtranslation := r.enablefieldtranslation;
			self.superfiles := r.superfiles;
			self.baseids := r.baseids;
			self.environmentids := r.environmentids;
			self.subfiles := [];
			self := l;
		end;

		dNormPackage := normalize(dNormPart,left.pkgs,xNormPackage(left,right));
		
		rNormPackage xNormBase(dNormPackage l, rBase r) := transform
			self.baseid := r.baseid;
			self := l;
		end;

		dNormBase := normalize(dNormPackage,left.baseids,xNormBase(left,right));
		
		rNormPackage xNormEnvironment(dNormPackage l, rEnvironment r) := transform
			self.environmentid := r.environmentid;
			self.environmentvalue := r.environmentvalue;
			self := l;
		end;

		dNormEnvironment := normalize(dNormPackage,left.environmentids,xNormEnvironment(left,right));

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

		dFull := dNormEnvironment + dNormBase + dNormSubFile;

		rPackageKeyInfoWithQueries xPackageInfo(dNormBase l) := transform
			self.packagename := l.pkgmapid;
			self.packageid := l.pid;
			self.partid := l.partid;
			self.baseid := l.baseid;
			self.environmentid := l.environmentid;
			self.environmentvalue := l.environmentvalue;
			self.daliip := l.daliip;
			self.compulsory := l.compulsory;
			self.enablefieldtranslation := l.enablefieldtranslation;
			self.superfile := l.superfileid;
			self.subfile := l.subfileid;
		end;

		dPackageInfo := project(dFull,xPackageInfo(left))(~regexfind('GENERATION[0-9]+$',packageid));

		return dPackageInfo;

	end;
	
	
	export fDatasetAsXMLPackage(dataset(rPackageKeyInfoWithQueries) pGetPackageAsDataset = dataset([],rPackageKeyInfoWithQueries)
																	,boolean pBuildWithoutPart = true) := function
		
		dGetPackageAsDatasetWithPart := if (count(pGetPackageAsDataset) = 0
															,sort(fXMLPackageAsDataset(),packagename,partid,packageid,environmentid,baseid,superfile)
															,sort(pGetPackageAsDataset,packagename,partid,packageid,environmentid,baseid,superfile)
															): independent;
															
		typeof(dGetPackageAsDatasetWithPart) xNoParts(dGetPackageAsDatasetWithPart l) := transform
			self.partid := '';
			self := l;
		end;
		
		dGetPackageAsDatasetWithoutPart := project(dGetPackageAsDatasetWithPart,xNoParts(left));
		
		dGetPackageAsDataset := if (pBuildWithoutPart
																	,dGetPackageAsDatasetWithoutPart
																	,dGetPackageAsDatasetWithPart);
		
		dGetPackageEnvironment := dGetPackageAsDataset(environmentid <> '');
		
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
			self.environmentids := [];
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
		
		
		// environment ids
		rPackageWithSubFiles xProjectEnvironment(dGetPackageEnvironment l) := transform
			self.pid := l.packageid;
			self.environmentids := dataset([{l.environmentid,l.environmentvalue}],rEnvironment);
			self.baseids := [];
			self.superfiles := [];
			self.subfiles := [];
			self.pkgs := [];
			self := l;
		end;

		dProjectEnvironment := project(dGetPackageEnvironment,xProjectEnvironment(left));
		
		rPackageWithSubFiles xRollupEnvironment(dProjectEnvironment l, dProjectEnvironment r) := transform
			self.environmentids := l.environmentids + row({r.environmentids[1].environmentid,r.environmentids[1].environmentvalue},rEnvironment);
			self := l;
		end;
		
		dRollupEnvironment := sort(rollup(dProjectEnvironment,packagename+partid+packageid,xRollupEnvironment(left,right)),partid,packageid,environmentid);
		
		
		// subfiles
		rPackageWithSubFiles xProjectSubFiles(dGetPackageSubFiles l) := transform
			self.pid := l.packageid;
			self.environmentids := [];
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
			self.environmentids := [];
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
		dCombine := sort(dRollupEnvironment + dRollupBase + dRollupSuperFiles,packagename,partid);
		
		rPackageWithSubFiles xProjectPackage(dCombine l) := transform
			self.pkgs := dataset([{l.pid,l.compulsory,l.enablefieldtranslation,l.daliip,l.environmentids,l.baseids,l.superfiles}],rPackageWithQueries);
			self := l;
		end;

		dProjectPackages := project(dCombine,xProjectPackage(left));
		
		rPartWithQueries xConvertToPackageLayout(dProjectPackages l) := transform
			self := l;
		end;
		
		dConvertToPackageLayout := project(dProjectPackages,xConvertToPackageLayout(left));
		
		rPartWithQueries xRollupParts(dConvertToPackageLayout l, dConvertToPackageLayout r) := transform
			self.pkgs := l.pkgs + dataset([{r.pkgs[1].pid
																	,r.pkgs[1].compulsory
																	,r.pkgs[1].enablefieldtranslation
																	,r.pkgs[1].daliip
																	,r.pkgs[1].environmentids
																	,r.pkgs[1].baseids
																	,r.pkgs[1].superfiles}],rPackageWithQueries);
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
																	,string pGetPartPackage = 'onepart.pkg'
																	,boolean pCombineParts = true) := function
	
		string lPackageMapName := if (pPackageMapName <> '',pPackageMapName, 'roxie');
	
		dDatasetAsXMLPackage := fDatasetAsXMLPackage(pGetPackageAsDataset);
		
		
		rPackageFile xGetPackageString(dDatasetAsXMLPackage l) := transform
			self.packagemaps := lPackageMapName;
			self.partid := if (~pCombineParts, l.partid, pGetPartPackage);
			// removing part for now, can add later if need be
			//self.PackageXMLAsString := '<Part id=\"'+trim(l.partid,left,right)+'\">'+fRemovePartFromXML(dDatasetAsXMLPackage,l.partid)+'</Part>';
			self.PackageXMLAsString := fRemovePartFromXML(dDatasetAsXMLPackage,l.partid);
			self := l;
		end;
		
		
		dGetPackageString := project(dDatasetAsXMLPackage,xGetPackageString(left));
		
		rPackageFile xRollupParts(dGetPackageString l, dGetPackageString r) := transform
			self.PackageXMLAsString := l.PackageXMLAsString + r.PackageXMLAsString;
			self := l;
		end;
		
		dRollupParts := rollup(dGetPackageString,partid,xRollupParts(left,right));
		
		
		rFinalPackageString := record, maxlength(30000000)
			string PackageXMLAsString;
		end;
		
		dPackage := if (~pCombineParts
												,if (pGetPartPackage <> ''
														,dGetPackageString(partid = pGetPartPackage)
														,dRollupParts)
												,dRollupParts
											
										);
		rFinalPackageString xFinalPackageString(dPackage l) := transform
			self.PackageXMLAsString := '<RoxiePackage>'+trim(l.PackageXMLAsString)+'</RoxiePackage>';
		end;
		
		dFinalPackageString := project(dPackage,xFinalPackageString(left));
		
		return dFinalPackageString[1].PackageXMLAsString;
	end;

	
end;
/////