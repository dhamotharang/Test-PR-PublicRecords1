//=================================================================================
// ====== RETURNS SHEILA GRECO DATA FOR A MAINCOMPANYID IN ESP-COMPLIANT WAY. =====
// ================================================================================
//
import Sheila_Greco, iesp, BIPV2, ut, codes, std, doxie;

export SheilaGrecoSource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  SourceService_Layouts.OptionsLayout inoptions,
	doxie.IDataAccess mod_access, 
	boolean IsFCRA = false) 
 := MODULE

	// There isn't any key file for sheila greco to build the source doc from, for this reason
	// the payload file of the linkid key file will be used.
	in_docs_linkonly := PROJECT(in_docids,TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
																																		
	// *** Key fetch to get sgreco data
  SHARED sgreco_recs := Sheila_Greco.Key_LinkIds.KFetch(in_docs_linkonly, mod_access,
	                                                      inoptions.fetch_level,,
																												TopBusiness_Services.Constants.DefaultJoinLimit);
	
	SHARED sgreco_idValue := JOIN(sgreco_recs,in_docids,
                             BIPV2.IDmacros.mac_JoinLinkids(inoptions.fetch_level) AND                                                                               
                             (((string) left.source_rec_id = right.IdValue AND 
                             right.IdType = Constants.sourcerecid) OR
                             (right.IdValue = '')),
                             TRANSFORM(LEFT));

	iesp.directorycorpaffiliation.t_DirectoryCorpAffiliationRecord toOut(recordof(sgreco_idValue) L) := TRANSFORM
			IDmacros.mac_IespTransferLinkids(UseIdValue:=false)
			self.CompanyId					 := L.rawfields.maincompanyid;
			self.TickerSymbol        := L.rawfields.ticker;
			self.FortuneRank    		 := L.rawfields.fortunerank;
			self.PrimaryIndustry		 := L.rawfields.primaryindustry;
			self.Phone               := L.clean_phones.phone;
			self.Url                 := L.rawfields.weburl;
			// Cast to a real for the decimal, then the computationaional result to integer to drop the decimal values from the output
			self.Sales               := (string) ((integer)((REAL8) L.rawfields.sales * 1000000));
			self.EmployeeNumber      := (integer) stringlib.StringFilterOut(L.rawfields.employees,',');
			self.DivisionName				 := L.rawfields.divisionname;
			self.Auditor						 := L.rawfields.auditor;
			self.EntryDate         	 := iesp.ECL2ESP.toDate ((integer4) L.clean_dates.entrydate);
			self.LastUpdate    	 		 := iesp.ECL2ESP.toDate ((integer4) L.clean_dates.lastupdate);
			self.BusinessDescription := L.rawfields.description;
			SELF.Address := iesp.ECL2ESP.setAddress(
															L.clean_address.prim_name,L.clean_address.prim_range,
															L.clean_address.predir,L.clean_address.postdir,
															L.clean_address.addr_suffix,L.clean_address.unit_desig,
															L.clean_address.sec_range,L.clean_address.v_city_name,
															L.clean_address.st,L.clean_address.zip,L.clean_address.zip4,'','',
															L.rawfields.address1,L.rawfields.address2);
															
			// Create a dataset of siccodes by splitting on comma.	
			sic_dset := DATASET([Std.Str.SplitWords(L.rawfields.siccode,',')],{string siccode});
			//Only output sic codes that are valid (length of 4).
			self.Sics := PROJECT(CHOOSEN(sic_dset(length(siccode)=4),iesp.Constants.DCA.MAX_SICS),TRANSFORM(iesp.rollupbizreport.t_SicCode,
																							SELF.Sic := LEFT.siccode,
																							SELF.Description := Codes.Key_SIC4(keyed(sic4_code = LEFT.siccode))[1].sic4_description;,
																							SELF := []));
			
			// Create a datatset of competitors by splitting on comma
			competitor_dset := DATASET([Std.Str.SplitWords(L.rawfields.competitors,',')],{string competitor});
			self.Competitors := PROJECT(CHOOSEN(competitor_dset,iesp.Constants.DCA.MAX_COMPETITORS),TRANSFORM(iesp.share.t_StringArrayItem,
																							SELF.value := LEFT.competitor,
																							SELF := []));
																							
			SELF := [];
	END;
	
	SourceView_RecsIesp := PROJECT(sgreco_idValue, toOut(left));

	EXPORT SourceView_Recs := DEDUP(SourceView_RecsIesp,ALL,HASH,EXCEPT businessIds.ultid,businessIds.orgid,businessIds.seleid,businessIds.proxid,
																							businessIds.dotid,businessIds.empid,businessIds.powid);
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);

END;
