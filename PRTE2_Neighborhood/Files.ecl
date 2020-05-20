IMPORT PRTE2_Neighborhood, Address_Attributes, prte_CSV, STD, PRTE2_SexOffender;

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

  
  //prte::key::neighborhood::qa::colleges::geolink
  EXPORT Colleges := dedup(project(bip_header(company_name_type_raw = 'COLLEGES AND UNIVERSITIES'),
                           transform(PRTE2_Neighborhood.layouts.rthor_data400_key_neighborhood_colleges_address,
                                     self.college_name := left.company_name,
                                     self.geolink := left.st + left.fips_county + left.geo_blk,
                                     self.webaddr := left.company_url,
                                     self.phone := left.company_phone,
                                     self.county := left.fips_county,
                                     self := left,
                                     self := [])), record, all);

  
  //prte::key::neighborhood::qa::schools::geolink
  set_school := ['HOSPITAL MEDICAL SCHOOL AFFILIATION AND VEHICLE DRIVING SCHOOL',
                 'VEHICLE DRIVING SCHOOL', 'HYPNOSIS SCHOOL', 'ELEMENTARY AND SECONDARY SCHOOLS',
                 'PRIVATE SENIOR HIGH SCHOOL', 'PRIVATE SENIOR HIGH SCHOOL'];

  EXPORT Schools := dedup(project(bip_header(company_name_type_raw in set_school),
                                  transform(PRTE2_Neighborhood.layouts.rthor_data400_key_neighborhood_schools_address,
                                            self.school_name := left.company_name,
                                            self.geolink := left.st + left.fips_county + left.geo_blk,
                                            self.county := left.fips_county,
                                            self := left,
                                            self := [])), record, all);

  
  //prte::key::neighborhood::qa::businesses_geolink
  EXPORT Businesses := dedup(project(bip_header,
                                     transform(PRTE_CSV.Neighborhood.rthor_data400_key_neighborhood_businesses_geolink,
                                               self.geolink := left.st + left.fips_county + left.geo_blk,
                                               self.zip := (unsigned3)left.zip,
                                               self.zip4 := (unsigned2)left.zip4,
                                               self.state := trim(left.st, all),
                                               self.city := trim(left.p_city_name, all),
                                               self := left,
                                               self := [])), record, all);

  
  //prte::key::neighborhood::qa::aca_institutions_geolink
  EXPORT ACA_Institute := dedup(project(bip_header(company_name_type_raw = 'CORRECTIONAL INSTITUTIONS'),
                                        transform(PRTE_CSV.Neighborhood.rthor_data400_key_neighborhood_aca_institutions_geolink,
                                                  self.institution := left.company_name,
                                                  self.state := trim(left.st, all),
                                                  self.city  := trim(left.v_city_name, all),
                                                  self.phone := trim(left.contact_phone, all),
                                                  self.addr1 := trim(left.prim_range, right) + ' '
                                                              + trim(left.predir, right) +' ' 
                                                              + trim(left.prim_name, right ) + ' ' 
                                                              + trim(left.addr_suffix, right) +' '
                                                              + trim(left.postdir, right) +' '
                                                              + trim(left.unit_desig, right) +' '
                                                              + trim(left.sec_range, right);  
                                                  self.title := '',
                                                  self.fname := '',
                                                  self.lname := '',
                                                  self.mname := '',
                                                  self.name_suffix := '',
                                                  self.geolink := left.st + left.fips_county + left.geo_blk,
                                                  self.INST_TYPE_EXP := 'MUNICIPAL',
                                                  self.INST_TYPE := 'MU',
                                                  self := left,
                                                  self := [])), record, all);

  
  //prte::key::neighborhood::qa::sex_offender_geolink
  EXPORT SexOffender := dedup(project(PRTE2_SexOffender.Files.Offender_di_ref(prim_name != '' and st != ''),
                                        transform(PRTE2_Neighborhood.layouts.rthor_data400_key_neighborhood_sex_offender_geolink,
                                                  self.geolink := left.st + left.county + left.geo_blk,
                                                  self.sex := map(left.sex = 'M' => 'MALE',
                                                                  left.sex = 'F' => 'FEMALE', 'OTHER');
                                                  self.OFFENDER_ID  := left.seisint_primary_key,
                                                  self.ADDR_DT_LAST_SEEN := left.dt_last_reported,
                                                  self := left,
                                                  self := [])), record, all);
                                                  
  
  EXPORT FireDept := DATASET([], recordof(address_attributes.File_Fire_Departments));
  EXPORT LawEnforcement	:= DATASET([], recordof(address_attributes.File_Law_Enforcement));

END;



