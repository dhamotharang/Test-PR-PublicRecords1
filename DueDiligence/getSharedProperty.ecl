﻿IMPORT BIPv2, DueDiligence, LN_PropertyV2;

/*
	Following Keys being used:
			LN_PropertyV2.key_assessor_fid
*/
EXPORT getSharedProperty(DATASET(DueDiligence.LayoutsInternal.PropertySlimLayout) inProps,
                         BOOLEAN isPerson = FALSE) := FUNCTION

    //we only care about sold and owned properties, so lets filter them to limit the amount of data to work with
    soldOwnedProperty := inProps(sourceCode IN [DueDiligence.Constants.OWNED_PROPERTY_CODE, DueDiligence.Constants.SOLD_PROPERTY_CODE]);
 
    getUniquePropertyBySource(STRING2 propertySource) := FUNCTION
      filterProperty := soldOwnedProperty(sourceCode = propertySource);
      sortProperty := SORT(filterProperty, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, LNFaresId, prim_range, prim_name[1..8], zip5, -dateLastSeen);
      dedupProperty := DEDUP(sortProperty, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, LNFaresId, prim_range, prim_name[1..8], zip5);
      
      RETURN dedupProperty;
    END;


    //select property records that were OWNED at some point
    propOwnedAtSomePoint := getUniquePropertyBySource(DueDiligence.Constants.OWNED_PROPERTY_CODE);

    //select property records that were SOLD at some point
    propertySold := getUniquePropertyBySource(DueDiligence.Constants.Sold_Property_code);                 
    uniqueSoldPropAddrs := DEDUP(SORT(propertySold, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, prim_range, prim_name[1..8], zip5, -dateLastSeen), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, prim_range, prim_name[1..8], zip5); 
  
  
    
  
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
                                    LEFT.zip5 = RIGHT.zip5,
                                    TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout, 
                                                SELF := LEFT),
                                    LEFT ONLY);
    
	
    propOwnedDataToUse := IF(isPerson, inProps(isCurrent), propertyCurrentlyOwned);
		
    //Get the assessed value and other details for each property in the list														
    propertyOwnedWithDetails := JOIN(propOwnedDataToUse, LN_PropertyV2.key_assessor_fid(), 
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
                                                SELF.county := LEFT.county;
                                                SELF.geo_blk := LEFT.geo_blk;
                                                
                                                SELF.recordingDate := RIGHT.recording_date; //recorded date is the date the property officially transferred
                                                SELF.purchasePrice := (INTEGER)RIGHT.sales_price; //sale date is the date the paperwork was created, another name for it is a "contract" date
                                                SELF.purchaseDate := RIGHT.sale_date;
                                                SELF.lengthOfOwnership := DueDiligence.CommonDate.DaysApartWithZeroEmptyDate(RIGHT.sale_date, (STRING)LEFT.historydate)/30;        //store the value in months. 
                                                SELF.addressType := RIGHT.county_land_use_description;

                                                SELF := LEFT;
                                                SELF := [];),
                                      LEFT OUTER,
                                      KEEP(5));
                                      
                                      
    sortedProps := SORT(propertyOwnedWithDetails, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, prim_range, prim_name[1..8], zip5, -assessedYear, -assessedTotalValue, -purchaseDate, -recordingDate);  
    propWithUniqueAddress := ROLLUP(sortedProps,
                                    #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                    LEFT.did = RIGHT.did AND
                                    LEFT.prim_range = RIGHT.prim_range AND
                                    LEFT.prim_name[1..8] = RIGHT.prim_name[1..8] AND
                                    LEFT.zip5 = RIGHT.zip5,
                                    TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout,
                                              purchaseInfo := IF(LEFT.purchasePrice = 0 AND LEFT.purchaseDate = DueDiligence.Constants.EMPTY, RIGHT, LEFT);
                                              
                                              SELF.addressType := IF(LEFT.addressType = DueDiligence.Constants.EMPTY, RIGHT.addressType, LEFT.addressType);
                                              SELF.purchasePrice := purchaseInfo.purchasePrice;
                                              SELF.purchaseDate := purchaseInfo.purchaseDate;
                                              SELF.lengthOfOwnership := purchaseInfo.lengthOfOwnership;
                                              SELF.recordingDate := purchaseInfo.recordingDate;
                                              
                                              //see if we have an assessed amount - else grab the most recent year assessed with 0
                                              assessed := MAP(LEFT.assessedTotalValue > 0 => LEFT,  //grab most recent assessed value
                                                              RIGHT.assessedTotalValue > 0 => RIGHT,
                                                              LEFT);
                                                              
                                              SELF.assessedYear := assessed.assessedYear;
                                              SELF.assessedTotalValue := assessed.assessedTotalValue;
                                                                                            
                                              SELF := LEFT;)); 
                                              
                                          
                 
                 
    limitedProperties := DEDUP(SORT(propWithUniqueAddress, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -assessedYear), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, KEEP(DueDiligence.Constants.MAX_PROPERTIES));

    maxProperties := PROJECT(limitedProperties, TRANSFORM({DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout, UNSIGNED4 ownPropCnt, UNSIGNED4 soldPropCnt, 
                                                                                INTEGER8 totalSumAssessedValue, DATASET(DueDiligence.LayoutsInternal.PropertySlimLayout) ownedProps},
                                                           SELF.seq := LEFT.seq;
                                                           SELF.ultID := LEFT.ultID;
                                                           SELF.orgID := LEFT.orgID;
                                                           SELF.seleID := LEFT.seleID;
                                                           SELF.did := LEFT.did;
                                                           SELF.totalSumAssessedValue := LEFT.assessedTotalValue;
                                                           SELF.ownedProps := DATASET([TRANSFORM(DueDiligence.LayoutsInternal.PropertySlimLayout, SELF := LEFT;)]);
                                                           SELF := [];)); 
    
    

                                                            
    rollGroup := ROLLUP(SORT(maxProperties, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did),
                        #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                        LEFT.did = RIGHT.did,
                        TRANSFORM(RECORDOF(LEFT),
                                  SELF.ownedProps := LEFT.ownedProps + RIGHT.ownedProps;
                                  SELF.totalSumAssessedValue := LEFT.totalSumAssessedValue + RIGHT.totalSumAssessedValue;
                                  SELF := LEFT;));  
                                  
    
    //grab unique individuals/businesses in the event there are no current properties
    uniqueInputIDs := DEDUP(SORT(inProps, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did); 
		
    //addSummaryCounts
    addCounts := JOIN(uniqueInputIDs, rollGroup,
                      #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                      LEFT.did = RIGHT.did,
                      TRANSFORM(RECORDOF(RIGHT),
                                SELF.seq := LEFT.seq;
                                SELF.ultID := LEFT.ultID;
                                SELF.orgID := LEFT.orgID;
                                SELF.seleID := LEFT.seleID;
                                SELF.did := LEFT.did;
                                SELF.ownPropCnt := COUNT(RIGHT.ownedProps);
                                SELF.soldPropCnt := COUNT(uniqueSoldPropAddrs(ultID = LEFT.ultID AND
                                                                              orgID = LEFT.orgID AND
                                                                              seleID = LEFT.seleID AND
                                                                              did = LEFT.did));
                                SELF := RIGHT;),
                     LEFT OUTER);
                      
                                              
    
                      





     // OUTPUT(inProps, NAMED('inProps'));
     // OUTPUT(propOwnedAtSomePoint, NAMED('propOwnedAtSomePoint'));
     // OUTPUT(propertySold, NAMED('propertySold'));
     // OUTPUT(uniqueSoldPropAddrs, NAMED('uniqueSoldPropAddrs'));
        
     // OUTPUT(propertyCurrentlyOwned, NAMED('propertyCurrentlyOwned'));
     // OUTPUT(propOwnedDataToUse, NAMED('propOwnedDataToUse'));
     // OUTPUT(propertyOwnedWithDetails, NAMED('propertyOwnedWithDetails'));
     // OUTPUT(sortedProps, NAMED('sortedProps'));
     // OUTPUT(propWithUniqueAddress, NAMED('propWithUniqueAddress'));
     // OUTPUT(limitedProperties, NAMED('limitedProperties'));
     // OUTPUT(maxProperties, NAMED('maxProperties'));
     
     // OUTPUT(rollGroup, NAMED('rollGroup'));
     // OUTPUT(uniqueInputIDs, NAMED('uniqueInputIDs'));
     // OUTPUT(addCounts, NAMED('addCounts'));    


    RETURN addCounts;
END;