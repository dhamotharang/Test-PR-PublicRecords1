//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Watercraft_Search.BWR_Hygiene - Hygiene & Stats - SALT V3.11.9');
IMPORT Scrubs_Watercraft_Search,SALT311;
// First create an instantiated hygiene module
  infile := Scrubs_Watercraft_Search.In_Watercraft_Search;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_Watercraft_Search.hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Layout_Watercraft_Search'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,date_first_seen,Examples),NAMED('date_first_seenBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,date_last_seen,Examples),NAMED('date_last_seenBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,date_vendor_first_reported,Examples),NAMED('date_vendor_first_reportedBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,date_vendor_last_reported,Examples),NAMED('date_vendor_last_reportedBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,watercraft_key,Examples),NAMED('watercraft_keyBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,sequence_key,Examples),NAMED('sequence_keyBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,state_origin,Examples),NAMED('state_originBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,dppa_flag,Examples),NAMED('dppa_flagBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name,Examples),NAMED('orig_nameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name_type_code,Examples),NAMED('orig_name_type_codeBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name_type_description,Examples),NAMED('orig_name_type_descriptionBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name_first,Examples),NAMED('orig_name_firstBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name_middle,Examples),NAMED('orig_name_middleBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name_last,Examples),NAMED('orig_name_lastBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_name_suffix,Examples),NAMED('orig_name_suffixBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_address_1,Examples),NAMED('orig_address_1Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_address_2,Examples),NAMED('orig_address_2Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_city,Examples),NAMED('orig_cityBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_state,Examples),NAMED('orig_stateBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_zip,Examples),NAMED('orig_zipBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_fips,Examples),NAMED('orig_fipsBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_province,Examples),NAMED('orig_provinceBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_country,Examples),NAMED('orig_countryBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,dob,Examples),NAMED('dobBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_ssn,Examples),NAMED('orig_ssnBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orig_fein,Examples),NAMED('orig_feinBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,gender,Examples),NAMED('genderBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,phone_1,Examples),NAMED('phone_1Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,phone_2,Examples),NAMED('phone_2Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,title,Examples),NAMED('titleBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,fname,Examples),NAMED('fnameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,mname,Examples),NAMED('mnameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,lname,Examples),NAMED('lnameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,name_suffix,Examples),NAMED('name_suffixBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,name_cleaning_score,Examples),NAMED('name_cleaning_scoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,company_name,Examples),NAMED('company_nameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,prim_range,Examples),NAMED('prim_rangeBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,predir,Examples),NAMED('predirBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,prim_name,Examples),NAMED('prim_nameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,suffix,Examples),NAMED('suffixBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,postdir,Examples),NAMED('postdirBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,unit_desig,Examples),NAMED('unit_desigBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,sec_range,Examples),NAMED('sec_rangeBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,p_city_name,Examples),NAMED('p_city_nameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,v_city_name,Examples),NAMED('v_city_nameBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,st,Examples),NAMED('stBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,zip5,Examples),NAMED('zip5Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,zip4,Examples),NAMED('zip4Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,county,Examples),NAMED('countyBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,cart,Examples),NAMED('cartBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,cr_sort_sz,Examples),NAMED('cr_sort_szBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,lot,Examples),NAMED('lotBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,lot_order,Examples),NAMED('lot_orderBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,dpbc,Examples),NAMED('dpbcBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,chk_digit,Examples),NAMED('chk_digitBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,rec_type,Examples),NAMED('rec_typeBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,ace_fips_st,Examples),NAMED('ace_fips_stBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,ace_fips_county,Examples),NAMED('ace_fips_countyBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,geo_lat,Examples),NAMED('geo_latBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,geo_long,Examples),NAMED('geo_longBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,msa,Examples),NAMED('msaBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,geo_blk,Examples),NAMED('geo_blkBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,geo_match,Examples),NAMED('geo_matchBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,err_stat,Examples),NAMED('err_statBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,bdid,Examples),NAMED('bdidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,fein,Examples),NAMED('feinBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,did,Examples),NAMED('didBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,did_score,Examples),NAMED('did_scoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,ssn,Examples),NAMED('ssnBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,history_flag,Examples),NAMED('history_flagBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,rawaid,Examples),NAMED('rawaidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,reg_owner_name_2,Examples),NAMED('reg_owner_name_2Bysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,persistent_record_id,Examples),NAMED('persistent_record_idBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,source_rec_id,Examples),NAMED('source_rec_idBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,dotscore,Examples),NAMED('dotscoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,dotweight,Examples),NAMED('dotweightBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,empid,Examples),NAMED('empidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,empscore,Examples),NAMED('empscoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,empweight,Examples),NAMED('empweightBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,powid,Examples),NAMED('powidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,powscore,Examples),NAMED('powscoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,powweight,Examples),NAMED('powweightBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,proxid,Examples),NAMED('proxidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,proxscore,Examples),NAMED('proxscoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,proxweight,Examples),NAMED('proxweightBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,seleid,Examples),NAMED('seleidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,selescore,Examples),NAMED('selescoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,seleweight,Examples),NAMED('seleweightBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orgid,Examples),NAMED('orgidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orgscore,Examples),NAMED('orgscoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,orgweight,Examples),NAMED('orgweightBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,ultid,Examples),NAMED('ultidBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,ultscore,Examples),NAMED('ultscoreBysource_code'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source_code,ultweight,Examples),NAMED('ultweightBysource_code'));
