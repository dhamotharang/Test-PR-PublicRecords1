import doxie, ut,BIPV2,fcra;

EXPORT Key_REO_Addr(BOOLEAN IsFCRA = FALSE) := FUNCTION

df_in := BKForeclosure.File_BK_Foreclosure.fReo;

cleaned := df_in(zip !='' and 
								prim_range !='' and 
								prim_name !='');
								
KeyName      := '~thor_data400::key::BKForeclosure_REO::';
KeyName_FCRA := '~thor_data400::key::BKForeclosure_REO::FCRA::';

key_name    := if(isFCRA, KeyName_fcra, KeyName) + 'Addr_' + doxie.Version_SuperKey;;

return_file := index(cleaned,
                            {zip, 
														 prim_range, 
														 prim_name, 
														 addr_suffix, 
														 predir},
														 {cleaned},
														 key_name);

RETURN(return_file);

END;																		