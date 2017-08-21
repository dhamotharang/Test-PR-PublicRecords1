keyLayout := record
	string10 phone;
	PhonesInfo.Layout_Common.portedMetadata_Main-phone;
	unsigned8 __internal_fpos__ := 0;
end;

EXPORT File_Deact_Batch := dataset('~thor_data400::base::phones::disconnect_main_batch', keyLayout, csv(heading(1), terminator('\n'), separator('\t')));
	
