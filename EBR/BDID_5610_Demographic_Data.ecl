import ut, Business_Header, Business_Header_SS, did_add,lib_stringlib,idl_header;

dFlippedNames 	:= EBR.BDID_5610_Demo_Input_Norm;
segment_code 		:= '5610';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, dFlippedNames(clean_officer_name.lname != ''), BDID_Append);

ebr.Layout_5610_Demographic_Data_Base					tLayout_5610_Demographic_Data_Base(				    ebr.Layout_5610_Demographic_Data_Base				l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

export BDID_5610_Demographic_Data := project(BDID_Append, tLayout_5610_Demographic_Data_Base(left))
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;
