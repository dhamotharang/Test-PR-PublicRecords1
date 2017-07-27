export File_MIdc_In := 
DATASET('~images::in::Michigan20031208',
		Layout_MIdc_In,
		csv(separator('\t'), TERMINATOR('\n'), QUOTE(''),
		MAXLENGTH(1500000)));