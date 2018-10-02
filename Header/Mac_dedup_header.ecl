import ut;
export Mac_dedup_header (infile, ofile, sffx='\'\'') := macro

	#uniquename(me_use)
	%me_use% := distribute(infile,hash(src,fname,lname,zip,zip4));

	#uniquename(tra)
	header.Layout_PairMatch %tra%(%me_use% l, %me_use% r) := transform
		self.old_rid := r.rid;
		self.new_rid := l.rid;
		self.pflag := 21;
		end;

	#uniquename(j)
	%j% := join(%me_use%,%me_use%
			,   left.rid < right.rid
			and left.src=right.src
// Bug: 173413
// this change is in conjunction with other changes made in:
// Header.New_Header_Records
// DriversV2.dls_as_header
// Header.Header_Joined
			and (	~Mdr.SourceTools.SourceIsDL(left.src)
					or left.vendor_id=right.vendor_id)
			and left.fname=right.fname
			and left.mname=right.mname
			and left.lname=right.lname
			and left.name_suffix=right.name_suffix
			and left.ssn=right.ssn
			and left.dob=right.dob
			and left.phone=right.phone
			and left.postdir=right.postdir
			and left.predir=right.predir
			and left.prim_name=right.prim_name
			and left.prim_range=right.prim_range
			and left.sec_range=right.sec_range
			and left.suffix=right.suffix
			and left.unit_desig=right.unit_desig
			and left.city_name=right.city_name
			and left.st=right.st
			and left.zip=right.zip
			and left.zip4=right.zip4
			and left.county=right.county
						,%tra%(left,right)
					,local);

	#uniquename(sj)
	%sj% := sort(distribute(%j%,old_rid),old_rid,new_rid,local);

	#uniquename(rolled_rids)
	%rolled_rids% := dedup(%sj%,old_rid,local):persist('~thor_data400::persist::patchrids'+sffx);

	#uniquename(old_and_new)
	ut.MAC_Patch_Id(infile, rid, %rolled_rids%, old_rid, new_rid, %old_and_new%);

	#uniquename(dinfile)
	%dinfile% := distribute(%old_and_new%,hash(rid));

	#uniquename(BR_s)
	%BR_s% := sort(%dinfile%, rid,did,local);

	#uniquename(t_rollup)
	{infile} %t_rollup%(infile l, infile r) := transform
		self.rec_type  := if ( l.rec_type='' or (l.dt_last_seen<r.dt_last_seen and l.dt_last_seen>0)
											 or (l.dt_last_seen=r.dt_last_seen and r.rec_type<l.rec_type), r.rec_type, l.rec_type );
		self.vendor_id                := map(Header.Vendor_Id_Null(l.vendor_id) => r.vendor_id
																					,Header.Vendor_Id_Null(r.vendor_id) => l.vendor_id
																					,l.dt_vendor_last_reported > r.dt_vendor_last_reported => l.vendor_id
																					,l.rec_type <= r.rec_type => l.vendor_id
																					,r.vendor_id);
		self.dt_first_seen            := ut.min2(l.dt_first_seen,r.dt_first_seen);
		self.dt_last_seen             := max(l.dt_last_seen, r.dt_last_seen);
		self.dt_vendor_first_reported := ut.min2(l.dt_vendor_first_reported,r.dt_vendor_first_reported);
		self.dt_vendor_last_reported  := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		self.dt_nonglb_last_seen      := max(l.dt_nonglb_last_seen, r.dt_nonglb_last_seen);
		self.RawAid                   := if (l.RawAid = 0, r.RawAid, l.RawAid );
		self.dodgy_tracking           := if (l.dodgy_tracking = '', r.dodgy_tracking, l.dodgy_tracking );
		self := l;
	end;

	ofile := rollup(%BR_s%,left.rid=right.rid,%t_rollup%(left,right),local);

endMacro;