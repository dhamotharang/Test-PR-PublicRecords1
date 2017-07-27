import ut, Business_Header, Business_Header_SS, did_add;

EBR_Header_In 		:= File_0010_Header_In;
EBR_Header_Base 	:= File_0010_Header_Base;
segment_code 		:= '0010';

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
	self.vendor_id 			:= L.FILE_NUMBER;
	self.bdid 				:= 0;
	self.date_first_seen		:= map(business_header.validatedate(l.file_estab_date,1) != '' => trim(business_header.validatedate(l.file_estab_date,1)) + '00',
								business_header.validatedate(l.extract_date) != '' => business_header.validatedate(l.extract_date), '');
	self.date_last_seen 		:= self.date_first_seen;
	self.process_date_first_seen	:= (unsigned4)l.process_date;
	self.process_date_last_seen 	:= self.process_date_first_seen;
	self.record_type			:= 'C';
	self 					:= l;
end;

EBR_Header_vendor_id_in := project(EBR_Header_In, AddVendorIDIn(left));

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Vendor Id to Base File, clear bdid field
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

EBR_Header_seq := sort(distribute(project(EBR_Header_vendor_id, AddSeqNum(left, counter)),seq),seq,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Slim Record for BDIDing, add BDID field
//////////////////////////////////////////////////////////////////////////////////////////////
layout_EBR_Header_bdid := 
record
	unsigned6 bdid := 0;
	EBR_Header_seq.seq;
	EBR_Header_seq.vendor_id;
	EBR_Header_seq.company_name;
	EBR_Header_seq.prim_range;
	EBR_Header_seq.prim_name;
	EBR_Header_seq.sec_range;
	EBR_Header_seq.st;
	EBR_Header_seq.zip;
	EBR_Header_seq.PHONE_NUMBER;
	EBR_Header_seq.FILE_NUMBER;
end;

EBR_Header_to_bdid := table(EBR_Header_seq, layout_EBR_Header_bdid);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records First Pass
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match(EBR_Header_to_bdid, EBR_Header_bdid_init,
                        false, bdid,
                        false, 'EB',
                        true,  FILE_NUMBER,
                        company_name,prim_range, prim_name, sec_range, zip,
                        true,  PHONE_NUMBER,
                        false, fein_field,
				    true,  vendor_id);


BDID_Matchset 			:= ['A','P'];
EBR_Header_bdid_match 	:= EBR_Header_bdid_init(bdid <> 0);
EBR_Header_bdid_nomatch 	:= EBR_Header_bdid_init(bdid = 0);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records Second Pass on address and phone
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header_SS.MAC_Add_BDID_Flex(EBR_Header_bdid_nomatch,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, zip,
                                  sec_range, st,
                                  PHONE_NUMBER, fein_field,
                                  bdid, layout_EBR_Header_bdid,
                                  false, BDID_score_field,
                                  EBR_Header_bdid_rematch)

EBR_Header_bdid_all := sort(distribute(EBR_Header_bdid_match + EBR_Header_bdid_rematch,seq),seq,local);
					
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Join back to input file and append BDIDs to create base file
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_0010_Header_Base JoinBack(layout_EBR_Header_seq L, layout_EBR_Header_bdid R) := 
transform
	self.bdid	:= R.bdid;
	self 	:= L;
END;
EBR_Header_bdid_append := join(EBR_Header_seq,
                          EBR_Header_bdid_all,
				          left.seq = right.seq,
				          JoinBack(left,right),
//				          transform(Layout_Header_Base, self.bdid := right.bdid, self := left),
				          left outer,
				          local);

//////////////////////////////////////////////////////////////////////////////////////////
// -- Rollup on Raw Fields, setting date_first_seen, date_last_seen
//////////////////////////////////////////////////////////////////////////////////////////
Layout_0010_Header_Base RollupBase(Layout_0010_Header_Base L, Layout_0010_Header_Base R) := 
transform
	self.date_first_seen 		:= (string8)ut.EarliestDate(
								ut.EarliestDate((unsigned6)L.date_first_seen,(unsigned6)R.date_first_seen),
								ut.EarliestDate((unsigned6)L.date_last_seen,	(unsigned6)R.date_last_seen));
	self.date_last_seen 		:= (string8)ut.LatestDate((unsigned6)L.date_last_seen, (unsigned6)R.date_last_seen);
	self.process_date_first_seen	:= ut.EarliestDate(	L.process_date_first_seen,R.process_date_first_seen);
	self.process_date_last_seen 	:= ut.LatestDate(	L.process_date_last_seen, R.process_date_last_seen);
	self := L;
END;

EBR_Header_dist := distribute(EBR_Header_bdid_append,hash(FILE_NUMBER));
EBR_Header_sort := sort(EBR_Header_dist, 
						FILE_NUMBER,
						SEGMENT_CODE,
						SEQUENCE_NUMBER,
						orig_EXTRACT_DATE_MDY,
						orig_FILE_ESTAB_DATE_MMYY,
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
					left.orig_EXTRACT_DATE_MDY	= right.orig_EXTRACT_DATE_MDY and
			          left.FILE_ESTAB_FLAG 		= right.FILE_ESTAB_FLAG 		and
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

Layout_0010_Header_Base SetRecordType(EBR_Header_Grpd_Sort l, EBR_Header_Grpd_Sort r) := 
transform
	self.record_type 	:= if(l.record_type = '', 'C', 'H');
	SELF 			:= r;
END;

EBR_Header_Prop := GROUP(ITERATE(EBR_Header_Grpd_Sort, SetRecordType(LEFT, RIGHT)));

export BDID_0010_Header := EBR_Header_Prop : persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code));