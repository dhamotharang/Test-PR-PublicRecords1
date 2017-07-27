// ================================================================================
// ======      RETURNS InfoUSA_ABIUS DATA FOR A GIVEN ROOT&SUB IN ESP-COMPLIANT WAY     =====
// ================================================================================
IMPORT InfoUSA, BIPV2, iesp, MDR, ut;

EXPORT InfoUSA_ABIUSSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE

	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																												
	// *** Key fetch to get abi_number from linkids
  SHARED infousa_abius_recs := InfoUSA.Key_ABIUS_LinkIds.kFetch(DEDUP(in_docs_linkonly,ALL),
	                                                 inoptions.fetch_level,,
																									 TopBusiness_Services.Constants.SlimKeepLimit);

	SHARED infousa_abius_idValue := JOIN(infousa_abius_recs,in_docids,
                             BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
                             (((string) left.source_rec_id = right.IdValue AND 
                             right.IdType = Constants.sourcerecid) OR
														 (right.IdValue = left.abi_number AND
														 right.IdType = Constants.busvlid) OR
														 right.IdValue = ''),
                             TRANSFORM(LEFT));									

	SHARED infousa_abius_recs_grp := GROUP(DEDUP(SORT(infousa_abius_idValue,abi_number,contact_name),abi_number,contact_name),abi_number);
	
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(infousa_abius_recs_grp L) := TRANSFORM
		SELF.Name := iesp.ECL2ESP.setName(L.fname, '', L.lname, '', '');
		SELF.Title := L.title;
		SELF := [];
	END;
	
	iesp.topbusinessOtherSources.t_OtherSICCode xform_sic(infousa_abius_idValue L, INTEGER C) := TRANSFORM
		SELF.Code								:= CHOOSE(C, L.sic_cd, L.secondary_sic_1, L.secondary_sic_2,
																				L.secondary_sic_3, L.secondary_sic_4);
		
		SELF.Description := CHOOSE(C, L.sic_desc, L.secondary_sic_desc1, L.secondary_sic_desc2,
																 L.secondary_sic_desc3, L.secondary_sic_desc4);
	END;

	
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(infousa_abius_recs_grp) L, 
																									DATASET(recordof(infousa_abius_recs_grp)) allRows) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
    SELF.IDValue								:= L.abi_number;		
		SELF.Source 								:= MDR.sourceTools.src_INFOUSA_ABIUS_USABIZ;
		SELF.CompanyName        		:= L.company_name;
		SELF.BusinessDescription		:= L.Industry_Desc;
		SELF.Address := iesp.ECL2ESP.setAddress('','','','','','','',
																						L.city1,L.state1,L.zip1_5, L.zip1_4,'','',L.street1,);
		SELF.Phone									:= L.phone;
									
		sic_norm := NORMALIZE(allRows, iesp.Constants.USABIZ.MAX_SICS, xform_sic(LEFT, COUNTER));
		
		sic_deduped := DEDUP(SORT(sic_norm, code), code);
												
		SELF.SicCodes 							:= PROJECT(sic_deduped, transform(iesp.topbusinessOtherSources.t_OtherSICCode,
																															SELF := LEFT));
																							
		SELF.Contacts 							:= PROJECT(allRows, xform_contacts(LEFT));
		SELF.SecondaryPhone					:= L.Fax;
		SELF := [];
	END;

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(RECORDOF(infousa_abius_recs_grp) L,
																										DATASET(recordof(infousa_abius_recs_grp)) allRows) := TRANSFORM
			self.src			:= 'IA';
			self.src_desc := 'InfoUSA ABIUS';
			self.hasName  := IF(EXISTS(allRows(company_name <> '')), true, false);
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= IF(EXISTS(allRows(street1<>'')), true, false);
		  self.hasPhone := IF(EXISTS(allRows(phone<>'')), true, false);
			self := [];
	END;

	EXPORT SourceDetailInfo := ROLLUP(infousa_abius_recs_grp, GROUP, xform_Details(LEFT,ROWS(LEFT)));
	EXPORT SourceView_Recs := ROLLUP(infousa_abius_recs_grp, GROUP, toOUT(LEFT,ROWS(LEFT)));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;