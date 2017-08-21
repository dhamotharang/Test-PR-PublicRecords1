//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Death_Master_Supplemental.BWR_Hygiene - Hygiene & Stats - SALT V3.0 A21');
IMPORT Scrubs_Death_Master_Supplemental,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_Death_Master_Supplemental.In_Death_Master_Supplemental;
  h := Scrubs_Death_Master_Supplemental.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_Death_Master_Supplemental'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,process_date,Examples),NAMED('process_dateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,source_state,Examples),NAMED('source_stateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,certificate_vol_no,Examples),NAMED('certificate_vol_noBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,certificate_vol_year,Examples),NAMED('certificate_vol_yearBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,publication,Examples),NAMED('publicationBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,decedent_name,Examples),NAMED('decedent_nameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,decedent_race,Examples),NAMED('decedent_raceBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,decedent_origin,Examples),NAMED('decedent_originBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,decedent_sex,Examples),NAMED('decedent_sexBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,decedent_age,Examples),NAMED('decedent_ageBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,education,Examples),NAMED('educationBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,occupation,Examples),NAMED('occupationBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,where_worked,Examples),NAMED('where_workedBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,cause,Examples),NAMED('causeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,ssn,Examples),NAMED('ssnBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,dob,Examples),NAMED('dobBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,dod,Examples),NAMED('dodBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,birthplace,Examples),NAMED('birthplaceBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,marital_status,Examples),NAMED('marital_statusBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,father,Examples),NAMED('fatherBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,mother,Examples),NAMED('motherBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,filed_date,Examples),NAMED('filed_dateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,year,Examples),NAMED('yearBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,county_residence,Examples),NAMED('county_residenceBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,county_death,Examples),NAMED('county_deathBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,address,Examples),NAMED('addressBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,autopsy,Examples),NAMED('autopsyBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,autopsy_findings,Examples),NAMED('autopsy_findingsBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,primary_cause_of_death,Examples),NAMED('primary_cause_of_deathBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,underlying_cause_of_death,Examples),NAMED('underlying_cause_of_deathBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,med_exam,Examples),NAMED('med_examBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,est_lic_no,Examples),NAMED('est_lic_noBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,disposition,Examples),NAMED('dispositionBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,disposition_date,Examples),NAMED('disposition_dateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,work_injury,Examples),NAMED('work_injuryBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,injury_date,Examples),NAMED('injury_dateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,injury_type,Examples),NAMED('injury_typeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,injury_location,Examples),NAMED('injury_locationBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,surg_performed,Examples),NAMED('surg_performedBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,surgery_date,Examples),NAMED('surgery_dateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,hospital_status,Examples),NAMED('hospital_statusBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,pregnancy,Examples),NAMED('pregnancyBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,facility_death,Examples),NAMED('facility_deathBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,embalmer_lic_no,Examples),NAMED('embalmer_lic_noBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,death_type,Examples),NAMED('death_typeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,time_death,Examples),NAMED('time_deathBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,birth_cert,Examples),NAMED('birth_certBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,certifier,Examples),NAMED('certifierBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,cert_number,Examples),NAMED('cert_numberBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,birth_vol_year,Examples),NAMED('birth_vol_yearBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,local_file_no,Examples),NAMED('local_file_noBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,vdi,Examples),NAMED('vdiBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,cite_id,Examples),NAMED('cite_idBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,file_id,Examples),NAMED('file_idBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,date_last_trans,Examples),NAMED('date_last_transBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,amendment_code,Examples),NAMED('amendment_codeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,amendment_year,Examples),NAMED('amendment_yearBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,_on_lexis,Examples),NAMED('_on_lexisBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,_fs_profile,Examples),NAMED('_fs_profileBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,us_armed_forces,Examples),NAMED('us_armed_forcesBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,place_of_death,Examples),NAMED('place_of_deathBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,state_death_id,Examples),NAMED('state_death_idBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,state_death_flag,Examples),NAMED('state_death_flagBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,title,Examples),NAMED('titleBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,fname,Examples),NAMED('fnameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,mname,Examples),NAMED('mnameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,lname,Examples),NAMED('lnameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,name_suffix,Examples),NAMED('name_suffixBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,name_score,Examples),NAMED('name_scoreBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,prim_range,Examples),NAMED('prim_rangeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,predir,Examples),NAMED('predirBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,prim_name,Examples),NAMED('prim_nameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,addr_suffix,Examples),NAMED('addr_suffixBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,postdir,Examples),NAMED('postdirBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,unit_desig,Examples),NAMED('unit_desigBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,sec_range,Examples),NAMED('sec_rangeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,p_city_name,Examples),NAMED('p_city_nameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,v_city_name,Examples),NAMED('v_city_nameBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,state,Examples),NAMED('stateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,zip5,Examples),NAMED('zip5Bysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,zip4,Examples),NAMED('zip4Bysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,cart,Examples),NAMED('cartBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,cr_sort_sz,Examples),NAMED('cr_sort_szBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,lot,Examples),NAMED('lotBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,lot_order,Examples),NAMED('lot_orderBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,dpbc,Examples),NAMED('dpbcBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,chk_digit,Examples),NAMED('chk_digitBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,rec_type,Examples),NAMED('rec_typeBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,fips_state,Examples),NAMED('fips_stateBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,fips_county,Examples),NAMED('fips_countyBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,geo_lat,Examples),NAMED('geo_latBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,geo_long,Examples),NAMED('geo_longBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,msa,Examples),NAMED('msaBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,geo_blk,Examples),NAMED('geo_blkBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,geo_match,Examples),NAMED('geo_matchBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,err_stat,Examples),NAMED('err_statBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,rawaid,Examples),NAMED('rawaidBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,orig_address1,Examples),NAMED('orig_address1Bysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,orig_address2,Examples),NAMED('orig_address2Bysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,statefn,Examples),NAMED('statefnBysource_state'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_state,lf,Examples),NAMED('lfBysource_state'));
