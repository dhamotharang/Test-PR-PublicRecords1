import doxie, data_services, Prof_LicenseV2;

pre_base := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  Prof_LicenseV2.Layouts_ProfLic.Layout_Base);
base := Prep_Build.prepBase_Id(pre_base);

export Key_ProfLic_Id := index(base,
						       {Prolic_seq_id},
						       {base},
									 data_services.data_location.prefix() + 'thor_data400::key::prolicV2::'+doxie.Version_SuperKey+'::Prolic_Id');