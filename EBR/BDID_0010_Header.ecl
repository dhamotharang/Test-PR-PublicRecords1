import _control, ut, Address, BIPV2, Business_Header, Business_Headerv2, Business_Header_SS, did_add,mdr, AID, Std;

EBR_Header_In 		:= File_0010_Header_In;
EBR_Header_Base 	:= File_0010_Header_Base_AID;
EBR_Demo_Combined := BDID_5610_Demo_For_Header;
segment_code 			:= '0010';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Vendor Id, date first seen, and bdid fields to Input File
//////////////////////////////////////////////////////////////////////////////////////////////
layout_EBR_Header_vendor_id := 
record
	qstring34 vendor_id;
	EBR_Header_Base;
end;

layout_EBR_Header_vendor_id AddVendorIDIn(EBR_Header_In l) := 
transform
	self.vendor_id								:= 	L.FILE_NUMBER;
	self.bdid											:=	 0;
	self.date_first_seen					:= 	map(business_header.validatedate(l.file_estab_date,1) != '' => trim(business_header.validatedate(l.file_estab_date,1)) + '00',
																				business_header.validatedate(l.extract_date) != '' => business_header.validatedate(l.extract_date),
																				''
																			 );
	self.date_last_seen						:= 	if (	business_header.validatedate(l.extract_date) != '' and
																					(integer) self.date_first_seen <= (integer) business_header.validatedate(l.extract_date),  
																							business_header.validatedate(l.extract_date),
																							self.date_first_seen
																				);
	self.process_date_first_seen	:= 	(unsigned4)l.process_date;
	self.process_date_last_seen		:= 	self.process_date_first_seen;
	self.record_type							:= 	'C';
	self													:=	l;
	self													:=	[];
end;

