import RoxieKeyBuild;
EXPORT ID(string datasetname) := module

	export ValidDatasets := ['liens','gong','ucc','bankruptcy'];
	
	export isValidDataset := if (datasetname in ValidDatasets
																		,true
																		,false);
	
	shared thresholddate := '20171201000000';
	
	export rSuppressLayout := record
		string idvalue;
		string filedate;
		string whenupdated;
		string flag;
	end;
	
	export Files() := module
		export Prefix := '~thor::base::suppress';
		export Suffix := datasetname;
		export Super := Prefix+'::qa::'+Suffix;
		export Logical(string filedate) := Prefix+'::'+filedate+'::'+Suffix;
	end;
	
	export GetRecords() := dataset(Files().Super,rSuppressLayout,thor,opt);
	
	export GetIDsAsSet(boolean isFCRA = false) := set(if (isFCRA
																										,GetRecords()(flag = 'A' and whenupdated < thresholddate)
																										,GetRecords()(flag = 'A')
																									)
																						,idvalue);
		
	export Add(set of string idvalues
							,string filedate) := function
		
		dSuppressedRecords := GetRecords();
		dInputIDs := dataset(idvalues,{string idvals});
		
		rSuppressLayout xConvertToSuppressLayout(dInputIDs l) := transform
			self.idvalue := l.idvals;
			self.filedate := filedate;
			self.whenupdated := regexreplace('-', WORKUNIT,'')[2..];
			self.flag := 'A';
		end;
		
		dConvertToSuppressLayout := project(dInputIDs,xConvertToSuppressLayout(left));
		
		dAddSuppressIDs := dedup(sort(dSuppressedRecords + dConvertToSuppressLayout
																	,idvalue,filedate)
															,idvalue);
		
		
		RoxieKeyBuild.MAC_SF_BuildProcess_V2(dAddSuppressIDs
																					,Files().Prefix
																					,Files().Suffix
																					,filedate
																					,mCreateFile
																					,,,true);
		
		return if(isValidDataset
									,mCreateFile
									,fail(datasetname + ' not found in Suppress.ID.ValidDatasets')
								);
		
	end;
	
	
	export Delete(set of string idvalues
							,string filedate) := function
		
		dSuppressedRecords := GetRecords();
		
		rSuppressLayout xFlagAsDeletes(dSuppressedRecords l) := transform
			self.flag := if (l.idvalue in idvalues,'D',l.flag);
			self.whenupdated := regexreplace('-', WORKUNIT,'')[2..];
			self := l;
		end;
		
		dFlagAsDeletes := project(dSuppressedRecords,xFlagAsDeletes(left));
		
		
		RoxieKeyBuild.MAC_SF_BuildProcess_V2(dFlagAsDeletes
																					,Files().Prefix
																					,Files().Suffix
																					,filedate
																					,mCreateFile
																					,,,true);
		
		return if(isValidDataset
									,mCreateFile
									,fail(datasetname + ' not found in Suppress.ID.ValidDatasets')
								);
		
	end;
end;