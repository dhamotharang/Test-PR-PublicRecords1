import header,mdr,liensv2,ut;

export LiensV2_as_Source(boolean pFastHeader = false) := function

main_all := if(pFastHeader
							,dataset('~thor_data400::base::LiensV2_mainQuickHeader_Building',LiensV2.layout_liens_main_module.layout_liens_main,flat)
							,dataset('~thor_data400::base::LiensV2_mainHeader_Building',LiensV2.layout_liens_main_module.layout_liens_main,flat)
							)
							;

main_slim := project(main_all,transform(liensv2.Layout_as_source,self := left));

main := dedup(sort(main_slim,tmsid),tmsid);

src_rec := record
 header.Layout_Source_ID;
 liensv2.Layout_as_source;
end;

seed:=if(pFastHeader,999999999999,1);
header.Mac_Set_Header_Source(main,liensv2.Layout_as_source,src_rec,MDR.sourceTools.src_Liens_v2,withUID,seed);

dForHeader	:=	withUID	: persist('~thor_data400::persist::headerbuild_liensV2_src');
dForOther	:=	withUID;
ReturnValue	:=	if(pFastHeader, dForOther, dForHeader);

return ReturnValue;
end;