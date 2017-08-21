import ut, Business_Header, Business_Header_SS, did_add;

EBR_Header_in := File_Header_In;

//////////////////////////////////////////////////////////////////////////////////////////////
// -- Add Sequence Number and Vendor Id
//////////////////////////////////////////////////////////////////////////////////////////////
layout_EBR_Header_temp := 
record
	unsigned4 seq;
	qstring34 vendor_id;
	EBR_Header_in;
end;

layout_EBR_Header_temp AddSeqNum(EBR_Header_in l, unsigned4 cnt) := 
transform
	self.seq 		:= cnt;
	self.vendor_id := L.FILE_NUMBER;
	self 		:= l;
end;

EBR_Header_seq := project(EBR_Header_in, AddSeqNum(left, counter));

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
	EBR_Header_seq.z5;
	EBR_Header_seq.PHONE_NUMBER;
	EBR_Header_seq.FILE_NUMBER;
end;

EBR_Header_to_bdid := table(EBR_Header_seq, layout_EBR_Header_bdid);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records First Pass
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header.MAC_Source_Match_BIPAlpha(EBR_Header_to_bdid, EBR_Header_bdid_init,
                        false, bdid,
                        false, 'EB',
                        true,  FILE_NUMBER,
                        company_name,prim_range, prim_name, sec_range, z5,
                        true,  PHONE_NUMBER,
                        false, fein_field,
				    true,  vendor_id);


BDID_Matchset 			:= ['A','P'];
EBR_Header_bdid_match 	:= EBR_Header_bdid_init(bdid <> 0);
EBR_Header_bdid_nomatch 	:= EBR_Header_bdid_init(bdid = 0);

//////////////////////////////////////////////////////////////////////////////////////////////
// -- BDID records Second Pass on address and phone
//////////////////////////////////////////////////////////////////////////////////////////////
Business_Header_SS.MAC_Add_BDID_FLEX_BIPAlpha(EBR_Header_bdid_nomatch,
                                  BDID_Matchset,
                                  company_name,
                                  prim_range, prim_name, z5,
                                  sec_range, st,
                                  PHONE_NUMBER, fein_field,
                                  bdid, layout_EBR_Header_bdid,
                                  false, BDID_score_field,
                                  EBR_Header_bdid_rematch)

EBR_Header_bdid_all := EBR_Header_bdid_match + EBR_Header_bdid_rematch;
					
//////////////////////////////////////////////////////////////////////////////////////////////
// -- Join back to input file and append BDIDs to create base file
//////////////////////////////////////////////////////////////////////////////////////////////
EBR_Header_bdid_append := join(EBR_Header_seq,
                          EBR_Header_bdid_all,
				          left.seq = right.seq,
				          transform(Layout_Header_Base, self.bdid := right.bdid, self := left),
				          left outer,
				          hash);

export BDID_Header := EBR_Header_bdid_append : persist(EBR_thor + 'TEMP::BDID_' + dataset_name + '_Header');
