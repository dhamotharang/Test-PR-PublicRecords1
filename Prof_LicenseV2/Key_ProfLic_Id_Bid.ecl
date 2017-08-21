import doxie;

base := project(Prof_LicenseV2.File_Proflic_Base_Keybuild,  transform(Prof_LicenseV2.Layouts_ProfLic.Layout_Base, self.bdid := (string)left.bid, self := left));

export Key_ProfLic_Id_Bid := index(base,
																	 {Prolic_seq_id},
																	 {base},
																	 '~thor_data400::key::prolicV2::'+doxie.Version_SuperKey+'::Bid::Prolic_Id');