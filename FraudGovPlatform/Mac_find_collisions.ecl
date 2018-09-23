EXPORT Mac_find_collisions
	(
	infile
	,matchset
	,priority_
	,fname_field = 'fname'
	,lname_field = 'lname'
	,suffix_field = 'name_suffix'
	,ssn_field = 'ssn'
	,dob_field = 'dob'
	,DID_field = 'did'
	,prange_field = 'prim_range'
	,pname_field = 'prim_name'
	,city_field = 'v_city_name'
	,state_field = 'st'
	,zip_field	= 'zip'
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

inf_dis:=distribute(infile
		(
		#if('S' in matchset)
			(unsigned)ssn_field>0,
		#end
		#if('D' in matchset)
			(unsigned)dob_field>0,
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
			left.lname_field=right.lname_field and
		#end

		#if('V' in matchset)
			left.lname_field=right.lname_field and
			left.fname_field<>right.fname_field and
			left.fname_field[1]=right.fname_field[1] and
			ut.nneq(left.suffix_field,right.suffix_field)		and
		#end

		#if('S' in matchset)
			(unsigned)left.ssn_field>0 and
			(unsigned)right.ssn_field>0 and		
			left.ssn_field=right.ssn_field and
		#end

		#if('D' in matchset)

			left.dob_field=right.dob_field and
			ut.nneq(left.suffix_field,right.suffix_field) and
		#end

		#if('P' in matchset)
			(unsigned)left.ssn_field>0 and
			(unsigned)right.ssn_field>0 and
			left.ssn_field[6..9]=right.ssn_field[6..9] and
		#end

		#if('B' in matchset)
			header.gens_ok(left.suffix_field,left.dob_field,right.suffix_field,right.dob_field) and
			(unsigned)left.dob_field>0 and
			(unsigned)right.dob_field>0 and
			#if(dob_threshold = 3)
				header.sig_near_dob(left.dob_field,right.dob_field) and
			#elseif(dob_threshold = 2)
				header.date_value(left.dob_field,right.dob_field) > 1 and
			#elseif(dob_threshold = 1)
				header.date_value(left.dob_field,right.dob_field) > 0 and
			#else
				header.sig_near_dob(left.dob_field,right.dob_field) and
			#end
		#end

		#if('A' in matchset)
			left.pname_field<>'' and
			right.pname_field<>'' and
			left.pname_field=right.pname_field and
			left.prange_field=right.prange_field and
		#end		

		#if('C' in matchset)
			left.city_field<>'' and
			right.city_field<>'' and
			left.state_field<>'' and
			right.state_field<>'' and
			left.city_field=right.city_field and
			left.state_field=right.state_field and
		#end

		#if('Z' in matchset)
			left.zip_field<>'' and
			right.zip_field<>'' and
			left.zip_field=right.zip_field and
		#end

		true	//the one just keeps the "and" from messing it up
		,tr(left,right)
		,local);

outfile := dedup(match);

endmacro;