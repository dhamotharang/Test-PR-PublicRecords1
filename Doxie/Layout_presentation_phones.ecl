export Layout_presentation_phones := RECORD, MAXLENGTH(8192)
	Layout_presentation;
	DATASET(Layout_phones) Phones {MAXCOUNT(rollup_limits.phones)} := DATASET([],doxie.layout_phones);
END;
