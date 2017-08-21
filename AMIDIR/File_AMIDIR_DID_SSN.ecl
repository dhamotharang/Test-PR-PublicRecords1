Layout_outf := record
		string12 did;
		string9  ssn;
		AMIDIR.Layout_AMIDIR_Common;
end;

export File_AMIDIR_DID_SSN := dataset(AMIDIR.Cluster + 'persist::Cleaned_AMIDIR_after_did_ssn',Layout_outf,thor);
