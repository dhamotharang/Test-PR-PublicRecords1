import data_services,liensv2;

src_rec := record
	header.layout_Source_ID;
	liensv2.Layout_as_source
end;

export Key_Src_LienV2(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

liens_as_source := if(pCombo,pDataset,header.Files_SeqdSrc(pFastHeader).LiensV2);

mac_key_src(liens_as_source, liensv2.Layout_as_source, 
						lienv2_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::LienV2_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id);

return id;
end;