import header, lib_fileservices,_control,ut,AID,header_services,mdr,PromoteSupers;

head := dataset('~thor_data400::Base::HeaderKey_Building', header.Layout_Header_v2, flat);

ut.mac_suppress_by_phonetype(head,phone,st,phone_suppression,true,did);

head_bldg0:=doxie_build.fn_file_header_building(phone_suppression)(Header.Blocked_data_new());
head_bldg := header.fn_block_records.filter(head_bldg0);

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

full_out_suppress0:=full_out_suppress(phone<>'');

YellowPages.NPA_PhoneType(full_out_suppress0,phone,ptype,full_out_suppress1);
full_out_suppress2:=project(full_out_suppress1
											,transform({full_out_suppress}
												,self.phone:=if(regexfind('invalid',left.ptype,nocase),'',left.phone)
												,self:=left
												))
												+
												full_out_suppress(phone='')
												;

DoBuild := distribute(full_out_suppress2,hash(did));

pre1 := if(fileservices.getsuperfilesubcount('~thor_data400::Base::file_header_building_BUILDING')>0,
    output('Nothing added to Base::file_header_building_BUILDING'),
    fileservices.addsuperfile('~thor_data400::Base::file_header_building_BUILDING','~thor_data400::base::header',,true));

PromoteSupers.Mac_SF_BuildProcess(DoBuild,'~thor_data400::BASE::file_header_building',bld,2,,true,pVersion:=Header.version_build)

post1 := sequential(
		fileservices.clearsuperfile('~thor_Data400::base::file_header_building_BUILT'),
		fileservices.addsuperfile('~thor_data400::base::file_header_building_BUILT','~thor_Data400::base::file_header_building_BUILDING',0,true),
		fileservices.clearsuperfile('~thor_Data400::base::file_header_building_BUILDING'));

// dFile:=dataset('~thor_data400::BASE::file_header_building',header.layout_header,thor);
dFile:=DoBuild;
check_file:=assert( count(dFile)=count(dedup(dFile+dFile,rid,all)),'Duplicate rids found',FAIL);
check_file;

full1 := if (fileservices.getsuperfilesubname('~thor_Data400::base::file_header_building_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::header',1),
		output('Header Base = BUILT. Nothing Done.'),
		sequential(pre1, bld ,post1,check_file));

export Proc_file_header_building := full1;