Import Data_Services, doxie_build,doxie, ut, hygenics_search, vault, _control;

#IF(_Control.Environment.onVault) 
export Key_Offenders (boolean IsFCRA = false) := vault.doxie_files.Key_Offenders(IsFCRA);
#ELSE
export Key_Offenders (boolean IsFCRA = false) := function

df2 	:= File_Fcra_Offenders(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 		:= File_Offenders;

string file_name := if(IsFCRA, 
					 Data_Services.Data_location.Prefix('Criminal')+'thor_200::key::criminal_offenders::fcra::'+doxie.Version_SuperKey+'::did',
					 Data_Services.Data_location.Prefix('Criminal')+'thor_data400::key::corrections_offenders_'+doxie_build.buildstate+ '_' + doxie.Version_SuperKey);

return if (IsFCRA,
           index(df2((integer)did != 0),{unsigned6 sdid := (integer)df2.did},{df2}, file_name, OPT),
           index(df((integer)did != 0),{unsigned6 sdid := (integer)df.did},{df}, file_name, OPT));

end;

#END;



