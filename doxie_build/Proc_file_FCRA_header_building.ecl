import header, lib_fileservices,_control,ut,AID,header_services,mdr,PromoteSupers;

export Proc_file_FCRA_header_building(string filedate, boolean inc) := function

typ:=if(inc,'inc','mnt');

head := dataset('~thor_data400::Base::FCRA_HeaderKey_Building', header.Layout_Header, flat);

ut.mac_suppress_by_phonetype(head,phone,st,phone_suppression,true,did);

head_bldg0:=doxie_build.fn_file_FCRA_header_building(phone_suppression)(Header.Blocked_data_new());
head_bldg := header.fn_block_records.filter(head_bldg0);

//

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
    fileservices.addsuperfile('~thor_data400::Base::file_fcra_header_building_BUILDING','~thor_data400::base::fcra_header_'+typ,,true));

PromoteSupers.Mac_SF_BuildProcess(DoBuild,'~thor_data400::BASE::file_fcra_header_building',bld,2,,true,pVersion:=filedate)
PromoteSupers.Mac_SF_BuildProcess(DoBuild,'~thor_data400::BASE::file_fcra_header_building_mnt',bld_m,2,,true,pVersion:=filedate)

post1 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::file_fcra_header_building_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::file_fcra_header_building_BUILT','~thor_Data400::base::file_fcra_header_building_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::file_fcra_header_building_BUILDING'));

full1 := if (fileservices.getsuperfilesubname('~thor_Data400::base::file_fcra_header_building_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::fcra_header_'+typ,1),
		output('FCRA Header Base = BUILT. Nothing Done.'),
		sequential(pre1, bld , if(~inc,bld_m),post1));

return full1;

end;