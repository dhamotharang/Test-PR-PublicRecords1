import _control, ut, Business_Header, Business_Header_SS, did_add, AID, Address, idl_header, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= 	ebr.File_6510_Government_Debarred_Contractor_In;
segment_code 	:= 	'6510';
File_Base			:=	ebr.File_6510_Government_Debarred_Contractor_Base_AID;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_6510_Government_Debarred_Contractor_Base_AID Convert2Base(File_in l) := 
transform
	self.date_first_seen					:=	if(business_header.validatedate(l.date_filed) != '', 
																					business_header.validatedate(l.date_filed),
																					business_header.validatedate(l.date_reported)
																			 );
	self.date_last_seen 					:=	self.date_first_seen;
	self.process_date_first_seen	:= 	(unsigned4)l.process_date;
	self.dt_effective_first				:= 	(unsigned4)l.process_date;
	self.process_date_last_seen 	:= 	self.process_date_first_seen;
	self.record_type							:= 	'C';	
	self													:=	l;
	self													:=	[];
end;

File_in2base := project(File_in, Convert2Base(left));

Layout_6510_Government_Debarred_Contractor_Base_AID BlankBDIDBase(Layout_6510_Government_Debarred_Contractor_Base_AID l) := transform
	self.file_number	:= regexreplace('\n', l.file_number, ' ');
	self.bdid					:= 0;
	self							:= l;
end;

File_Base_blank_bdid := project(File_Base, BlankBDIDBase(left));

File_Combined	:=	if(EBR.EBR_Init_Flag(segment_code) = false,
												File_in2base + File_Base_blank_bdid,
												File_in2base
										);

HasAddress	:=	trim(File_Combined.prep_addr_line1, left,right) != '' and 
								trim(File_Combined.prep_addr_last_line, left,right) != '';
									
dWith_address			:= File_Combined(HasAddress);
dWithout_address	:= File_Combined(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
	
dBase := project(dwithAID,transform(
																			Layout_6510_Government_Debarred_Contractor_Base_AID
																			,
																			self.Append_ACEAID							:= left.aidwork_acecache.aid;
																			self.Append_RawAID							:= left.aidwork_rawaid;
																			self.Clean_Business_Address.zip	:= left.aidwork_acecache.zip5;
																			self.Clean_Business_address			:= left.aidwork_acecache;
																			self														:= left;
																		)
								) + project(dWithout_address,transform(Layout_6510_Government_Debarred_Contractor_Base_AID, self := left));
								
Address.Mac_Is_Business( dBase(co_bus_name != '') ,co_bus_name,Clean_Name,name_flag,false,true );

cln_layout := RECORD
	recordof(dBase);
	string1		name_flag;
	string5		cln_title;
	string20	cln_fname;
	string20	cln_mname;
	string20	cln_lname;
	string5		cln_suffix;
	string5		cln_title2;
	string20	cln_fname2;
	string20	cln_mname2;
	string20	cln_lname2;
	string5		cln_suffix2;
END;
	
dNameBlank	:=      project(dBase(co_bus_name = ''),transform(cln_layout,self	:=	left; self	:=	[]));
dCleanName	:=      Clean_Name   +  dNameBlank;

Layout_6510_Government_Debarred_Contractor_Base_AID  CleanUpName( dCleanName  l) := transform
	self.clean_business_name.title			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_title,
																							l.name_flag = 'U' => l.clean_business_name.title, 
																							''
																						);
	self.clean_business_name.fname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_fname,
																							l.name_flag = 'U' => l.clean_business_name.fname, 
																							''
																						);
	self.clean_business_name.mname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_mname,
																							l.name_flag = 'U' => l.clean_business_name.mname, 
																							''
																						);
	self.clean_business_name.lname			:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_lname,
																							l.name_flag = 'U' => l.clean_business_name.lname, 
																							''
																						 );
	self.clean_business_name.name_suffix:= map( l.name_flag = 'P' or l.name_flag = 'D' => l.cln_suffix,
																							l.name_flag = 'U' => l.clean_business_name.name_suffix, 
																							''
																						);
	self																:=	l;
	self																:=	[];
end;		
				
clean6510Names	:=project( dCleanName ,CleanUpName(left));

ut.mac_flipnames(clean6510Names,clean_business_name.fname,clean_business_name.mname,clean_business_name.lname,dFlippedNames);							
								
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Append BDIDs
//////////////////////////////////////////////////////////////////////////////////////////////
BDID_Segment_AID_Base_Files(segment_code, dFlippedNames, BDID_Append)

Layout_6510_Government_Debarred_Contractor_Base_AID		tLayout_6510_Government_Debarred_Contractor_Base(	Layout_6510_Government_Debarred_Contractor_Base_AID	l) :=
transform
	self.process_date := (string)l.process_date_last_seen;
	self := l;
end;

projectBase  := project(BDID_Append, tLayout_6510_Government_Debarred_Contractor_Base(left));

addGlobalSID := mdr.macGetGlobalSID(projectBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export BDID_6510_Government_Debarred_Contractor := addGlobalSID;