import ut,DriversV2, data_services;

src_rec := record
 header.Layout_Source_ID;
 driversv2.layout_dl;
end;
 
export Key_Src_DLv2(boolean pFastHeader = false, boolean pCombo = true, dataset(src_rec) pDataset=dataset([],src_rec)) := function
 
TempSrc	:=	DriversV2.DLs_as_Source(if(pFastHeader,DriversV2.File_Base_withAID),~pFastHeader,pFastHeader);

DLs_as_Source_orig	:=	project(TempSrc,TRANSFORM(src_rec,SELF := LEFT;));

dDLs_as_Source := if(pCombo,pDataset,DLs_as_Source_orig);

mac_key_src(dDLs_as_Source, DriversV2.Layout_DL, 
						dl_child, 
						Data_Services.Data_location.person_header+'thor_data400::key::dlv2_src_index'+if(pCombo,'',SF_suffix(pFastHeader))+'_',id);
						
return id;
end;

