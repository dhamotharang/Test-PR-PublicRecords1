IMPORT AutoStandardI, DCAV2, BIPV2, iesp, MDR, TopBusiness_Services, ut, std;

EXPORT LNCASection := MODULE


 // *********** Main function to return LNCA section of the report.
 EXPORT fn_FullView(
   dataset(SupplierRisk_Services.SupplierRisk_Layouts.rec_input_ids) ds_in_ids
	 ,SupplierRisk_Services.SupplierRisk_Layouts.Section_options in_options
	                   ):= FUNCTION 
  
	UNSIGNED2 MaxTreeDepth := 9;  // Depth is actually 10, but ultimate parent is retrieved outside the loop.
	UNSIGNED3 MaxStringLen := 200000;
	UNSIGNED1 HierLenError := 200;   // Error code to indicate that the output length has been exceeded.
	// A constant fake group Id is added to every company record within the hierarchy so that
	// the records can be grouped on a common value. Value has no meaning whatsover.
	STRING1 Fake_groupID := 'A';
	
	slim_hierRec := RECORD
	 	STRING9			enterprise_num;
		STRING9 		parent_enterprise_number;
		STRING2			child_level;
		INTEGER 		grpLevel;
		UNSIGNED1		numPrecEndTags := 0;
		UNSIGNED2 	sub_group_id1 := 0;
		UNSIGNED2 	sub_group_id2 := 0;
		UNSIGNED2 	sub_group_id3 := 0;
		UNSIGNED2 	sub_group_id4 := 0;
		UNSIGNED2 	sub_group_id5 := 0;
		UNSIGNED2 	sub_group_id6 := 0;
		UNSIGNED2 	sub_group_id7 := 0;
		UNSIGNED2 	sub_group_id8 := 0;
		UNSIGNED2 	sub_group_id9 := 0;
	END;

	full_HierRec := RECORD
			STRING9					enterprise_num;
			STRING9 				parent_enterprise_number;
			STRING2					child_level := '';
			INTEGER 				grpLevel := 0;
			UNSIGNED1				numPrecEndTags := 0;
			BOOLEAN					lastRec := FALSE;
			STRING1					dummyGroupField := Fake_groupId;
			UNSIGNED2 			sub_group_id1 := 0;
			UNSIGNED2 			sub_group_id2 := 0;
			UNSIGNED2 			sub_group_id3 := 0;
			UNSIGNED2 			sub_group_id4 := 0;
			UNSIGNED2 			sub_group_id5 := 0;
			UNSIGNED2 			sub_group_id6 := 0;
			UNSIGNED2 			sub_group_id7 := 0;
			UNSIGNED2 			sub_group_id8 := 0;
			UNSIGNED2 			sub_group_id9 := 0;
			UNSIGNED6   		bdid;
			STRING105   		name;
			STRING10        prim_range;
			STRING2         predir;
			STRING28        prim_name;
			STRING4         addr_suffix;
			STRING2         postdir;
			STRING10        unit_desig;
			STRING8         sec_range;
			STRING25        p_city_name;
			STRING25        v_city_name;
			STRING2         st;
			STRING5         z5;                   
	END;

	hierXMLRec := RECORD
			STRING 			company;
			STRING9			enterprise_num;
			STRING9 		parent_enterprise_number;
			STRING2			child_level;
			INTEGER 		grpLevel;
			STRING1			dummyGroupField;
			UNSIGNED1		numPrecEndTags := 0;
			UNSIGNED2 	sub_group_id1 := 0;
			UNSIGNED2 	sub_group_id2 := 0;
			UNSIGNED2 	sub_group_id3 := 0;
			UNSIGNED2 	sub_group_id4 := 0;
			UNSIGNED2 	sub_group_id5 := 0;
			UNSIGNED2 	sub_group_id6 := 0;
			UNSIGNED2 	sub_group_id7 := 0;
			UNSIGNED2 	sub_group_id8 := 0;
			UNSIGNED2 	sub_group_id9 := 0;
	END;
	endTags := [	'</Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>',
								'</Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company></Subsidiaries></Company>'];

	XMLOutRec := RECORD
			STRING200000	 	hierarchy;
			STRING1					dummyGroupField;
			UNSIGNED1				hier_err_code := 0;
	END;
	
	exec_layout := RECORD
			STRING50		title;
			STRING70		name;
	END;
	
	code_layout := RECORD
			STRING7 code;
			STRING150 description;
	END;
	
	lncaFirmRec := RECORD
			UNSIGNED6				bdid;
			STRING9					enterprise_num;
			STRING8					process_date;
			STRING8					update_date;
			STRING1					dummyGroupField;
			STRING70        Type_orig;
			STRING105       name;
			STRING107       Note;
			STRING2         Incorp;
			STRING5       	percent_owned;
			STRING12        Earnings;
			STRING12       	Sales;
			STRING15        Sales_Desc;
			STRING12       	assets;
			STRING12        liabilities;
			STRING12        Net_Worth_;
			STRING6         FYE;
			STRING9         EMP_NUM;
			STRING1         Import_orig;
			STRING1         Export_orig;
			STRING1502      Bus_Desc;
			DATASET(code_layout) siccodes;
			DATASET(code_layout) naicodes;
			DATASET(exec_layout) executives;
			STRING11        Ticker_Symbol;
			STRING7         Exchange1;
			STRING6         Exchange2;
			STRING6         Exchange3;
			STRING6         Exchange4;
	END;
	
	lncaOutRec := RECORD
			STRING200000 		hierarchy := '';
			UNSIGNED1				hier_err_code := 0;
			lncaFirmRec;
	END;
	
	FETCH_LEVEL := in_options.ReportFetchLevel;

  // Strip off the input acctno from each record, will re-attach them later.
	ds_in_unique_ids_only := PROJECT(ds_in_ids,transform(BIPV2.IDlayouts.l_xlink_ids,
	                                                       self := left));

  //
  // *** Key fetch to get lnca key linking data from BIP2 linkids key file.
  ds_dca_recs := DCAV2.Key_LinkIds.kFetch(
	                         ds_in_unique_ids_only, ,// input file to join key with
													 FETCH_LEVEL); // level of ids to join with
							  					 // 3rd parm is ScoreThreshold, take default of 0

	
	// Sort the highest and the most recent non level 0 record to the top. We want the highest non level 0 when available
	// since with the lnca data we have stamped linkids on records fro which lnca/dca have as an outlier 
	// within the hierarchy tree. These outliers are treated as companies to themsleves hense they have a
	// level of 0. This tends to occur in very large companies (Time warner) in which these are branch offices
	// that Lexis has enough info to create likids for them, but lnca doesn't have them under the ultimate parent umbrella.
	dca_rec := CHOOSEN(SORT(ds_dca_recs,rawfields.level = '0',rawfields.level,-date_vendor_last_reported,rawfields.enterprise_num,RECORD),1);
	
	// Get the lnca info for the most recent enterprise number.
	comp_lnca_info :=
			JOIN(
				dca_rec, DCAV2.Keys().EntNumNonFilt.qa,
				KEYED(LEFT.rawfields.enterprise_num = RIGHT.enterprise_num),
				TRANSFORM(DCAV2.Layouts.base.keybuildEntNum, SELF := RIGHT),
				LIMIT(ut.limits.default, SKIP));
	
	// There are several records per enterprise number in the key and not every one has an sales,fye
	// and desc value, roll up the reocrds on enterprise number to get these values.
	comp_lnca_sort := GROUP(SORT(comp_lnca_info,enterprise_num,-update_date,RECORD),enterprise_num);
		
	DATASET(code_layout) create_sics(DATASET(DCAV2.Layouts.base.keybuildEntNum) L) := FUNCTION
		
		allSics := normalize(L,10,transform(code_layout,
																					self.code := choose(COUNTER,left.Sic1,left.Sic2,left.Sic3,left.Sic4,left.Sic5,
																										left.Sic6,left.Sic7,left.Sic8,left.Sic9,left.Sic10);
																					self.description := choose(COUNTER,left.Text1,left.Text2,left.Text3,left.Text4,left.Text5,
																										left.Text6,left.Text7,left.Text8,left.Text9,left.Text10)));
		
		allSics_dedup := DEDUP(allSics(code != '' or description != ''),ALL);
		RETURN(allSics_dedup);
	END;
	
	DATASET(code_layout) create_naics(DATASET(DCAV2.Layouts.base.keybuildEntNum) L) := FUNCTION
		
		allNaics := normalize(L,10,transform(code_layout,
																					self.code := choose(COUNTER,left.naics1,left.naics2,left.naics3,left.naics4,left.naics5,
																										left.naics6,left.naics7,left.naics8,left.naics9,left.naics10);
																					self.description := choose(COUNTER,left.naics_text1,left.naics_text2,left.naics_text3,left.naics_text4,
																										left.naics_text5,left.naics_text6,left.naics_text7,left.naics_text8,left.naics_text9,left.naics_text10)));
		
		allNaics_dedup := DEDUP(allNaics(code != '' or description != ''),ALL);
		RETURN(allNaics_dedup);
	END;
	
	DATASET(exec_layout) create_executives(DATASET(DCAV2.Layouts.base.keybuildEntNum) L) := FUNCTION
		
		allNames := normalize(L,10,transform(exec_layout,  
																			self.name  := choose(COUNTER,left.Name_1,left.Name_2,left.Name_3,left.Name_4,left.Name_5,
																															left.Name_6,left.Name_7,left.Name_8,left.Name_9,left.Name_10);  
																			self.title := choose(COUNTER,left.Title_1,left.Title_2,left.Title_3,left.Title_4,left.Title_5,
																															left.Title_6,left.Title_7,left.Title_8,left.Title_9,left.Title_10);  
																			));
		
		allNames_dedup := DEDUP(allNames,ALL);
		RETURN(allNames_dedup);
	END;
	
	lncaFirmRec roll_lnca(DCAV2.Layouts.base.keybuildEntNum l, DATASET(DCAV2.Layouts.base.keybuildEntNum) allRows) := TRANSFORM
			SELF.executives := create_executives(allRows);
			SELF.siccodes := create_sics(allRows);
			SELF.naicodes := create_naics(allRows);
			SELF.Sales            := allRows(sales != '')[1].sales;
			SELF.FYE							:= allRows(fye != '')[1].fye; 
			SELF.Sales_Desc 			:= allRows(Sales_Desc != '')[1].Sales_Desc;
			SELF.Assets           := allRows(Assets != '')[1].Assets;
			SELF.Liabilities      := allRows(Liabilities != '')[1].Liabilities;
			SELF.Net_Worth_       := allRows(Net_Worth_ != '')[1].Net_Worth_;
			SELF.EMP_NUM       		:= allRows(EMP_NUM != '')[1].EMP_NUM;
			SELF.dummyGroupField 	:= Fake_groupID;
			SELF := l;
	END;
	
	comp_lnca_group := ROLLUP(comp_lnca_sort,GROUP,roll_lnca(LEFT,ROWS(LEFT)));
	
	
	/* The loop function will join the passed in hierarchy dataset with the hierarchy keyed file
	   n number of times, with n being the maximum known tree depth, at the time of developement it 
     was ten(note the loop count is 9, since the first level has already been populated via from the
     ulitmate parent. For each iteration, only the records added during the previous join will be used
     as part of the Join logic. Reason being is that the key file is a hierarchy keyed file and the
     function is going down each branch, so we want to exclude the previous 
     grandparents, great grandparents and so on. */
	fn_loopHierarchy(DATASET(slim_hierRec) hier, INTEGER cnt) := FUNCTION
				// Join only using the previously added records, (grplevel = cnt -1). For each loop call all of
				// records from each previously retrieved level are passed, records are appended during each interation of the loop.
				ChildRecs := JOIN(hier(grpLevel = cnt -1), DCAV2.Keys().HierP2CNew.qa, 
						 KEYED(LEFT.enterprise_num = RIGHT.parent_enterprise_number) AND
						 KEYED(LEFT.enterprise_num != RIGHT.enterprise_num), // Sometimes a company is listed as a parent of itself, this will exclude
						 TRANSFORM(slim_hierRec, 
											SELF.grpLevel := cnt,
											SELF := RIGHT),
											LIMIT(ut.limits.default, SKIP));
											
				// Remove dups from the data
				ChildRecsDedup := DEDUP(ChildRecs,RECORD,ALL);
				
				// Assign the sub_group_ids for the newly added records based on the level
				slim_hierRec Add_sub_id(slim_hierRec l, slim_hierRec r) := TRANSFORM
						SELF.sub_group_id1 := IF(r.grpLevel = 1,l.sub_group_id1+1,0);
						SELF.sub_group_id2 := IF(r.grpLevel = 2,l.sub_group_id2+1,0);
						SELF.sub_group_id3 := IF(r.grpLevel = 3,l.sub_group_id3+1,0);
						SELF.sub_group_id4 := IF(r.grpLevel = 4,l.sub_group_id4+1,0);
						SELF.sub_group_id5 := IF(r.grpLevel = 5,l.sub_group_id5+1,0);
						SELF.sub_group_id6 := IF(r.grpLevel = 6,l.sub_group_id6+1,0);
						SELF.sub_group_id7 := IF(r.grpLevel = 7,l.sub_group_id7+1,0);
						SELF.sub_group_id8 := IF(r.grpLevel = 8,l.sub_group_id8+1,0);
						SELF.sub_group_id9 := IF(r.grpLevel = 9,l.sub_group_id9+1,0);
						SELF := r;
				END;
				
				ChildSubId := ITERATE(ChildRecsDedup,Add_sub_id(LEFT,RIGHT));
				
				/* Join against passed in hier recs to pass on the previous assigned sub group level numbers for the added company records.
				   In order to keep the complete ancestory of each company subgroupids are used. Note, the ultimate
					 doesn't have a sub_group_id value, since all children are its ancestors.
           
				
				Company Name				grp_lev	 sub_group_id1   sub_group_id2    sub_group_id3   sub_group_id4
			 Reed Elsevier				 0					0								0									0								0
			 Lexis Nexis Group		 1					1								0									0								0
			 Lexis Nexis					 2					1								1									0								0
			 Risk Solutions				 2					1								2									0								0
			 Lexis Doc Service		 3					1								1									1								0
			 Michie								 3					1								1									2								0
			 Dolan								 3					1								2									3								0
			 Riskwise							 3					1								2									4								0
			 Michie Docs					 4					1								1									2								1         
			 RiskWise Insurance		 4					1								2									4								2			*/
 
				ChildParentIds := JOIN(ChildSubId, hier,
																LEFT.parent_enterprise_number = RIGHT.enterprise_num,
																TRANSFORM(slim_hierRec,
																		SELF.sub_group_id1 := IF(LEFT.grpLevel = 1,LEFT.sub_group_id1,RIGHT.sub_group_id1),
																		SELF.sub_group_id2 := IF(LEFT.grpLevel = 2,LEFT.sub_group_id2,RIGHT.sub_group_id2),
																		SELF.sub_group_id3 := IF(LEFT.grpLevel = 3,LEFT.sub_group_id3,RIGHT.sub_group_id3),
																		SELF.sub_group_id4 := IF(LEFT.grpLevel = 4,LEFT.sub_group_id4,RIGHT.sub_group_id4),
																		SELF.sub_group_id5 := IF(LEFT.grpLevel = 5,LEFT.sub_group_id5,RIGHT.sub_group_id5),
																		SELF.sub_group_id6 := IF(LEFT.grpLevel = 6,LEFT.sub_group_id6,RIGHT.sub_group_id6),
																		SELF.sub_group_id7 := IF(LEFT.grpLevel = 7,LEFT.sub_group_id7,RIGHT.sub_group_id7),
																		SELF.sub_group_id8 := IF(LEFT.grpLevel = 8,LEFT.sub_group_id8,RIGHT.sub_group_id8),
																		SELF.sub_group_id9 := IF(LEFT.grpLevel = 9,LEFT.sub_group_id9,RIGHT.sub_group_id9),
																		SELF := LEFT));
				
				// Added the newly found child records to the previous parent, grandparents etc records.
				RETURN(hier + ChildParentIds);
	END;
	
	/* Get the ultimate parent number to use as the starting point for the hierarchy tree. If the passed linkid record is the ultimate
     parent (level 0) then use its enterprise number, otherwise use the ultimate enerprise number. */
	ultimateEntNumber := IF(dca_rec[1].rawfields.level = '0', dca_rec[1].rawfields.enterprise_num,dca_rec[1].rawfields.ultimate_enterprise_number);

	// Create the seed record default the group level, child level and num end tags to zero
	ultParent := DATASET([ {ultimateEntNumber,'',0,0}
												], slim_hierRec);
	
	// Construct record set of the hierarchy from the ultimate parent on down.
	hierSet := LOOP(ultParent,MaxTreeDepth,fn_loopHierarchy(ROWS(LEFT),COUNTER));
	
	// Get the full company information (name,address etc) from the enterprise numbers.
	fullHierSet := 	JOIN(
										hierSet, DCAV2.Keys().EntNum.qa,
										KEYED(LEFT.enterprise_num = RIGHT.enterprise_num),
										TRANSFORM(full_HierRec,
															SELF.parent_enterprise_number := LEFT.parent_enterprise_number,
															SELF := LEFT,
															SELF := RIGHT),
										KEEP(1),
										LIMIT(0)
										);
	
	// Emtpy record to append to end of hierarchy to force closing tags.
	emptyRec := PROJECT(ultParent,TRANSFORM(full_HierRec,
																					SELF.enterprise_num := LEFT.enterprise_num,
																					SELF.dummyGroupField := Fake_groupID,
																					SELF.lastRec := TRUE,
																					SELF := []));
																					
	hierSetSrt := SORT(fullhierSet+emptyRec,lastrec,sub_group_id1,sub_group_id2,sub_group_id3,sub_group_id4,
															sub_group_id5,sub_group_id6,sub_group_id7,sub_group_id8,
															sub_group_id9,record);
	
	full_HierRec xfm_MarkEndTag(full_HierRec l, full_HierRec r, INTEGER cnt) := TRANSFORM
			// Don't set preceding tag count for first record.
			SELF.numPrecEndTags := IF (cnt > 1,(l.grpLevel - r.grpLevel +1),0);  // Set the number of end tags needed for the record via the
																																					 // group levels, calculation isn't necessary for top parent record.
			SELF := r;
	END;

	hierSetTag := ITERATE(hierSetSrt,xfm_MarkEndTag(LEFT,RIGHT,COUNTER));
	
	// This transform will create an xml string for each company row in the record set.
	// NOTE, no encoding is being done on the XML since the system by defaults encodes the results
	// from the services.
	hierXMLRec xfm_createXML(full_HierRec l) := TRANSFORM
		precXML := IF(l.numPrecEndTags > 0,(endTags[l.numPrecEndTags]),'');
			SELF.company := precXML + 
											IF(l.lastRec, '',  // For last rec, no content to output, just preceding closing tags.
												('<Company>' +     
																	// '<UniqueID>' + XMLENCODE(TRIM((STRING)l.bdid)) + '</UniqueID>' +
																	'<Name>' + XMLENCODE(TRIM(l.name)) + '</Name>' +
																	'<Address>' + 
																		'<StreetNumber>' + XMLENCODE(TRIM(l.prim_range)) + '</StreetNumber>' +
																		'<StreetPreDirection>' + XMLENCODE(TRIM(l.predir)) + '</StreetPreDirection>' +
																		'<StreetName>' + XMLENCODE(TRIM(l.prim_name)) + '</StreetName>' +
																		'<StreetSuffix>' + XMLENCODE(TRIM(l.addr_suffix)) + '</StreetSuffix>' +
																		'<StreetPostDirection>' + XMLENCODE(TRIM(l.postdir)) + '</StreetPostDirection>' +
																		'<UnitDesignation>' + XMLENCODE(TRIM(l.unit_desig)) + '</UnitDesignation>' +
																		'<UnitNumber>' + XMLENCODE(TRIM(l.sec_range)) + '</UnitNumber>' +
																		'<City>' + XMLENCODE(TRIM(l.p_city_name)) + '</City>' +
																		'<State>' + XMLENCODE(TRIM(l.st)) + '</State>' +
																		'<Zip5>' + XMLENCODE(TRIM(l.z5)) + '</Zip5>' + 
																	'</Address>' +
																	'<Subsidiaries>'));
			SELF := l;
	END;
	
	// At the time of development returning a nested parent/child dataset structure up to 9 levels deep was 
	// not possible, it was determined that the best solution was to return a string of XML. 
	hierSetXML := PROJECT(hierSetTag,xfm_createXML(LEFT));
	
	UNSIGNED3 combStrLength := SUM(hierSetXML, LENGTH(hierSetXML.company));
	
	// Roll up each XML row in the recordset into one large string.
	XMLOutRec roll_Recs(XMLOutRec l,  hierXMLRec r) := TRANSFORM
		SELF.hierarchy := TRIM(l.hierarchy) + r.company;
		SELF.dummyGroupField := r.dummyGroupField;
		SELF := [];
	END;
	
	// Create dataset record to roll the record's into with the same group id (fake_groupid)
	tempOut := DATASET([{'',Fake_groupID}], XMLOutRec);
		
	// Dataset with error message when hierarchy string exceeds 200,000 characters, which is the limit for the
	// output string. 200,000 choosen since if this length is exceeded it probably indicates a data issue.
	LenErrRec := DATASET([{'',Fake_groupID,HierLenError}], XMLOutRec);
	
	// If the hierachy length is less than the maximum value then output, otherwise output empty string with rtn code.
	outXML := IF(combStrLength < MaxStringLen,
									DENORMALIZE(tempOut,HierSetXML,LEFT.dummyGroupField = RIGHT.dummyGroupField,roll_Recs(LEFT,RIGHT),ALL),									
									LenErrRec);
	
	//Combine the hierarchy info with the lnca firmographic info of the passed company, outRec will be empty if
	// no matching linkids were found and no output will be built. Check is needed because a dummyGroupId will always exist.
	outRec := IF(EXISTS(comp_lnca_group),DENORMALIZE(outXML,comp_lnca_group,LEFT.dummyGroupField = RIGHT.dummyGroupField,GROUP,	
																								TRANSFORM(lncaOutRec,SELF := LEFT, SELF := RIGHT, SELF := []),ALL));
	
	// Transform into IESP output layout
	iesp.lncafirmographics.t_LNCARecord xfm_lncaRecs(lncaOutRec l) := TRANSFORM
			SELF.Hierarchy := l.hierarchy;
			SELF.HierarchyErrorCode := l.hier_err_code;
			SELF.CompanyType := l.Type_orig;
			SELF.BusinessName := l.name;
			SELF.Note := l.Note;
			SELF.Incorp := l.Incorp;
			SELF.PercentageOwned := (INTEGER) l.percent_owned;
			SELF.Earnings := (INTEGER) l.Earnings;
			SELF.Sales := (INTEGER) l.Sales;
			SELF.SalesDescription := l.Sales_Desc;
			SELF.Assets := (INTEGER) l.assets;
			SELF.Liabilities := (INTEGER) l.Liabilities;
			SELF.NetWorth := (INTEGER) l.Net_Worth_;
			SELF.FiscalYearEnd := iesp.ECL2ESP.toDatestring8((string) Std.Date.FromStringToDate(l.FYE, '%m%d%y'));
			SELF.NumberOfEmployees := (INTEGER) l.EMP_NUM;
			SELF.Imports := l.Import_orig;
			SELF.Exports := l.Export_orig;
			SELF.BusinessDescription := l.Bus_Desc;
      
			SELF.SICCodes := PROJECT(CHOOSEN(l.siccodes,iesp.constants.LNCA.MaxSICCodes),
																	TRANSFORM(iesp.lncafirmographics.t_lncaSICCode,
																				SELF.code := (INTEGER)LEFT.code, SELF := LEFT));
																	
			SELF.Executives := PROJECT(CHOOSEN(l.executives,iesp.constants.LNCA.MaxExecutives),
															TRANSFORM(iesp.lncafirmographics.t_lncaExecutive,
																		SELF.Name := iesp.ECL2ESP.setName('','','','','',LEFT.name),
																		SELF.title := LEFT.title,
																		SELF := []));
			
			ExchngRecs := DATASET([{l.Exchange1},{l.Exchange2},{l.Exchange3},{l.Exchange4}],iesp.share.t_StringArrayItem);
			SELF.Exchanges := CHOOSEN(ExchngRecs(value != ''),iesp.constants.LNCA.MaxExchanges);
			
			SELF.NAICSCodes := PROJECT(CHOOSEN(l.naicodes,iesp.constants.LNCA.MaxNAICSCodes),
																	TRANSFORM(iesp.lncafirmographics.t_lncaNAICSCodes,
																				SELF.code := (INTEGER)LEFT.code, SELF := LEFT));
			SELF := [];														
	END;
	
	SupplierRisk_layouts.lnca_layout format() := TRANSFORM
				self.LNCARecords := PROJECT(outRec,xfm_lncaRecs(LEFT));
				self.LNCACount := COUNT(outRec);
				self.TotalLNCACount := COUNT(outRec);
				
				iesp.topbusiness_share.t_TopBusinessSourceDocInfo xfm_sourcedoc(full_HierRec l) := TRANSFORM
						// TopBusiness_Services.IDMacros.mac_IespTransferLinkids(false)
						self.BusinessIds.ultid := ds_in_ids[1].ultid,
						self.BusinessIds.orgid := ds_in_ids[1].orgid,
						self.BusinessIds.seleid := ds_in_ids[1].seleid,
						self.BusinessIds.proxid := ds_in_ids[1].proxid,
						self.BusinessIds.dotid := ds_in_ids[1].dotid,
						self.BusinessIds.powid := ds_in_ids[1].powid,
						self.BusinessIds.empid := ds_in_ids[1].empid,		
						self.source := MDR.sourceTools.src_DCA;
						self.IdValue := l.enterprise_num;
						self.IdType := TopBusiness_Services.Constants.enterprisenumber;
						self := [];
				END;
				
				sourceDoc := PROJECT(fullHierSet,xfm_sourcedoc(LEFT));
				self.sourcedocs :=  IF(EXISTS(outRec),CHOOSEN(sourceDoc,iesp.Constants.TOPBUSINESS.MAX_COUNT_DCA_RECORD));
				self.acctno := ds_in_ids[1].acctno;
				self := [];
	end;

	lnca_final_results := dataset([format()]);
	return lnca_final_results;
	 
 END; // end of the fn_FullView function
	
END; //end of the module