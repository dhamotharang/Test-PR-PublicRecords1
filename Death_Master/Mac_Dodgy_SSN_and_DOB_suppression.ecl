// this macro take an input header/imput base source and clears ssn and/or dob from the input source if it
// conflicts with the ssn and/or dob from the input header in the same cluster
// if the imput header has atleast on ssn and/or dob.

EXPORT Mac_Dodgy_SSN_and_DOB_suppression(inHeader,inSrcFile, DodgySrc, ofile)	:= MACRO

	#uniquename(h)
	%h%:=table(inHeader(dob>0 or ssn<>''),{did,src,ssn,dob});
	#uniquename(i)
	%i%:=table(inSrcFile(dob>0 or ssn<>''),{did,src,ssn,dob});
	#uniquename(d)
	%d%:=distribute(%h% + %i%,hash(did));
	#uniquename(ssn_t1)
	%ssn_t1%:=table(%d%(ssn<>''),{
								did
								,ssn
								,ssn_in_other:=src not in DodgySrc
								},local);
	#uniquename(ssn_t2)
	%ssn_t2%:=table(%ssn_t1%,{
								did
								,ssn
								,in_other:=max(group,ssn_in_other)
								},did,ssn,few,local);
	#uniquename(ssn_t3)
	%ssn_t3%:=table(%ssn_t2%,{
								did
								,other_cnt:=sum(group,if(in_other,1,0))
								,cnt:=count(group)
								},did,few,local);

	#uniquename(DodgySSN)
	%DodgySSN% := %ssn_t3%(cnt>other_cnt and other_cnt>0);

	#uniquename(inSrcFile_dis)
	%inSrcFile_dis%:=distribute(inSrcFile,hash(did));

	#uniquename(ofile0)
	%ofile0%:=join(%inSrcFile_dis%,%DodgySSN%
						,	left.did=right.did
						,transform({inSrcFile}
							,self.ssn:=if(left.did=right.did,'',left.ssn)
							,self:=left)
						,left outer
						,local);

	#uniquename(dob_t1)
	%dob_t1%:=table(%d%(dob>0),{
								did
								,dob_:=(unsigned)dob[1..4]
								,dob_in_other:=src not in DodgySrc
								},local);
	#uniquename(dob_t2)
	%dob_t2%:=table(%dob_t1%,{
								did
								,dob_
								,in_other:=max(group,dob_in_other)
								},did,dob_,few,local);
	#uniquename(dob_t3)
	%dob_t3%:=table(%dob_t2%,{
								did
								,other_cnt:=sum(group,if(in_other,1,0))
								,cnt:=count(group)
								},did,few,local);

	#uniquename(DodgyDOB)
	%DodgyDOB% := %dob_t3%(cnt>other_cnt and other_cnt>0);

	#uniquename(ofile1)
	%ofile1%:=join(%ofile0%,%DodgyDOB%
						,	left.did=right.did
						,transform({inSrcFile}
							,self.dob:=if(left.did=right.did,0,left.dob)
							,self:=left)
						,left outer
						,local);

	ofile:=%ofile1%;
endMacro;