export Datasets := MODULE

export dsMXNameStats :=DATASET(Filenames.F_MXNameStats,Layouts.L_MXNameStats,THOR);
export dsMXNameStatsFpos :=DATASET(Filenames.F_MXNameStats,Layouts.L_MXNameStatsFpos,THOR);

export dsMXRawRefNames := DATASET(Filenames.F_Raw_RefNames,{UNICODE name,STRING namePart},CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"')));

// export dsMXGenderFlagger := DATASET(Filenames.F_GenderFlagger,{UNICODE name,STRING1 gender},THOR);
export dsMXGenderFlagger := DATASET(Filenames.F_GenderFlagger,{UNICODE name,STRING1 gender},CSV(HEADING(1),SEPARATOR('|'),QUOTE('"')));

export dsMXRefNames := DATASET(Filenames.F_RefNames,Layouts.L_MXPersonNamePart,THOR);
		

END;