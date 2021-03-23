import Header, std, Watchdog, ut,mdr;

allowed_st := ['AK', 'AL', 'AR', 'CO', 'CT', 'DC', 'FL', 'LA', 'MA', 'MI', 'NC', 'NV', 'NY', 'OH', 'OK', 'RI', 'WI'];

vo_hdr := Header.File_Headers(src = 'VO'); //349,403,820
vo     := dataset('~thor_data400::in::SeqdHeaderSrc_VO',header.Layouts_SeqdSrc.VO_src_rec,flat);

d_vo_hdr := distribute(vo_hdr,hash(fname,lname,zip));
d_vo     := distribute(vo, hash(fname,lname,zip));

j := join(d_vo_hdr
		  ,d_vo
		  ,left.fname=right.fname
		and left.lname=right.lname
		and ut.nneq_date(left.dob, (unsigned8)right.dob)
		and left.mname=right.mname
		and	
		((left.zip=right.mail_zip
		and left.prim_range=right.mail_prim_range
		and left.predir=right.mail_predir
		and left.prim_name=right.mail_prim_name
		and left.suffix=right.mail_addr_suffix
		and left.postdir=right.mail_postdir
		and	ut.NNEQ(left.sec_range, right.mail_sec_range)
		and left.st=right.mail_st
		) or
		(left.zip=right.zip 
		and left.prim_range=trim(right.prim_range)
		and left.predir=trim(right.predir)
		and left.prim_name=right.prim_name
		and left.suffix=right.addr_suffix
		and left.postdir=right.postdir
		and	ut.NNEQ(left.sec_range, right.sec_range)
		and left.st=right.st
		))		
		and	ut.NNEQ_Phone(left.phone,right.phone)
		and ut.nneq_ssn(left.ssn, right.ssn)
		and left.vendor_id = right.vendor_id, TRANSFORM({RECORDOF(LEFT),string source_state},SELF.source_state:=RIGHT.source_state,SELF:=LEFT)
		,left outer
		,keep(1)
		,local);

EXPORT Voters_Inclusions := project(J(source_state in allowed_st), recordof(j) - [source_state]);

// output(count(Voters_Inclusions), named('allowed_voters')); //238,579,821