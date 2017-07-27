export RiskviewseedKeys := macro
	output(choosen(seed_files.Key_RVAuto,10));
	output(choosen(seed_files.Key_RVBankcard,10));
	output(choosen(seed_files.Key_RVRetail,10));
	output(choosen(seed_files.Key_RVTelecom,10));
	output(choosen(seed_files.Key_RVAttributes,10));
	output(choosen(seed_files.Key_RiskView,10));
	output(choosen(seed_files.Key_RVderogs,10));
	output(choosen(seed_files.Key_FCRA_GongHistory,10));
	output(choosen(seed_files.key_NCFInsurance,10));
	output(choosen(seed_files.key_MVRInsurance,10));
	output(choosen(Seed_Files.Key_Boca_Shell(true),10));
endmacro;