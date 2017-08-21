import data_services,bankruptcyv3,BankruptcyV2;

src_rec := record
header.layout_Source_ID;
string50 tmsid;
end;

export Key_Src_bkv2(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

dBK_as_Source	:=	if(pCombo,pDataset,project(header.Files_SeqdSrc(pFastHeader).BA,src_rec));

mac_key_src(dBK_as_Source, {string50 tmsid}, 
						bk_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::bkv2_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id)
						
return id;
end;