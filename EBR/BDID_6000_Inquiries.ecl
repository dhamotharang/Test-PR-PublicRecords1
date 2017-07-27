import ut, Business_Header, Business_Header_SS, did_add;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_6000_Inquiries_In;
segment_code 		:= '6000';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_6000_Inquiries_Base Convert2Base(File_in l, integer cnt) := 
transform
	self.date_first_seen	:= '';
	self.date_last_seen 	:= self.date_first_seen;
	self.INQ_MM			:= choose(cnt,	
		l.INQ_MM_1,	l.INQ_MM_2,	l.INQ_MM_3,	l.INQ_MM_4,	l.INQ_MM_5,	l.INQ_MM_6,
		l.INQ_MM_7,	l.INQ_MM_8,	l.INQ_MM_9);
	self.INQ_YY			:= choose(cnt,	
		l.INQ_YY_1,	l.INQ_YY_2,	l.INQ_YY_3,	l.INQ_YY_4,	l.INQ_YY_5,	l.INQ_YY_6,
		l.INQ_YY_7,	l.INQ_YY_8,	l.INQ_YY_9);
	self.INQ_COUNT			:= choose(cnt,	
		l.INQ_COUNT_1,	l.INQ_COUNT_2,	l.INQ_COUNT_3,	l.INQ_COUNT_4,	l.INQ_COUNT_5,	l.INQ_COUNT_6,
		l.INQ_COUNT_7,	l.INQ_COUNT_8,	l.INQ_COUNT_9);
	self 				:= l;
end;

File_in2base := normalize(File_in, 9, Convert2Base(left, counter));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)


export BDID_6000_Inquiries := BDID_Append : persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code));