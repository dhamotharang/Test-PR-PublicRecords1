export Datasets := MODULE
	
//	export dsMXStates := 
//		 DATASET(Filenames.F_MXStates,mxd_Common.Layouts.L_MXState,THOR);//,CSV(HEADING(1),SEPARATOR('|'),QUOTE('"')));
	//export dsMXCities := 
	//	 DATASET(Filenames.F_MXCities,mxd_Common.Layouts.L_MXCity,THOR);//,CSV(HEADING(1),SEPARATOR('|'),QUOTE('"')));
		 
	export dsMXRawCities := 
		 DATASET(Filenames.F_Raw_MXCities,mxd_Common.Layouts.L_MXRawCity,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"')));
	
	export dsMXRawStates := 
		 DATASET(Filenames.F_Raw_MXStates,mxd_Common.Layouts.L_MXState,CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"')));
	
//	export idxMXCities := INDEX(dsMXCities,{state_name,city_name,standard_name,country_name,fpos},mxd_Common.Filenames.F_MXCitiesIDX);

export DS_MXSynonymM :=
	IF(FileServices.FileExists(Filenames.File_IDX_MXSynonymM),
		 Mod_Indexes.MXSynonymMIdx,
		 DATASET([], Layouts.L_MXSynonymMFPos));
		 
export dsNewLog :=DATASET([],Layouts.L_Logging);		
		 
export dsMXStates :=
	IF(FileServices.FileExists(Filenames.F_MXStatesIDX),
		 Mod_Indexes.MXStateIdx,
		 DATASET([], Layouts.L_MXState));

export dsMXCities :=
	IF(FileServices.FileExists(Filenames.F_MXCitiesIDX),
		 Mod_Indexes.MXCityIdx,
		 DATASET([], Layouts.L_MXCity));

export dsMXWordsRaw := DATASET(Filenames.F_MXWordsRaw,Layouts.L_MxWords, THOR);
export dsMXWords := DATASET(Filenames.F_MXWords,Layouts.L_MxWordsFpos, THOR);


END;