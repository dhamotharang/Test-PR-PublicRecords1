import doxie;

df := file_proflicense_keybuilt;

export key_proflic_did_FCRA := index(df((unsigned)did != 0), 
								{UNSIGNED6 s_did := (UNSIGNED6) did}, {df},
								'~thor_data400::key::fcra::prolicense_did_' + doxie.Version_SuperKey);