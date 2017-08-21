export mac_edit_distance_pairs(infile,infield,countfield,thresh,phonetics,outfile) := MACRO
  #uniquename(p_cnt_r)
	%p_cnt_r% := record
	  string10 mtp := metaphonelib.dmetaphone1(infile.infield);
		infile.countfield;
	  end;
	#uniquename(p_cnt_t)
	%p_cnt_t% := table(infile,%p_cnt_r%);
  #uniquename(p_cnt_rt)
	%p_cnt_rt% := record
	  %p_cnt_t%.mtp;
		unsigned6 cnt := sum(group,%p_cnt_t%.countfield);
	  end;
	#uniquename(p_cnt_tt)
	%p_cnt_tt% := table(%p_cnt_t%,%p_cnt_rt%,mtp,few);
	
	#uniquename(rhs_r)
	%rhs_r% := record
	  infile.infield;
		infile.countfield;
		integer2 rl := length(trim(infile.infield));
		end;
	#uniquename(rhs_t0)
	%rhs_t0% := table(infile,%rhs_r%);
	
	#uniquename(b_cand)
	%rhs_r% %b_cand%(%rhs_r% le,unsigned1 c) := transform
	self.rl := le.rl - thresh * 2 + c - 1; // Computing candidate length to match to
	self := le;
	end;
	
	#uniquename(rhs)
	%rhs% := normalize( %rhs_t0%, thresh * 2 + 1, %b_cand%(left,counter))(rl>0); // Produces (thres*2+1) records for each incoming
	
	#uniquename(matchrec)
	%matchrec% := record
	  typeof(infile.infield) id1;
		typeof(infile.countfield) count1;
		typeof(infile.infield) id2;
		typeof(infile.countfield) count2;
		unsigned1       distance;
		boolean         phonetic;
	  end;
		
	#uniquename(trans)
	%matchrec% %trans%(infile le,infile ri) := transform
	  self.id1 := le.infield;
		self.id2 := ri.infield;
		self.count1 := le.countfield;
		self.count2 := ri.countfield;
		self.distance := ut.StringSimilar(le.infield,ri.infield);
		self.phonetic := phonetics and metaphonelib.dmetaphone1(le.infield) = metaphonelib.dmetaphone1(ri.infield);
	  end;	
		
	#uniquename(trans1)
	%matchrec% %trans1%(infile le,%rhs_r% ri) := transform
	  self.id1 := le.infield;
		self.id2 := ri.infield;
		self.count1 := le.countfield;
		self.count2 := ri.countfield;
		self.distance := ut.StringSimilar(le.infield,ri.infield);
		self.phonetic := phonetics and metaphonelib.dmetaphone1(le.infield) = metaphonelib.dmetaphone1(ri.infield);
	  end;	
		// An error of 1 place in a 4 char document counts as a 2.5; given our lowest threshold is 2 this means
		// the lowest 'hit' will be a 5 char document with one error. Thus we can assert that at least 4 chars will always be fixed ...
		// the below would miss a 2 on a word where it was the two ends .... such is life ....
	// Use the 4 fixed places for strings <= 7	
	#uniquename(inf7)
	%inf7% := infile(thresh>0,length(trim(infield))<=7);
	#uniquename(j1)
	%j1% := join(%inf7%,%inf7%,left.infield[1..4]=right.infield[1..4] and  ut.WithinEditN(left.infield,right.infield,thresh),%trans%(left,right));
	#uniquename(j2)
	%j2% := join(%inf7%,%inf7%,left.infield[1..3]=right.infield[1..3] and left.infield[length(trim(left.infield))] = right.infield[length(trim(right.infield))] and ut.WithinEditN(left.infield,right.infield,thresh),%trans%(left,right));
	#uniquename(j6)
	%j6% := join(%inf7%,%inf7%,left.infield[1..2]=right.infield[1..2] and left.infield[length(trim(left.infield))-1..] = right.infield[length(trim(right.infield))-1..] and ut.WithinEditN(left.infield,right.infield,thresh),%trans%(left,right));
	#uniquename(j3)
	%j3% := join(%inf7%,%inf7%,left.infield[1]=right.infield[1] and left.infield[length(trim(left.infield))-2..] = right.infield[length(trim(right.infield))-2..] and ut.WithinEditN(left.infield,right.infield,thresh),%trans%(left,right));
	#uniquename(j4)
	%j4% := join(%inf7%,%inf7%,left.infield[length(trim(left.infield))-3..] = right.infield[length(trim(right.infield))-3..] and ut.WithinEditN(left.infield,right.infield,thresh),%trans%(left,right));
	#uniquename(j5)
	%j5% := join(infile(phonetics),infile(phonetics),metaphonelib.DMetaPhone1(left.infield) = metaphonelib.DMetaPhone1(right.infield),%trans%(left,right));
	// Use 5 fixed places for rest
	#uniquename(inf8p)
	%inf8p% := infile(thresh>0,length(trim(infield))>=6);
	#uniquename(j9)
	%j9% := join(%inf8p%,%rhs%,length(trim(left.infield))=right.rl and left.infield[1..5]=right.infield[1..5] and  ut.WithinEditN(left.infield,right.infield,thresh),%trans1%(left,right),hash);
	#uniquename(j7)
	%j7% := join(%inf8p%,%rhs%,length(trim(left.infield))=right.rl and left.infield[1..2]=right.infield[1..2] and left.infield[length(trim(left.infield))-2..] = right.infield[length(trim(right.infield))-2..] and ut.WithinEditN(left.infield,right.infield,thresh),%trans1%(left,right),hash);
	#uniquename(j8)
	%j8% := join(%inf8p%,%rhs%,length(trim(left.infield))=right.rl and left.infield[length(trim(left.infield))-4..] = right.infield[length(trim(right.infield))-4..] and ut.WithinEditN(left.infield,right.infield,thresh),%trans1%(left,right),hash);
	
	#uniquename(aj)
	%aj% := dedup( sort( %j1%+%j2%+%j3%+%J4%+%J6%+%J9%+%j7%+%j8%, whole record, skew(1) ), whole record );
