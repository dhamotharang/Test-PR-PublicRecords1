import _control, ut, Business_Header, Business_Header_SS, did_add, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_4510_UCC_Filings_In;
segment_code 		:= '4510';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_4510_UCC_Filings_Base Convert2Base(File_in l) := 
transform
	self.date_first_seen		:= business_header.validatedate(l.date_filed);
	self.date_last_seen 		:= self.date_first_seen;
	self 					:= 	l;
	self					:=	[];
end;

File_in2base := project(File_in, Convert2Base(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment(segment_code, File_in2base, BDID_Append)

ebr.Layout_4510_UCC_Filings_Base						tLayout_4510_UCC_Filings_Base(					    ebr.Layout_4510_UCC_Filings_Base					l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

projectBase  := project(BDID_Append, tLayout_4510_UCC_Filings_Base(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_4510_UCC_Filings := addGlobalSID
/*	: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;