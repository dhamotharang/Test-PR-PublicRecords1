EXPORT File_Sam := DATASET('~thor::in::epls::sam',Layout_SAM,
				CSV(HEADING(1),SEPARATOR(','),QUOTE('"'),TERMINATOR('\n'),MAXLENGTH(12000)));
