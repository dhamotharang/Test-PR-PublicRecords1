IMPORT PRTE2_Neighborhood, PRTE2_Business_Risk, PRTE2_GlobalWatchLists, Address_Attributes, prte_CSV, STD;

//prte::key::bipv2::business_header::qa::linkids
EXPORT Files := MODULE

            EXPORT bip_header := index({
                                         unsigned6 ultid,
                                         unsigned6 orgid,
                                         unsigned6 seleid,
                                         unsigned6 proxid,
                                         unsigned6 powid,
                                         unsigned6 empid,
                                         unsigned6 dotid
                                      }, PRTE2_Neighborhood.layouts.linkids, constants.Bip_filename);


  //thor_data400::key::business_header::20200428::address_siccode
  EXPORT address_siccode := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                  TRANSFORM(PRTE2_Business_Risk.Layouts.address_siccode,
                                            self.z5 := left.zip, 
                                            self.sic_code := left.company_sic_code1,                                              
                                            self.suffix := left.addr_suffix,                                             
                                            self := left,
                                            self := [])), record, all);


  //thor_data400::key::business_header::20200428::business_risk_bdid
  EXPORT business_risk_bdid := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                     TRANSFORM(PRTE2_Business_Risk.layouts.Business_Risk_bdid,
                                               self.bdid := right.bdid,
                                               self.streetlink := left.zip + left.zip4,
                                               self.City := left.v_city_name,
                                               self.State := left.st,
                                               self.geolink := left.st + left.fips_county + left.geo_blk,
                                               self.county := left.fips_county,
                                               self.match_company_name := left.company_name,
                                               self.address_type := left.company_address_type_raw, 
                                               self := left,
                                               self := [])), record, all);


  //thor_data400::key::business_header::20200428::hri::address_siccode
  EXPORT hri_address_siccode := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                      TRANSFORM(PRTE2_Business_Risk.layouts.hri_address_siccode,
                                                self.suffix := left.addr_suffix,
                                                self.sic_code := left.company_sic_code1,
                                                self.z5 := left.zip, 
                                                self := left,
                                                self := [])), record, all);

  
  //thor_data400::key::business_header::20200428::hri::address
  EXPORT hri_address := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                   TRANSFORM(PRTE2_Business_Risk.layouts.hri_address,
                                             self.sic_code := left.company_sic_code1,
                                             self.suffix := left.addr_suffix,
                                             self.City := left.v_city_name,
                                             self.State := left.st,
                                             self.z5 := left.zip, 
                                             self := left,
                                             self := [])), record, all);
                                      
  
  //thor_data400::key::business_header::20200428::hri::sic.z5
  EXPORT hri_sic := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                               TRANSFORM(PRTE2_Business_Risk.layouts.hri_sic,
                                         self.bdid := right.bdid,
                                         self.lat := left.geo_lat,
                                         self.long := left.geo_long,
                                         self.sic_code := left.company_sic_code1,
                                         self.suffix := left.addr_suffix,
                                         self.City := left.v_city_name,
                                         self.State := left.st,
                                         self.z5 := left.zip, 
                                         self.z4 := left.zip4,
                                         self := left,
                                         self := [])), record, all);

END;

