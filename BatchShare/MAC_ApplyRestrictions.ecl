//This Function Macro accepts any DS of DIDs and sources and in_params
//with all restrictions and suppression fields as in doxie/IDataAccess
//It then removes any record containing SRC that should be restricted per the in_params
EXPORT MAC_ApplyRestrictions(in_ds,in_params,_pSSN = 'ssn',_pDID = 'did',_pDateFS = 'dt_first_seen'):= FUNCTIONMACRO
	IMPORT doxie, mdr, Suppress;

	//FILTERS
	is_glb_preGlb_safe := in_params.isValidGLB (in_params.check_RNA_)
							           OR in_params.isHeaderPreGLB(0, in_ds._pDateFS, in_ds.src);
												 
	is_dppa_safe := ~mdr.Source_is_DPPA(in_ds.src)
							    OR (in_params.isValidDPPA(in_params.check_RNA_)
									    AND in_params.isValidDPPAState(mdr.sourceTools.DPPAOriginState(in_ds.src), in_ds.src));
											
	is_DRM_safe := ~in_params.isHeaderSourceRestricted(in_ds.src);
	
	is_industry_class_safe := ~(in_ds.src in MDR.sourceTools.set_Utilities 
	                             AND in_params.isUtility()); //'UTILI'

	// apply restrictions for GLB,DPPA,RNA,DRM,INDUSTRY_CLASS
	glb_dppa_DRM_IC_safe_ds := in_ds(is_glb_preGlb_safe AND is_dppa_safe
					                         AND is_DRM_safe AND is_industry_class_safe);

	//MINORS - we suppress all minor (age 0-18) records unless glb purpose is 2 (law enforcement) or IncludeMinors flag is TRUE.
  minor_safe_ds := doxie.compliance.MAC_FilterOutMinors (glb_dppa_DRM_IC_safe_ds, , , in_params.show_minors);

	//SUPPRESSION - we suppress all records found in our suppression keys
	Suppress.MAC_Suppress(minor_safe_ds,supp_DID_safe_ds,in_params.application_type,Suppress.Constants.LinkTypes.DID,_pDID);
  Suppress.MAC_Suppress(supp_DID_safe_ds,supp_SSN_safe_ds,in_params.application_type,Suppress.Constants.LinkTypes.SSN,_pSSN);
	//SSN PRUNING
	doxie.MAC_PruneOldSSNs(supp_SSN_safe_ds,recs_pruned,_pSSN,_pDID);
	//SSN MASKING
	Suppress.MAC_Mask(recs_pruned,recs_masked,_pSSN,none,true,false,,,,in_params.ssn_mask);

	out_final := IF(in_params.suppress_and_mask,recs_masked,minor_safe_ds);

	RETURN out_final;
ENDMACRO;