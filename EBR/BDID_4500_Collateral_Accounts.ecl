import ut, Business_Header, Business_Header_SS, did_add;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_4500_Collateral_Accounts_In;
segment_code 		:= '4500';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_4500_Collateral_Accounts_Base Convert2Base(File_in l) := 
transform
	self.date_first_seen	:= '';
	self.date_last_seen 	:= self.date_first_seen;
	self 				:= l;
end;

File_in2base := project(File_in, Convert2Base(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)

ebr.Layout_4500_Collateral_Accounts_Base				tLayout_4500_Collateral_Accounts_Base(			    ebr.Layout_4500_Collateral_Accounts_Base			l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

export BDID_4500_Collateral_Accounts := project(BDID_Append, tLayout_4500_Collateral_Accounts_Base(left))
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;
