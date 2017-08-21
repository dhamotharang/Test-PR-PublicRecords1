//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Email_Data.BWR_Hygiene - Hygiene & Stats - SALT V3.0 A21');
IMPORT Scrubs_Email_Data,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_Email_Data.In_Email_Data;
  h := Scrubs_Email_Data.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_Email_Data'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,clean_email,Examples),NAMED('clean_emailByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_email_username,Examples),NAMED('append_email_usernameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_domain,Examples),NAMED('append_domainByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_domain_type,Examples),NAMED('append_domain_typeByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_domain_root,Examples),NAMED('append_domain_rootByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_domain_ext,Examples),NAMED('append_domain_extByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_is_tld_state,Examples),NAMED('append_is_tld_stateByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_is_tld_generic,Examples),NAMED('append_is_tld_genericByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_is_tld_country,Examples),NAMED('append_is_tld_countryByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_is_valid_domain_ext,Examples),NAMED('append_is_valid_domain_extByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,email_rec_key,Examples),NAMED('email_rec_keyByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,email_src,Examples),NAMED('email_srcByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,rec_src_all,Examples),NAMED('rec_src_allByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,email_src_all,Examples),NAMED('email_src_allByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,email_src_num,Examples),NAMED('email_src_numByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,num_email_per_did,Examples),NAMED('num_email_per_didByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,num_did_per_email,Examples),NAMED('num_did_per_emailByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_pmghousehold_id,Examples),NAMED('orig_pmghousehold_idByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_pmgindividual_id,Examples),NAMED('orig_pmgindividual_idByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_first_name,Examples),NAMED('orig_first_nameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_last_name,Examples),NAMED('orig_last_nameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_address,Examples),NAMED('orig_addressByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_city,Examples),NAMED('orig_cityByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_state,Examples),NAMED('orig_stateByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_zip,Examples),NAMED('orig_zipByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_zip4,Examples),NAMED('orig_zip4Byemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_email,Examples),NAMED('orig_emailByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_ip,Examples),NAMED('orig_ipByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_login_date,Examples),NAMED('orig_login_dateByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_site,Examples),NAMED('orig_siteByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_e360_id,Examples),NAMED('orig_e360_idByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,orig_teramedia_id,Examples),NAMED('orig_teramedia_idByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,did,Examples),NAMED('didByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,did_score,Examples),NAMED('did_scoreByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,did_type,Examples),NAMED('did_typeByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,is_did_prop,Examples),NAMED('is_did_propByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,hhid,Examples),NAMED('hhidByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,title,Examples),NAMED('titleByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,fname,Examples),NAMED('fnameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,mname,Examples),NAMED('mnameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,lname,Examples),NAMED('lnameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,name_suffix,Examples),NAMED('name_suffixByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,name_score,Examples),NAMED('name_scoreByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,prim_range,Examples),NAMED('prim_rangeByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,predir,Examples),NAMED('predirByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,prim_name,Examples),NAMED('prim_nameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,addr_suffix,Examples),NAMED('addr_suffixByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,postdir,Examples),NAMED('postdirByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,unit_desig,Examples),NAMED('unit_desigByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,sec_range,Examples),NAMED('sec_rangeByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,p_city_name,Examples),NAMED('p_city_nameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,v_city_name,Examples),NAMED('v_city_nameByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,st,Examples),NAMED('stByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,zip,Examples),NAMED('zipByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,zip4,Examples),NAMED('zip4Byemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,cart,Examples),NAMED('cartByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,cr_sort_sz,Examples),NAMED('cr_sort_szByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,lot,Examples),NAMED('lotByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,lot_order,Examples),NAMED('lot_orderByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,dbpc,Examples),NAMED('dbpcByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,chk_digit,Examples),NAMED('chk_digitByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,rec_type,Examples),NAMED('rec_typeByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,county,Examples),NAMED('countyByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,geo_lat,Examples),NAMED('geo_latByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,geo_long,Examples),NAMED('geo_longByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,msa,Examples),NAMED('msaByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,geo_blk,Examples),NAMED('geo_blkByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,geo_match,Examples),NAMED('geo_matchByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,err_stat,Examples),NAMED('err_statByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,append_rawaid,Examples),NAMED('append_rawaidByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,best_ssn,Examples),NAMED('best_ssnByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,best_dob,Examples),NAMED('best_dobByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,process_date,Examples),NAMED('process_dateByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,activecode,Examples),NAMED('activecodeByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,date_first_seen,Examples),NAMED('date_first_seenByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,date_last_seen,Examples),NAMED('date_last_seenByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,date_vendor_first_reported,Examples),NAMED('date_vendor_first_reportedByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,date_vendor_last_reported,Examples),NAMED('date_vendor_last_reportedByemail_src'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,email_src,current_rec,Examples),NAMED('current_recByemail_src'));
