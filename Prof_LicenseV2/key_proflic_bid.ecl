import  doxie;

df := project(Prof_LicenseV2.File_Proflic_Base_Keybuild, transform(Prof_LicenseV2.Layouts_ProfLic.Layout_Base, self.bdid := (string)left.bid, self := left))((integer)bdid != 0);

export key_proflic_bid := index(df,
                                {unsigned6 bd := (integer)df.bdid},
																{df},'~thor_data400::key::prolicv2::'+ doxie.Version_SuperKey +'::proflic_bid');