//	%aj% := dedup( sort( %j1%+%j2%+%j3%+%J4%+%J5%+%J6%+%J9%+%j7%+%j8%, whole record, skew(1) ), whole record );
	
#uniquename(r1)
%r1% := record
  %aj%.id1;
	unsigned6 all_cnt := sum(group,%aj%.count2);
	unsigned6 e1_cnt := sum(group,if(%aj%.distance<=1,%aj%.count2,0));
	unsigned6 e2_cnt := sum(group,if(%aj%.distance<=2,%aj%.count2,0));
	unsigned6 e1p_cnt := sum(group,if(%aj%.distance<=1 and %aj%.phonetic,%aj%.count2,0));
	unsigned6 e2p_cnt := sum(group,if(%aj%.distance<=2 and %aj%.phonetic,%aj%.count2,0));
	unsigned6 p_cnt := sum(group,if(%aj%.phonetic,%aj%.count2,0));
  end;
#uniquename(t)
%t% := table(%aj%,%r1%,id1,few);	
#uniquename(oform)
// Slim things down to help the match_candidates
%oform% := record
  infile;
	unsigned6 all_cnt;
	#if (thresh>0)
	unsigned6 e1_cnt;
	unsigned6 e2_cnt;
	#if (phonetics)
	unsigned6 e1p_cnt;
	unsigned6 e2p_cnt;
	#end
	#end
	#if (phonetics)
	unsigned6 p_cnt;
	#end
  end;
#uniquename(take_vals)
%oform% %take_vals%(infile le, %t% ri) := transform
  self := le;
	self := ri;
  end;
	
#uniquename(j)
%j% := join(infile,%t%,left.infield=right.id1,%take_vals%(left,right));
#if (phonetics )
#uniquename(add_ponly)
typeof(%j%) %add_ponly%(%j% le,%p_cnt_tt% ri) := transform
  self.p_cnt := ri.cnt;
  self := le;
  end;
	
	outfile := join(%j%,%p_cnt_tt%,metaphonelib.DMetaPhone1(left.infield)=right.mtp,%add_ponly%(left,right),lookup,left outer);
#else
	outfile := %j%;
#end
	
  ENDMACRO;