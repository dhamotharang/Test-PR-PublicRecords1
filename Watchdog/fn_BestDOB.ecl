import ut,header;

export fn_BestDOB(dataset(recordof(header.layout_header)) infile) := FUNCTION

	// constants, layouts
	thresh := 1.5;
	max_srcs := 1500;
	l_core := record
		unsigned6	did;
		unsigned4	dob;
		integer		dob_quality	:= 0;
		unsigned	dob_total		:= 1;
	end;
	l_src := {infile.src};
	l_slim := record(l_core)
		dataset(l_src) srcs {maxcount(max_srcs)};
	end;
	l_norm := record(l_core)
		infile.src;
	end;
	l_out := record(l_core)
		unsigned	dob_src_cnt;
		// unsigned4	alt_dob;		// alt values are useful for analysis, but not needed in prod
		// unsigned 	alt_total;
		// unsigned 	alt_src_cnt;
	end;

	// slim down, get the dob_field's quality score (0, 2, 4 or 6)
	//   quality=6 => known year, month, and day
	//   quality=4 => known year and month
	//   quality=2 => known year
	sel:=['SL','LW','E4','XV','+E'];
	l_slim slim(infile L) := transform
		dq := ut.mod_date_quality(L.dob,if(l.src not in sel,false,true));
		self.dob_quality	:= if(dq.quality>0,dq.quality,skip);
		self.dob					:= dq.normDate;
		self.srcs					:= dataset([{L.src}], l_src);
		self							:= L;
	end;
	slim_h := project(infile(did<>0,dob<>0),slim(left));
	
	// distribute, group(same did, dob and quality) and sort
	dis_infile := distribute(slim_h,hash(did));
	
	// count DOBs within a DID
	l_slim toCnt(l_slim L, l_slim R) := transform
		self.srcs				:= L.srcs+R.srcs;
		self.dob_total	:= L.dob_total + R.dob_total;
		self						:= L;
	end;
	cnt_dobs := rollup(sort(dis_infile,did,dob,local), toCnt(left,right), did, dob, local);
	
	// add count number of quality 2 dob to qaulity 4, 6 of the same type			
	high_quality_2(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) := 
		(lqlt=4 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
		(lqlt=4 and rqlt=2 and rdob % 10000 = 0 and ((ldob div 10000)+1 = rdob div 10000)) or
		(lqlt=6 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
		(lqlt=6 and rqlt=2 and rdob % 10000 = 0 and ((ldob div 10000)+1 = rdob div 10000));
	join_dobs_2 := join(
		cnt_dobs, cnt_dobs(dob_quality>=0), // NOTE: This should be a self-join, when fully supported by thor
		left.did=right.did and high_quality_2(left.dob,right.dob,left.dob_quality,right.dob_quality),
		toCnt(left,right),
		left outer, local);
	
	// add count number of quality 4 dob to quality 6 of the same type	
	high_quality_4(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) := 		
		(lqlt=6 and rqlt=4 and (ldob div 100 = rdob div 100)); 
	join_dobs_4 := join(
		join_dobs_2, cnt_dobs,
		left.did=right.did and high_quality_4(left.dob,right.dob,left.dob_quality,right.dob_quality),
		toCnt(left,right),
		left outer, local);
	
	// Remove lower-quality dobs whose counts have been incorporated into higher-quality counterparts
	high_quality_all(unsigned4 ldob, unsigned4 rdob, integer lqlt, integer rqlt) := 
		(lqlt=4 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
		(lqlt=4 and rqlt=2 and rdob % 10000 = 0 and ((ldob div 10000)+1 = rdob div 10000)) or
		(lqlt=6 and rqlt=2 and (ldob div 10000 = rdob div 10000)) or
		(lqlt=6 and rqlt=2 and rdob % 10000 = 0 and ((ldob div 10000)+1 = rdob div 10000)) or
		(lqlt=6 and rqlt=4 and (ldob div 100 = rdob div 100));
	rm_dups := dedup(
		sort(join_dobs_4,did,-dob_quality,-dob_total,local),
		did, high_quality_all(left.dob,right.dob,left.dob_quality,right.dob_quality),
		local);
	
	// count unique sources
	norm	 := normalize(rm_dups, left.srcs, transform(l_norm,self:=left,self:=right));
	norm_d := dedup(norm,all,hash,local);
	norm_t := table(norm_d,
		{did, dob, dob_quality, dob_total,unsigned dob_src_cnt:=count(group)},
		did, dob, dob_quality, dob_total,
		many, unsorted, local);
	
	// reduce to 2 dobs per did
	group_sort := sort(norm_t,did,-dob_src_cnt,-dob_total,local);
	two_did := dedup(group_sort,did,keep 2,local);
	
	// check if the larger count > thresh * smaller count
	// if true, keep the larger count, other wise both will be removed, no best dob
	l_out dob_join(two_did L, two_did R) := transform
		isWinner	:= L.dob_src_cnt>=(thresh*R.dob_src_cnt) or L.dob_total>=(thresh*R.dob_total);
		common		:= map(
			L.dob DIV 100 = R.dob DIV 100			=> (L.dob DIV 100) * 100,			// YYYYMM00
			L.dob DIV 10000 = R.dob DIV 10000	=> (L.dob DIV 10000) * 10000,	// YYYY0000
			0);
		self.did					:= L.did;
		self.dob					:= if(isWinner, L.dob,					if(common<>0,common,skip));
		self.dob_quality	:= if(isWinner, L.dob_quality,	ut.mod_date_quality(common).quality);
		self.dob_total		:= if(isWinner, L.dob_total,		L.dob_total+R.dob_total);
		self.dob_src_cnt	:= if(isWinner, L.dob_src_cnt,	ut.max2(L.dob_src_cnt,R.dob_src_cnt)); // common isn't really additive here, but close enough
		// self.alt_dob			:= R.dob;						// alt values are useful for analysis, but not needed in prod
		// self.alt_total		:= R.dob_total;
		// self.alt_src_cnt	:= R.dob_src_cnt;
	end;
	join_cnt := join(
		two_did, two_did(dob_quality>=0), // NOTE: This should be a self-join, when fully supported by thor
		left.did=right.did and left.dob<>right.dob,
		dob_join(left,right),
		left outer, local);
	
	// final cleanup
	outfile := dedup(join_cnt(dob <> 0),did,local);
	
	// debugging
	// output(slim_h, 			named('slim_h'));
	// output(cnt_dobs, 		named('cnt_dobs'));
	// output(roll_dobs,		named('roll_dobs'));
	// output(join_dobs_2,	named('join_dobs_2'));
	// output(join_dobs_4,	named('join_dobs_4'));
	// output(rm_dups,			named('rm_dups'));
	// output(norm_t,				named('norm_t'));
	// output(two_did,			named('two_did'));
	// output(join_cnt, 		named('join_cnt'));
	// output(outfile,			named('outfile'));
	
	// stats
	// cnt_dids := count(table(infile(did<>0,dob<>0),{did},did,many,unsorted,local));
	// cnt_best := count(outfile);
	// output(cnt_dids, named('cnt_dids'));
	// output(cnt_best, named('cnt_best'));
	
	return outfile;

end;