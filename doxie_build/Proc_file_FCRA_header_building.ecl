import header, lib_fileservices,_control,ut,AID,header_services,mdr,PromoteSupers;

export Proc_file_FCRA_header_building(string filedate, boolean inc) := function

typ:=if(inc,'_inc','');

head := dataset('~thor_data400::Base::FCRA_HeaderKey_Building', header.Layout_Header, flat);

ut.mac_suppress_by_phonetype(head,phone,st,phone_suppression,true,did);

head_bldg0:=doxie_build.fn_file_FCRA_header_building(phone_suppression)(Header.Blocked_data_new());
head_bldg1 := header.fn_block_records.filter(head_bldg0);

vo_fcra := head_bldg1(src = 'VO');

//ARMBS-415 - Remove Nebraska and Delaware Voters from FCRA Header
vo_src := dataset('~thor_data400::in::SeqdHeaderSrc_VO',header.Layouts_SeqdSrc.VO_src_rec,flat);

vo_fcra_dist := distribute(vo_fcra,hash(fname,lname,zip));
vo_src_dist  := distribute(vo_src,hash(fname,lname,zip));

j_vo_fcra := join(vo_fcra_dist
		  ,vo_src_dist
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

fcra_vo_filtered := project(j_vo_fcra(source_state not in ['DE', 'NE']), recordof(j_vo_fcra) - [source_state]);
head_bldg := head_bldg1(src <> 'VO') + fcra_vo_filtered;

header_services.Supplemental_Data.mac_verify('didaddress_sup.txt',header_services.Supplemental_Data.layout_in,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 head_bldg;
 rHashDIDAddress;
end;

rFullOut_HashDIDAddress tHashDIDAddress(head_bldg l) := transform                            
 self.hval := hashmd5(intformat(l.did,15,1),(string)l.st,(string)l.zip,(string)l.city_name,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.suffix,(string)l.postdir,(string)l.sec_range);
 self := l;
end;

dHeader_withMD5 := project(head_bldg, tHashDIDAddress(left));

head_bldg tSuppress(dHeader_withMD5 l, dSuppressedIn r) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval=right.hval,
						  tSuppress(left,right),
						  left only,lookup);

//
DoBuild := distribute(full_out_suppress,hash(did));

pre1 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::file_fcra_header_building_BUILDING')>0,
    output('Nothing added to Base::file_fcra_header_building_BUILDING'),
    fileservices.addsuperfile('~thor_data400::Base::file_fcra_header_building_BUILDING','~thor_data400::base::fcra_header'+typ,,true));

PromoteSupers.Mac_SF_BuildProcess(DoBuild,'~thor_data400::BASE::file_fcra_header_building',bld,2,,true,pVersion:=filedate)
PromoteSupers.Mac_SF_BuildProcess(DoBuild,'~thor_data400::BASE::file_fcra_header_building_mnt',bld_m,2,,true,pVersion:=filedate)

post1 := sequential(
	fileservices.StartSuperFileTransaction(),
	fileservices.clearsuperfile('~thor_Data400::base::file_fcra_header_building_BUILT'),
	fileservices.addsuperfile('~thor_data400::base::file_fcra_header_building_BUILT','~thor_Data400::base::file_fcra_header_building_BUILDING',0,true),
	fileservices.clearsuperfile('~thor_Data400::base::file_fcra_header_building_BUILDING'),
	fileservices.clearsuperfile('~thor_data400::BASE::file_fcra_header_building_Delete'),
	fileservices.FinishSuperFileTransaction()
	);

full1 := if (fileservices.getsuperfilesubname('~thor_Data400::base::file_fcra_header_building_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::fcra_header'+typ,1),
		output('FCRA Header Base = BUILT. Nothing Done.'),
		sequential(pre1, bld , if(~inc,bld_m),post1));

return full1;

end;