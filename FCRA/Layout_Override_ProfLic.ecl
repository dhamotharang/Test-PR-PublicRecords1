IMPORT prof_license;

EXPORT Layout_Override_ProfLic := RECORD
  UNSIGNED6   prolic_seq_id       := 0;		//CCPA-1042 - sync up with the layout of thor_data400::key::prolicv2::fcra::qa::prolicense_did
  prof_license.layout_proflic_out;
  UNSIGNED4   global_sid          := 0;		//CCPA-1042
  UNSIGNED8   record_sid          := 0;		//CCPA-1042
  STRING20    flag_file_id;
END;

