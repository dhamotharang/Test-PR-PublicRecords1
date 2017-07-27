import ut,bankruptcyv3,BankruptcyV2;

export Key_Src_BKv2_prep(boolean pFastHeader = false) := function

src_rec := record
header.layout_Source_ID;
string50 tmsid;
end;

dBK_as_Source	:=	project(BankruptcyV3.BKv3_as_source(if(pFastHeader,BankruptcyV2.file_bankruptcy_search_v3_supp), if(pFastHeader,BankruptcyV2.file_bankruptcy_main_v3_supplemented),~pFastHeader,pFastHeader),src_rec);

mac_key_src(dBK_as_Source, {string50 tmsid}, 
						bk_child, 
						ut.Data_Location.Person_header+'thor_data400::key::bkv2_src_index'+SF_suffix(pFastHeader)+'_',id)

return id;
end;
