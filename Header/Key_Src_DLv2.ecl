import ut,DriversV2;

src_rec := record
 header.Layout_Source_ID;
 driversv2.layout_dl;
end;
 
export Key_Src_DLv2(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function
 
DLs_as_Source_orig	:=	project(header.Files_SeqdSrc(pFastHeader).DL,src_rec);

dDLs_as_Source := if(pCombo,pDataset,DLs_as_Source_orig);

mac_key_src(dDLs_as_Source, DriversV2.Layout_DL, 
						dl_child, 
						ut.Data_Location.Person_header+'thor_data400::key::dlv2_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id);
						
return id;
end;

