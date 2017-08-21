//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTN_NPKeys.incident_bip_BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT Scrubs_SANCTN_NPKeys,SALT33;
// First create an instantiated hygiene module
  infile := Scrubs_SANCTN_NPKeys.incident_bip_In_SANCTN_NPKeys;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := Scrubs_SANCTN_NPKeys.incident_bip_Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_SANCTN_NPKeys'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,dotid,Examples),NAMED('dotidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,dotscore,Examples),NAMED('dotscoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,dotweight,Examples),NAMED('dotweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,empid,Examples),NAMED('empidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,empscore,Examples),NAMED('empscoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,empweight,Examples),NAMED('empweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,powid,Examples),NAMED('powidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,powscore,Examples),NAMED('powscoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,powweight,Examples),NAMED('powweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,proxid,Examples),NAMED('proxidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,proxscore,Examples),NAMED('proxscoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,proxweight,Examples),NAMED('proxweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,seleid,Examples),NAMED('seleidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,selescore,Examples),NAMED('selescoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,seleweight,Examples),NAMED('seleweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,orgid,Examples),NAMED('orgidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,orgscore,Examples),NAMED('orgscoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,orgweight,Examples),NAMED('orgweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,ultid,Examples),NAMED('ultidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,ultscore,Examples),NAMED('ultscoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,ultweight,Examples),NAMED('ultweightBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,source_rec_id,Examples),NAMED('source_rec_idBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,batch,Examples),NAMED('batchBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,batch_date,Examples),NAMED('batch_dateBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,incident_num,Examples),NAMED('incident_numBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,incident_date,Examples),NAMED('incident_dateBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,int_key,Examples),NAMED('int_keyBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,srce_cd,Examples),NAMED('srce_cdBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,billing_code,Examples),NAMED('billing_codeBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,case_num,Examples),NAMED('case_numBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,jurisdiction,Examples),NAMED('jurisdictionBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,agency,Examples),NAMED('agencyBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,source_doc,Examples),NAMED('source_docBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,source_ref,Examples),NAMED('source_refBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,additional_info,Examples),NAMED('additional_infoBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,modified_date,Examples),NAMED('modified_dateBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,entry_date,Examples),NAMED('entry_dateBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,member_name,Examples),NAMED('member_nameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,submitter_name,Examples),NAMED('submitter_nameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,submitter_nickname,Examples),NAMED('submitter_nicknameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,submitter_phone,Examples),NAMED('submitter_phoneBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,submitter_fax,Examples),NAMED('submitter_faxBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,submitter_email,Examples),NAMED('submitter_emailBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,prop_addr,Examples),NAMED('prop_addrBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,prop_city,Examples),NAMED('prop_cityBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,prop_state,Examples),NAMED('prop_stateBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,prop_zip,Examples),NAMED('prop_zipBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,aid,Examples),NAMED('aidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,did,Examples),NAMED('didBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,did_score,Examples),NAMED('did_scoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,bdid,Examples),NAMED('bdidBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,bdid_score,Examples),NAMED('bdid_scoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,title,Examples),NAMED('titleBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,fname,Examples),NAMED('fnameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,mname,Examples),NAMED('mnameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,lname,Examples),NAMED('lnameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,name_suffix,Examples),NAMED('name_suffixBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,name_score,Examples),NAMED('name_scoreBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,cname,Examples),NAMED('cnameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,prim_range,Examples),NAMED('prim_rangeBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,predir,Examples),NAMED('predirBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,prim_name,Examples),NAMED('prim_nameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,addr_suffix,Examples),NAMED('addr_suffixBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,postdir,Examples),NAMED('postdirBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,unit_desig,Examples),NAMED('unit_desigBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,sec_range,Examples),NAMED('sec_rangeBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,p_city_name,Examples),NAMED('p_city_nameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,v_city_name,Examples),NAMED('v_city_nameBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,st,Examples),NAMED('stBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,zip5,Examples),NAMED('zip5Bydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,zip4,Examples),NAMED('zip4Bydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,fips_state,Examples),NAMED('fips_stateBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,fips_county,Examples),NAMED('fips_countyBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,addr_rec_type,Examples),NAMED('addr_rec_typeBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,geo_lat,Examples),NAMED('geo_latBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,geo_long,Examples),NAMED('geo_longBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,cbsa,Examples),NAMED('cbsaBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,geo_blk,Examples),NAMED('geo_blkBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,geo_match,Examples),NAMED('geo_matchBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,cart,Examples),NAMED('cartBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,cr_sort_sz,Examples),NAMED('cr_sort_szBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,lot,Examples),NAMED('lotBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,lot_order,Examples),NAMED('lot_orderBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,dpbc,Examples),NAMED('dpbcBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,chk_digit,Examples),NAMED('chk_digitBydbcode'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,dbcode,err_stat,Examples),NAMED('err_statBydbcode'));
