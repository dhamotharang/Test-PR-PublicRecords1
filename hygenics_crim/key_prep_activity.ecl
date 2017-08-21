import doxie, doxie_build, ut, RoxieKeyBuild, hygenics_search;

export Key_Prep_Activity (boolean IsFCRA = false) := function

df2 := file_Activity_KeyBuilding(Vendor not in hygenics_search.sCourt_Vendors_To_Omit);
df 	:= file_Activity_KeyBuilding;

string file_name := if(IsFCRA, 
					 '~thor_data400::key::corrections::fcra::activity_'+doxie_build.buildstate+'_'+doxie.Version_SuperKey,
					 '~thor_Data400::key::corrections_activity_'+doxie_build.buildstate + thorlib.wuid());

return if (IsFCRA,
           index(df2,{ok := df2.offender_key},{df2}, file_name, OPT),
           index(df,{ok := df.offender_key},{df}, file_name));

end;