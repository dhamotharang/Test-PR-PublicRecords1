Import Data_Services, doxie_build,doxie,Life_EIR,ut, hygenics_crim;

df 								:= Life_EIR.File_FCRA_Criminal.court_offenses;
output_file_name 	:= Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections::fcra::court_offenses_';
						 
export Key_Court_Offenses_FCRA := index(df,{ofk := df.offender_key},{df},output_file_name + doxie_build.buildstate + '_' + doxie.Version_SuperKey);

