import data_services,ExperianCred;

src_rec := record
	header.layout_Source_ID;
	ExperianCred.Layouts.Layout_Out_old
end;

export key_src_experian(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

Experian_in := if(pCombo,pDataset,header.Files_SeqdSrc(pFastHeader).EN);

mac_key_src(Experian_in, ExperianCred.Layouts.Layout_Out_old, 
						Experian_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::Experian_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id)

return id;
end;