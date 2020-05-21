EXPORT PackageResponseLayouts := module

	// COMMON RECORD SETS ///
	export rStatus := record
		string Code{xpath('Code')};
		string Description{xpath('Code')};
		
	end;
	
	export rExceptions := record
		string Code{xpath('Code')};
		string Message{xpath('Message')};
		string Source{xpath('Source')};
	end;
	
	
	export rFilesNotFound := record
		string File{xpath('')};
	end;
	
	////////////////////////
	
	// BEGIN GetQueryFileMapping //
	
	export rNames := record
		string Name{xpath('')};
	end;
	
	export rSubFiles := record
		dataset(rNames) files{xpath('File')};
	end;
	
	export rSupers := record
		string Name{xpath('Name')};
		dataset(rSubFiles) subfiles{xpath('SubFiles')};
	end;
	

	export rWUQueryDetailsResponse  := record
		string QueryId {xpath('QueryId')};
		string QuerySet {xpath('QuerySet')};
		string QueryName {xpath('QueryName')};
		string Wuid {xpath('Wuid')};
		string Dll {xpath('Dll')};
		boolean Suspended {xpath('Suspended')};
		boolean Activated {xpath('Activated')};
		string SuspendedBy {xpath('SuspendedBy')};
		string PublishedBy {xpath('PublishedBy')};
		dataset(rSupers) superfiles{xpath('SuperFiles/SuperFile')};
	end;
	
	// END GetQueryFileMapping //
	
	// BEGIN ListPackages //
	export rPackageMapList := record
		string Id{xpath('Id')};
		string Target{xpath('Target')};
		string Active{xpath('Active')};
	end;
				
	export rListPackagesResponse := record
		dataset(rPackageMapList) PackageMapList{xpath('PackageMapList/PackageListMapData')};
		dataset(rStatus) status{xpath('status')};
	end;
	
	// END ListPackages //
	
	// BEGIN AddPackage //
	
	export rAddPackageResponse := record
		dataset(rFilesNotFound) FilesNotFound{xpath('FilesNotFound/File')};
		dataset(rStatus) status{xpath('status')};
		dataset(rExceptions) exceptions{xpath('Exceptions/Exception')};
		
	end;
	
	// END AddPackage //
	
	// BEGIN Get Queries //
	
	export rQuerysetQueries := record
		string Name {xpath('Name')};
		string Dll {xpath('Dll')};
		boolean Suspended {xpath('Suspended')};
		string IsLibrary {xpath('IsLibrary')};
	end;
	
	export rWUQuerySetDetailsResponse := record
		string QuerySetName {xpath('QuerySetName')};
		dataset(rQuerysetQueries) QuerysetQueries {xpath('QuerysetQueries/QuerySetQuery')};
		dataset(rStatus) status{xpath('status')};
	end;

	// END Get Queries //
	
	// BEGIN Key Query Association //
	
	export rGetQueryKeyAssociation := record
		string queryname := '';
		string queryid := '';
		string queryset := '';
		string superfile := '';
		string subfile := '';
		boolean suspended := false;
	end;
	
	// END Key Query Association //
	
	// BEGIN ValidatePackage //
	
	export rWarnings := record
		string Item{xpath('')};
	end;
	
	export rPackages := record
		dataset(rWarnings) Unmatched{xpath('')};
	end;
	
	export rQueries := record
		dataset(rWarnings) Unmatched{xpath('')};
	end;
	
	export rFiles := record
		dataset(rWarnings) Unmatched{xpath('')};
		dataset(rFilesNotFound) NotInDFS{xpath('NotInDFS')};
	end;
	
	export rValidatePackageResponse := record
		string PMID {xpath('PMID')};
		dataset(rWarnings) warnings{xpath('Warnings/Item')};
		dataset(rWarnings) errors{xpath('Errors/Item')};
		dataset(rWarnings) packages{xpath('packages/Unmatched/Item')};
		dataset(rWarnings) queries{xpath('queries/Unmatched/Item')};
		dataset(rWarnings) filesunmatched{xpath('files/Unmatched/Item')};
		dataset(rFilesNotFound) filesnotindfs{xpath('files/NotInDFS/File')};
		dataset(rStatus) status{xpath('status')};
		dataset(rExceptions) exceptions{xpath('Exceptions/Exception')};
		
	end;
	
	// END ValidatePackage //
	
	// BEGIN ActivePackage //
	export rActivatePackageResponse := record
		dataset(rStatus) status{xpath('status')};
		dataset(rExceptions) exceptions{xpath('Exceptions/Exception')};
		
	end;
	// END ActivePackage //
	
	// BEGIN deActivePackage //
	export rDeActivatePackageResponse := record
		dataset(rStatus) status{xpath('status')};
		dataset(rExceptions) exceptions{xpath('Exceptions/Exception')};
		
	end;
	// END deActivePackage //
	
	// BEGIN DeletePackage //
	export rDeletePackageResponse := record
		dataset(rStatus) status{xpath('status')};
		dataset(rExceptions) exceptions{xpath('Exceptions/Exception')};
		
	end;
	// END deActivePackage //
end;