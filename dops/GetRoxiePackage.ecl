EXPORT GetRoxiePackage(string roxieesp, string roxieport, string roxietarget) := module

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
	// 6.x platforms have part id in the package file
	export	rPart := RECORD
			string partid {XPATH('@id')};
			dataset(rPackage) pkgs {xpath('Package')};
	END;
	//////////////////////
	export	rPackageMap := RECORD
			string pkgmaps {XPATH('@id')};
			dataset(rPart) parts {xpath('Part')};
	END;

	export rPackageKeyInfo := record
			string packagename := '';
			string packageid := '';
			string superfile := '';
			string subfile := '';
	end;

	export PackageFromXML() := function
		InputRec := record
			string datasetname{xpath('Target')} := roxietarget;
			string location{xpath('Process')} := '*';
		end;
	
		outrec := record,maxlength(5000000)
			string Info {xpath('Info')};
		end;
	
		soapresults := SOAPCALL(
				'http://'+roxieesp+':'+roxieport+'/WsPackageProcess',
				'GetPackage',
				InputRec
				,dataset(outrec),
				xpath('GetPackageResponse'));
	
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

end;