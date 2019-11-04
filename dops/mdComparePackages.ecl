import DOPS;
EXPORT mdComparePackages(
													string pCompareESP // package environment to compare
													,string pComparePort = '8010' // port of the package environment to compare
													,string pCompareTarget // roxie target cluster of the package environment to compare
													,string pCompareProcess = '*'
													,string pUpdateESP // package environment to update with changes
													,string pUpdateProcess = '*'
													,string pUpdatePort = '8010' // port for update environment
													,string pUpdateTarget // roxie target for update environment
													,boolean bCaptureAllChanges = false
													,boolean bCaptureDataChanges = true
													,boolean bCaptureQueryChanges = false
													,set of string pDatasetsToUpdate = [] // used only when bCaptureDataChanges = true
												) := module
	export dComparePackage := sort(dops.GetRoxiePackage(pCompareESP,pComparePort,pCompareTarget,pCompareProcess).fXMLPackageAsDataset(),partid, packageid, baseid, superfile, subfile) : independent;
	export dUpdatePackage := sort(dops.GetRoxiePackage(pUpdateESP,pUpdatePort,pUpdateTarget,pUpdateProcess).fXMLPackageAsDataset(),partid, packageid, baseid, superfile, subfile) : independent;

	export rCaptureChanges := record
			recordof(dUpdatePackage);
			string sourcesuperfile;
			string sourcesubfile;
			string sourcepackageid;
			string sourcebaseid;
			boolean ischanged;
	end;
	
	export fCaptureChanges() := function
		rCaptureChanges xGetChanges(dUpdatePackage l, dComparePackage r) := transform
			self.ischanged := MAP(
															bCaptureAllChanges => 
															if (
																	(
																		(l.subfile <> r.subfile or l.superfile <> r.superfile) 
																			and l.superfile <> '' and r.superfile <> ''
																	) or 
																	(l.superfile = '' and r.superfile <> '') or
																	l.packageid <> r.packageid or
																	(l.packageid <> r.packageid and l.baseid <> r.baseid)
																,if (count(pDatasetsToUpdate) > 0 
																					,if (l.packageid in pDatasetsToUpdate
																									or r.packageid in pDatasetsToUpdate
																								,true
																								,false)
																					,true)
																,false)
															,bCaptureDataChanges =>
																if (
																		(
																			(l.subfile <> r.subfile or l.superfile <> r.superfile) 
																				and l.superfile <> '' and r.superfile <> ''
																		)
																		or (l.superfile = '' and r.superfile <> '') // new key
																		,if (count(pDatasetsToUpdate) > 0 
																					,if (l.packageid in pDatasetsToUpdate
																								or r.packageid in pDatasetsToUpdate
																								,true
																								,false)
																					,true)
																		,false)
															,bCaptureQueryChanges =>
																if (l.packageid <> r.packageid or
																	(l.packageid <> r.packageid and l.baseid <> r.baseid)
																,true
																,false)
															,false
																
														);
			self.sourcesuperfile := r.superfile;
			self.sourcesubfile := r.subfile;
			self.sourcepackageid := r.packageid;
			self.sourcebaseid := r.baseid;
			self := l;
			
		end;

		dGetChanges := join(dUpdatePackage, dComparePackage
											,/*left.partid = right.partid
												and */left.packageid = right.packageid
												and left.baseid = right.baseid
												and left.superfile = right.superfile
											
											,xGetChanges(left,right)
											,full outer
											);
		return dedup(sort(dGetChanges,partid, packageid, baseid, superfile, subfile),record);
	end;

	export fGetUpdatedPackageAsDataset(dataset(rCaptureChanges) pdChanges = dataset([],rCaptureChanges)) := function
	
		dChanges := if (count(pdChanges) > 0, pdChanges, fCaptureChanges());
	
		typeof(dUpdatePackage) xConvertToPackageLayout(dChanges l) := transform
			self.subfile := if ((bCaptureAllChanges or bCaptureDataChanges) 
																	and l.ischanged, l.sourcesubfile, l.subfile);
			self.superfile := if ((bCaptureAllChanges or bCaptureDataChanges)  
																	and l.ischanged, l.sourcesuperfile, l.superfile);
			self.packageid := if ((bCaptureAllChanges or bCaptureQueryChanges or bCaptureDataChanges)  
																	and l.ischanged, l.sourcepackageid, l.packageid);
			self.baseid := if ((bCaptureAllChanges or bCaptureQueryChanges) 
																	and l.ischanged, l.sourcebaseid, l.baseid);
			
			self := l;
			
		end;

		dConvertToPackageLayout := dedup(sort(project(dChanges,xConvertToPackageLayout(left)),partid, packageid, baseid, superfile, subfile),record);
		
		return dConvertToPackageLayout;
	end;
	
	export fGetUpdatedPackageAsXMLString() := function
		return dops.GetRoxiePackage('','','').fGetXMLPackageAsString(fGetUpdatedPackageAsDataset());
	end;

end;