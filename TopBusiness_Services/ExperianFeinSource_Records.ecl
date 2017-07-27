// ================================================================================
// ===== RETURNS Experian FEIN Source Doc records in an ESP-COMPLIANT WAY ====
// ================================================================================
IMPORT iesp, BIPV2, Suppress, TopBusiness_Services;

EXPORT ExperianFeinSource_Records (
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 	
	// There isn't any unique id key file for experian fein to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get experian fein data
  fein_recs_all := TopBusiness_Services.Key_Fetches(DEDUP(in_docs_linkonly,ALL),
													                          inoptions.fetch_level
																							     ).ds_expfein_linkidskey_recs;
	
		// If a non-blank idvalue was passed in, join to match on source_rec_id.
	fein_recs := JOIN(fein_recs_all,in_docids,
	                             BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND
															 (right.IdValue = '' OR
															 (right.IdType = Constants.taxid AND
									              left.norm_tax_id = right.IdValue) OR
															 (right.IdType = Constants.busvlid AND
									              TRIM(left.business_identification_number) + TRIM(left.norm_tax_id) = right.IdValue)),
										         TRANSFORM(LEFT));
														 
	fein_recs_sort := DEDUP(GROUP(SORT(fein_recs,norm_tax_id),norm_tax_id), business_name, business_address, business_city, business_state, business_zip);
			
  iesp.fein.t_FEINCompanyInfo xform_companyinfo(recordof(fein_recs_sort) L) := TRANSFORM
	  SELF.CompanyName    := L.business_name;
		SELF.AddressRecords := iesp.ECL2ESP.setAddress(
															L.prim_name,L.prim_range,L.predir,L.postdir,L.addr_suffix,L.unit_desig,
															L.sec_range,L.v_city_name,L.st,L.zip,L.zip4,'','',L.business_address,);
		SELF := [];
	end;

 iesp.fein.t_FEINSearchRecord toOut(recordof(fein_recs_sort) l, DATASET(recordof(fein_recs_sort)) allRows) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
	  SELF.AlsoFound := false;
		// Set the FEIN mask level. If the ssn_mask option is NONE then that means the user can see full
		// SSN's regardless of the source (E5). Otherwise, set the mask level to the ssn_mask passed
		// if the output contains records from source E5, NOTE: In cases were there are E5 and E6 souces
		// for the same source record, we'll assume E5.
		mask_type := IF(inoptions.ssn_mask != 'NONE' and EXISTS(allRows(source = 'E5')),inoptions.ssn_mask,'NONE');
		SELF.FEINSource := IF(EXISTS(allRows(source = 'E5')),'E5',l.source);
		SELF.FEIN      := Suppress.ssn_mask(L.norm_tax_id,mask_type);
		SELF.FEINCompanyInfoRecords := PROJECT(CHOOSEN(allRows,iesp.Constants.DNBFEIN.MAX_COMPANIES),
																										xform_companyinfo(left));
		SELF := [];
  end;
	
	EXPORT SourceView_Recs := ROLLUP(fein_recs_sort, GROUP, toOut(left,ROWS(left)));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;
