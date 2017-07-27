Import Data_Services, doxie_build,doxie,ut,crimsrch,Life_EIR,doxie_files;

export key_offenders_offenderkey_fcra := function

	df 								:= hygenics_search.Life_EIR_File_FCRA_Criminal.Offenders;
	output_file_name 	:= Data_Services.Data_location.Prefix('Provider')+'thor_data400::key::corrections::fcra::offenders_offenderkey_';

return index(df,{string60 ofk := df.offender_key},{df},
             output_file_name  + doxie_build.buildstate + '_' + doxie.Version_SuperKey);
end;