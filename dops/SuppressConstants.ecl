import data_services,dops;
EXPORT SuppressConstants (string datasetname, boolean useLocal) := module

	// datasetname - name that matches the validdatasets
	// useProdFile - whether to use the prod file 
	export ValidDatasets := ['liens','gong','ucc','bankruptcy','foreclosure','unsuppress','fbn'];
	
	export isValidDataset := if (datasetname in ValidDatasets
																		,true
																		,false);
	
	export thresholddate := '20180831000000';
	export ProdOrDev := if (~useLocal 
													,if (dops.constants.ThorEnvironment = 'prod'
																,'~'
																,Data_Services.foreign_prod)
													,'~'
													);
		
	export Files(boolean useConditionalPrefix = false) := module
		export Prefix := if (useConditionalPrefix,ProdOrDev,'~') + 'thor::base::suppress';
		export Suffix := datasetname;
		export Super := Prefix+'::qa::'+Suffix;
		export Logical(string filedate) := Prefix+'::'+filedate+'::'+Suffix;
	end;
	
	export SuperName := Files(true).Super;
	
end;