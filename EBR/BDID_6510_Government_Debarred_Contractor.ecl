import ut, Business_Header, Business_Header_SS, did_add;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_6510_Government_Debarred_Contractor_In;
segment_code 		:= '6510';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_6510_Government_Debarred_Contractor_Base Convert2Base(File_in l) := 
transform
	self.date_first_seen		:= if(business_header.validatedate(l.date_filed) != '', 
								 business_header.validatedate(l.date_filed),
								 business_header.validatedate(l.date_reported));
	self.date_last_seen 		:= self.date_first_seen;
	self 					:= l;
end;

File_in2base := project(File_in, Convert2Base(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)


export BDID_6510_Government_Debarred_Contractor := BDID_Append : persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code));