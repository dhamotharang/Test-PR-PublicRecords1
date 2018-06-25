IMPORT BIPv2, DueDiligence, iesp;

EXPORT reportSharedProperty (DATASET(DueDiligence.LayoutsInternalReport.SharedPropertyLayout) inData) := FUNCTION

    //limit the number of properties according to the max for the report
    limitedProperties := DEDUP(SORT(inData, seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, -assessedYear), seq, #EXPAND(BIPv2.IDmacros.mac_ListTop3Linkids()), did, KEEP(iesp.constants.DDRAttributesConst.MaxProperties));
        
    //transform data to calc the geographic risk per address
    geoPropertyAddress := PROJECT(limitedProperties, TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
                                                               SELF.seq := LEFT.seq;
                                                               SELF.ultID := LEFT.ultID;
                                                               SELF.orgID := LEFT.orgID;
                                                               SELF.seleID := LEFT.seleID;
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
                                                               SELF := [];));
   
    propertyOwnedRisk := DueDiligence.Common.getGeographicRisk(geoPropertyAddress);
   
   
    //add the risk back to the property details
    ownedPropertyDetails := JOIN(limitedProperties, propertyOwnedRisk,
                                  #EXPAND(DueDiligence.Constants.mac_JOINLinkids_Results()) AND
                                  LEFT.did = RIGHT.did AND
                                  LEFT.prim_range = RIGHT.prim_range AND
                                  LEFT.prim_name[1..8] = RIGHT.prim_name[1..8] AND
                                  LEFT.zip5 = RIGHT.zip5,
                                  TRANSFORM(DueDiligence.LayoutsInternalReport.SharedPropertyLayout,
                                            SELF.buildgeolink := RIGHT.buildgeolink;
                                            SELF.EasiTotCrime := RIGHT.EasiTotCrime;
                                            SELF.CityState := RIGHT.CityState;
                                            SELF.FipsCode := RIGHT.FipsCode;  
                                            SELF.CountyName := RIGHT.CountyName;                     
                                            SELF.CountyHasHighCrimeIndex := RIGHT.CountyHasHighCrimeIndex;   
                                            SELF.CountyBordersForgeinJur := RIGHT.CountyBordersForgeinJur;   
                                            SELF.CountyBorderOceanForgJur := RIGHT.CountyBorderOceanForgJur;  
                                            SELF.CityBorderStation := RIGHT.CityBorderStation;  
                                            SELF.CityFerryCrossing := RIGHT.CityFerryCrossing;  
                                            SELF.CityRailStation := RIGHT.CityRailStation; 
                                            SELF.HIDTA := RIGHT.HIDTA;  
                                            SELF.HIFCA := RIGHT.HIFCA;     
                                            SELF := LEFT;),
                                  LEFT OUTER,
                                  ATMOST(1));





    //OUTPUT(limitedProperties, NAMED('limitedProperties'));
   // OUTPUT(geoPropertyAddress, NAMED('geoPropertyAddress'));
   // OUTPUT(propertyOwnedRisk, NAMED('propertyOwnedRisk'));
   // OUTPUT(ownedPropertyDetails, NAMED('ownedPropertyDetails'));

    RETURN ownedPropertyDetails;
END;