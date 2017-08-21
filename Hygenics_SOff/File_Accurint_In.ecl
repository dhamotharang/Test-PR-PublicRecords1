import hygenics_soff; 

	Layout_Mainfile := record
		Hygenics_SOff.Layout_Accurint_Mainfile;
		string2 newline;// := '\r\n';
	end;

export File_Accurint_In := dataset('~thor_200::base::hd::OKC_Sex_Offender_File_Accurint_In', Layout_Mainfile, flat);