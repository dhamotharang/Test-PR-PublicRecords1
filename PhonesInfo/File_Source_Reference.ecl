import ut;

EXPORT File_Source_Reference := MODULE

	EXPORT RAW	:= dataset('~thor_data400::in::phones::source_reference', 				PhonesInfo.Layout_Common.sourceRefIn , csv(heading(1), terminator('\n'), separator('\t'), quote('"')));
	EXPORT MAIN := dataset('~thor_data400::base::phones::source_reference_main', 	PhonesInfo.Layout_Common.sourceRefBase, flat);

END; 