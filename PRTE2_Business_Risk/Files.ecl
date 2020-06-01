IMPORT PRTE2_Neighborhood, PRTE2_Business_Risk, PRTE2_GlobalWatchLists, Address_Attributes, PRTE2_LNProperty;

EXPORT Files := MODULE
     
    //prte::key::bipv2::business_header::qa::linkids
    EXPORT bip_header := index({
                                 unsigned6 ultid,
                                 unsigned6 orgid,
                                 unsigned6 seleid,
                                 unsigned6 proxid,
                                 unsigned6 powid,
                                 unsigned6 empid,
                                 unsigned6 dotid}, 
                                 PRTE2_Neighborhood.layouts.linkids, 
                                 constants.Bip_filename
                              );

            
    //prte::key::ln_propertyv2::qa::assessor.fid
    EXPORT FID_FileName := index ({
                                    string12 ln_fares_id;
                                    unsigned6 proc_date}, 
                                    PRTE2_Business_Risk.layouts.fid_layout, 
                                    constants.FID_FileName
                                 );


        //thor_data400::key::business_header::qa::address_siccode
        EXPORT address_siccode := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                             TRANSFORM(PRTE2_Business_Risk.Layouts.address_siccode,
                                                       self.z5 := left.zip,
                                                       self.sic_code := left.company_sic_code1,
                                                       self.suffix := left.addr_suffix,
                                                       self := left,
                                                       self := [])), record, all);

   
        //Join Global watchlist and Assesor.FID files for Business_Risk_bdid
        J1 := JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                   TRANSFORM(PRTE2_Neighborhood.layouts.linkids,
                             self:=left));
        //Output for J1
        business_GWL := dedup(J1); 
    
        //thor_data400::key::business_header::qa::business_risk_bdid: uses the J1 JOIN
        EXPORT business_Property := dedup(JOIN(FID_FileName, business_GWL, LEFT.assessee_name = RIGHT.company_name,
                                               TRANSFORM(PRTE2_Business_Risk.layouts.Business_Risk_bdid,
                                                         SELF.bdid := RIGHT.company_bdid,
                                                         SELF.zip := RIGHT.zip,
                                                         SELF.prim_range := RIGHT.prim_range,
                                                         SELF.prim_name := RIGHT.prim_name,
                                                         SELF.addr_suffix := RIGHT.addr_suffix,
                                                         SELF.predir := RIGHT.predir,
                                                         SELF.postdir := RIGHT.postdir,
                                                         SELF.unit_desig := RIGHT.unit_desig,
                                                         SELF.sec_range := RIGHT.sec_range,
                                                         SELF.city := RIGHT.v_city_name,
                                                         SELF.state := RIGHT.st,
                                                         SELF.zip4 := (unsigned)RIGHT.zip4,
                                                         SELF.geo_blk := RIGHT.geo_blk,
                                                         SELF.geolink := RIGHT.st + LEFT.county_name + RIGHT.geo_blk,
                                                         SELF.streetlink := RIGHT.ZIP + RIGHT.ZIP4,
                                                         SELF.dt_first_seen := RIGHT.dt_first_seen,
                                                         SELF.dt_last_seen := RIGHT.dt_last_seen,
                                                         SELF.county := LEFT.county_name,
                                                         SELF.msa := RIGHT.msa,
                                                         SELF.geo_lat := RIGHT.geo_lat,
                                                         SELF.geo_long := RIGHT.geo_long,
                                                         SELF.current := RIGHT.current,
                                                         SELF.source := RIGHT.source,
                                                         SELF.match_company_name := RIGHT.company_name,
                                                         SELF.address_type := RIGHT.company_address_type_raw,
                                                         SELF.occupant_owned := (UNSIGNED)LEFT.owner_occupied,
                                                         SELF.standardized_land_use_code := LEFT.standardized_land_use_code,
                                                         SELF.building_area := (UNSIGNED)LEFT.building_area,
                                                         SELF.no_of_buildings := (UNSIGNED)LEFT.no_of_buildings,
                                                         SELF.no_of_stories := (UNSIGNED)LEFT.no_of_stories,
                                                         SELF.no_of_rooms := (UNSIGNED)LEFT.no_of_rooms,
                                                         SELF.no_of_bedrooms := (unsigned)LEFT.no_of_bedrooms,
                                                         SELF.undel_sec_range := (unsigned)RIGHT.sec_range,
                                                         SELF := left,
                                                         SELF := [])), record, all);
                                                         

        //thor_data400::key::business_header::qa::hri::address_siccode
        EXPORT hri_address_siccode := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                                 TRANSFORM(PRTE2_Business_Risk.layouts.hri_address_siccode,
                                                           self.suffix := left.addr_suffix,
                                                           self.sic_code := left.company_sic_code1,
                                                           self.z5 := left.zip,
                                                           self := left,
                                                           self := [])), record, all);


        //thor_data400::key::hri_address_to_sic_qa
        EXPORT hri_address := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                         TRANSFORM(PRTE2_Business_Risk.layouts.hri_address,
                                                   self.sic_code := left.company_sic_code1,
                                                   self.suffix := left.addr_suffix,
                                                   self.City := left.v_city_name,
                                                   self.State := left.st,
                                                   self.z5 := left.zip,
                                                   self := left,
                                                   self := [])), record, all);


        //thor_data400::key::hri_sic_zip_to_address_qa
        EXPORT hri_sic := dedup(JOIN(bip_header, PRTE2_GlobalWatchLists.files.GWL_Base, LEFT.company_fein = RIGHT.link_fein,
                                     TRANSFORM(PRTE2_Business_Risk.layouts.hri_sic,
                                               self.bdid := (string)right.bdid,
                                               self.lat := (real)left.geo_lat,
                                               self.long := (real)left.geo_long,
                                               self.sic_code := left.company_sic_code1,
                                               self.suffix := left.addr_suffix,
                                               self.City := left.v_city_name,
                                               self.State := left.st,
                                               self.z5 := left.zip,
                                               self.z4 := left.zip4,
                                               self := left,
                                               self := [])), record, all);

END;