//rule - a) ADL has both a death record and a non-deadth record with a confirmed SSN(jflag3=C)
//       b) said pair has different SSN and other disparities
import ut,mdr;
export fn_FindDodgyDead_and_alive(dataset(header.Layout_Header) hdr_in) := function

threshld:=-1;

hh:=hdr_in(trim(ssn)<>'' and (MDR.sourceTools.SourceIsDeath(src) or jflag3='C'));
t0:=table(hh,{	did
				,rid
				,src
				,ssn
				,dob
				,fname
				,mname
				,lname
				,name_suffix
				,ind:=if(MDR.sourceTools.SourceIsDeath(src),'D','C')});

t1:=dedup(sort(distribute(t0,hash(did)),did,rid,ssn,ind,local),did,ssn,ind,all,local);

t2:=t1(ind='D');
t3:=t1(ind='C');

genderDiff(string l, string r) :=
	(datalib.gender(trim(l))='M' and datalib.gender(trim(r))='F') or
	(datalib.gender(trim(r))='M' and datalib.gender(trim(l))='F');

j:=join(t2,t3
			,	left.did=right.did
			and	header.ssn_value(left.ssn,right.ssn)<0
			,transform({t1.did
						,recordof(t2)-[did] left_
						,recordof(t3)-[did] right_
						,integer date_value
						,integer suffix_value
						,integer genderDiff
						,integer NameMatch
						,integer score}
							,self.did:=left.did
							,self.left_:=left
							,self.right_:=right
							,self.date_value	:=header.date_value(left.dob,right.dob)
							,self.suffix_value	:=header.suffix_value(left.name_suffix,right.name_suffix)
							,self.genderDiff	:=-if((genderDiff(left.fname, right.fname)), 2, 0)
							,self.NameMatch		:=-ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)
							,self.score:=	header.date_value(left.dob,right.dob)
										+	header.suffix_value(left.name_suffix,right.name_suffix)
										-	if((genderDiff(left.fname, right.fname)), 2, 0)
										-	ut.NameMatch(left.fname,left.mname,left.lname,right.fname,right.mname,right.lname)
								)
			,local
			)(score < threshld);

dead_alive:=dedup(sort(j,did,score,left_.rid,local),did,local);

return dead_alive;

end;