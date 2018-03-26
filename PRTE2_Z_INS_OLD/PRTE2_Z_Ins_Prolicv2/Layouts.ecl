IMPORT Prof_LicenseV2, PRTE_CSV;

/* zz_JStewart.File_BaseFiles (updated)

//Professional Licenses
//Prof_LicenseV2.File_ProfLic_Base;
export proflic := dataset(ut.foreign_prod+'thor_data400::base::Prolicv2::proflic_base::built', Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers, thor);

*/

EXPORT Layouts := MODULE

	EXPORT AlphaBaseOUT := RECORD
	     Prof_LicenseV2.Layouts_ProfLic.Layout_Base_With_Tiers     // zz_JStewart.File_BaseFiles.File_BaseFiles
	END;

END;		                    