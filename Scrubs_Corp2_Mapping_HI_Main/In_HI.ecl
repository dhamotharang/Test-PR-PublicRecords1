IMPORT corp2_mapping;
EXPORT In_HI := MODULE

	EXPORT Main := dataset('~thor_data400::in::corp2::20161109::main_hi',corp2_mapping.layoutscommon.main,thor);
	EXPORT Corp := Main(recordorigin = 'C');
	EXPORT Cont := Main(recordorigin = 'T');

END;