import doxie,Data_Services;

base := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  Prof_LicenseV2.Layouts_ProfLic.Layout_Base);
//Prof_LicenseV2.File_Proflic_Base_Keybuild;

export Key_ProfLic_Id := index(base,
						       {Prolic_seq_id},
						       {base},
						       Data_Services.Data_location.Prefix()+'thor_data400::key::prolicV2::'+doxie.Version_SuperKey+'::Prolic_Id');