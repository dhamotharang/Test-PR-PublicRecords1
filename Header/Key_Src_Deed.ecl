import data_services,ln_propertyv2,ln_mortgage;

src_rec := record
	header.layout_Source_ID;
	ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base
end;

export Key_Src_Deed(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

dDE_as_Source := if(pCombo,pDataset,header.Files_SeqdSrc(pFastHeader).FAD);

mac_key_src(dDE_as_Source, ln_mortgage.Layout_Deed_Mortgage_Common_Model_Base, 
						deeds_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::propdeed_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id);
						
return id;
end;