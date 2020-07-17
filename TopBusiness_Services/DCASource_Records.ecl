// ================================================================================
// ======   RETURNS DCA DATA FOR A GIVEN ENTERPRISE_NUM IN ESP-COMPLIANT WAY  =====
// ================================================================================
IMPORT DCAV2, BIPV2, iesp, TopBusiness_Services, std;

EXPORT DCASource_Records(
  dataset(Layouts.rec_input_ids_wSrc) in_docids,
  TopBusiness_Services.SourceService_Layouts.OptionsLayout inoptions, 
	boolean IsFCRA = false) 
 := MODULE
 
 SHARED dca_layout_wLinkIds := RECORD
		TopBusiness_Services.Layouts.rec_input_ids_wSrc;
		DCAV2.Layouts.base.keybuildEntNum;
	END;

 SHARED dca_key_layout := RECORD
		DCAV2.Layouts.base.keybuild.Enterprise_num;
 END;

	// For in_docids records that don't have IdValue's retrieve them from linkid file
	in_docs_linkonly := PROJECT(in_docids(IdValue = ''),TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
																																		SELF := LEFT,
																																		SELF := []));
	
	// *** Key fetch to get enterprise_num from DCAV2 linkids key
  ds_dcakeys := PROJECT(TopBusiness_Services.Key_Fetches(in_docs_linkonly, // input file to join key with
								                                         inoptions.fetch_level ,TopBusiness_Services.Constants.defaultJoinLimit
																												).ds_dca_linkidskey_recs,
																TRANSFORM(Layouts.rec_input_ids_wSrc,
																					SELF.IdValue := LEFT.rawfields.Enterprise_num,
																					SELF := LEFT,
																					SELF := []));
																					
	dca_keys_comb := in_docids+ds_dcakeys;

	dca_keys := PROJECT(dca_keys_comb(IdValue != ''),TRANSFORM(dca_key_layout,SELF.Enterprise_num := LEFT.IdValue, SELF := []));
	
      dca_keys_dedup :=  DEDUP(SORT(dca_keys, Enterprise_num), Enterprise_num);
	
 	// Since there is no existing ???_Services.raw(???) that accesses DCA data, 
	// join input ds to DCA.key_EntNum on enterprise_num and use all
	// the data on the key file.
	dca_sourceview := join(dca_keys_dedup,DCAV2.Keys().EntNumNonFilt.qa,
	                         keyed(left.Enterprise_num = Right.Enterprise_num), 
												 transform(DCAV2.Layouts.base.keybuildEntNum,self := right),
												 limit(TopBusiness_Services.Constants.defaultJoinLimit,skip));

	dca_sourceview_wLinkIds := JOIN(dca_sourceview,dca_keys_comb,
																					LEFT.Enterprise_num = RIGHT.IdValue,
																					TRANSFORM(dca_layout_wLinkIds,
																							SELF := RIGHT,
																							SELF := LEFT),
																					KEEP(1));   // For cases in which a idvalue has multiple linkids;
	
	SHARED dca_sourceview_grp := GROUP(SORT(dca_sourceview_wLinkIds,Enterprise_num,-update_date,RECORD),Enterprise_num);
	
  // transforms for the iesp child dataset layouts used
	
	DATASET(iesp.rollupbizreport.t_SicCode) create_sics(DATASET(dca_layout_wLinkIds) L) := FUNCTION
		
		allSics := normalize(L,10,transform(iesp.rollupbizreport.t_SicCode,
																					self.Sic := choose(COUNTER,left.Sic1,left.Sic2,left.Sic3,left.Sic4,left.Sic5,
																										left.Sic6,left.Sic7,left.Sic8,left.Sic9,left.Sic10);
																					self.Description := choose(COUNTER,left.Text1,left.Text2,left.Text3,left.Text4,left.Text5,
																										left.Text6,left.Text7,left.Text8,left.Text9,left.Text10)));
		
		allSics_dedup := DEDUP(SORT(allSics(Sic != '' or Description != ''),RECORD),RECORD);
		RETURN(allSics_dedup);
	END;
	
	DATASET(iesp.share.t_CodeMap) create_naics(DATASET(dca_layout_wLinkIds) L) := FUNCTION
		
		allNaics := normalize(L,10,transform(iesp.share.t_CodeMap,
																					self.Code := choose(COUNTER,left.naics1,left.naics2,left.naics3,left.naics4,left.naics5,
																										left.naics6,left.naics7,left.naics8,left.naics9,left.naics10);
																					self.Description := choose(COUNTER,left.naics_text1,left.naics_text2,left.naics_text3,left.naics_text4,
																										left.naics_text5,left.naics_text6,left.naics_text7,left.naics_text8,left.naics_text9,left.naics_text10)));
		
		allNaics_dedup := DEDUP(SORT(allNaics(Code != '' or Description != ''),RECORD),RECORD);
		RETURN(allNaics_dedup);
	END;
	
	DATASET(iesp.directorycorpaffiliation.t_DCAContact) create_contacts(DATASET(dca_layout_wLinkIds) L) := FUNCTION
		
		allNames := normalize(L,10,transform(iesp.directorycorpaffiliation.t_DCAContact,
																			self.Name := choose(COUNTER,
																							left.Name_1,left.Name_2,left.Name_3,left.Name_4,left.Name_5,
																							left.Name_6,left.Name_7,left.Name_8,left.Name_9,left.Name_10);
																			self.Title := choose(COUNTER,
																							left.Title_1,left.Title_2,left.Title_3,left.Title_4,left.Title_5,
																							left.Title_6,left.Title_7,left.Title_8,left.Title_9,left.Title_10)));
		
		allNames_dedup := DEDUP(SORT(allNames,RECORD),RECORD);
		RETURN(allNames_dedup);
	END;
		
	DATASET(iesp.share.t_Name) create_executives(DATASET(dca_layout_wLinkIds) L) := FUNCTION
		
		allNames := normalize(L,10,transform(iesp.share.t_Name,
																			self.First  := choose(COUNTER,left.exec1_fname,left.exec2_fname,left.exec3_fname,left.exec4_fname,left.exec5_fname,
																															left.exec6_fname,left.exec7_fname,left.exec8_fname,left.exec9_fname,left.exec10_fname);  
																			self.Middle := choose(COUNTER,left.exec1_mname,left.exec2_mname,left.exec3_mname,left.exec4_mname,left.exec5_mname,
																															left.exec6_mname,left.exec7_mname,left.exec8_mname,left.exec9_mname,left.exec10_mname);  
																			self.Last   := choose(COUNTER,left.exec1_lname,left.exec2_lname,left.exec3_lname,left.exec4_lname,left.exec5_lname,
																															left.exec6_lname,left.exec7_lname,left.exec8_lname,left.exec9_lname,left.exec10_lname);  
																			self.Suffix := choose(COUNTER,left.exec1_name_suffix,left.exec2_name_suffix,left.exec3_name_suffix,left.exec4_name_suffix,left.exec5_name_suffix,
																															left.exec6_name_suffix,left.exec7_name_suffix,left.exec8_name_suffix,left.exec9_name_suffix,left.exec10_name_suffix);  
																			self.Prefix := choose(COUNTER,left.exec1_title,left.exec2_title,left.exec3_title,left.exec4_title,left.exec5_title,
																															left.exec6_title,left.exec7_title,left.exec8_title,left.exec9_title,left.exec10_title);  
																			self.Full := ''));
		
		allNames_dedup := DEDUP(SORT(allNames,RECORD),RECORD);
		RETURN(allNames_dedup);
	END;
	
	iesp.share.t_StringArrayItem xform_exchanges(dca_layout_wLinkIds L, integer C) := transform
	  self.value := choose(C,L.Exchange1,L.Exchange2,L.Exchange3,L.Exchange4,L.Exchange5,
		                       L.Exchange6,L.Exchange7,L.Exchange8,L.Exchange9,L.Exchange10,
                           L.Exchange11,L.Exchange12,L.Exchange13,L.Exchange14,L.Exchange15,
		                       L.Exchange16,L.Exchange17,L.Exchange18,L.Exchange19);
	end;

  // transform for the main output iesp record layout
  iesp.directorycorpaffiliation.t_DirectoryCorpAffiliationRecord toOut (dca_layout_wLinkIds L, 
																															DATASET(dca_layout_wLinkIds) allRows) := transform
		TopBusiness_Services.IDmacros.mac_IespTransferLinkids()
	  self.ProcessDate         := iesp.ECL2ESP.toDate ((integer4) L.process_date);
	  self.EnterpriseNumber    := L.Enterprise_num;
	  self.TypeOrig            := L.Type_orig;
	  self.CompanyName         := L.Name;
	  self.Note                := L.Note;
	  self.Level               := L.level;
	  self.Root                := L.Root;
	  self.Sub                 := L.Sub;
	  self.ParentName          := L.Parent_Name;
	  self.Phone               := L.Phone;
	  self.Fax                 := L.Fax;
	  self.Telex               := L.Telex;
	  self.Email               := L.E_mail;
	  self.Url                 := L.URL;
	  self.Incorp              := L.Incorp;
	  self.Earnings            := L.Earnings;
		// For the sales and Fye, for some reason not every record for the enterprise_num
		// contains a value, so use the first non blank values.
		self.Sales               := allRows(sales != '')[1].sales;
		self.FiscalYearEnd			 := allRows(fye != '')[1].fye; // Waiting on iesp change
	  self.SalesDescription    := allRows(Sales_Desc != '')[1].Sales_Desc;
	  self.Assets              := allRows(Assets != '')[1].Assets;
	  self.Liabilities         := allRows(Liabilities != '')[1].Liabilities;
	  self.NetWorth            := allRows(Net_Worth_ != '')[1].Net_Worth_;
	  self.EmployeeNumber      := (integer) std.str.FilterOut(allRows(EMP_NUM != '')[1].EMP_NUM,',');
	  self.BusinessDescription := L.Bus_Desc;
	  self.TickerSymbol        := L.Ticker_Symbol;
	  self.Address.StreetNumber        := L.prim_range;
	  self.Address.StreetPreDirection  := L.predir;
	  self.Address.StreetName          := L.prim_name;
	  self.Address.StreetSuffix        := L.addr_suffix;
	  self.Address.StreetPostDirection := L.postdir;
	  self.Address.UnitDesignation     := L.unit_desig;
	  self.Address.UnitNumber          := L.sec_range;
	  self.Address.StreetAddress1      := '';
	  self.Address.StreetAddress2      := '';
	  self.Address.City                := L.p_city_name;
	  self.Address.State               := L.st;
	  self.Address.Zip5                := L.zip;
	  self.Address.Zip4                := L.zip4;
	  self.Address.County              := L.county;
	  self.Address.PostalCode          := '';
	  self.Address.StateCityZip        := '';
		
		// Get all unique sics values for the group
		Siccs := create_sics(allRows);
		self.Sics       := choosen(Siccs,iesp.Constants.DCA.MAX_SICS);
		
		// Get all unique naics values for the group (Waiting on iesp change)
		Naics := create_naics(allRows);
		self.Naics       := choosen(Naics(Code != '' or Description != ''),iesp.Constants.DCA.MAX_NAICS);
		
		// Get all unique contacts for the group
		CNames := create_contacts(allRows);
		self.Contacts := choosen(CNames,iesp.Constants.DCA.MAX_CONTACTS);
		
		// Get all unique executives for the group
		ENames := create_executives(allRows);
		self.Executives := choosen(ENames,iesp.Constants.DCA.MAX_EXECUTIVES);

		self.Exchanges := normalize(dataset(L),iesp.Constants.DCA.MAX_EXCHANGES,
		                             xform_exchanges(left, counter));
		self := [];
  end;
	
	EXPORT SourceView_Recs := ROLLUP(dca_sourceview_grp, GROUP, toOUT(LEFT,ROWS(LEFT)));
  EXPORT SourceView_RecCount := COUNT(SourceView_Recs);
	
END;
