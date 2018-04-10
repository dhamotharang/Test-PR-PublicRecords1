EXPORT PackageResponseLayouts := module
	export rStatus := record
		string Code{xpath('Code')};
		string Description{xpath('Code')};
		
	end;
	
	export rExceptions := record
		string Code{xpath('Code')};
		string Message{xpath('Message')};
		string Source{xpath('Source')};
	end;
	
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
	
	export rGetQueryFileMappingResponse  := record
		dataset(rSupers) superfiles{xpath('SuperFile')};
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
	
	export rFilesNotFound := record
		string File{xpath('')};
	end;
	
	export rAddPackageResponse := record
		dataset(rFilesNotFound) FilesNotFound{xpath('FilesNotFound/File')};
		dataset(rStatus) status{xpath('status')};
		dataset(rExceptions) exceptions{xpath('Exceptions/Exception')};
		
	end;
end;