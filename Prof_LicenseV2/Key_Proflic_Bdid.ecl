import  doxie;

df := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  Prof_LicenseV2.Layouts_ProfLic.Layout_Base)((integer)bdid != 0);
//Prof_LicenseV2.File_Proflic_Base_Keybuild((integer)bdid != 0);

export Key_Proflic_Bdid := index(df,
                                 {unsigned6 bd := (integer)df.bdid},
								 {df},
								 '~thor_data400::key::prolicv2::'+ doxie.Version_SuperKey +'::proflic_bdid');
