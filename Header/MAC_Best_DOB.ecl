//get the best dob of a given did, the input file is required to have:  
//unsigned6 did_field, unsigned4 dob_field;

export mac_best_dob(infile,did_field,dob_field,outfile,thresh='1.5') := macro

#uniquename(rfields)
%rfields% := record
	unsigned6    did;
	unsigned4	   dob;
	integer      dob_quality := 0;    //dob's quality score
end;

//slim down, get the dob_field's quality score(0, 2, 4 or 6)
#uniquename(slim)
%rfields% %slim%(infile l) := transform
     self.did := l.did_field;
     self.dob := l.dob_field;
     self.dob_quality :=	(ut.date_quality(l.dob_field) div 2) * 2;	
end;

#uniquename(slim_h)
%slim_h% := project(infile,%slim%(left));

//distribute, group(same did, dob and quality) and sort
#uniquename(dis_infile)
%dis_infile% := distribute(%slim_h%,hash(did_field));

#uniquename(cnt_table)
#uniquename(dob_total)
%cnt_table% := record
	%dis_infile%.did;
	%dis_infile%.dob;
	%dis_infile%.dob_quality;
	%dob_total% := count(group);
end;

//count DOBs within a DID
#uniquename(cnt_dobs)
#uniquename(srt_dobs)

%cnt_dobs% := table(%dis_infile%(%dis_infile%.dob_quality > 0),%cnt_table%,did,dob,dob_quality,local);
%srt_dobs% := sort(%cnt_dobs%,did,dob_quality,-dob,local);

//count total number of dobs of same the 'type':
//quality = 2, same dob year 
//quality = 4, same dob year and month
//quality = 6. same dob year, month and day
#uniquename(same_quality)
boolean %same_quality%(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) :=
                      (lqlt=2 and rqlt=2 and (ldob div 10000)=(rdob div 10000)) or
			       (lqlt=4 and rqlt=4 and (ldob div 100)=(rdob div 100)) or
			       (lqlt=6 and rqlt=6 and ldob=rdob);

#uniquename(add_quality)
#uniquename(roll_dobs)
typeof(%srt_dobs%) %add_quality%(%srt_dobs% l, %srt_dobs% r) := transform
	self.%dob_total% := l.%dob_total% + r.%dob_total%;
	self := l;
end;

%roll_dobs% := rollup(%srt_dobs%,
                      left.did=right.did and 
			       %same_quality%(left.dob,right.dob,left.dob_quality,right.dob_quality),
	                 %add_quality%(left,right),local);

//add count number of quality 2 dob to qaulity 4, 6 of the same type			
#uniquename(high_quality_2)
#uniquename(join_dobs_2)
%high_quality_2%(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) := 
                (lqlt=4 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
		      (lqlt=6 and rqlt=2 and (ldob div 10000 = rdob div 10000));
	
%join_dobs_2% := join(%roll_dobs%,%roll_dobs%,
                      left.did=right.did and 
   			       %high_quality_2%(left.dob, right.dob, left.dob_quality, right.dob_quality), 
  			       %add_quality%(left,right),left outer,local); 

//add count number of quality 4 dob to quality 6 of the same type	
#uniquename(high_quality_4)				  
#uniquename(join_dobs_4)
%high_quality_4%(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) := 		
   	           (lqlt=6 and rqlt=4 and (ldob div 100 = rdob div 100)); 

%join_dobs_4% := join(%join_dobs_2%,%roll_dobs%,
                      left.did=right.did and 
   			       %high_quality_4%(left.dob, right.dob, left.dob_quality, right.dob_quality), 
  			       %add_quality%(left,right),left outer,local); 

//Remove dobs that are of lower quality
#uniquename(high_quality_all)
#uniquename(rm_dups)
%high_quality_all%(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) := 
                (lqlt=4 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
		      (lqlt=6 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
			 (lqlt=6 and rqlt=4 and (ldob div 100 = rdob div 100));

%rm_dups% := dedup(sort(%join_dobs_4%,did,-dob,local),did,%high_quality_all%(left.dob,right.dob,left.dob_quality,right.dob_quality),local);
				  
//reduce to 2 dobs per did, and check if the larger count > thresh * smaller count
//if true, keep the larger count, other wise both will be removed, no best dob
#uniquename(group_sort)
%group_sort% := sort(%rm_dups%,did,-%dob_total%,local);

#uniquename(two_did)
%two_did% := dedup(%group_sort%,did,keep 2,local);

#uniquename(dob_join) 
typeof(%two_did%) %dob_join%(%two_did% l, %two_did% r) := transform
	self.dob := if(l.%dob_total% > (real8)thresh*r.%dob_total%,l.dob,0);
	self := l;
end;

#uniquename(join_cnt)
%join_cnt% := join(%two_did%, %two_did%, 
                   left.did=right.did and left.dob<>right.dob,
			    %dob_join%(left,right), left outer, local);
			    
outfile := %join_cnt%(dob <> 0);

endmacro;