Import Data_Services, doxie_build, doxie, Life_EIR, ut;

export Key_Activity_fcra := function

df 					:= hygenics_search.Life_EIR_File_FCRA_Criminal.Activity;
output_file_name 	:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections::fcra::activity_';
						 
return  index(df,{ok := df.offender_key},{df},output_file_name + doxie_build.buildstate + '_' + doxie.Version_SuperKey);

end;