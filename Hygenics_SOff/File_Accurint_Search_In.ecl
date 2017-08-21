import hygenics_soff;

	Layout_SearchFile := record
		Hygenics_SOff.Layout_Accurint_SearchFile;
		string2 newline := '\r\n';
	end;

export File_Accurint_Search_In := dataset('~thor_200::base::hd::okc_sex_offender_search_file', Layout_SearchFile, flat);