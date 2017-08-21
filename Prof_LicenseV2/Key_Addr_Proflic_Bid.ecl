import prof_license, doxie;

d := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  transform(Prof_LicenseV2.Layouts_ProfLic.Layout_Base, self.bdid := (string)left.bid, self := left))(prim_name <> '' and zip <> '');

export Key_Addr_Proflic_Bid := index(d,
																		 {prim_name,prim_range,zip,sec_range},
																		 {d},
																		 '~thor_data400::key::prolicv2::'+ doxie.Version_SuperKey +'::bid::cbrs.addr_proflic');
