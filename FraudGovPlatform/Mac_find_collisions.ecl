EXPORT Mac_find_collisions
	(
	infile
	,matchset
	,priority_
	,fname_field = 'fname'
	,lname_field = 'lname'
	,name_suffix_field = 'name_suffix'
	,ssn_field = 'ssn'
	,dob_field = 'dob'
	,DID_field	= 'did'
	,outrec
	,outfile
	,ssn_threshold
	,dob_threshold
	) 
	:= macro

import ut, header;
// L             LexId
// N             Name
// S             Full SSN
// P             Probable SSN
// D             DOB
// B             Probable DOB
// A             Street Address
// C             City/State Address
// Z             Zip Address
// V             Last Name + Partial First
// W             Last Name
// H             Phone

matchChars:=
					 if('L' in matchset,'L','')
					+if('N' in matchset,'N','')
					+if('V' in matchset,'V','')
					+if('W' in matchset,'W','')
					+if('S' in matchset,'S','')
					+if('P' in matchset,'P','')
					+if('D' in matchset,'D','')
					+if('B' in matchset,'B','')
					+if('A' in matchset,'A','')
					+if('C' in matchset,'C','')
					+if('Z' in matchset,'Z','')
					+if('H' in matchset,'H','')
					;

ssn_value(string9 l, string9 r) :=
  MAP( l='' or r='' => 0
       ,l = r      => 3
			,(unsigned)l % 10000 = (unsigned)r % 10000 AND 
						(((unsigned)l div 10000) = 0 OR ((unsigned)r div 10000) = 0)  => 1
       ,ut.stringsimilar(l,r) < 4 or ut.stringsimilar(r,l) < 4 => 3-min(ut.stringsimilar(l,r),ut.stringsimilar(r,l))
       ,-10 );

inf_dis:=distribute(infile
		(
		#if('S' in matchset)
			(unsigned)ssn_field>0,
		#end
		#if('D' in matchset)
			dob_field>0,
		#end
		 fname_field<>'',
		 lname_field<>''
		)
		,hash(
		#if('S' in matchset)
			ssn_field,
		#end
		#if('D' in matchset)
			dob_field,
		#end
		fname_field,
		lname_field
		));

inf_ddp:=dedup(inf_dis,		record,		all,		local);

slim := record
	string matchset
	,unsigned1 pri
	,unsigned6 new_rid
	,unsigned6 old_rid
	,inf_ddp
end;

slim	tr(inf_ddp l, inf_ddp r) := transform
			self.old_rid:=l.did;
			self.new_rid:=r.did;
			self.pri:=priority_;
			self.matchset:=matchChars;
			self:=l;
end;


match:=join(inf_ddp,inf_ddp,
		left.did>right.did and
		left.lname_field=right.lname_field and

		#if('N' in matchset)
			left.fname_field=right.fname_field and
		#end

		#if('S' in matchset)
			left.ssn_field=right.ssn_field and
		#end

		#if('P' in matchset)
			(unsigned)left.ssn_field>0 and
			(unsigned)right.ssn_field>0 and
			left.ssn_field[6..9]=right.ssn_field[6..9] and
		#end

		#if('D' in matchset)
			left.dob_field=right.dob_field and
			ut.nneq(left.name_suffix_field,right.name_suffix_field) and
		#end

		true	//the one just keeps the "and" from messing it up
		,tr(left,right)
		,local);

outfile := dedup(match);

endmacro;