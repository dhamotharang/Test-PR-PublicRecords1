import Data_Services, doxie_build,doxie,ut,crimsrch,Life_EIR,doxie_files;

df 				 := Life_EIR.File_FCRA_Criminal.Offenders;

output_file_name := Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections::fcra::offenders_offenderkey_';
             
export Key_Offenders_OffenderKey_FCRA := index(df,{string60 ofk := df.offender_key},{df},
             output_file_name  + doxie_build.buildstate + '_' + doxie.Version_SuperKey);