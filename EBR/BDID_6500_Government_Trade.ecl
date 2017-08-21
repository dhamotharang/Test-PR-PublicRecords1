import ut, Business_Header, Business_Header_SS, did_add;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_6500_Government_Trade_In;
segment_code 		:= '6500';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_6500_Government_Trade_Base Convert2Base(File_in l) := 
transform
	self.date_first_seen		:= business_header.validatedate(l.date_reported);
	self.date_last_seen 		:= self.date_first_seen;
	self 					:= l;
end;

File_in2base := project(File_in, Convert2Base(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)

ebr.Layout_6500_Government_Trade_Base					tLayout_6500_Government_Trade_Base(				    ebr.Layout_6500_Government_Trade_Base				l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;


export BDID_6500_Government_Trade := project(BDID_Append, tLayout_6500_Government_Trade_Base(left))
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;