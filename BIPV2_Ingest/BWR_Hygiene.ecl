//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Ingest.BWR_Hygiene - Hygiene & Stats - SALT V3.5.3');
IMPORT BIPV2_Ingest,SALT35;
// First create an instantiated hygiene module
  infile := BIPV2_Ingest.In_BASE;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := BIPV2_Ingest.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(h.ClusterCounts,NAMED('ClusterCounts'),ALL); // Breakdown by size of clusters
  OUTPUT(h.ClusterSrc,NAMED('ClusterSrc'),ALL); // Breakdown of source distribution in clusters
  OUTPUT(h.SrcProfiles,NAMED('SrcProfiles'),ALL); // Which sources contribute values to a cluster
  OUTPUT(SALT35.MAC_Character_Counts.EclRecord(p,'Layout_BASE'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT35.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Consistency of DOTid *******
  // DOTid consistency module
  CM := BIPV2_Ingest.Fields.UIDConsistency(BIPV2_Ingest.In_BASE);
  // Either run the basic or be more thorough and run the advanced
//  OUTPUT(CM.Basic0,NAMED('SimpleIDErrors0'));
  OUTPUT(CM.IdCounts,NAMED('IDCounts'));
  OUTPUT(CM.Advanced0,NAMED('IDErrors0'));
// If there are problems with the unbased0 numbers; these attributes will show the clusters without a basis
//  OUTPUT(CM.DOTid_Unbased,NAMED('UnbasedDOTid'));
// If there are problems with the Twoparent0 numbers; these attributes will show the clusters with two parents
//  OUTPUT(CM.rcid_TwoParents,NAMED('Twoparentsrcid'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT35.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,source_record_id,Examples),NAMED('source_record_idBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_first_seen,Examples),NAMED('dt_first_seenBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_last_seen,Examples),NAMED('dt_last_seenBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_vendor_first_reported,Examples),NAMED('dt_vendor_first_reportedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_vendor_last_reported,Examples),NAMED('dt_vendor_last_reportedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_first_seen_company_name,Examples),NAMED('dt_first_seen_company_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_last_seen_company_name,Examples),NAMED('dt_last_seen_company_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_first_seen_company_address,Examples),NAMED('dt_first_seen_company_addressBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_last_seen_company_address,Examples),NAMED('dt_last_seen_company_addressBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_first_seen_contact,Examples),NAMED('dt_first_seen_contactBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dt_last_seen_contact,Examples),NAMED('dt_last_seen_contactBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,isContact,Examples),NAMED('isContactBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,iscorp,Examples),NAMED('iscorpBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_hasnumber,Examples),NAMED('cnp_hasnumberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_name,Examples),NAMED('cnp_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_number,Examples),NAMED('cnp_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_btype,Examples),NAMED('cnp_btypeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_lowv,Examples),NAMED('cnp_lowvBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_translated,Examples),NAMED('cnp_translatedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cnp_classid,Examples),NAMED('cnp_classidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_aceaid,Examples),NAMED('company_aceaidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,corp_legal_name,Examples),NAMED('corp_legal_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dba_name,Examples),NAMED('dba_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,active_duns_number,Examples),NAMED('active_duns_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,hist_duns_number,Examples),NAMED('hist_duns_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,active_enterprise_number,Examples),NAMED('active_enterprise_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,hist_enterprise_number,Examples),NAMED('hist_enterprise_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,ebr_file_number,Examples),NAMED('ebr_file_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,active_domestic_corp_key,Examples),NAMED('active_domestic_corp_keyBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,hist_domestic_corp_key,Examples),NAMED('hist_domestic_corp_keyBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,foreign_corp_key,Examples),NAMED('foreign_corp_keyBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,unk_corp_key,Examples),NAMED('unk_corp_keyBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,global_sid,Examples),NAMED('global_sidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,record_sid,Examples),NAMED('record_sidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,employee_count_org_raw,Examples),NAMED('employee_count_org_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,employee_count_org_derived,Examples),NAMED('employee_count_org_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,revenue_org_raw,Examples),NAMED('revenue_org_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,revenue_org_derived,Examples),NAMED('revenue_org_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,employee_count_local_raw,Examples),NAMED('employee_count_local_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,employee_count_local_derived,Examples),NAMED('employee_count_local_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,revenue_local_raw,Examples),NAMED('revenue_local_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,revenue_local_derived,Examples),NAMED('revenue_local_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,locid,Examples),NAMED('locidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,source_docid,Examples),NAMED('source_docidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,title,Examples),NAMED('titleBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,fname,Examples),NAMED('fnameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,mname,Examples),NAMED('mnameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,lname,Examples),NAMED('lnameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,name_suffix,Examples),NAMED('name_suffixBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,name_score,Examples),NAMED('name_scoreBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_name,Examples),NAMED('company_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_name_type_raw,Examples),NAMED('company_name_type_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_name_type_derived,Examples),NAMED('company_name_type_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_rawaid,Examples),NAMED('company_rawaidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,predir,Examples),NAMED('predirBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,addr_suffix,Examples),NAMED('addr_suffixBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,postdir,Examples),NAMED('postdirBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,unit_desig,Examples),NAMED('unit_desigBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,p_city_name,Examples),NAMED('p_city_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,zip4,Examples),NAMED('zip4Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cart,Examples),NAMED('cartBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,cr_sort_sz,Examples),NAMED('cr_sort_szBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,lot,Examples),NAMED('lotBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,lot_order,Examples),NAMED('lot_orderBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,dbpc,Examples),NAMED('dbpcBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,chk_digit,Examples),NAMED('chk_digitBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,rec_type,Examples),NAMED('rec_typeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,fips_state,Examples),NAMED('fips_stateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,fips_county,Examples),NAMED('fips_countyBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,geo_lat,Examples),NAMED('geo_latBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,geo_long,Examples),NAMED('geo_longBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,msa,Examples),NAMED('msaBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,geo_blk,Examples),NAMED('geo_blkBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,geo_match,Examples),NAMED('geo_matchBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,err_stat,Examples),NAMED('err_statBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_bdid,Examples),NAMED('company_bdidBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_address_type_raw,Examples),NAMED('company_address_type_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_fein,Examples),NAMED('company_feinBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,best_fein_indicator,Examples),NAMED('best_fein_indicatorBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_phone,Examples),NAMED('company_phoneBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,phone_type,Examples),NAMED('phone_typeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,phone_score,Examples),NAMED('phone_scoreBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_org_structure_raw,Examples),NAMED('company_org_structure_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_incorporation_date,Examples),NAMED('company_incorporation_dateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_sic_code1,Examples),NAMED('company_sic_code1Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_sic_code2,Examples),NAMED('company_sic_code2Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_sic_code3,Examples),NAMED('company_sic_code3Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_sic_code4,Examples),NAMED('company_sic_code4Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_sic_code5,Examples),NAMED('company_sic_code5Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_naics_code1,Examples),NAMED('company_naics_code1Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_naics_code2,Examples),NAMED('company_naics_code2Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_naics_code3,Examples),NAMED('company_naics_code3Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_naics_code4,Examples),NAMED('company_naics_code4Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_naics_code5,Examples),NAMED('company_naics_code5Bysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_ticker,Examples),NAMED('company_tickerBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_ticker_exchange,Examples),NAMED('company_ticker_exchangeBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_foreign_domestic,Examples),NAMED('company_foreign_domesticBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_url,Examples),NAMED('company_urlBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_inc_state,Examples),NAMED('company_inc_stateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_charter_number,Examples),NAMED('company_charter_numberBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_filing_date,Examples),NAMED('company_filing_dateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_status_date,Examples),NAMED('company_status_dateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_foreign_date,Examples),NAMED('company_foreign_dateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,event_filing_date,Examples),NAMED('event_filing_dateBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_name_status_raw,Examples),NAMED('company_name_status_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_status_raw,Examples),NAMED('company_status_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,vl_id,Examples),NAMED('vl_idBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,current,Examples),NAMED('currentBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_did,Examples),NAMED('contact_didBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_type_raw,Examples),NAMED('contact_type_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_job_title_raw,Examples),NAMED('contact_job_title_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_ssn,Examples),NAMED('contact_ssnBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_dob,Examples),NAMED('contact_dobBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_status_raw,Examples),NAMED('contact_status_rawBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_email,Examples),NAMED('contact_emailBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_email_username,Examples),NAMED('contact_email_usernameBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_email_domain,Examples),NAMED('contact_email_domainBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_phone,Examples),NAMED('contact_phoneBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,from_hdr,Examples),NAMED('from_hdrBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_department,Examples),NAMED('company_departmentBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_address_type_derived,Examples),NAMED('company_address_type_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_org_structure_derived,Examples),NAMED('company_org_structure_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_name_status_derived,Examples),NAMED('company_name_status_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,company_status_derived,Examples),NAMED('company_status_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_type_derived,Examples),NAMED('contact_type_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_job_title_derived,Examples),NAMED('contact_job_title_derivedBysource'));
  //  OUTPUT(SALT35.MAC_CrossTab(infile,source,contact_status_derived,Examples),NAMED('contact_status_derivedBysource'));
