import ut, Business_Header, Business_Header_SS, did_add;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_2015_Trade_Payment_Totals_In;
segment_code 		:= '2015';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_2015_Trade_Payment_Totals_Base Convert2Base(File_in l) := 
transform
	self.date_first_seen		:= '';
	self.date_last_seen 		:= self.date_first_seen;
	self 					:= l;
end;

File_in2base := project(File_in, Convert2Base(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)

ebr.Layout_2015_Trade_Payment_Totals_Base				tLayout_2015_Trade_Payment_Totals_Base(			    ebr.Layout_2015_Trade_Payment_Totals_Base			l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

export BDID_2015_Trade_Payment_Totals := project(BDID_Append, tLayout_2015_Trade_Payment_Totals_Base(left)) 
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;