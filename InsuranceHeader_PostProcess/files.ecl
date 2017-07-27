import data_services, InsuranceHeader_PostProcess;
export files := module;

  export location := Data_Services.Data_Location.Prefix('IDL_Header');

	shared cluster := 'thor_data400::';
	shared ProjectName := 'base::insuranceheader::';
	shared filePrefix := location + cluster + ProjectName;
	
	/*----------------- Mapping between IDL - BocaDID -------------------------------------------------- */
	EXPORT FILE_MAP_IDL_BOCADID					:= filePrefix + 'mapping_idl_bocadid';
	export DS_MAP_IDL_BOCADID           := DATASET(FILE_MAP_IDL_BOCADID, layout_map_idl_bocadid, thor);
	
	EXPORT FILE_MAP_IDL_BOCADID_FATHER	:= filePrefix + 'mapping_idl_bocadid_father';
	export DS_MAP_IDL_BOCADID_FATHER    := DATASET(FILE_MAP_IDL_BOCADID_FATHER, layout_map_idl_bocadid, thor);

	/*----------------- DID RID -------------------------------------------------- */
	EXPORT FILE_DID_RID					:= filePrefix + 'did_rid';
	export DS_DID_RID          	:= DATASET(FILE_DID_RID, layout_did_rid, thor);
	
	EXPORT FILE_DID_RID_FATHER	:= filePrefix + 'did_rid_father';
	export DS_DID_RID_FATHER   	:= DATASET(FILE_DID_RID_FATHER, layout_did_rid, thor);
	
	/*----------------- Header Segmentation ------------------------------------------ */
	EXPORT FILE_HDR_SEGMENTATION						:= filePrefix + 'SEGMENTATION';
	EXPORT DS_HDR_SEGMENTATION			   			:= DATASET(FILE_HDR_SEGMENTATION, InsuranceHeader_PostProcess.layout_corecheck, thor);
	
	EXPORT FILE_HDR_SEGMENTATION_FATHER			:= filePrefix + 'SEGMENTATION_FATHER';
	EXPORT DS_HDR_SEGMENTATION_FATHER 			:= DATASET(FILE_HDR_SEGMENTATION_FATHER, InsuranceHeader_PostProcess.layout_corecheck, thor);	
	
	/*-------------------- updateMappingSuperFiles ----------------------------------------------------*/
	export updateMappingSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_MAP_IDL_BOCADID, 
																									 FILE_MAP_IDL_BOCADID_FATHER], inFile, true)
							);
		return action;
	END;	
	
	/*-------------------- updateDIDRIDSuperFiles ----------------------------------------------------*/
	export updateDIDRIDSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_DID_RID, 
																									 FILE_DID_RID_FATHER], inFile, true)
							);
		return action;
	END;	
	
	/*-------------------- updateSegmentationSuperFiles ----------------------------------------------------*/
	export updateSegmentationSuperFiles(string inFile) := FUNCTION
		action := Sequential(
								FileServices.PromoteSuperFileList([FILE_HDR_SEGMENTATION, 
																									 FILE_HDR_SEGMENTATION_FATHER], inFile, true)
							);
		return action;
	END;		
end;