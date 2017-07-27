import ut, doxie;

teaser := Header.file_teaser_cnsmr;

export Key_Teaser_cnsmr_did := index(teaser, {did},{teaser},
															 ut.Data_Location.Person_header + 'thor_data400::key::header.teaser_did_' + doxie.Version_SuperKey);