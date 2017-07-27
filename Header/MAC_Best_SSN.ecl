// No longer uses DPPA recs to calc. best SSN.  2/24/04 CJM.

export MAC_Best_SSN(infile, did_field, outfile,thresh='2') := macro

import ut;

#uniquename(rfields)
%rfields% := record
unsigned6    did_field;
qstring9     ssn;
unsigned4	 dob;
string1		 ssn_valid := 'Y';
string1		 old_ssn := 'N';
end;

//Slim down and set ssn_valid for 9 digit ssns that aren't 0 padded
#uniquename(slim)
%rfields% %slim%(infile l) := transform
self.ssn := intformat((integer)l.ssn,9,1);
self.ssn_valid := if(length(trim((string)l.ssn))=9 and ((unsigned)l.ssn div 1000000)>0,'Y','N');
self := l;
  end;

#uniquename(slim_h)
%slim_h% := project(infile(~mdr.Source_is_DPPA(src) and (integer)ssn>0),%slim%(left));

#uniquename(dis_infile)
%dis_infile% := distribute(%slim_h%,hash(did_field));

//Set Old_SSN flag for SSNs that were issued before birth
#uniquename(dob_rec)
#uniquename(min_dob)
%dob_rec% := record
	%dis_infile%.did_field;
	integer %min_dob% := min(group,(%dis_infile%.dob div 10000));
end;

#uniquename(best_dob)
%best_dob% := table(%dis_infile%(dob>18500000),%dob_rec%,did_field,local);

#uniquename(set_dob)
%rfields% %set_dob%(%rfields% L, %dob_rec% R) := transform
 self.dob := r.%min_dob%;
 self := l;
end;

#uniquename(with_dob)
%with_dob% := join(%dis_infile%,%best_dob%,left.did_field=right.did_field,%set_dob%(left,right),left outer, local);

//Compare with SSN Map file to get issue date

//TODO: why only year is compared?
#uniquename(get_old)
%rfields% %get_old%(%rfields% L, header.Layout_SSN_Map R) := transform

  // new ssn-issue data have '20990101' for the current date intervals
  r_end := IF (R.end_date='20990101', '', R.end_date[1..4]);
  end_date_int := (INTEGER) r_end;

  self.old_ssn := if ((end_date_int = 0) OR (l.dob <= end_date_int),
                      'N', 'Y');
  self := l;
end;

#uniquename(with_old)
%with_old% := join(%with_dob%, header.File_SSN_Map,
                   (Left.ssn[1..5] <> '') AND
                   (Left.ssn[1..5] = Right.ssn5) AND
                   (Left.ssn[6..9] between Right.start_serial and Right.end_serial), //between is inclusive
                   %get_old% (Left, Right),
                   LEFT OUTER, LOOKUP);

#uniquename(dis_again)
%dis_again% := distribute(%with_old%,hash(did_field));

//Count SSNs within a DID
#uniquename(cnt_table)
#uniquename(ssn_total)
%cnt_table% := record
 %dis_again%.did_field;
 %dis_again%.ssn;
 %dis_again%.ssn_valid;
 %dis_again%.old_ssn;
 %ssn_total% := count(group);
end;

#uniquename(cnt_ssns)
%cnt_ssns% := table(%dis_again%,%cnt_table%,did_field,ssn,ssn_valid,old_ssn,local);

#uniquename(val_ssn)
%val_ssn% := %cnt_ssns%(ssn_valid='Y');
#uniquename(inval_ssn)
%inval_ssn% := %cnt_ssns%(ssn_valid='N');

#uniquename(srt_inval)
%srt_inval% := sort(%inval_ssn%,did_field,((unsigned)ssn % 10000),local);

#uniquename(rollInval)
typeof(%srt_inval%) %rollInval%(%srt_inval% l, %srt_inval% r) := transform
 self.%ssn_total% := l.%ssn_total% + r.%ssn_total%;
 self := l;
end;

#uniquename(inval_roll)
%inval_roll% := rollup(%inval_ssn%,left.did_field=right.did_field and ((unsigned)left.ssn % 10000)=((unsigned)right.ssn % 10000),%rollInval%(left,right),local);


//Join valids to invalids to count 4 digits in with respective 9 digits
#uniquename(addInval)
%cnt_table% %addinval%(%cnt_table% L, %cnt_table% R) := transform
 self.%ssn_total% := l.%ssn_total% + r.%ssn_total%;
 self := l;
end;

#uniquename(withInval)
%withInval% := join(%val_ssn%,%inval_roll%,left.did_field=right.did_field and 
						((unsigned)left.ssn % 10000)=((unsigned)right.ssn % 10000),%addInval%(left,right),left outer,local);
#uniquename(rm_matches)
%cnt_table% %rm_matches%(%cnt_table% L, %cnt_table% R) := transform
 self := l;
end;

//Find SSN that are ONLY invalid (not matching 9 digit number)
#uniquename(ex_inval)
%ex_inval% := join(%inval_ssn%,%val_ssn%,left.did_field=right.did_field and 
								((unsigned)left.ssn % 10000)=((unsigned)right.ssn % 10000),%rm_matches%(left,right),left only,local); 

#uniquename(allRecs)
%allRecs% := %withInval% + %ex_inval%;

//Ungroup and resort
#uniquename(group_sort)
%group_sort% := sort(distribute(%allRecs%,hash(did_field)),did_field,-%ssn_total%,old_ssn,local);

//Dedup by DID keeping the top two most frequent
#uniquename(two_DID)
%two_DID% := dedup(%group_sort%,did_field,keep 2,local);

//If SSN count is 2x greater than the next and it is valid, it is 'best'
#uniquename(ssn_join)
%cnt_table% %ssn_join%(%cnt_table% le, %cnt_table% rt) := transform
self.ssn := map(le.ssn_valid='N'=> '',
				le.%ssn_total% > (real8)thresh*rt.%ssn_total% => le.ssn,
				le.old_ssn='N' and rt.old_ssn='Y' and
				le.%ssn_total% >= rt.%ssn_total% => le.ssn,'');
self := le;
end;

#uniquename(join_cnt)
%join_cnt% := join(%two_DID%,%two_DID%,left.did_field=right.did_field and
					left.ssn <> right.ssn,%ssn_join%(left,right),left outer,local);				

//output only the 'best' ssn records (at most one per DID)
outfile := %join_cnt%(ssn <> '');

endmacro;