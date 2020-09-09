IMPORT LN_PropertyV2,LN_PropertyV2_Fast;
EXPORT ReplaceRecords (dataset(recordof(LN_PropertyV2_Fast.Layout_prep_assessment)) assessmntR,
                       dataset(recordof(LN_PropertyV2_Fast.Layout_prep_deed_mortg)) deedMortgR,
                       dataset(recordof(LN_PropertyV2_Fast.Layout_prep_addl_names)) addlNamesR,
                       dataset(recordof(LN_PropertyV2_Fast.Layout_prep_addl_legal)) addlLegalR,
                       dataset(recordof(LN_PropertyV2_Fast.Layout_prep_search_prp)) searchPrpR,
											 dataset(recordof(LN_PropertyV2_Fast.Layout_prep_addl_name_info)) addlNameInfoR
                                                                                                ) := MODULE

  SHARED aR := project(assessmntR(Append_ReplRecordInd='Y'),LN_PropertyV2.Layout_Property_Common_Model_BASE);
  SHARED aN := project(assessmntR(Append_ReplRecordInd<>'Y'),LN_PropertyV2.Layout_Property_Common_Model_BASE);
  SHARED dR := project(deedMortgR(Append_ReplRecordInd='Y'),LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE);
  SHARED dN := project(deedMortgR(Append_ReplRecordInd<>'Y'),LN_PropertyV2.Layout_Deed_Mortgage_Common_Model_BASE);
  SHARED nR := project(addlNamesR(Append_ReplRecordInd='Y'),LN_PropertyV2.layout_addl_names);
  SHARED nN := project(addlNamesR(Append_ReplRecordInd<>'Y'),LN_PropertyV2.layout_addl_names);
  SHARED gR := project(addlLegalR(Append_ReplRecordInd='Y'),LN_PropertyV2.Layout_Addl_legal);
  SHARED gN := project(addlLegalR(Append_ReplRecordInd<>'Y'),LN_PropertyV2.Layout_Addl_legal);
  SHARED sR := project(searchPrpR(Append_ReplRecordInd='Y'),LN_PropertyV2.Layout_DID_Out);
  SHARED sN := project(searchPrpR(Append_ReplRecordInd<>'Y'),LN_PropertyV2.Layout_DID_Out);
	SHARED fR := project(addlNameInfoR(Append_ReplRecordInd='Y'),LN_PropertyV2.layout_addl_name_info);
	SHARED fN := project(addlNameInfoR(Append_ReplRecordInd<>'Y'),LN_PropertyV2.layout_addl_name_info);
    
  
  EXPORT assessmnt      := LN_PropertyV2_Fast.replace_LN_AssessorDeeds.replace_assessor      (               		 aR,aN);
  EXPORT deedMortg      := LN_PropertyV2_Fast.replace_LN_AssessorDeeds.replace_deeds         (       dR,dN            );
  EXPORT addlNames      := LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Addl_Names  (nR,nN, deedMortg,  assessmnt);
	EXPORT addlLegal      := LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Addl_Legal  (gR,gN, deedMortg,  assessmnt);
	EXPORT searchPrp      := LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Search      (sR,sN, deedMortg,  assessmnt);
	EXPORT addlNameInfo   := LN_PropertyV2_Fast.replace_LN_searchAddlnames.Replace_Addl_Name_Info(fR,fN, deedMortg			);
         
END;