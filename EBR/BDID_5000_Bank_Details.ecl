import _control, ut, Business_Header, Business_Header_SS, did_add,AID, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_5000_Bank_Details_In;
segment_code 	:= '5000';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_5000_Bank_Details_Base_AID Convert2Base(File_in l) := 
transform
	self.date_first_seen					:=	'';
	self.date_last_seen 					:=	self.date_first_seen;
	self.process_date_first_seen	:= 	(unsigned4)l.process_date;
	self.process_date_last_seen		:= 	self.process_date_first_seen;
	self.record_type							:= 	'C';
	self													:= 	l;
	self													:=	[];
end;

File_in2base := project(File_in, Convert2Base(left));

ebr.GetSegmentFile_Base(segment_code, File_Base, 'A');

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Populate common base fields on update file
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_5000_Bank_Details_Base_AID PopulateBaseFields(Layout_5000_Bank_Details_Base_AID l) := transform
	self.bdid 										:= 0;
	self.process_date_first_seen	:= (unsigned4)l.process_date;
	self.process_date_last_seen		:= self.process_date_first_seen;
	self.record_type							:= 'C';
	self													:= l;
end;

File_In_common_fields := project(File_in2base, PopulateBaseFields(left));

Layout_5000_Bank_Details_Base_AID BlankBDIDBase(Layout_5000_Bank_Details_Base_AID l) := transform
	self.file_number	:= regexreplace('\n', l.file_number, ' ');
	self.bdid					:= 0;
	self							:= l;
end;

File_Base_blank_bdid := project(File_Base, BlankBDIDBase(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Clear bdid field on base file
//////////////////////////////////////////////////////////////////////////////////////////////
File_Combined	:=	if(EBR.EBR_Init_Flag(segment_code) = false,
												File_In_common_fields + File_Base_blank_bdid,
												File_In_common_fields
										);

HasAddress	:=	trim(File_Combined.prep_addr_line1, left,right) != '' and 
								trim(File_Combined.prep_addr_last_line, left,right) != '';
									
dWith_address			:= File_Combined(HasAddress);
dWithout_address	:= File_Combined(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
	
dBase := project(dwithAID,transform(
																			Layout_5000_Bank_Details_Base_AID
																			,
																			self.Append_ACEAID			:= left.aidwork_acecache.aid;
																			self.Append_RawAID			:= left.aidwork_rawaid;
																			self.Clean_Address.zip	:= left.aidwork_acecache.zip5;
																			self.Clean_address			:= left.aidwork_acecache;
																			self										:= left;
																		)
								) + project(dWithout_address,transform(Layout_5000_Bank_Details_Base_AID, self := left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Merge with Base File and Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment_AID_Base_Files(segment_code, dBase, BDID_Append)

Layout_5000_Bank_Details_Base_AID						tLayout_5000_Bank_Details_Base(					    Layout_5000_Bank_Details_Base_AID					l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

projectBase  :=  project(BDID_Append, tLayout_5000_Bank_Details_Base(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_5000_Bank_Details := addGlobalSID
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;
