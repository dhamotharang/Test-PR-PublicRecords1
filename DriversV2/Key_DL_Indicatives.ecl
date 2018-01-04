import doxie_build, doxie, data_services;

only_with := DriversV2.file_dl_keybuilding(race IN ['W','H','A','I','B'],
									sex_flag IN ['M','F'],(INTEGER)age<>0);

rec :=
RECORD
	STRING1 race;
	STRING1 sex_flag;
	UNSIGNED1 age;
	STRING2 orig_state;
	only_with.dl_number;
	unsigned randomizer := 0;
END;

rec proj(only_with le) :=
TRANSFORM
	SELF.age := (INTEGER)le.age;
	SELF := le;
END;

P := project(only_with, proj(LEFT));

dl4key := dedup(SORT(p, race, sex_flag, age, orig_state, dl_number), race, sex_flag, age, orig_state, dl_number);

rec iter(rec le, rec ri) :=
TRANSFORM
	SELF.randomizer := IF(le.randomizer=0 OR le.randomizer=10000, 1, le.randomizer+1);
	SELF := ri;
END;
enum := ITERATE(dl4key,iter(LEFT,RIGHT));

export Key_DL_Indicatives := index(enum, {race, sex_flag, age, orig_state, randomizer}, 
								   {dl_number}, 
								   data_services.data_location.prefix() + 'thor_data400::key::dl2::'+ doxie.Version_SuperKey +'::dl_indicatives_'+doxie_build.buildstate);
								   //data_services.data_location.prefix() + 'thor_data400::key::dl2::dl_indicatives_'+doxie_build.buildstate + '_qa');