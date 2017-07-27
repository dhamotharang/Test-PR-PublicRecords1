import doxie_files;

export Boca_Shell_Derogs_NoHist(GROUPED DATASET(Layout_Boca_Shell_ids) ids) :=
function

	bankrec := RECORD
		Layout_Boca_Shell_ids;
		Layout_Derogs BJL;
		// bk extras
		string5    court_code;
		string7    case_num; 
		// criminal extras
		string35    crim_case_num; 
		// liens extras
		STRING10 rmsid;
	END;

	bankrec get_BJL(ids L, doxie_files.Key_BJL_DID R) := transform
		self := L;
		self := R;
	end;
	
	outf := join(ids,
			   doxie_files.Key_BJL_DID,
					keyed(left.did = right.did),
			   get_BJL(LEFT,RIGHT), left outer);
	
	return outf;
end;

