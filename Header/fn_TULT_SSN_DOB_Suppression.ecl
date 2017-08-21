import mdr, ut, header_slimsort, did_add, didville, _control,USPS_AIS,Transunion_PTrak;
// objective:
// TU / LT records Â– to help with ambiguity caused by known bad DOBÂ’s and SSNÂ’s, only include for those
// records that have matching records with that information; otherwise, blank fields.

// (pass everything to the slimsorts then, after adl is assigned, perform the
// above.)

export fn_TULT_SSN_DOB_suppression(dataset(layout_header) TULT_file)	:= function

	d:=distribute(header.file_headers + TULT_file,hash(did)) :independent;
	SetTU := ['TS','TN','TU','LT'];
	ssn_t1:=table(d(ssn<>''),{
								did
								,ssn
								,ssn_in_other:=src not in SetTU
								},local);
	ssn_t2:=table(ssn_t1,{
								did
								,ssn
								,in_other:=max(group,ssn_in_other)
								},did,ssn,few,local);
	ssn_t3:=table(ssn_t2,{
								did
								,other_cnt:=sum(group,if(in_other,1,0))
								,cnt:=count(group)
								},did,few,local);

	ssn_diff_TU := ssn_t3(cnt>other_cnt and other_cnt>0);

	TULT_recs0:=distribute(TULT_file,hash(did));

	TULT_recs1:=join(TULT_recs0,ssn_diff_TU
						,	left.did=right.did
						,transform(layout_header
							,self.ssn:=if(left.did=right.did,'',left.ssn)
							,self:=left)
						,left outer
						,local);

	dob_t1:=table(d(dob>0),{
								did
								,dob_:=(unsigned)((string)dob)[1..4]
								,dob_in_other:=src not in SetTU
								},local);
	dob_t2:=table(dob_t1,{
								did
								,dob_
								,in_other:=max(group,dob_in_other)
								},did,dob_,few,local);
	dob_t3:=table(dob_t2,{
								did
								,other_cnt:=sum(group,if(in_other,1,0))
								,cnt:=count(group)
								},did,few,local);

	dob_diff_TU := dob_t3(cnt>other_cnt and other_cnt>0);

	TULT_recs:=join(TULT_recs1,dob_diff_TU
						,	left.did=right.did
						,transform(layout_header
							,self.dob:=if(left.did=right.did,0,left.dob)
							,self:=left)
						,left outer
						,local);

	return TULT_recs;
end;