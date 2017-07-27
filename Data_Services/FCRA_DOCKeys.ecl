export FCRA_DOCKeys := macro
	output(choosen(doxie_files.Key_BocaShell_Crim_FCRA,10));
	output(choosen(doxie_files.key_offenders_FCRA,10));
	output(choosen(doxie_files.Key_Offenses_FCRA,10));
	output(choosen(doxie_files.Key_Punishment_FCRA,10));
	output(choosen(doxie_files.Key_Offenses(true),10));
	output(choosen(doxie_files.Key_Offenders_OffenderKey(true),10));
	output(choosen(doxie_files.Key_Court_Offenses(true),10));
	output(choosen(doxie_files.Key_Activity(true),10));
	
endmacro;