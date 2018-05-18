IMPORT FraudShared;
EXPORT RingId := MODULE


	EXPORT RingId_Layout := RECORD
			unsigned6 did;
			unsigned8 record_id;
			string20 	fname;
			string20 	lname;
			string20 	name_suffix;
			string9 	ssn;
			unsigned4 dob;
	END;

	EXPORT LastRingID := MAX(FraudShared.Files().Base.Main.Built(DID >= FraudGovPlatform.Constants().FirstRingID), DID):independent;

	EXPORT MAC_Sequence_Records(infile,idfield,outfile,seed=1) := MACRO

	#uniquename(tr1)
	{infile} %tr1%(infile L) := transform
		self.idfield := 0 ; 
		self := l;
	end;
	#uniquename(p)
	%p% := project(infile,%tr1%(left));

	#uniquename(tr2)
	{infile} %tr2%(%p% l,%p% r) := transform
		self.idfield := if(l.idfield=0, thorlib.node() + seed, l.idfield + thorlib.nodes() );
		self := r;
	end;
	outfile := iterate(%p%,%tr2%(left,right),local);

	ENDMACRO;


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
	
	EXPORT Mod_Collisions(DATASET(RingId_Layout) FileBase) := Module

	SHARED threashold:=enum(unsigned1,Low,Medium,High);
	SHARED ssn_threashold:=threashold;
	SHARED dob_threashold:=threashold;

	//////////////////////////////////
	// 'NSD'=> 1             //LASTNAME & FIRSTNAME    & SSN      & DOB
	matchset:=['N','S','D'];
	Mac_find_collisions(
											FileBase
											,matchset
											,1
											,fname, lname, name_suffix
											,ssn, dob
											,DID
											,layout_slim
											,dsOut
											,ssn_threashold.High
											,dob_threashold.High
											);

	EXPORT N_S_D_col:=dsOut;
	//////////////////////////////////
	// 'NPD'=> 5            //LASTNAME & FIRSTNAME    & PROB_SSN & DOB
	matchset:=['N','P','D'];
	Mac_find_collisions(
											FileBase
											,matchset
											,5
											,fname, lname, name_suffix
											,ssn, dob
											,DID
											,layout_slim
											,dsOut
											,ssn_threashold.Medium
											,dob_threashold.High
											);

	EXPORT N_P_D_col:=dsOut;
	//////////////////////////////////
	concat_all :=
				N_S_D_col
				+ N_P_D_col
				;

	export 
	concat_srt
						:=
								sort(concat_all
											,fname
											,lname
											,name_suffix
											,ssn
											,dob
											,pri
											,did
											)
											:persist('~otto::persist::concat_srt')
											;
	concat_ddp
						:=
								dedup(concat_srt
											,fname
											,lname
											,name_suffix
											,ssn
											,dob
											)
											:persist('~otto::persist::concat_ddp')
											;

	EXPORT matches := concat_ddp;

	END;
	
	//1.Send main dataset to append lexid
	EXPORT Append_RingID(pBaseFile) := FUNCTIONMACRO
	
		import Header;
		
		// 2.Take new records w/o a lexid and join them to previous main file (AKA ringid, flexid, no match id)
		BaseFile := distribute(pBaseFile, hash32(record_id));
		previous_base 	:= distribute(FraudShared.Files().Base.Main.built, hash32(record_id));
		
		previous_RingIds := join (
			previous_base,
			BaseFile(did=0),
			left.record_id = right.record_id,
			transform(FraudShared.Layouts.Base.Main, self.did := right.did; self.did_score := left.did_score; self := left),
			local
		);

		// 3.Where there is a match in #2 transfer the previous RingID over to the record w/o a lexid

		shared base0 := join(
			BaseFile,
			previous_RingIds,
			left.record_id = right.record_id,
			transform(FraudShared.Layouts.Base.Main, self.did := if(right.did>0,right.did,left.did); self.did_score := if(right.did_score>0,right.did_score,left.did_score); self := left),
			left outer,
			local);
		
		shared base1:=project(base0(DID = 0)
					,transform(FraudGovPlatform.RingID.RingId_Layout
						,self.fname:=left.raw_first_name
						,self.lname:=left.raw_last_name
						,self.name_suffix:=if(left.raw_orig_suffix='\\N','',left.raw_orig_suffix)
						,self.dob:=(unsigned)left.dob
						,self:=left
						));
		
		//4.sequence those records in #2 that did not match anything in #3
		LastRingID := FraudGovPlatform.RingID.LastRingID;
		seed:= if (LastRingID > 0 , LastRingID, FraudGovPlatform.Constants().FirstRingID);
		
		FraudGovPlatform.RingID.MAC_Sequence_Records(
			base1,
			did,
			base2,
			seed);	
		
		//5.send all records with a RingID to be matched and collapsed
		mtchs:= FraudGovPlatform.RingID.Mod_Collisions( base2 ).matches;

	
		tBase:=table(base2
					,{did
					,record_id
					,fname
					,lname
					,name_suffix
					,ssn
					,dob});

		pairs:=table(mtchs,{new_rid,old_rid});

		Header.MAC_ApplyDid1(tBase,DID,pairs,outfile);
		//6.combine records with a real lexid and a flexid into one main base file
		RingIDs := join (base0,
									outfile,
									left.record_id = right.record_id,
									transform(FraudShared.Layouts.Base.Main, self.did := if(right.did>0,right.did,left.did); self := left; ),
									left outer,
									local
									);
		RETURN RingIDs;

	ENDMACRO;


END;