EBR_Header_vendor_id_in := project(EBR_Header_In, AddVendorIDIn(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Vendor Id to Base File, clear bdid field
// -- NOTE: EBR_Init_Flag determines if base file is being included as input.
//////////////////////////////////////////////////////////////////////////////////////////////
#if(EBR_Init_Flag(segment_code) = false)
layout_EBR_Header_vendor_id AddVendorIDBase(EBR_Header_Base l) := 
transform
	self.vendor_id 		:= L.FILE_NUMBER;
	self.bdid 			:= 0;
	self 				:= l;
end;

EBR_Header_vendor_id_base := project(EBR_Header_Base, AddVendorIDBase(left));

EBR_Header_vendor_id := EBR_Header_vendor_id_in + EBR_Header_vendor_id_base;
#else
EBR_Header_vendor_id := EBR_Header_vendor_id_in;
#end

/////////////////// Add AID here /////////////////////////////////////////////////////////////

HasAddress	:=	trim(ebr_header_vendor_id.prep_addr_line1, left,right) != '' and 
								trim(ebr_header_vendor_id.prep_addr_last_line, left,right) != '';
									
dWith_address			:= EBR_Header_vendor_id(HasAddress);
dWithout_address	:= EBR_Header_vendor_id(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dWith_address, prep_addr_line1, prep_addr_last_line, Append_RawAID, dwithAID, lFlags);
	
dBase := project(dwithAID,transform(
																			layout_EBR_Header_vendor_id
																			,
																			self.Append_ACEAID			:= left.aidwork_acecache.aid;
																			self.Append_RawAID			:= left.aidwork_rawaid;
																			self.Clean_Address.zip	:= left.aidwork_acecache.zip5;
																			self.Clean_address			:= left.aidwork_acecache;
																			self										:= left;
																		)
								) + project(dWithout_address,transform(layout_EBR_Header_vendor_id, self := left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Sequence Number to Combined File
//////////////////////////////////////////////////////////////////////////////////////////////
layout_EBR_Header_seq := 
record
	unsigned4 seq;
	layout_EBR_Header_vendor_id;
end;

layout_EBR_Header_seq AddSeqNum(layout_EBR_Header_vendor_id l, unsigned4 cnt) := 
transform
	self.seq 				:= cnt;
	self 				:= l;
end;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- EBR_Header_seq is the file used to append the linkids to;
//////////////////////////////////////////////////////////////////////////////////////////////
EBR_Header_seq := sort(distribute(project(dBase, AddSeqNum(left, counter)),seq),seq,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Slim Record for BDIDing, add BDID field
//////////////////////////////////////////////////////////////////////////////////////////////
slim_header_layout := 
record
	bipv2.idlayouts.l_xlink_ids;
	unsigned6 bdid := 0;
	string2	source := mdr.sourcetools.src_ebr;
	ebr_header_seq.source_rec_id;
	ebr_header_seq.seq;
	ebr_header_seq.vendor_id;
	ebr_header_seq.company_name;
	ebr_header_seq.clean_address.prim_range;
	ebr_header_seq.clean_address.prim_name;
	ebr_header_seq.clean_address.sec_range;
	ebr_header_seq.clean_address.p_city_name;
	ebr_header_seq.clean_address.st;
	ebr_header_seq.clean_address.zip;
	ebr_header_seq.phone_number;
	ebr_header_seq.file_number;
	ebr_header_seq.process_date;
	ebr_header_seq.process_date_first_seen;
	ebr_header_seq.process_date_last_seen;
  EBR_Demo_Combined.clean_officer_name.fname;	
  EBR_Demo_Combined.clean_officer_name.mname;	
	EBR_Demo_Combined.clean_officer_name.lname;	
end;

slim_header_layout	ebr_header_slim(layout_EBR_Header_seq l) := transform
	self.prim_range  := l.clean_address.prim_range;
	self.prim_name	 := l.clean_address.prim_name;
	self.sec_range	 := l.clean_address.sec_range;
	self.p_city_name := l.clean_address.p_city_name;
	self.st					 := l.clean_address.st;
	self.zip				 := l.clean_address.zip;
  self.fname	 		 := '';	
  self.mname	 		 := '';	
	self.lname	 	   := '';	
	self						 := l;
end;

slim_header				 := project(EBR_Header_seq, ebr_header_slim(left));
EBR_Header_sorted  := sort(distribute(slim_header,hash(file_number)),file_number,process_date_first_seen,process_date_last_seen,local);
EBR_Demo_sorted 	 := sort(distribute(EBR_Demo_Combined,hash(file_number)),file_number,process_date,local);

slim_header_layout join_header_demo(EBR_Header_sorted L, EBR_Demo_sorted R) := transform
	 self.fname				:= r.clean_officer_name.fname;
	 self.mname				:= r.clean_officer_name.mname;
	 self.lname				:= r.clean_officer_name.lname;
	 self 						:= l;
	 self							:= r;
end;

//The file_number is not unique and represents the "headquarters" of a company.  Therefore the 
//same file_number can be associated with multiple locations.  Since the contact file doesn't contain
//an address this causes the following join to link the same contacts to multiple locations (via the file number).
//In order to improve the linking, the process_date has been added to ensure that we are processing the same
//contact file with its associated company file.
join_demo_to_header := join(EBR_Header_sorted, EBR_Demo_sorted,
														left.file_number 												= right.file_number and
														(unsigned)left.process_date_first_seen <= (unsigned)right.process_date and
														(unsigned)left.process_date_last_seen	 >= (unsigned)right.process_date
														,join_header_demo(left,right)
														,left outer
														,local);
														
preBDID_no_company  := join_demo_to_header(company_name  = '');
preBDID						  := join_demo_to_header(company_name <> '');
														
//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records - does a direct source match to the current Business Headers
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match(
		 preBDID												// infile
		,dSourceMatchOut								// outfile
		,false													// bool_bdid_field_is_string12
		,bdid														// bdid_field
    ,false													// bool_infile_has_source_field
		,mdr.sourcetools.src_ebr				// source_type_or_field
    ,true														// bool_infile_has_source_group
		,file_number										// source_group_field
		,company_name										// company_name_field
		,prim_range											// prim_range_field
		,prim_name											// prim_name_field
		,sec_range											// sec_range_field
		,zip														// zip_field
		,true														// bool_infile_has_phone
		,phone_number										// phone_field
		,false													// bool_infile_has_fein
		,fein_field											// fein_field
		,true														// bool_infile_has_vendor_id = 'false'
		,file_number										// vendor_id field					 = 'vendor_id'
		);

BDID_Matchset 			:= ['A','P'];
														
//////////////////////////////////////////////////////////////////////////////////////////////
// -- 
//////////////////////////////////////////////////////////////////////////////////////////////																	
Business_Header_SS.MAC_Add_BDID_FLEX(
			 dSourceMatchOut											// input dataset						
			,bdid_matchset                        // bdid matchset what fields to match on           
			,company_name	                        // company_name	              
			,prim_range		                        // prim_range		              
			,prim_name		                        // prim_name		              
			,zip					                        // zip5					              
			,sec_range		                        // sec_range		              
			,st				        		                // state				              
			,phone_number			                    // phone				              
			,fein_field                       	  // fein              
			,bdid													        // bdid												
			,slim_header_layout           				// output layout 
			,false                                // output layout has bdid score field? 																	
			,bdid_score                           // bdid_score                 
			,dbdidout                             // output dataset   
			,																			// default threscold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,bipv2.xlink_version_set							// create bip keys only
			,																			// url
			,																			// email
			,p_city_name													// city
			,fname																// fname
			,mname																// mname
			,lname																// lname
			,																			// contact ssn
			,source																// source
			,source_rec_id												// source_record_id
			,true		 															// does MAC_Source_Match exist before Flex macro					
		);			

EBR_0010_bdid_all := preBDID_no_company + dBdidOut;
	
dBdidOut_dist			:= distribute	(EBR_0010_bdid_all(bdid 		!= 0 or 
																									 Ultid 		!= 0 or 
																									 OrgID 		!= 0 or 
																									 ProxID 	!= 0 or 
																									 SELEID		!= 0 or
																									 POWID 		!= 0 or 
																									 EmpID 		!= 0 or 
																									 DotID 		!= 0)	,seq);
dBdidOut_sort			:= sort				(dBdidOut_dist				,seq, -Bdid, -Ultid, -OrgID, -ProxID, -SeleID, -POWID, -EmpID, -DotID, local);
dBdidOut_dedup		:= dedup			(dBdidOut_sort				,seq, local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Join back to input file and append BDIDs to create base file
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_0010_Header_Base_AID JoinBack(layout_EBR_Header_seq L, slim_header_layout R) := 
transform
	self.DotID			:= R.DotID;
	self.DotScore		:= R.DotScore;
	self.DotWeight	:= R.DotWeight;
	self.EmpID			:= R.EmpID;
	self.EmpScore		:= R.EmpScore;
	self.EmpWeight	:= R.EmpWeight;
	self.POWID			:= R.POWID;
	self.POWScore		:= R.POWScore;
	self.POWWeight	:= R.POWWeight;
	self.ProxID			:= R.ProxID;
	self.ProxScore	:= R.ProxScore;
	self.ProxWeight	:= R.ProxWeight;
	self.SeleID			:= R.SeleID;
	self.SeleScore	:= R.SeleScore;
	self.SeleWeight	:= R.SeleWeight;	
	self.OrgID			:= R.OrgID;
	self.OrgScore		:= R.OrgScore;
	self.OrgWeight	:= R.OrgWeight;
	self.UltID			:= R.UltID;
	self.UltScore		:= R.UltScore;
	self.UltWeight	:= R.UltWeight;
	self.bdid				:= R.bdid;
	self 						:= L;
END;
EBR_Header_bdid_append := join( EBR_Header_seq,
																dBdidOut_dedup,
																left.seq = right.seq,
																JoinBack(left,right),
																left outer,
																local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
Layout_0010_Header_Base_AID RollupBase(Layout_0010_Header_Base_AID L, Layout_0010_Header_Base_AID R) := 
transform
	self.date_first_seen 		:= (string8)ut.EarliestDate(
								ut.EarliestDate((unsigned6)L.date_first_seen,(unsigned6)R.date_first_seen),
								ut.EarliestDate((unsigned6)L.date_last_seen,	(unsigned6)R.date_last_seen));
	self.date_last_seen 		:= (string8)MAX((unsigned6)L.date_last_seen, (unsigned6)R.date_last_seen);
	self.process_date_first_seen	:= ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= MAX(	L.process_date_last_seen, R.process_date_last_seen);
	self.source_rec_id						:= if (L.source_rec_id <> 0,L.source_rec_id,R.source_rec_id);
	self := L;
END;

EBR_Header_dist := distribute(EBR_Header_bdid_append,hash(FILE_NUMBER));
EBR_Header_sort := sort(EBR_Header_dist, 
						FILE_NUMBER,
						SEGMENT_CODE,
						SEQUENCE_NUMBER,
//						orig_EXTRACT_DATE_MDY,
//						orig_FILE_ESTAB_DATE_MMYY,
						FILE_ESTAB_FLAG,
						COMPANY_NAME,
						STREET_ADDRESS,
						CITY,
						STATE_CODE,
						STATE_NAME,
						orig_ZIP,
						orig_ZIP_4,
						PHONE_NUMBER,
						SIC_CODE,
						BUSINESS_DESC,
						DISPUTE_IND,
						-process_date_last_seen,
						local);

EBR_Header_rollup := rollup(EBR_Header_sort,
					left.FILE_NUMBER 			= right.FILE_NUMBER 		and
					left.SEGMENT_CODE 			= right.SEGMENT_CODE 		and
					left.SEQUENCE_NUMBER 		= right.SEQUENCE_NUMBER 		and
//					left.orig_EXTRACT_DATE_MDY	= right.orig_EXTRACT_DATE_MDY and
//			          left.FILE_ESTAB_FLAG 		= right.FILE_ESTAB_FLAG 		and
			          left.COMPANY_NAME 			= right.COMPANY_NAME 		and
			          left.STREET_ADDRESS 		= right.STREET_ADDRESS 		and
			          left.CITY 				= right.CITY 				and
			          left.STATE_CODE 			= right.STATE_CODE 			and
			          left.STATE_NAME 			= right.STATE_NAME 			and
			          left.orig_ZIP 				= right.orig_ZIP			and
			          left.orig_ZIP_4 			= right.orig_ZIP_4 			and
			          left.PHONE_NUMBER 			= right.PHONE_NUMBER 		and
			          left.SIC_CODE				= right.SIC_CODE 			and
			          left.BUSINESS_DESC 			= right.BUSINESS_DESC 		and
			          left.DISPUTE_IND 			= right.DISPUTE_IND,
					RollupBase(left, right),
					local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Set Record Type flag
//////////////////////////////////////////////////////////////////////////////////////////
EBR_Header_Grpd 		:= GROUP(EBR_Header_rollup, FILE_NUMBER, LOCAL);
EBR_Header_Grpd_Sort 	:= SORT(EBR_Header_Grpd, -process_date_last_seen);

Layout_0010_Header_Base_AID SetRecordType(EBR_Header_Grpd_Sort l, EBR_Header_Grpd_Sort r) := 
transform
	self.record_type 	:= if(l.record_type = '', 'C', 'H');
	self.process_date := (string)r.process_date_last_seen;
	SELF 			:= r;
END;

EBR_AddRecordType:= GROUP(ITERATE(EBR_Header_Grpd_Sort, SetRecordType(LEFT, RIGHT)));

addGlobalSID := mdr.macGetGlobalSID(EBR_AddRecordType,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

//Add the source_rec_id to the 0010 Header file
UT.MAC_Append_Rcid(addGlobalSID, source_rec_id, EBR_Header_Prop);

export BDID_0010_Header := EBR_Header_Prop; //: persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code) + '_BDID_0010_Header2');
