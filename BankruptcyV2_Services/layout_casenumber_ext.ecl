import bankruptcyv3;
export layout_casenumber_ext :=
	record
		bankruptcyv3.key_bankruptcyv3_main_full().orig_case_number;
		bankruptcyv3.key_bankruptcyv3_main_full().filing_jurisdiction;
		boolean isdeepdive;
	end;
	