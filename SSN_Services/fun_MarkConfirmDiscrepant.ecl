import doxie_raw, ut, doxie, ssn_services;

export fun_MarkConfirmDiscrepant
	(grouped dataset(doxie.layout_inBatchMaster) inputs,
	 grouped dataset(doxie_raw.Layout_HeaderRawBatchInput) heads,
	 boolean isConfirmBatch,
	 boolean isDiscrepantBatch) :=
FUNCTION

//**** Get the header info
outrec := layout_SSNBatchCD_wHead;

socc := ssn_services.str_outboundConfirmCode;
sodc := ssn_services.str_outboundDiscrepantCode;

outrec tra(inputs l, heads r) := transform

	lfname := l.name_first;
	lmname := l.name_middle;
	llname := l.name_last;
	
	rid := if(ut.NameMatch(lfname,lmname,llname, r.fname,r.mname,r.lname) <= 5 and
						l.prim_name = r.prim_name and
						l.prim_range = r.prim_range and
						l.z5 = r.zip,
						socc,
						sodc);

	self.acctno := l.acctno;
	self.RecordID := //4C is a match.  4B is no match.
		rid;
	
	self := r;
end;

j := join(inputs, heads, 
				  left.ssn = right.ssn,
					tra(left, right), many lookup)
			((isConfirmBatch and RecordID = socc) or (isDiscrepantBatch and RecordID = sodc));
	
//***** Get rid of dups
j Tra_Address_Rollup(j le, j ri) := transform
  self.dt_first_seen := if(ri.dt_first_seen = 0 or (le.dt_first_seen < ri.dt_first_seen and le.dt_first_seen>0),le.dt_first_seen,ri.dt_first_seen);
  self.dt_last_seen := if(le.dt_last_seen > ri.dt_last_seen, le.dt_last_seen, ri.dt_last_seen );
  self.sec_range := if ( length(trim(le.sec_range)) > length(trim(ri.sec_range)), le.sec_range, ri.sec_range );
  self := le;
  end;	

grpd := group(sort(j, /*acctno,*/ did), acctno,did);
srtd := sort(grpd,prim_range,prim_name,-sec_range,-predir,-zip4,-dt_last_seen,dt_first_seen,-phone,-listed_phone,-fname,-mname,-lname);
rld := rollup(srtd,left.prim_range=right.prim_range and
               ( 	left.prim_name=right.prim_name or
				right.zip4='' and 
				( ut.StringSimilar(left.prim_name,right.prim_name)<3 or
				length(trim(left.prim_range))>2 )
			)
			and ut.nneq(left.predir, right.predir), tra_address_rollup(left,right));
ddpd := group( dedup( sort( rld,-dt_last_seen, doxie.tnt_score(tnt), -dt_first_seen ), true, keep(50) ), acctno);


outfile_fat := if(isDiscrepantBatch, dedup(ddpd, acctno, keep(10)), dedup(ddpd, acctno, keep(1)));
	//only half of this will be populated
					
return outfile_fat;

END;