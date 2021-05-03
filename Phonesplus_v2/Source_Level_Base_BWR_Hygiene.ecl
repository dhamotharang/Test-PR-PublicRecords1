//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','PhonesPlus_V2.Source_Level_Base_BWR_Hygiene - Hygiene & Stats - SALT V3.11.11');
IMPORT PhonesPlus_V2,SALT311;
// First create an instantiated hygiene module
  infile := PhonesPlus_V2.In_Source_Level_Base;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := PhonesPlus_V2.Source_Level_Base_hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL,NAMED('Summary'));
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(SALT311.MAC_Character_Counts.EclRecord(p,'Source_Level_Base_Layout_Source_Level_Base'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT311.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT311.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cellphoneidkey,Examples),NAMED('cellphoneidkeyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,src_bitmap,Examples),NAMED('src_bitmapBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,household_flag,Examples),NAMED('household_flagBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,rules,Examples),NAMED('rulesBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cellphone,Examples),NAMED('cellphoneBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,npa,Examples),NAMED('npaBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,phone7,Examples),NAMED('phone7Bysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,phone7_did_key,Examples),NAMED('phone7_did_keyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,pdid,Examples),NAMED('pdidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,did,Examples),NAMED('didBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,did_score,Examples),NAMED('did_scoreBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,datefirstseen,Examples),NAMED('datefirstseenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,datelastseen,Examples),NAMED('datelastseenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,datevendorfirstreported,Examples),NAMED('datevendorfirstreportedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,datevendorlastreported,Examples),NAMED('datevendorlastreportedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dt_nonglb_last_seen,Examples),NAMED('dt_nonglb_last_seenBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,glb_dppa_flag,Examples),NAMED('glb_dppa_flagBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,did_type,Examples),NAMED('did_typeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,origname,Examples),NAMED('orignameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,address1,Examples),NAMED('address1Bysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,address2,Examples),NAMED('address2Bysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,origcity,Examples),NAMED('origcityBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,origstate,Examples),NAMED('origstateBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,origzip,Examples),NAMED('origzipBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,orig_phone,Examples),NAMED('orig_phoneBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,orig_carrier_name,Examples),NAMED('orig_carrier_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,predir,Examples),NAMED('predirBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,addr_suffix,Examples),NAMED('addr_suffixBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,postdir,Examples),NAMED('postdirBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,unit_desig,Examples),NAMED('unit_desigBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,p_city_name,Examples),NAMED('p_city_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,state,Examples),NAMED('stateBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,zip5,Examples),NAMED('zip5Bysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,zip4,Examples),NAMED('zip4Bysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cart,Examples),NAMED('cartBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cr_sort_sz,Examples),NAMED('cr_sort_szBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,lot,Examples),NAMED('lotBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,lot_order,Examples),NAMED('lot_orderBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dpbc,Examples),NAMED('dpbcBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,chk_digit,Examples),NAMED('chk_digitBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,rec_type,Examples),NAMED('rec_typeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,ace_fips_st,Examples),NAMED('ace_fips_stBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,ace_fips_county,Examples),NAMED('ace_fips_countyBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,geo_lat,Examples),NAMED('geo_latBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,geo_long,Examples),NAMED('geo_longBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,msa,Examples),NAMED('msaBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,geo_blk,Examples),NAMED('geo_blkBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,geo_match,Examples),NAMED('geo_matchBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,err_stat,Examples),NAMED('err_statBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,title,Examples),NAMED('titleBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,fname,Examples),NAMED('fnameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,mname,Examples),NAMED('mnameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,lname,Examples),NAMED('lnameBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,name_suffix,Examples),NAMED('name_suffixBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,name_score,Examples),NAMED('name_scoreBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,dob,Examples),NAMED('dobBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,rawaid,Examples),NAMED('rawaidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cleanaid,Examples),NAMED('cleanaidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,current_rec,Examples),NAMED('current_recBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,first_build_date,Examples),NAMED('first_build_dateBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,last_build_date,Examples),NAMED('last_build_dateBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,ingest_tpe,Examples),NAMED('ingest_tpeBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,verified,Examples),NAMED('verifiedBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,cord_cutter,Examples),NAMED('cord_cutterBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,activity_status,Examples),NAMED('activity_statusBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,prepaid,Examples),NAMED('prepaidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,global_sid,Examples),NAMED('global_sidBysource'));
  //  OUTPUT(SALT311.MAC_CrossTab(infile,source,record_sid,Examples),NAMED('record_sidBysource'));
