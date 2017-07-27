import doxie;

d := File_pullPhone;

export key_pullPhone := INDEX(d,{unsigned6 did := (unsigned6)d.did}, {STRING10 phone10 := (STRING10)d.phone10},
						'~thor_data400::key::blackphonelist_'+doxie.Version_SuperKey,OPT);