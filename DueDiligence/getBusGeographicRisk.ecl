IMPORT DueDiligence;

EXPORT getBusGeographicRisk(DATASET(DueDiligence.layouts.Busn_Internal) BusnData) := FUNCTION
	
 

    //Start by calling the Geographic Risk Function
    ListOfAddresses  :=  PROJECT(BusnData, TRANSFORM(DueDiligence.layoutsInternal.GeographicLayout,
                                                      //populate the Geographic internal record with address data from the left
                                                      SELF.seq := LEFT.seq;
                                                      SELF.ultID := LEFT.Busn_info.BIP_IDS.UltID.LinkID;
                                                      SELF.orgID := LEFT.Busn_info.BIP_IDS.OrgID.LinkID;
                                                      SELF.seleID := LEFT.Busn_info.BIP_IDS.seleID.LinkID;
                                                      SELF.proxID := LEFT.Busn_info.BIP_IDS.proxID.LinkID;
                                                      SELF.powID := LEFT.Busn_info.BIP_IDS.powid.LinkID; 
                                                      SELF.did := 0;  //Notice the did is zero.  This address is for a Business.
                                                      SELF.streetaddress1 := LEFT.busn_info.address.streetaddress1;
                                                      SELF.streetaddress2 := LEFT.busn_info.address.streetaddress2;
                                                      SELF.prim_range := LEFT.busn_info.address.prim_range;
                                                      SELF.predir := LEFT.busn_info.address.predir;
                                                      SELF.prim_name := LEFT.busn_info.address.prim_name;
                                                      SELF.addr_suffix := LEFT.busn_info.address.addr_suffix;
                                                      SELF.postdir := LEFT.busn_info.address.postdir;
                                                      SELF.unit_desig := LEFT.busn_info.address.unit_desig;
                                                      SELF.sec_range := LEFT.busn_info.address.sec_range;
                                                      SELF.city := LEFT.busn_info.address.city;
                                                      SELF.zip5 := LEFT.busn_info.address.zip5;
                                                      SELF.zip4 := LEFT.busn_info.address.zip4;
                                                      SELF.cart := LEFT.busn_info.address.cart;
                                                      SELF.state := LEFT.busn_info.address.state;
                                                      SELF.county := LEFT.busn_info.address.county;
                                                      SELF.geo_blk := LEFT.busn_info.address.geo_blk;
                                                      SELF := LEFT;
                                                      SELF := [];));  //all other fields can be empty

                                                                                  
    //Determine the Geographic Risk for the Inquired Business
    AddressBusnGeoRisk := DueDiligence.CommonAddress.getAddressRisk(ListOfAddresses, TRUE);  


    //add the Geographic Risk to Busn_Internal layout.
    WithBusnGeoRisk := JOIN(BusnData, AddressBusnGeoRisk,
                            LEFT.seq = RIGHT.seq AND
                            LEFT.Busn_info.BIP_IDS.UltID.LinkID = RIGHT.ultID AND
                            LEFT.Busn_info.BIP_IDS.OrgID.LinkID = RIGHT.orgID AND
                            LEFT.Busn_info.BIP_IDS.SeleID.LinkID = RIGHT.seleID,												
                            TRANSFORM(DueDiligence.Layouts.Busn_Internal, 
                                      //Populate the Business Internal will the Geographic risk from the RIGHT
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
                                      SELF.censusRecordExists := RIGHT.censusRecordExists;
                                      SELF.CountyName := RIGHT.CountyName;  
                                      //Populate the rest of the Business Internal from the LEFT       
                                      SELF := LEFT),
                            LEFT OUTER,
                            ATMOST(DueDiligence.Constants.MAX_ATMOST_1));




    // OUTPUT(CHOOSEN(ListOfAddresses, 100),          NAMED('ListOfAddresses'));
    // OUTPUT(CHOOSEN(AddressBusnGeoRisk, 100),       NAMED('AddressBusnGeoRisk'));
    // OUTPUT(CHOOSEN(WithBusnGeoRisk, 100),          NAMED('WithBusnGeoRisk'));

    RETURN WithBusnGeoRisk;
END;
	