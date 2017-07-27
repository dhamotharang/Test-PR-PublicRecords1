import data_services,ExperianCred;

src_rec := record
	header.layout_Source_ID;
	ExperianCred.Layouts.Layout_Out_old
end;

export key_src_experian(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

Experian_in := if(pCombo,pDataset,ExperianCred.Experian_as_source(if(pFastHeader,ExperianCred.Files.Base_File_Out),~pFastHeader,pFastHeader));

mac_key_src(Experian_in, ExperianCred.Layouts.Layout_Out_old, 
						Experian_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::Experian_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id)

return id;
end;