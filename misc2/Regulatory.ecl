EXPORT Regulatory  := MODULE
	IMPORT misc2, Suppress;

	in_layout := record
		String32 hval;
		String2 state;
		String8 startDate;
		String8 endDate;
		String1 nl;
	end;

	EXPORT fileIn := Suppress.applyRegulatory.getfile('ssi2_sup.txt', in_layout);	

END;