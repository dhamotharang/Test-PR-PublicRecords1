import ut, Business_Header, Business_Header_SS, did_add, AID, Address, idl_header;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_in 			:= File_6510_Government_Debarred_Contractor_In;
segment_code 		:= '6510';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Convert the Input File to Base format
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_6510_Government_Debarred_Contractor_Base_AID Convert2Base(File_in l) := 
transform
	self.date_first_seen		:=	if(business_header.validatedate(l.date_filed) != '', 
																		business_header.validatedate(l.date_filed),
																		business_header.validatedate(l.date_reported)
																 );
	self.date_last_seen 		:=	self.date_first_seen;
	self										:=	l;
	self										:=	[];
end;

File_in2base := project(File_in, Convert2Base(left));

ebr.GetSegmentFile_Base(segment_code, File_Base, 'A');

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Populate common base fields on update file
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_6510_Government_Debarred_Contractor_Base_AID PopulateBaseFields(Layout_6510_Government_Debarred_Contractor_Base_AID l) := transform
	self.bdid 										:= 0;
	self.process_date_first_seen	:= (unsigned4)l.process_date;
	self.process_date_last_seen		:= self.process_date_first_seen;
	self.record_type							:= 'C';
	self													:= l;
end;

File_In_common_fields := project(File_in2base, PopulateBaseFields(left));

Layout_6510_Government_Debarred_Contractor_Base_AID BlankBDIDBase(Layout_6510_Government_Debarred_Contractor_Base_AID l) := transform
	self.file_number	:= regexreplace('\n', l.file_number, ' ');
	self.bdid					:= 0;
	self							:= l;
end;

File_Base_blank_bdid := project(File_Base, BlankBDIDBase(left));

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
	// self.CompanyName										:= if(l.name_flag = 'B',
																								// l.co_bus_name,
																								// ''
																						// );	
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


export BDID_6510_Government_Debarred_Contractor := project(BDID_Append, tLayout_6510_Government_Debarred_Contractor_Base(left))
	/*: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;