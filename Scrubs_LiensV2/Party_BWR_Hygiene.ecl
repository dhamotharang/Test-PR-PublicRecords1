//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LiensV2.Party_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_LiensV2,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_LiensV2.Party_In_LiensV2;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_LiensV2.Party_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_LiensV2'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,tmsid,Examples),NAMED('tmsidBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,rmsid,Examples),NAMED('rmsidBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_rmsid,Examples),NAMED('orig_rmsidBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_full_debtorname,Examples),NAMED('orig_full_debtornameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_name,Examples),NAMED('orig_nameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_lname,Examples),NAMED('orig_lnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_fname,Examples),NAMED('orig_fnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_mname,Examples),NAMED('orig_mnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_suffix,Examples),NAMED('orig_suffixBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,tax_id,Examples),NAMED('tax_idBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,ssn,Examples),NAMED('ssnBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,title,Examples),NAMED('titleBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,fname,Examples),NAMED('fnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,mname,Examples),NAMED('mnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,lname,Examples),NAMED('lnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,name_suffix,Examples),NAMED('name_suffixBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,name_score,Examples),NAMED('name_scoreBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,cname,Examples),NAMED('cnameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_address1,Examples),NAMED('orig_address1Bysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_address2,Examples),NAMED('orig_address2Bysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_city,Examples),NAMED('orig_cityBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_state,Examples),NAMED('orig_stateBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_zip5,Examples),NAMED('orig_zip5Bysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_zip4,Examples),NAMED('orig_zip4Bysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_county,Examples),NAMED('orig_countyBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,orig_country,Examples),NAMED('orig_countryBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,prim_range,Examples),NAMED('prim_rangeBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,predir,Examples),NAMED('predirBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,prim_name,Examples),NAMED('prim_nameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,addr_suffix,Examples),NAMED('addr_suffixBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,postdir,Examples),NAMED('postdirBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,unit_desig,Examples),NAMED('unit_desigBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,sec_range,Examples),NAMED('sec_rangeBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,p_city_name,Examples),NAMED('p_city_nameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,v_city_name,Examples),NAMED('v_city_nameBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,st,Examples),NAMED('stBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,zip,Examples),NAMED('zipBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,zip4,Examples),NAMED('zip4Bysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,cart,Examples),NAMED('cartBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,cr_sort_sz,Examples),NAMED('cr_sort_szBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,lot,Examples),NAMED('lotBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,lot_order,Examples),NAMED('lot_orderBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,dbpc,Examples),NAMED('dbpcBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,chk_digit,Examples),NAMED('chk_digitBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,rec_type,Examples),NAMED('rec_typeBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,county,Examples),NAMED('countyBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,geo_lat,Examples),NAMED('geo_latBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,geo_long,Examples),NAMED('geo_longBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,msa,Examples),NAMED('msaBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,geo_blk,Examples),NAMED('geo_blkBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,geo_match,Examples),NAMED('geo_matchBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,err_stat,Examples),NAMED('err_statBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,phone,Examples),NAMED('phoneBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,name_type,Examples),NAMED('name_typeBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,did,Examples),NAMED('didBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,bdid,Examples),NAMED('bdidBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,date_first_seen,Examples),NAMED('date_first_seenBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,date_last_seen,Examples),NAMED('date_last_seenBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,date_vendor_first_reported,Examples),NAMED('date_vendor_first_reportedBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,date_vendor_last_reported,Examples),NAMED('date_vendor_last_reportedBysource_file'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,source_file,persistent_record_id,Examples),NAMED('persistent_record_idBysource_file'));
