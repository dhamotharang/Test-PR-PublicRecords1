IMPORT BIPv2, DueDiligence, LN_PropertyV2;

/*
	Following Keys being used:
			LN_PropertyV2.key_assessor_fid
*/
EXPORT getSharedProperty(DATASET(DueDiligence.LayoutsInternal.PropertySlimLayout) inProps) := FUNCTION

    //we only care about sold and owned properties, so lets filter them to limit the amount of data to work with
    soldOwnedProperty := inProps(sourceCode IN [DueDiligence.Constants.Owned_Property_code, DueDiligence.Constants.Sold_Property_code]);
 
    getUniquePropertyBySource(STRING2 propertySource) := FUNCTION
      filterProperty := soldOwnedProperty(sourceCode = propertySource);
      sortProperty := SORT(filterProperty, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, LNFaresId, prim_range, prim_name[1..8], zip, -dateLastSeen);
      dedupProperty := DEDUP(sortProperty, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, LNFaresId, prim_range, prim_name[1..8], zip);
      
      RETURN dedupProperty;
    END;


    //select property records that were OWNED at some point
    propOwnedAtSomePoint := getUniquePropertyBySource(DueDiligence.Constants.Owned_Property_code);
  
    //select property records that were SOLD at some point by this business                                                                                   ------
    propertySold := getUniquePropertyBySource(DueDiligence.Constants.Sold_Property_code);                 
    uniqueSoldPropAddrs := DEDUP(SORT(propertySold, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, prim_range, prim_name[1..8], zip, -dateLastSeen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, prim_range, prim_name[1..8]); 
  
  
    //select property records that are Currenty OWNED
    //that is if the records on right (SOLD) cancel out the records on the left 
    propertyCurrentlyOwned := JOIN(propOwnedAtSomePoint, uniqueSoldPropAddrs,
                                    LEFT.seq = RIGHT.seq AND
																    LEFT.ultid = RIGHT.ultid AND
																	  LEFT.orgid = RIGHT.orgid AND
                                    LEFT.seleid = RIGHT.seleid AND
                                    LEFT.did = RIGHT.did AND
                                    LEFT.prim_range = RIGHT.prim_range AND
                                    LEFT.prim_name[1..8] = RIGHT.prim_name[1..8] AND
                                    LEFT.zip = RIGHT.zip,
                                    TRANSFORM(RECORDOF(LEFT), 
                                                SELF := LEFT),
                                    LEFT ONLY);
    
	
		
    //Get the assessed value and other details for each property in the list														
    propertyOwnedWithDetails := JOIN(propertyCurrentlyOwned, LN_PropertyV2.key_assessor_fid(), 
                                      KEYED(left.LNFaresId = right.ln_fares_id),
                                      TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                                                SELF.seq := LEFT.seq;
                                                SELF.ultID := LEFT.ultID;
                                                SELF.orgID := LEFT.orgID;
                                                SELF.seleID := LEFT.seleID;
                                                SELF.did := LEFT.did;
                                                SELF.lnFaresID := LEFT.LNFaresId;
                                                
                                                SELF.assessedYear := IF(RIGHT.assessed_value_year = DueDiligence.Constants.EMPTY, RIGHT.tax_year, RIGHT.assessed_value_year);
                                                SELF.assessedTotalValue := (INTEGER)RIGHT.assessed_total_value;
                                                
                                                SELF.sourceCode := LEFT.sourcecode;
                                                SELF.ownerOccupied := RIGHT.owner_occupied;
                                                SELF.county := LEFT.county[3..5];
                                                SELF.geo_blk := LEFT.geo_blk;
                                                
                                                SELF.recordingDate := RIGHT.recording_date; //recorded date is the date the property officially transferred
                                                SELF.purchasePrice := (INTEGER)RIGHT.sales_price; //sale date is the date the paperwork was created, another name for it is a "contract" date
                                                SELF.purchaseDate := RIGHT.sale_date;
                                                SELF.lengthOfOwnership := DueDiligence.Common.DaysApartWithZeroEmptyDate(RIGHT.sale_date, (STRING)LEFT.historydate)/30;        //store the value in months. 
                                                SELF.addressType := RIGHT.county_land_use_description;

                                                SELF := LEFT;
                                                SELF := [];),
                                      LEFT OUTER,
                                      KEEP(5));
                                      
                                      
    sortedProps := SORT(propertyOwnedWithDetails, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, prim_range, prim_name[1..8], zip, -assessedYear, -recordingDate);  
    propWithUniqueAddress := ROLLUP(sortedProps,
                                    #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                    LEFT.did = RIGHT.did AND
                                    LEFT.prim_range = RIGHT.prim_range AND
                                    LEFT.prim_name[1..8] = RIGHT.prim_name[1..8] AND
                                    LEFT.zip = RIGHT.zip,
                                    TRANSFORM(RECORDOF(LEFT),
                                              purchaseInfo := IF(LEFT.purchasePrice = 0 AND LEFT.purchaseDate = DueDiligence.Constants.EMPTY, RIGHT, LEFT);
                                              
                                              SELF.addressType := IF(LEFT.addressType = DueDiligence.Constants.EMPTY, RIGHT.addressType, LEFT.addressType);
                                              SELF.ownerOccupied := IF(LEFT.ownerOccupied = DueDiligence.Constants.EMPTY, RIGHT.ownerOccupied, LEFT.ownerOccupied);
                                              SELF.purchasePrice := purchaseInfo.purchasePrice;
                                              SELF.purchaseDate := purchaseInfo.purchaseDate;
                                              SELF.lengthOfOwnership := purchaseInfo.lengthOfOwnership;
                                              SELF.recordingDate := purchaseInfo.recordingDate;
                                              
                                              SELF := LEFT;)); 
                 
                 
    groupProps := GROUP(SORT(propWithUniqueAddress, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -assessedYear), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did);
    
    
    {DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 ownPropCnt, UNSIGNED4 soldPropCnt, 
     INTEGER8 totalSumAssessedValue, DATASET(DueDiligence.LayoutsInternal.PropertySlimLayout) ownedProps}  getMaxProperties(DueDiligence.LayoutsInternal.PropertySlimLayout psl, INTEGER c) := TRANSFORM, SKIP(c > DueDiligence.Constants.MAX_PROPERTIES)
     
           SELF.seq := psl.seq;
           SELF.ultID := psl.ultID;
           SELF.orgID := psl.orgID;
           SELF.seleID := psl.seleID;
           SELF.did := psl.did;
           SELF.totalSumAssessedValue := psl.assessedTotalValue;
           SELF.ownedProps := DATASET([TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout, SELF := psl;)]);
           SELF := [];
    END;
    
    maxProperties := UNGROUP(PROJECT(groupProps, getMaxProperties(LEFT, COUNTER)));
                                                            
    rollGroup := ROLLUP(SORT(maxProperties, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did),
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.ownedProps := LEFT.ownedProps + RIGHT.ownedProps;
                                  SELF.totalSumAssessedValue := LEFT.totalSumAssessedValue + RIGHT.totalSumAssessedValue;
                                  SELF := LEFT;));                                                          	
		
    //addSummaryCounts
    addOwnCounts := PROJECT(rollGroup, TRANSFORM(RECORDOF(LEFT),
                                              SELF.ownPropCnt := COUNT(LEFT.ownedProps);
                                              SELF := LEFT;));
                                              
    //Summarize the results to get the SOLD Property Count
    summerizeSoldProps := TABLE(uniqueSoldPropAddrs, 
	                              {seq, ultid, orgid, seleid, did,
																SOLDPropCnt := COUNT(GROUP)}, 
																seq, ultid, orgid, seleid, did);
                                              
    addSoldCounts := JOIN(addOwnCounts, summerizeSoldProps,
                          #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                          LEFT.did = RIGHT.did,
                          TRANSFORM(RECORDOF(LEFT),
                                    SELF.soldPropCnt := RIGHT.SOLDPropCnt;
                                    SELF := LEFT;),
                          LEFT OUTER,
                          ATMOST(1));
                      





     // OUTPUT(propOwnedAtSomePoint, NAMED('propOwnedAtSomePoint'));
     // OUTPUT(propertySold, NAMED('propertySold'));
     // OUTPUT(uniqueSoldPropAddrs, NAMED('uniqueSoldPropAddrs'));
        
     // OUTPUT(propertyCurrentlyOwned, NAMED('propertyCurrentlyOwned'));
     // OUTPUT(propertyOwnedWithDetails, NAMED('propertyOwnedWithDetails'));
     // OUTPUT(sortedProps, NAMED('sortedProps'));
     // OUTPUT(propWithUniqueAddress, NAMED('propWithUniqueAddress'));
     // OUTPUT(maxProperties, NAMED('maxProperties'));
     
     // OUTPUT(groupProps, NAMED('groupProps'));
     // OUTPUT(rollGroup, NAMED('rollGroup'));
     // OUTPUT(addOwnCounts, NAMED('addOwnCounts'));    
     // OUTPUT(summerizeSoldProps, NAMED('summerizeSoldProps'));
     // OUTPUT(addSoldCounts, NAMED('addSoldCounts'));


    RETURN addSoldCounts;
END;