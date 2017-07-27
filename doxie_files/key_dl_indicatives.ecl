import doxie_build;

only_with := doxie_build.file_dl_keybuilding(race IN ['W','H','A','I','B'],
									sex_flag IN ['M','F'],(INTEGER)age<>0);

rec :=
RECORD
	STRING1 race;
	STRING1 sex_flag;
	UNSIGNED1 age;
	STRING2 orig_state;
	only_with.dl_number;
END;

rec proj(only_with le) :=
TRANSFORM
	SELF.age := (INTEGER)le.age;
	SELF := le;
END;

P := project(only_with, proj(LEFT));

dl4key := dedup(SORT(p, race, sex_flag, age, orig_state, dl_number), race, sex_flag, age, orig_state, dl_number);

export key_dl_indicatives := index(dl4key, {race, sex_flag, age, orig_state}, 
								   {dl_number}, 
								   '~thor_data400::key::dl_indicatives'+doxie_build.buildstate + '_QA');