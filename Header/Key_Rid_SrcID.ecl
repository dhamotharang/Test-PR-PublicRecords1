IMPORT dx_header;

EXPORT Key_Rid_SrcID(boolean pFastHeader = false, boolean pCombo = true, dataset(Layout_RID_SrcID) pDataset=dataset([],Layout_RID_SrcID)) := 
  dx_header.Key_Rid_SrcID ( , pFastHeader, pCombo);
