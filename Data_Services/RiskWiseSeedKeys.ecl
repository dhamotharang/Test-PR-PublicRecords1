export RiskWiseSeedKeys := macro
	output(choosen(seed_files.Key_RVAuto,10));
	output(choosen(seed_files.Key_RVBankcard,10));
	output(choosen(seed_files.Key_RVRetail,10));
	output(choosen(seed_files.Key_RVTelecom,10));
endmacro;