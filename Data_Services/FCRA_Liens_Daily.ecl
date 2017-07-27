export FCRA_Liens_Daily := macro
	output(choosen(doxie.key_liens_did_FCRA,10));
	output(choosen(doxie.key_liens_rmsid_FCRA,10));
	output(choosen(doxie_files.Key_BocaShell_Liens_FCRA,10));
endmacro;