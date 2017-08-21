IMPORT inquiry_acclogs;

/////////////////////////// THIS IS A BWR

#workunit('name','Inquiry FCRA PRTE Copy')

version := '20130919';

// thor_data400::key::inquiry::fcra::20130915::ssn
// thor_data400::key::inquiry::fcra::20130915::did
// thor_data400::key::inquiry::fcra::20130915::phone
// thor_data400::key::inquiry::fcra::20130915::billgroups_did
// thor_data400::key::inquiry::fcra::20130915::address
	
df := dataset([], Inquiry_AccLogs.layout.Common_indexes_FCRA);
															
buildindex(df, {unsigned6 s_did := person_q.appended_ADL}, {df},
																'~prte::key::inquiry::fcra::'+version+'::did',overwrite);
																
buildindex(df, {string5 zip := person_q.zip,person_q.prim_name,person_q.prim_range,person_q.sec_range}, {df},
																'~prte::key::inquiry::fcra::'+version+'::address',overwrite);
																
buildindex(df, {string10 phone10 := person_q.personal_phone}, {df},
																'~prte::key::inquiry::fcra::'+version+'::phone',overwrite);
																
buildindex(df, {string9 ssn := person_q.SSN}, {df},
																'~prte::key::inquiry::fcra::'+version+'::ssn',overwrite);

df2 := DATASET([], RECORDOF(Inquiry_AccLogs.File_FCRA_Inquiry_Billgroups_DID().File));

buildindex(df2, {did}, {df2}, '~prte::key::inquiry::fcra::' +version+ '::billgroups_did');
											

