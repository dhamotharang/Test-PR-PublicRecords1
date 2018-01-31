import doxie,Data_Services;

d := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  Prof_LicenseV2.Layouts_ProfLic.Layout_Base)(prim_name <> '' and zip <> '');
//Prof_LicenseV2.File_Proflic_Base_Keybuild(prim_name <> '' and zip <> '');

export Key_Addr_Proflic := index(d,
								 {prim_name,prim_range,zip,sec_range},
                                 {d},
                                 Data_Services.Data_location.Prefix()+'thor_data400::key::prolicv2::'+ doxie.Version_SuperKey +'::cbrs.addr_proflic');
