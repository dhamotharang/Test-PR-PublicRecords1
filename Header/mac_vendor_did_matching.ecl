export mac_vendor_did_matching(infile, dataset_, DoPersist=false,
                               did_field, fname_field, mname_field, lname_field, suffix_field,
							   vendor_id, use_mname, use_suffix, vendor_confidence_score=0,
							   pf_value=0, outfile) := macro

#uniquename(threshld)
%threshld% := 2;
#uniquename(did_match_rec)
%did_match_rec% := record
 
 unsigned6 did         := did_field;
 string20  fname       := fname_field;
 string20  mname       := if(use_mname='true',mname_field,'');
 string20  lname       := lname_field;
 string5   name_suffix := if(use_suffix='true',suffix_field,'');
 string30  derived_id  := vendor_id;
 qstring9  ssn         := '';
 qstring8  dob         := '';

end;

#uniquename(unique_t1)
%unique_t1% := table(infile((integer)did_field<>0 and length(trim((string)vendor_id))>2),%did_match_rec%);

#uniquename(unique_nodup)
ut.MAC_Remove_Withdups(%unique_t1%,derived_id,20,%unique_nodup%);

#uniquename(unique_vendor_dist)
%unique_vendor_dist% := distribute(%unique_nodup%,hash(did));

#uniquename(t_add_dob_ssn)
%did_match_rec% %t_add_dob_ssn%(%did_match_rec% le, watchdog.layout_best ri) := transform
 self.ssn := ri.ssn;
 self.dob := if(ri.dob=0,'',(qstring8)ri.dob);
 self     := le;
end;

#uniquename(unique_best_vendor)
%unique_best_vendor% := join(%unique_vendor_dist%,watchdog.file_best,
                      left.did=right.did,
					  %t_add_dob_ssn%(left,right),
					  left outer,
					  local
					 );

// Find possible DID matches
#uniquename(t_match_dids)
{header.layout_pairmatch, integer score:=0}
 %t_match_dids%(%did_match_rec% le, %did_match_rec% ri) := transform
 self.old_rid	:= if(le.did < ri.did, ri.did, le.did);
 self.new_rid	:= if(le.did > ri.did, ri.did, le.did);
 self.pflag		:= pf_value;

 match1			:= header.SSN_Match_Score(le.ssn,ri.ssn);
 
 dob_score		:= did_add.DOB_Match_Score((integer)le.dob,(integer)ri.dob);
 match2			:= if(dob_score=255,0,(integer)(dob_score/10));
 
 match3			:= ut.namematch(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname) * -1;
 
 match4			:= if(		le.fname=ri.fname and length(trim(le.fname))>0
						and le.mname=ri.mname and length(trim(le.mname))>0
						and le.lname=ri.lname and length(trim(le.lname))>0,2,0);

 match6			:= if(		le.fname=ri.fname and length(trim(le.fname))>0
						and le.mname <> ri.mname and le.mname[1]=ri.mname[1]
						and le.lname=ri.lname and length(trim(le.lname))>0,2,0);

 match7			:= vendor_confidence_score;

 self.score		:=	 match1
					+match2
					+match3
					+match4
					+match6
					+match7;

end;

#uniquename(unique_dist)
%unique_dist% := distribute(%unique_best_vendor%,hash(derived_id));

#uniquename(unique_j)
%unique_j% := JOIN(%unique_dist%, %unique_dist%
					,		left.did	!=	right.did
					and	left.derived_id	 =	right.derived_id
					and	ut.nneq_suffix(left.name_suffix, right.name_suffix)
					and	ut.nneq_int   (left.dob,         right.dob)
					and	ut.nneq_ssn   (left.ssn,         right.ssn)
					,%t_match_dids%(left, right)
					,local);

#uniquename(unique_ddp)
%unique_ddp% := dedup(%unique_j%, old_rid, new_rid, all);

#uniquename(noPoutfile)
%noPoutfile%	:= project(%unique_ddp%(score>=%threshld%), transform(Header.Layout_PairMatch, self := left) );
#uniquename(Poutfile)
%Poutfile%	:= %noPoutfile% : persist('persist::'+dataset_+'_did_matches');

outfile:=if(DoPersist,%Poutfile%,%noPoutfile%);
endmacro;