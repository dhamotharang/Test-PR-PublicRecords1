// ================================================================================
// ======      RETURNS TXBUS DATA FOR A GIVEN ROOT&SUB IN ESP-COMPLIANT WAY     =====
// ================================================================================
IMPORT BIPV2, iesp, MDR, TXBUS, TXBUSV2_Services, ut;

EXPORT TxbusSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE

	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get taxpayer_number from linkids
  SHARED txbus_recs := TXBUS.Key_TXBUS_LinkIds.keyfetch(DEDUP(in_docs_linkonly,ALL),
	                   inoptions.fetch_level,,TopBusiness_Services.Constants.SlimKeepLimit);

	SHARED txbus_recs_sorted := DEDUP(SORT(txbus_recs, taxpayer_number, outlet_number, -dt_last_seen), 
																taxpayer_number, outlet_number);
	
	SHARED txbus_idValue := JOIN(txbus_recs_sorted,in_docids,
										BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND	                			
										((string) left.taxpayer_number = right.IdValue OR
										(right.IdValue = '')),
										TRANSFORM(LEFT));
	 
	SHARED iesp.topbusinessOtherSources.t_OtherContact xform_contacts(txbus_idValue L) := TRANSFORM
		SELF.Name := iesp.ECL2ESP.setName('', '', '', '', '', L.taxpayer_name);
		SELF._type := 'Taxpayer';
		SELF.Phone := L.taxpayer_phone;
		SELF := [];
	END;	
	
  // transforms for the iesp child dataset layouts used
	SHARED iesp.topbusinessOtherSources.t_OtherSourceRecord toOut(RECORDOF(txbus_idValue) L) := TRANSFORM
		IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
		SELF.Source 								:= MDR.sourceTools.src_TXBUS;
		SELF.CompanyName        		:= L.outlet_name;
		SELF.CompanyOrgStructure		:= L.taxpayer_org_type_desc;
		SELF.Address := iesp.ECL2ESP.setAddress(
															L.outlet_prim_name, L.outlet_prim_range, L.outlet_predir, L.outlet_postdir, 
															L.outlet_addr_suffix, L.outlet_unit_desig, L.outlet_sec_range, L.outlet_v_city_name, 
															L.outlet_st, L.outlet_zip5, L.outlet_zip4,'');
		SELF.Phone									:= L.outlet_phone;
		SELF.NAICSCodes := DATASET([{L.outlet_naics_code, ''}], iesp.topbusinessOtherSources.t_otherNAICSCodes);
		SELF.Contacts 							:= PROJECT(L, xform_contacts(LEFT));
		SELF.IdValue								:= L.taxpayer_number;
		SELF := [];
	END;
	
	SHARED SourceCount_Layouts.SourceDetailsLayout xform_Details(RECORDOF(txbus_idValue) L) := TRANSFORM
			self.src			:= 'TX';
			self.src_desc := 'TXBUS';
			self.hasName 	:= (L.taxpayer_name<>'');
			self.hasSSN  	:= false;
			self.hasDOB  	:= false;
		  self.hasFEIN 	:= false;		
			self.hasAddr 	:= (L.taxpayer_prim_name<>'');
		  self.hasPhone := (L.taxpayer_phone<>'');
			self := [];
	END;
	
	EXPORT SourceDetailInfo := PROJECT(txbus_recs_sorted,xform_Details(LEFT));
	SourceView_RecsIesp := PROJECT(txbus_recs_sorted, toOut(left));
	EXPORT SourceView_Recs := SourceView_RecsIesp;
	EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;