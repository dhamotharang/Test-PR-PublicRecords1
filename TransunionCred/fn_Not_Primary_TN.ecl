import header,mdr;

src_rec := record
 header.Layout_Source_ID;
 Layouts.base;
end;

export fn_Not_Primary_TN	(
							dataset(src_rec) infile
							)
 :=
 FUNCTION

	preprec:=record
		integer		mths_since_last_seen_in_other_sources:=0,
		unsigned6   hd_rid:=0,
		recordof(infile),
	end;

	infile1:=distribute(project(infile(did>0),preprec),hash(did));

	treashld:=3; //number of months when other source primary record with same address was seen

	boolean IsValidVendor(qstring18 pVend) := trim(regexreplace('0',pVend,''),all) <> '';

	//#################### step 1 filter equifax rec_type 1 only and count vendor_id per did.
	TN_type1:=sort(distribute(infile1(did>0,IsCurrent,IsValidVendor(party_id))
									,hash(did)),did,party_id,local);

	r0:=record
		TN_type1.did;
		qstring18 party_id:='';
		cnt_did:=count(group);
	end;
	t:=table(TN_type1,r0,did,local);

	t0:=(t(cnt_did>1));

	r0 tr(t0 l, TN_type1 r) := transform
		self.party_id:=r.party_id;
		self:=l;
	end;

	j1:=join(t0, TN_type1
				,left.did=right.did
				,tr(left,right)
				,local);

	multi_TN0:=dedup(j1,did,local);
	multi_TN:=sort(distribute(multi_TN0,hash(did)),did,local);

	recordof(TN_type1) tr1(TN_type1 l, multi_TN r) := transform
		self:=l;
	end;

	TN_multy_type1:=join(TN_type1, multi_TN
				,left.did=right.did
				,tr1(left,right)
				,local);
	//#################### step 2 gather other sources for dids with multi TN type1
	hd_type1:=distribute(header.file_headers( ~mdr.sourceTools.SourceIsTransunion_Credit_Header(src) ),hash(did));

	recordof(hd_type1) tr0(multi_TN l,hd_type1 r) :=transform
		self := r;
	end;

	other_src:=join(multi_TN, hd_type1
				,left.did=right.did
				,tr0(left,right)
				,local);
	//#################### step 3 reveal TN_multi_type1 with other sources with the same address and
	//#################### how many months before or after were last seen.
	preprec trp(TN_multy_type1 l,other_src r):=transform
		diff_mnth	:=header.convertyyyymmtonumberofmonths(l.dt_last_seen)
					- header.convertyyyymmtonumberofmonths(r.dt_last_seen);

		mths_since_last_seen_in_other_sources0	:= if(r.dt_last_seen<>0,diff_mnth,0);
		mths_since_last_seen_in_other_sources	:= if(l.dt_last_seen=r.dt_last_seen
														and r.dt_last_seen<>0
														,1
														,mths_since_last_seen_in_other_sources0);

		self.mths_since_last_seen_in_other_sources :=	mths_since_last_seen_in_other_sources;
		self.hd_rid :=	r.rid;

		self:=l;
	end;

	PriMtch0:=join(TN_multy_type1, other_src
					,	left.did=right.did
					and left.prim_range=right.prim_range
					and left.prim_name=right.prim_name
					and left.sec_range=right.sec_range
					and left.zip=right.zip
					,trp(left,right)
					,left outer
					,local);
	//#################### step 4 select TN did,vendor_id with other source seen most recently - within threshold
	PriMtch1:=(sort(PriMtch0
						(
							mths_since_last_seen_in_other_sources <> 0
							,mths_since_last_seen_in_other_sources <= treashld
						)
					,did
					,mths_since_last_seen_in_other_sources
					,-dt_last_seen
					,-dt_first_seen
					,uid
					,local));

	PriMtch:=dedup(PriMtch1,did,local);
	//#################### step 5 bring back all the records for the dids with multy type1
	//#################### that also have other recent sources with the same address
	preprec tr2(TN_multy_type1 l,PriMtch r) :=transform
		boolean aHit	:=	l.did=r.did
						and l.party_id=r.party_id
						and l.IsCurrent
						and l.uid=r.uid;
		self.mths_since_last_seen_in_other_sources
							:=if(aHit,r.mths_since_last_seen_in_other_sources,0);
		self.hd_rid			:=if(aHit,r.hd_rid,if(l.did=r.did,1,0));
		self:=l;
	end;

	didAfect:=join(TN_multy_type1, PriMtch
					,left.did=right.did
					,tr2(left,right)
					,left outer
					,local);
	//#################### step 6 clear rec_type from the records of dids with multy type1
	//#################### and that DO NOT have other recent sources with same address
	preprec tr3(infile1 l,didAfect r) :=transform
		self.mths_since_last_seen_in_other_sources:=r.mths_since_last_seen_in_other_sources;
		self.dt_first_seen	:=if(r.hd_rid<>1, l.dt_first_seen, 0);
		self.dt_last_seen	:=if(r.hd_rid<>1, l.dt_last_seen, 0);
		self.IsCurrent		:=if(r.hd_rid<>1, l.IsCurrent, false);
		self.hd_rid			:=r.hd_rid;
		self:=l;
	end;

	outfile:=join(infile1, didAfect
					,	left.did=right.did
					and	left.dt_last_seen=right.dt_last_seen
					and	left.dt_first_seen=right.dt_first_seen
					and	left.party_id=right.party_id
					and	left.IsCurrent=right.IsCurrent
					and	left.uid=right.uid
					,tr3(left,right)
					,left outer
					,keep(1)
					,local);

	QA_persist:=sort(outfile(hd_rid<>0),did,local) : persist('~thor_data400::persist::TN_multy1_remd');

	return project(outfile,src_rec) + infile(did=0);

end;