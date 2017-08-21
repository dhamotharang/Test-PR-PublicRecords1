import data_services,ln_property,ln_propertyv2;

src_rec := record
	header.layout_Source_ID;
	LN_Property.Layout_Property_Common_Model_BASE
end;

export Key_Src_PropAssess(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function

dAS_as_Source := if(pCombo,pDataset,header.Files_SeqdSrc(pFastHeader).FAT);

mac_key_src(dAS_as_Source, LN_Property.Layout_Property_Common_Model_BASE, 
						asses_child, 
						data_services.Data_location.prefix('Source')+'thor_data400::key::propasses_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id);
						
return id;
end;