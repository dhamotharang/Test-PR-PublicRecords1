// ================================================================================
// ======  RETURNS InfoUSA_Deadco DATA FOR A GIVEN ROOT&SUB IN ESP-COMPLIANT WAY =====
// ================================================================================
IMPORT InfoUSA, BIPV2, iesp, MDR, ut, doxie;

EXPORT InfoUSA_DeadcoSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions,
	doxie.IDataAccess mod_access, 
	boolean IsFCRA = false) 
 := MODULE

	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																						
	// *** Key fetch to get abi_number from linkids
  SHARED infousa_deadco_recs := InfoUSA.Key_deadco_LinkIds.kFetch(
	                       DEDUP(in_docs_linkonly,ALL), mod_access, inoptions.fetch_level,,
												 TopBusiness_Services.Constants.SlimKeepLimit);

	SHARED infousa_deadco_idValue := JOIN(infousa_deadco_recs,in_docids,
                             BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
                             (((string) left.source_rec_id = right.IdValue AND 
                             right.IdType = Constants.sourcerecid) OR
														 (right.IdValue = left.abi_number + left.production_date AND
														 right.IdType = Constants.busvlid) OR
														 right.IdValue = ''),
                             TRANSFORM(LEFT));									

	SHARED infousa_deadco_recs_grp := DEDUP(SORT(infousa_deadco_idValue,abi_number,production_date),abi_number,production_date);
	
	iesp.topbusinessOtherSources.t_OtherSICCode xform_sic(infousa_deadco_idValue L, INTEGER C) := TRANSFORM
		SELF.Code								:= CHOOSE(C, L.sic_cd, L.secondary_sic_1, L.secondary_sic_2,
																				L.secondary_sic_3, L.secondary_sic_4);
		
		SELF.Description := CHOOSE(C, L.sic_desc, L.secondary_sic_desc1, L.secondary_sic_desc2,
																 L.secondary_sic_desc3, L.secondary_sic_desc4);
	END;
	
		SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(recordof(infousa_deadco_recs_grp) L) := TRANSFORM
		
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
    SELF.IDValue								:= L.abi_number + L.production_date;		
		SELF.Source 								:= MDR.sourceTools.src_INFOUSA_DEAD_COMPANIES;
		SELF.CompanyName        		:= L.company_name;
		SELF.BusinessDescription		:= L.Industry_Desc;
		SELF.Address := iesp.ECL2ESP.setAddress('','','','','','','',
																						L.city1,L.state1,L.zip1_5, L.zip1_4,'','',L.street1,);
		SELF.Phone									:= L.phone;

		SELF.SicCodes :=	DATASET([{L.primary_sic, L.sic_desc},{L.secondary_sic_1, L.secondary_sic_desc1},
																{L.secondary_sic_2,L.secondary_sic_desc2},{L.secondary_sic_3,L.secondary_sic_desc3},
																{L.secondary_sic_4,L.secondary_sic_desc4}], iesp.topbusinessOtherSources.t_otherSICCode);
		
		SELF.Contacts := DATASET([{'',L.fname,'',L.mname, L.lname,L.name_suffix,L.title,'',
																		L.contact_prof_title,'',0,0,0,'','',''}],iesp.topbusinessOtherSources.t_OtherContact);
		SELF.SecondaryPhone					:= L.Fax;
		SELF := [];
	END;

	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(RECORDOF(infousa_deadco_recs_grp) L) := TRANSFORM
			
			self.src			:= 'IA';
			self.src_desc := 'InfoUSA Deadco';
			self.hasName  := IF(L.company_name <> '', true, false);
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= IF(L.street1<>'', true, false);
		  self.hasPhone := IF(L.phone<>'', true, false);
			self := [];
	END;

	EXPORT SourceDetailInfo := PROJECT(infousa_deadco_recs_grp, xform_Details(LEFT));
	EXPORT SourceView_Recs := PROJECT(infousa_deadco_recs_grp, toOUT(LEFT));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;