import header,mdr;

src_rec := record
 header.Layout_Source_ID;
 ExperianCred.Layouts.Layout_Out_old;
end;

export fn_Not_Primary_EN	(
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
	EN_type1:=sort(distribute(infile1(did>0,current_rec_flag=1,IsValidVendor(Encrypted_Experian_PIN))
									,hash(did)),did,Encrypted_Experian_PIN,local);

	r0:=record
		EN_type1.did;
		qstring18 Encrypted_Experian_PIN:='';
		cnt_did:=count(group);
	end;
	t:=table(EN_type1,r0,did,local);

	t0:=(t(cnt_did>1));

	r0 tr(t0 l, EN_type1 r) := transform
		self.Encrypted_Experian_PIN:=r.Encrypted_Experian_PIN;
		self:=l;
	end;

	j1:=join(t0, EN_type1
				,left.did=right.did
				,tr(left,right)
				,local);

	multi_EN0:=dedup(j1,did,local);
	multi_EN:=sort(distribute(multi_EN0,hash(did)),did,local);

	recordof(EN_type1) tr1(EN_type1 l, multi_EN r) := transform
		self:=l;
	end;

	EN_multy_type1:=join(EN_type1, multi_EN
				,left.did=right.did
				,tr1(left,right)
				,local);
	//#################### step 2 gather other sources for dids with multi EN type1
	hd_type1:=distribute(header.file_headers( ~mdr.sourceTools.SourceIsExperian_Credit_Header(src) ),hash(did));

	recordof(hd_type1) tr0(multi_EN l,hd_type1 r) :=transform
		self := r;
	end;

	other_src:=join(multi_EN, hd_type1
				,left.did=right.did
				,tr0(left,right)
				,local);
	//#################### step 3 reveal EN_multi_type1 with other sources with the same address and
	//#################### how many months before or after were last seen.
	preprec trp(EN_multy_type1 l,other_src r):=transform
		diff_mnth	:=header.convertyyyymmtonumberofmonths(l.date_last_seen)
					- header.convertyyyymmtonumberofmonths(r.dt_last_seen);

		mths_since_last_seen_in_other_sources0	:= if(r.dt_last_seen<>0,diff_mnth,0);
		mths_since_last_seen_in_other_sources	:= if(l.date_last_seen=r.dt_last_seen
														and r.dt_last_seen<>0
														,1
														,mths_since_last_seen_in_other_sources0);

		self.mths_since_last_seen_in_other_sources :=	mths_since_last_seen_in_other_sources;
		self.hd_rid :=	r.rid;

		self:=l;
	end;

	PriMtch0:=join(EN_multy_type1, other_src
					,	left.did=right.did
					and left.prim_range=right.prim_range
					and left.prim_name=right.prim_name
					and left.sec_range=right.sec_range
					and left.zip=right.zip
					,trp(left,right)
					,left outer
					,local);
	//#################### step 4 select EN did,vendor_id with other source seen most recently - within threshold
	PriMtch1:=(sort(PriMtch0
						(
							mths_since_last_seen_in_other_sources <> 0
							,mths_since_last_seen_in_other_sources <= treashld
						)
					,did
					,mths_since_last_seen_in_other_sources
					,-date_last_seen
					,-date_first_seen
					,uid
					,local));

	PriMtch:=dedup(PriMtch1,did,local);
	//#################### step 5 bring back all the records for the dids with multy type1
	//#################### that also have other recent sources with the same address
	preprec tr2(EN_multy_type1 l,PriMtch r) :=transform
		boolean aHit	:=	l.did=r.did
						and l.Encrypted_Experian_PIN=r.Encrypted_Experian_PIN
						and l.current_rec_flag=1
						and l.uid=r.uid;
		self.mths_since_last_seen_in_other_sources
							:=if(aHit,r.mths_since_last_seen_in_other_sources,0);
		self.hd_rid			:=if(aHit,r.hd_rid,if(l.did=r.did,1,0));
		self:=l;
	end;

	didAfect:=join(EN_multy_type1, PriMtch
					,left.did=right.did
					,tr2(left,right)
					,left outer
					,local);
	//#################### step 6 clear rec_type from the records of dids with multy type1
	//#################### and that DO NOT have other recent sources with same address
	preprec tr3(infile1 l,didAfect r) :=transform
		self.mths_since_last_seen_in_other_sources:=r.mths_since_last_seen_in_other_sources;
		self.date_first_seen	:=if(r.hd_rid<>1, l.date_first_seen, 0);
		self.date_last_seen	:=if(r.hd_rid<>1, l.date_last_seen, 0);
		self.current_rec_flag		:=if(r.hd_rid<>1, l.current_rec_flag, 0);
		self.hd_rid			:=r.hd_rid;
		self:=l;
	end;

	outfile:=join(infile1, didAfect
					,	left.did=right.did
					and	left.date_last_seen=right.date_last_seen
					and	left.date_first_seen=right.date_first_seen
					and	left.Encrypted_Experian_PIN=right.Encrypted_Experian_PIN
					and	left.current_rec_flag=right.current_rec_flag
					and	left.uid=right.uid
					,tr3(left,right)
					,left outer
					,keep(1)
					,local);

	QA_persist:=sort(outfile(hd_rid<>0),did,local) : persist('~thor_data400::persist::EN_multy1_remd');

	return project(outfile,src_rec) + infile(did=0);

end;