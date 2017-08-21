export Mod_Indexes := MODULE

	// Index of synonyms.
	export IDX_MXSynonym(STRING filename, BOOLEAN writeIndex = FALSE,
			DATASET(Layouts.L_MXSynonymFPos) ds = DATASET([],Layouts.L_MXSynonymFPos)) := 
				INDEX(IF(writeIndex,ds, DATASET(filename, Layouts.L_MXSynonymFPos, THOR)	),
								{term1},
								{term2, fpos},
								filename);
	EXPORT MXSynonymIdx := IDX_MXSynonym(Filenames.File_IDX_MXSynonym);

	// Index of synonym metaphone values.
	export IDX_MXSynonymM(STRING filename, BOOLEAN writeIndex = FALSE,
			DATASET(Layouts.L_MXSynonymMFPos) ds = DATASET([],Layouts.L_MXSynonymMFPos)) :=
				INDEX(IF(writeIndex,ds,DATASET(filename, Layouts.L_MXSynonymMFPos, THOR)),
							{term1M1, term1M2}, {term2M1, term2M2, term1, term2, fpos},
							filename, DISTRIBUTED);
	EXPORT MXSynonymMIdx := IDX_MXSynonymM(Filenames.File_IDX_MXSynonymM);

	// Index of city values.
	export IDX_Cities(STRING filename, BOOLEAN writeIndex = FALSE,
			DATASET(Layouts.L_MXCity) ds = DATASET([],Layouts.L_MXCity)) :=
				INDEX(IF(writeIndex,ds,DATASET(filename, Layouts.L_MXCity, THOR)),
							{city_name,state_name,standard_name,country_name,fpos},
							filename, DISTRIBUTED);
	EXPORT MXCityIdx := IDX_Cities(Filenames.F_MXCitiesIDX);

	// Index of city values.
	export IDX_States(STRING filename, BOOLEAN writeIndex = FALSE,
			DATASET(Layouts.L_MXState) ds = DATASET([],Layouts.L_MXState)) :=
				INDEX(IF(writeIndex,ds,DATASET(filename, Layouts.L_MXState, THOR)),
						{state_name,standard_state_name,country_name,fpos},
							filename, DISTRIBUTED);
	EXPORT MXStateIdx := IDX_States(Filenames.F_MXStatesIDX);

	// export IDX_Person(STRING filename, DATASET(Layouts.L_MXPersonFpos) ds) :=
				// INDEX(ds,
						// {rec_id,fpos},{firstname,middlename1,middlename2,middlename3,middlename4,middlename5,lastname,matronymic,husbandslastname,patronymic,gender,not_parsed,unparsed_name},
							// filename, DISTRIBUTED);
	

END;