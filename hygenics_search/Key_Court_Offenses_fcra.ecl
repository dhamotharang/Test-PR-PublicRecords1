Import Data_Services, doxie_build,doxie,Life_EIR,ut;

export Key_Court_Offenses_fcra := function

df 					:= hygenics_search.Life_EIR_File_FCRA_Criminal.court_offenses;
output_file_name 	:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections::fcra::court_offenses_';
						 
return  index(df,{ofk := df.offender_key},{df},output_file_name + doxie_build.buildstate + '_' + doxie.Version_SuperKey);

end;