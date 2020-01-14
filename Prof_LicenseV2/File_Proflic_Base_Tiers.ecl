Layout_base_Prolicv2 := Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers;

export File_ProfLic_Base_Tiers := dataset(Prof_LicenseV2.Constants.cluster + 'base::Prolicv2::proflic_base::built', Layout_base_Prolicv2, thor)
 (prolic_key <> '');