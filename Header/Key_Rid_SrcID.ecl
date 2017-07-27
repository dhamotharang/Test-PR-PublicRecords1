Import Data_Services, doxie,data_services;
export Key_Rid_SrcID(boolean pFastHeader = false, boolean pCombo = true, dataset(Layout_RID_SrcID) pDataset=dataset([],Layout_RID_SrcID)) := function

	get_recs := dataset([],Layout_RID_SrcID);

	return index(get_recs, {rid}, {get_recs},data_services.Data_location.prefix('Source')+'thor_data400::key::header_rid_srid'+if(pCombo,'',SF_suffix(pFastHeader))+'_' + doxie.Version_SuperKey,opt);

end;