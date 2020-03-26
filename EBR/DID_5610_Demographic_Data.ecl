import _control, DID_Add,Header_slimsort,ut,watchdog,didville,fair_isaac,census_data, business_Header, business_Header_ss, Mdr, Std;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Value Types
//////////////////////////////////////////////////////////////////////////////////////////////
File_BDID_Demo				:= BDID_5610_Demographic_Data;
File_0010_Header_Base_Local	:= File_0010_Header_Base;
File_Watchdog_Best			:= watchdog.File_Best;

segment_code 				:= '5610';

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Sequence Number to BDID'd file, sort
//////////////////////////////////////////////////////////////////////////////////////////////
layout_EBR_Demo_seq := 
record
	unsigned4 seq;
	Layout_5610_Demographic_Data_Base;
end;

layout_EBR_Demo_seq AddSeqNum(Layout_5610_Demographic_Data_Base l, unsigned4 cnt) := 
transform
	self.seq 				:= cnt;
	self 				:= l;
end;

EBR_Demo_seq := sort(distribute(project(File_BDID_Demo, AddSeqNum(left, counter)),seq),seq,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Sort Demo, 0010_Header by FILE_NUMBER to prepare for join
//////////////////////////////////////////////////////////////////////////////////////////////
EBR_Demo_sort := sort(distribute(EBR_Demo_seq,hash(FILE_NUMBER)),FILE_NUMBER,-process_date,local);
EBR_0010_Header_sort := sort(distribute(File_0010_Header_Base_Local,hash(FILE_NUMBER)),FILE_NUMBER,-process_date_last_seen,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Map to DIDREC layout to prepare for DIDing(Includes join to 0010_Header segment for address)
//////////////////////////////////////////////////////////////////////////////////////////////
didrec := 
record
	didville.Layout_Did_InBatch;
	unsigned6	did		:= 0;
	unsigned1	score	:= 0;
end;

didrec tGetAddressFrom0010_Header(EBR_Demo_sort L, Layout_0010_Header_Base R) := 
transform
	self.fname		:= l.clean_officer_name.fname;
	self.mname		:= l.clean_officer_name.mname;
	self.lname		:= l.clean_officer_name.lname;
	self.suffix		:= l.clean_officer_name.name_suffix;
	self.title		:= l.clean_officer_name.fname;
	self.prim_range	:= r.prim_range;
	self.predir		:= r.predir;
	self.prim_name		:= r.prim_name;
	self.addr_suffix	:= r.addr_suffix;
	self.postdir		:= r.postdir;
	self.unit_desig	:= r.unit_desig;
	self.sec_range		:= r.sec_range;
	self.p_city_name	:= r.p_city_name;
	self.st			:= r.st;
	self.z5			:= r.zip;
	self.zip4			:= r.zip4;
	self.phone10		:= r.PHONE_NUMBER;
	self.ssn			:= '';
	self.dob			:= '';
	self.seq			:= l.seq;
	self 			:= L;
end;

EBR_demo_did_rec:= join(EBR_Demo_sort,
                        EBR_0010_Header_sort,
				          left.FILE_NUMBER = right.FILE_NUMBER and
						(unsigned)left.process_date >= right.process_date_first_seen and
						(unsigned)left.process_date <= right.process_date_last_seen,
				          tGetAddressFrom0010_Header(left,right),
				          local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- DID the file using address and phone, dedup, grabbing highest score DID
//////////////////////////////////////////////////////////////////////////////////////////////
matchset := ['A','P'];

DID_Add.MAC_Match_Flex(EBR_demo_did_rec,matchset,
	junk,junk,fname,mname,lname,suffix,
	prim_range,prim_name,sec_range,z5,st,phone10,
	did,didrec,true,score, 
	75,DIDout)


DIDout_deduped := dedup(sort(distribute(DIDout,hash(seq)),seq,-score,did,local),seq,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match input file to DID file and grab DID
//////////////////////////////////////////////////////////////////////////////////////////////
layout_EBR_Demo_seq tJoinBack2InputFile(DIDout_deduped l,EBR_Demo_seq R) := 
transform
	self.did		:= l.did;
	self.did_score	:= l.score;
	self.ssn		:= 0;
	self			:= R;
end;
	
withdid := join(DIDout_deduped,EBR_Demo_seq,left.seq = right.seq,tJoinBack2InputFile(LEFT,RIGHT),right outer,local);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Match to Watchdog file to get SSN
//////////////////////////////////////////////////////////////////////////////////////////////
Layout_5610_Demographic_Data_Base getssn(File_Watchdog_Best L, withdid R) := 
transform
	self.ssn	:= (unsigned4)L.ssn;
	self 	:= R;
end;
Layout_5610_Demographic_Data_Base tback2baseformat(withdid l) := 
transform
	self 	:= l;
end;

withdid_sort	:= sort(distribute(withdid(did != 0),hash((integer)did)),did,local);
withoutdid		:= project(withdid(did = 0), tback2baseformat(left));

ssn_records	:= join(File_Watchdog_Best,withdid_sort,
					left.did = right.did,
					getssn(LEFT,RIGHT),
					right outer,local);

concatBase   := ssn_records + withoutdid;

addGlobalSID := mdr.macGetGlobalSID(concatBase,'EBR','','global_sid'); //DF-26349: Populate Global_SID Field

export DID_5610_Demographic_Data := distribute(addGlobalSID, hash(FILE_NUMBER))/*: persist(EBR_thor + 'TEMP::DID_' + dataset_name + '_' + segment_code + '_' + decode_segments(segment_code))*/;