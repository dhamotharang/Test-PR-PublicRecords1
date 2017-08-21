










import Text_Search;


Layout_bus_keyed := record
Layout_Common.Business;
unsigned6 doc;
end;

export Convert_FBN_Bus_Func (DATASET(Layout_bus_keyed )ds) := FUNCTION






	Text_Search.Layout_Document cvt(Layout_bus_keyed  l) := TRANSFORM
		SELF.docRef.src := 0; 
		SELF.docRef.doc := l.doc;
		SELF.segs := DATASET([
		// need stuff here
		{1,0,l.filing_jurisdiction},
		{2,0,l.filing_number + '; ' + l.orig_filing_number},
		{3,0,l.Filing_date + '; ' + l.ORIG_FILING_DATE},
		{4,0,l.filing_type},
		{5,0,l.EXPIRATION_DATE},
		{6,0,l.cancellation_date},
		
		{7,0,l.bus_name},
		{8,0,l.bus_comm_dATE},
		{9,0,l.bus_status},
		{10,0,l.orig_FEIN},
		{11,0,l.bus_phone_num},
		{12,0,l.sic_code},
		{13,0,l.bus_type_desc},
		
		{14,0,l.bus_address1 + ' ' + l.bus_address2 + ' ' + l.bus_city + ' ' +
				l.bus_state + ' ' + l.bus_zip + ' ' + l.bus_zip4},
	//	{15,0,l.bus_city + '; ' + l.mail_city},		
	//	{16,0,l.bus_county},
	//	{17,0,l.bus_state + '; ' + l.mail_state},
	//	{18,0,l.bus_zip + l.bus_zip4 + '; ' + l.mail_zip},
		{19,0,l.bus_country},
		{20,0,l.mail_street + ' ' + l.mail_city + ' ' + l.mail_state + ' ' + l.mail_zip},
		

		{27,0,l.filing_number + '; ' + l.orig_filing_number},	
		{28,0,l.Filing_date + '; ' + l.ORIG_FILING_DATE + '; ' + l.EXPIRATION_DATE + '; ' +
				l.cancellation_date + '; ' + l.bus_comm_dATE},
		{29,0,l.filing_type + '; ' + l.bus_type_desc},
		{30,0,l.bus_name},
		{31,0,l.bus_status},
		{32,0,l.bus_phone_num},
		
		{33,0,l.bus_address1 + ' ' + l.bus_address2 + ' ' + l.bus_city + ' ' +
				l.bus_state + ' ' + l.bus_zip + ' ' + l.bus_zip4
				+ '; ' + l.mail_city + '; ' + l.mail_street + ' ' + l.mail_city + ' ' + 
				l.mail_state + ' ' + l.mail_zip}

		
		
		


		], Text_Search.Layout_Segment);
	END;

	reslt := PROJECT(ds, cvt(LEFT));

	
	
Text_Search.layout_DocSeg flatten(Text_Search.Layout_Document l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
END;
	
norm_cont := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));

	
	RETURN norm_cont;
END;