IMPORT DueDiligence; 

EXPORT getIndGeographicRisk(DATASET(DueDiligence.Layouts.Indv_Internal) inData) := FUNCTION
	
                                                                                    
    //Start by calling the Geographic Risk Function                                        
    //The individual address IS the cleaned input and geo blk came from the 
    //address cleaner.
    ListOfAddresses  :=  PROJECT(inData, TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
                                                    //populate the Geographic internal record with address data from the left
                                                    SELF.seq := LEFT.seq; 
                                                    SELF.did := LEFT.inquiredDID;              
                                                    SELF.streetaddress1 := LEFT.individual.streetaddress1;
                                                    SELF.streetaddress2 := LEFT.individual.streetaddress2;
                                                    SELF.prim_range := LEFT.individual.prim_range;
                                                    SELF.predir := LEFT.individual.predir;
                                                    SELF.prim_name := LEFT.individual.prim_name;
                                                    SELF.addr_suffix := LEFT.individual.addr_suffix;
                                                    SELF.postdir := LEFT.individual.postdir;
                                                    SELF.unit_desig := LEFT.individual.unit_desig;
                                                    SELF.sec_range := LEFT.individual.sec_range;
                                                    SELF.city := LEFT.individual.city;
                                                    SELF.zip5 := LEFT.individual.zip5;
                                                    SELF.zip4 := LEFT.individual.zip4;
                                                    SELF.cart := LEFT.individual.cart;
                                                    SELF.state := LEFT.individual.state;
                                                    SELF.county := LEFT.individual.county;
                                                    SELF.geo_blk := LEFT.individual.geo_blk;
                                                    SELF := LEFT;
                                                    SELF := [];));  //all other fields can be empty

    //Determine the Geographic Risk for the Inquired Individual
    AddressPersonGeoRisk := DueDiligence.CommonAddress.getAddressRisk(ListOfAddresses);  


    //add the Geographic Risk to Indv_Internal layout
    WithPersonGeoRisk := JOIN(inData, AddressPersonGeoRisk,
                              LEFT.seq          = RIGHT.seq AND
                              LEFT.inquiredDID  = RIGHT.did,												
                              TRANSFORM(DueDiligence.Layouts.Indv_Internal, 
                                        //Populate the Individual Internal will the Geographic risk from the RIGHT  
                                        SELF.buildgeolink := RIGHT.buildgeolink,	
                                        SELF.EasiTotCrime := RIGHT.EasiTotCrime;
                                        SELF.CityState := RIGHT.CityState;
                                        SELF.CountyHasHighCrimeIndex := RIGHT.CountyHasHighCrimeIndex;
                                        SELF.CountyBordersForgeinJur := Right.CountyBordersForgeinJur;
                                        SELF.CountyBorderOceanForgJur := RIGHT.CountyBorderOceanForgJur;
                                        SELF.CityBorderStation := RIGHT.CityBorderStation;
                                        SELF.CityFerryCrossing := RIGHT.CityFerryCrossing;
                                        SELF.CityRailStation := RIGHT.CityRailStation;
                                        SELF.HIDTA := RIGHT.HIDTA;
                                        SELF.HIFCA := RIGHT.HIFCA;
                                        SELF.FipsCode := RIGHT.FipsCode;
                                        SELF.validFIPSCode := RIGHT.validFIPSCode;
                                        SELF.CountyName := RIGHT.CountyName;  
                                        SELF.censusRecordExists := RIGHT.censusRecordExists;
                                        //Populate the rest of the Individual Internal from the LEFT
                                        SELF := LEFT),
                              LEFT OUTER,
                              ATMOST(DueDiligence.Constants.MAX_ATMOST_1));
																	




    // OUTPUT(CHOOSEN(ListOfAddresses, 100), NAMED('ListOfAddresses'));
    // OUTPUT(CHOOSEN(AddressPersonGeoRisk, 100), NAMED('AddressPersonGeoRisk'));
    // OUTPUT(CHOOSEN(WithPersonGeoRisk, 100), NAMED('WithPersonGeoRisk'));

    RETURN WithPersonGeoRisk;
END;
