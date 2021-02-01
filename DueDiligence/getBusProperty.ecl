IMPORT Address, BIPV2, Business_Risk_BIP, LN_PropertyV2, MDR, DueDiligence, SALT28, iesp, STD;

EXPORT getBusProperty(DATASET(DueDiligence.Layouts.Busn_Internal) busnData, 
											 Business_Risk_BIP.LIB_Business_Shell_LIBIN options,
											 BIPV2.mod_sources.iParams linkingOptions) := FUNCTION

  
	//Get the LinkIDs for this Business
	busnKeys := DueDiligence.CommonBusiness.GetLinkIDs(busnData);
	
  
  //Property Data - Using Business IDs 
	propertyRaw := LN_PropertyV2.Key_LinkIds.kFetch2(busnKeys,     
                                                    Business_Risk_BIP.Common.SetLinkSearchLevel(Options.LinkSearchLevel),
                                                    in_mod := linkingOptions,
                                                    joinLimit := DueDiligence.Constants.MAX_5000);      
	
	
	//Add our sequence number to the Raw Property records found for this Business
	propertyRawWithSeq := DueDiligence.CommonBusiness.AppendSeq(PropertyRaw, BusnData, TRUE);
	
	//Clean dates used in logic and/or attribute levels here so all comparisions flow through consistently
	propertyCleanDates := DueDiligence.Common.CleanDatasetDateFields(propertyRawWithSeq, 'dt_first_seen, dt_vendor_first_reported, dt_last_seen, dt_vendor_last_reported');


  //When this query runs in ARCHIVE MODE the History date on the input contains a date 
	//Use this function drop property records that are out of scope for this transaction 
	//If the History date is all 9's essentially no records will be dropped - also known 
	//as CURRENT MODE. 
	propertyFiltered := DueDiligence.CommonDate.FilterRecords(propertyCleanDates, dt_first_seen, dt_vendor_first_reported); 

  //we need to project the first and last seen dates with vendor if they are not populated so we do not lose records....
  formatProperty := PROJECT(propertyFiltered, TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                                                        SELF.seq := LEFT.seq;
                                                        SELF.ultID := LEFT.ultID;
                                                        SELF.orgID := LEFT.orgID;
                                                        SELF.seleID := LEFT.seleID;

                                                        SELF.LNFaresID := LEFT.ln_fares_id;
                                                        SELF.dateFirstSeen := IF(LEFT.dt_first_seen > 0, LEFT.dt_first_seen, LEFT.dt_vendor_first_reported);
                                                        SELF.dateLastSeen := IF(LEFT.dt_last_seen > 0, LEFT.dt_last_seen, LEFT.dt_vendor_last_reported);
                                                        SELF.historyDate := IF(LEFT.historyDate = DueDiligence.Constants.date8Nines, STD.Date.Today(), LEFT.historyDate); 

                                                        SELF.ownerName := LEFT.cname;

                                                        SELF := [];));
                                                                
  //remove all duplicate values
  formattedPropertyDeduped := DEDUP(formatProperty, ALL);  
  uniqueLNFaresID := DEDUP(SORT(formattedPropertyDeduped, LNFaresID), LNFaresID);
  
  
  addressesDatails := JOIN(formattedPropertyDeduped, LN_PropertyV2.key_search_fid(),
                            KEYED(LEFT.LNFaresID = RIGHT.ln_fares_id),	
                            TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                                      
                                      SELF.isPropertyAddress := RIGHT.source_code[2] = 'P';                                      
                                      
                                      SELF.prim_range := RIGHT.prim_range;
                                      SELF.predir := RIGHT.predir;
                                      SELF.prim_name := RIGHT.prim_name;
                                      SELF.addr_suffix := RIGHT.suffix;
                                      SELF.postdir := RIGHT.postdir;
                                      SELF.unit_desig := RIGHT.unit_desig;
                                      SELF.sec_range := RIGHT.sec_range;
                                      SELF.city := RIGHT.p_city_name;
                                      SELF.state := RIGHT.st;
                                      SELF.zip5 := RIGHT.zip;
                                      SELF.zip4 := RIGHT.zip4;
                                      SELF.county := RIGHT.county[3..5];
                                      SELF.geo_blk := RIGHT.geo_blk;                                      
                                      
                                      SELF.sourceObscure := MAP(LEFT.LNFaresId[1] IN ['R','F','S'] => 'A',
                                                                LEFT.LNFaresId[1] IN ['D','O'] => 'B',
                                                                DueDiligence.Constants.EMPTY);
                                      
                                      SELF := LEFT;), 
                            LIMIT(DueDiligence.Constants.MAX_0),
                            KEEP(DueDiligence.Constants.MAX_10));

  
  propertyAddresses := addressesDatails(isPropertyAddress);
  
  
  assessor := JOIN(uniqueLNFaresID, LN_PropertyV2.key_assessor_fid(), 
                    KEYED(LEFT.LNFaresID = RIGHT.ln_fares_id),
                    TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                    
                              SELF.isCurrent := RIGHT.current_record = DueDiligence.Constants.YES;
                              
                              SELF.assessedYear := IF(RIGHT.assessed_value_year = DueDiligence.Constants.EMPTY, RIGHT.tax_year, RIGHT.assessed_value_year);
                              SELF.assessedTotalValue := (INTEGER)RIGHT.assessed_total_value;
                              
                              SELF.ownerOccupied := RIGHT.owner_occupied;
                                                                              
                              SELF.recordingDate := RIGHT.recording_date; 
                              SELF.purchasePrice := (INTEGER)RIGHT.sales_price; 
                              SELF.purchaseDate := RIGHT.sale_date;
                              SELF.lengthOfOwnership := DueDiligence.CommonDate.DaysApartWithZeroEmptyDate(RIGHT.sale_date, (STRING)LEFT.historydate)/30;        //store the value in months. 
                              SELF.addressType := RIGHT.county_land_use_description;
                              
                              SELF := LEFT;),
                    LEFT OUTER,
                    KEEP(DueDiligence.Constants.MAX_5));

  deed := JOIN(assessor, LN_PropertyV2.key_deed_fid(),																	     
              KEYED(LEFT.LNFaresID = RIGHT.ln_fares_id)
              AND NOT LN_PropertyV2.fn_isAssignmentAndReleaseRecord(RIGHT.record_type, RIGHT.state, RIGHT.document_type_code),
              TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
              
                        SELF.isCurrent := LEFT.isCurrent OR RIGHT.current_record = 'Y';
                        SELF.recordingDate := IF(LEFT.recordingDate = '', RIGHT.recording_date, LEFT.recordingDate);
                        SELF.purchasePrice := IF(LEFT.purchasePrice = 0, (INTEGER)RIGHT.sales_price, LEFT.purchasePrice);
                        
                        SELF := LEFT;),
              LEFT OUTER,
              ATMOST(DueDiligence.Constants.MAX_1));
              
              
  //only care about those properties that are current            
  currentProperties := JOIN(propertyAddresses, deed(isCurrent),
                            LEFT.LNFaresId = RIGHT.LNFaresId,
                            TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                                      
                                      SELF.isCurrent := RIGHT.isCurrent;
                                                          
                                      SELF.assessedYear := RIGHT.assessedYear;
                                      SELF.assessedTotalValue := RIGHT.assessedTotalValue;
                                      
                                      SELF.ownerOccupied := RIGHT.ownerOccupied;
                                                                                      
                                      SELF.recordingDate := RIGHT.recordingDate; 
                                      SELF.purchasePrice := RIGHT.purchasePrice; 
                                      SELF.purchaseDate := RIGHT.purchaseDate;
                                      SELF.lengthOfOwnership := RIGHT.lengthOfOwnership;
                                      SELF.addressType := RIGHT.addressType;
                                      
                                      SELF := LEFT;));
                                      
  uniqueCurrProps := DEDUP(SORT(currentProperties, seq, ultID, orgID, seleID, zip5, prim_name[1..8], prim_range, -assessedYear, sourceObscure),
                           seq, ultID, orgID, seleID, zip5, prim_name[1..8], prim_range);  
                                                  

  sortGrpData := GROUP(SORT(uniqueCurrProps, seq, ultID, orgID, seleID, -assessedYear, -dateLastSeen, -dateFirstSeen), seq, ultID, orgID, seleID);
  limitedCurrentProps := DueDiligence.v3Common.General.GetMaxNumberOfRecords(sortGrpData, iesp.constants.DDRAttributesConst.MaxProperties);



  //don't need an exact count since we are just looking to see any sold properties exist
  soldProperties := JOIN(propertyAddresses, deed(isCurrent = FALSE AND purchasePrice > 0),
                          LEFT.LNFaresId = RIGHT.LNFaresId,
                          TRANSFORM({DueDiligence.LayoutsInternal.PropertySlimLayout, BOOLEAN soldProperty}, 
                                    
                                    currentProperty := uniqueCurrProps(seq = LEFT.seq AND
                                                                       ultID = LEFT.ultID AND
                                                                       orgID = LEFT.orgID AND
                                                                       seleID = LEFT.seleID AND
                                                                       zip5 = LEFT.zip5 AND 
                                                                       prim_name[1..8] = LEFT.prim_name[1..8] AND 
                                                                       prim_range = LEFT.prim_range);
                                    
                                    SELF.soldProperty := NOT EXISTS(currentProperty);
                                    SELF := LEFT;)); 



	updateBusnOwnedProperty := PROJECT(busnData, TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
                                                          
                                                          currProps := limitedCurrentProps(seq = LEFT.seq AND
                                                                                            ultID = LEFT.Busn_info.BIP_IDS.UltID.LinkID AND
                                                                                            orgID = LEFT.Busn_info.BIP_IDS.OrgID.LinkID AND
                                                                                            seleID = LEFT.Busn_info.BIP_IDS.SeleID.LinkID);
                                                                                            
                                                          soldProps := soldProperties(seq = LEFT.seq AND
                                                                                      ultID = LEFT.Busn_info.BIP_IDS.UltID.LinkID AND
                                                                                      orgID = LEFT.Busn_info.BIP_IDS.OrgID.LinkID AND
                                                                                      seleID = LEFT.Busn_info.BIP_IDS.SeleID.LinkID AND
                                                                                      soldProperty);

                                                          SELF.CurrPropOwnedCount := COUNT(currProps);
                                                          SELF.PropTaxValue := SUM(currProps, assessedTotalValue);
                                                          SELF.CountSoldProp := COUNT(soldProps);
                                                          SELF.busProperties := PROJECT(currProps, TRANSFORM(DueDiligence.Layouts.BusPropertyDataLayout,
                                                                                                              SELF.prim_range := LEFT.prim_range;
                                                                                                              SELF.predir := LEFT.predir;
                                                                                                              SELF.prim_name := LEFT.prim_name;
                                                                                                              SELF.addr_suffix := LEFT.addr_suffix;
                                                                                                              SELF.postdir := LEFT.postdir;
                                                                                                              SELF.unit_desig := LEFT.unit_desig;
                                                                                                              SELF.sec_range := LEFT.sec_range;
                                                                                                              SELF.city := LEFT.city;
                                                                                                              SELF.state := LEFT.state;
                                                                                                              SELF.zip5 := LEFT.zip5;
                                                                                                              SELF.zip4 := LEFT.zip4;
                                                                                                              SELF.county := LEFT.county;
                                                                                                              SELF.geo_blk := LEFT.geo_blk;
                                                                                                              SELF.addressType := LEFT.addressType;
                                                                                                              SELF.purchaseDate := LEFT.purchaseDate;
                                                                                                              SELF.purchasePrice := LEFT.purchasePrice;
                                                                                                              SELF.lengthOfOwnership := LEFT.lengthOfOwnership;
                                                                                                              SELF.assessedYear := LEFT.assessedYear;
                                                                                                              SELF.assessedValue := LEFT.assessedTotalValue;
                                                                                                              SELF.ownerName := LEFT.ownerName;
                                                                                                              
                                                                                                              SELF.streetAddress1 := Address.Addr1FromComponents(LEFT.prim_range, LEFT.predir, LEFT.prim_name, LEFT.addr_suffix, 
                                                                                                                                                                  LEFT.postdir, LEFT.unit_desig, LEFT.sec_range);
                                                                                                              
                                                                                                              SELF := [];));
                                                          SELF := LEFT;));
	
	// ********************
	//   DEBUGGING OUTPUTS
	// *********************
  // OUTPUT(propertyRaw, NAMED('propertyRaw'));
  // OUTPUT(propertyRawWithSeq, NAMED('propertyRawWithSeq'));
  // OUTPUT(propertyCleanDates, NAMED('propertyCleanDates'));
  // OUTPUT(propertyFiltered, NAMED('propertyFiltered'));
   
  // OUTPUT(formatProperty, NAMED('formatProperty'));
  // OUTPUT(formattedPropertyDeduped, NAMED('formattedPropertyDeduped'));
  
  // OUTPUT(propertyAddresses, NAMED('propertyAddresses'));
  // OUTPUT(assessor, NAMED('assessor'));
  // OUTPUT(deed, NAMED('deed'));
  
  // OUTPUT(currentProperties, NAMED('currentProperties'));
  // OUTPUT(uniqueCurrProps, NAMED('uniqueCurrProps'));
  // OUTPUT(limitedCurrentProps, NAMED('limitedCurrentProps'));
  
  // OUTPUT(soldProperties, NAMED('soldProperties'));
  
  // OUTPUT(updateBusnOwnedProperty, NAMED('updateBusnOwnedProperty'));


	RETURN UpdateBusnOwnedProperty;

END; 