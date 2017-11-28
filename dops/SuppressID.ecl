import RoxieKeyBuild,Data_Services;
EXPORT SuppressID(string datasetname,
									boolean useLocal = false) := module

	// datasetname - name that matches the validdatasets
	// useProdFile - whether to use the prod file 
	export ValidDatasets := ['liens','gong','ucc','bankruptcy','foreclosure','unsuppress','fbn'];
	
	export isValidDataset := if (datasetname in ValidDatasets
																		,true
																		,false);
	
	shared thresholddate := '20171201000000';
	shared ProdOrDev := if (~useLocal 
													,if (dops.constants.ThorEnvironment = 'prod'
																,'~'
																,Data_Services.foreign_prod)
													,'~'
													);
	
	export rSuppressLayout := record
		string idvalue;
		string filedate;
		string whenupdated;
		string flag;
	end;
	
	export Files(boolean useConditionalPrefix = false) := module
		export Prefix := if (useConditionalPrefix,ProdOrDev,'~') + 'thor::base::suppress';
		export Suffix := datasetname;
		export Super := Prefix+'::qa::'+Suffix;
		export Logical(string filedate) := Prefix+'::'+filedate+'::'+Suffix;
	end;
	
	export GetRecords() := dataset(Files(true).Super,rSuppressLayout,thor,opt);
	
	export GetIDsAsSet(boolean isFCRA = false, boolean isUnsuppress = false) 
																					:= if( ~isUnsuppress 
																								,set(if (isFCRA
																												,GetRecords()(flag = 'A' and whenupdated < thresholddate)
																												,GetRecords()(flag = 'A')
																											)
																									,idvalue)
																								,set(GetRecords()(flag = 'D'), idvalue)
																								);
	
		
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
																	,idvalue,-filedate)
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
		
		dSuppressedRecords := GetRecords()(idvalue not in idvalues);

		didvalues := dataset(idvalues,{string idvalue});
		
		rSuppressLayout xFlagAsDeletes(didvalues l) := transform
			self.flag := 'D';
			self.whenupdated := regexreplace('-', WORKUNIT,'')[2..];
			self.filedate := filedate;
			self := l;
		end;
		
		dFlagAsDeletes := project(didvalues,xFlagAsDeletes(left));
		
		
		RoxieKeyBuild.MAC_SF_BuildProcess_V2(dFlagAsDeletes + dSuppressedRecords
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