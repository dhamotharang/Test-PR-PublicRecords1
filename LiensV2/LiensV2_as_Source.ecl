import header,mdr,liensv2,ut;

export LiensV2_as_Source(boolean pFastHeader = false) := function

main_all := if(pFastHeader
							,dataset('~thor_data400::base::LiensV2_mainQuickHeader_Building',LiensV2.layout_liens_main_module.layout_liens_main,flat)
							,dataset('~thor_data400::base::LiensV2_mainHeader_Building',LiensV2.layout_liens_main_module.layout_liens_main,flat)
							)
							;
//DF-24044 To keep the header build consistent, we are using the tmsid_old field as tmsid has changed for some records
main_slim := project(main_all,transform(liensv2.Layout_as_source,self.tmsid:=left.tmsid_old, self := left));

main := dedup(sort(main_slim,tmsid),tmsid);

src_rec:=header.layouts_SeqdSrc.L2_src_rec;

seed:=if(pFastHeader,999999999999,1);
header.Mac_Set_Header_Source(main,liensv2.Layout_as_source,src_rec,MDR.sourceTools.src_Liens_v2,withUID,seed);

return withUID;
end;