import civil_court,demo_data_scrambler;

#workunit('name','civil court keybuilds and superfile tx')

// set civil_court.version_development

// not used wuid := 'x';
// not used filedate:= wuid;

s2:= output(demo_data_scrambler.scramble_civil_matters,,'~thor::base::demo_data_file_civil_matters'+civil_court.version_development+'_scrambled',overwrite);
s3:= output(demo_data_scrambler.scramble_civil_matters,,'~thor_200::base::civil_matter_'+ civil_court.Version_Development,overwrite);

s5:= output(demo_data_scrambler.scramble_civil_party,,'~thor::base::demo_data_file_civil_party'+civil_court.version_development+'_scrambled',overwrite);
s6:= output(demo_data_scrambler.scramble_civil_party,,'~thor_200::base::civil_party_' + civil_court.Version_Development,overwrite);

null_case_activity := dataset([],civil_court.layout_moxie_case_activity);
s8:= output(null_case_activity,,'~thor_200::base::civil_case_activity_' + Civil_Court.Version_Development,overwrite);

s9:= civil_court.proc_build_key(civil_court.Version_Development);

sequential(s2,s3,s5,s6,s8,s9);

