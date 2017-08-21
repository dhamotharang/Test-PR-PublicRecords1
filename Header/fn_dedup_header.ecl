import ut;
export fn_dedup_header (dataset(header.Layout_Header) infile) := function

	inf := distribute(infile,hash(did));

	sm_rec := record
		inf.did;
		inf.rid;
		inf.src;
		inf.dt_first_seen;
		inf.phone;
		inf.ssn;
		inf.dob;
		inf.fname;
		inf.mname;
		inf.lname;
		inf.name_suffix;
		inf.prim_range;
		inf.prim_name;
		inf.sec_range;
		inf.st;
		inf.zip;
		inf.county;
		inf.RawAID; 
	end;

	//****** Slim down the infile
	sm_rec slimHead(header.layout_header L) := transform
	 self := l;
	end;

	me_use := project(inf,slimHead(left)); 

	//-- Transform that assigns the right file ID as old_rid and the left file ID as new_rid
	//	 Sets flag to RU1 (rule 1)
	header.Layout_PairMatch tra(me_use ll, me_use r) := transform
	  self.old_rid := r.rid;
	  self.new_rid := ll.rid;
	  self.pflag := 21;
	  end;

	//****** Join the infile to itself
	j := join(me_use,me_use,
						left.did=right.did
					and left.rid < right.rid
					and	left.src        =right.src
					and	left.fname      =right.fname
					and	left.lname      =right.lname
					and	left.prim_range =right.prim_range
					and	left.prim_name  =right.prim_name
					and	left.st         =right.st
					and	(
								(left.ssn          =right.ssn
							and	left.dob         =right.dob
							and	left.phone       =right.phone
							and	left.mname       =right.mname
							and	left.name_suffix =right.name_suffix
							and	left.sec_range   =right.sec_range
							and	left.zip         =right.zip
							and	left.county      =right.county)
						or
								(ut.nneq(left.ssn          ,right.ssn)
							and	ut.NNEQ_Date(left.dob    ,right.dob)
							and	ut.nneq(left.phone       ,right.phone)
							and	(
									ut.nneq(left.mname       ,right.mname)
								or (if(left.mname[1]=right.mname[1] and (length(trim(left.mname))=1 or length(trim(right.mname))=1),true,false))
								)
							and	ut.nneq(left.name_suffix ,right.name_suffix)
							and	ut.nneq(left.sec_range   ,right.sec_range)
							and	ut.nneq(left.zip         ,right.zip)
							and	ut.nneq(left.county      ,right.county)

							and	(left.dt_first_seen=right.dt_first_seen or left.dt_first_seen=0 or right.dt_first_seen=0)
							)
						)
					,tra(left,right)
					,local);
					
	sj := sort(distribute(j,old_rid),old_rid,new_rid,local);

	rolled_rids := dedup(sj,old_rid,local);

	ut.MAC_Patch_Id(inf, rid, rolled_rids, old_rid, new_rid, old_and_new);

	dinfile := distribute(old_and_new,hash(rid));

	BR_s := sort(dinfile, rid,dt_vendor_last_reported,dt_vendor_first_reported,dt_last_seen,local);

	hddpd := rollup(BR_s,left.rid=right.rid,header.tra_merge_headers(left,right),local);

	return hddpd;

end;