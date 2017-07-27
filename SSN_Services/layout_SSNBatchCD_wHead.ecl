import doxie_raw;
export layout_SSNBatchCD_wHead := record
	//ssn_services.layout_SSNBatchCD_output;
	string20	acctno;
	string2		RecordID;
	doxie_raw.Layout_HeaderRawBatchInput;
end;