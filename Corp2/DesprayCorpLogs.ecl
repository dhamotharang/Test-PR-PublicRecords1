import versioncontrol,_Control;

export DesprayCorpLogs(

	 string 	pDateVersion
	,string 	pFileVersion		= 'sprayed'
	,boolean	pOverwrite			= false
	,boolean	pIsTesting			= VersionControl._Flags.IsDataland
	,boolean	pDisableDespray = VersionControl._Flags.IsDataland

) :=
function

	layout_despray :=
	record
		string100 name;
		string1		lf		:= '\n';
	end;
	
	fConvert4Despray(
		dataset(VersionControl.Layout_Names) pDataset
		
	) :=
	function
		return project(pDataset, transform(layout_despray, self := left));
	end;

	main	 	:= nothor(fileservices.superfilecontents(corp2.Filenames().input.main.new		(pFileVersion)));
	events	:= nothor(fileservices.superfilecontents(corp2.Filenames().input.events.new	(pFileVersion)));
	stock		:= nothor(fileservices.superfilecontents(corp2.Filenames().input.stock.new	(pFileVersion)));
	ar			:= nothor(fileservices.superfilecontents(corp2.Filenames().input.ar.new			(pFileVersion)));

	VersionControl.macBuildNewLogicalFile('~thor_data400::dump::corp2::used::main'	 	+ pDateVersion,fConvert4Despray(main		),mainout		,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::dump::corp2::used::events' 	+ pDateVersion,fConvert4Despray(events	),eventsout	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::dump::corp2::used::stock' 	+ pDateVersion,fConvert4Despray(stock		),stockout	,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile('~thor_data400::dump::corp2::used::ar'		 	+ pDateVersion,fConvert4Despray(ar			),arout			,,,pOverwrite);
	string landing_zone := _Control.IPAddress.bctlpedata10;

	myfilestodespray := dataset([
		
		 {	 '~thor_data400::dump::corp2::used::main'	 	 + pDateVersion	,landing_zone,'/data/data_build_4/corporate_filings/logs/spray_logs/sprayed_main_' 		+ pDateVersion + '.log' }
		,{	 '~thor_data400::dump::corp2::used::events'	 + pDateVersion	,landing_zone,'/data/data_build_4/corporate_filings/logs/spray_logs/sprayed_events_' 	+ pDateVersion + '.log' }
		,{	 '~thor_data400::dump::corp2::used::stock'	 + pDateVersion	,landing_zone,'/data/data_build_4/corporate_filings/logs/spray_logs/sprayed_stock_' 	+ pDateVersion + '.log' }
		,{	 '~thor_data400::dump::corp2::used::ar'			 + pDateVersion	,landing_zone,'/data/data_build_4/corporate_filings/logs/spray_logs/sprayed_ar_' 			+ pDateVersion + '.log' }
                                                                                                                           
	], versioncontrol.Layout_DKCs.Input);

	return 
		sequential(
			parallel(
				 mainout		
				,eventsout	
				,stockout	
				,arout			
			)
			,if(pDisableDespray = false,versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayCorp2SprayedInfo',pOverwrite,pIsTesting))
		);

end;