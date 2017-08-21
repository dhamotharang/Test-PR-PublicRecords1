//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_bk_main.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Beta 2');
IMPORT Scrubs_bk_main,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_bk_main.In_bk_main;
  h := Scrubs_bk_main.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_bk_main'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,process_date,Examples),NAMED('process_dateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,tmsid,Examples),NAMED('tmsidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,source,Examples),NAMED('sourceBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,id,Examples),NAMED('idBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,seq_number,Examples),NAMED('seq_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_created,Examples),NAMED('date_createdBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_modified,Examples),NAMED('date_modifiedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,method_dismiss,Examples),NAMED('method_dismissBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,case_status,Examples),NAMED('case_statusBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,court_code,Examples),NAMED('court_codeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,court_name,Examples),NAMED('court_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,court_location,Examples),NAMED('court_locationBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,case_number,Examples),NAMED('case_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,orig_case_number,Examples),NAMED('orig_case_numberBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_filed,Examples),NAMED('date_filedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,filing_status,Examples),NAMED('filing_statusBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,orig_chapter,Examples),NAMED('orig_chapterBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,orig_filing_date,Examples),NAMED('orig_filing_dateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,assets_no_asset_indicator,Examples),NAMED('assets_no_asset_indicatorBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,filer_type,Examples),NAMED('filer_typeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,meeting_date,Examples),NAMED('meeting_dateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,meeting_time,Examples),NAMED('meeting_timeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,address_341,Examples),NAMED('address_341Bysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,claims_deadline,Examples),NAMED('claims_deadlineBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,complaint_deadline,Examples),NAMED('complaint_deadlineBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,judge_name,Examples),NAMED('judge_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,judges_identification,Examples),NAMED('judges_identificationBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,filing_jurisdiction,Examples),NAMED('filing_jurisdictionBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,assets,Examples),NAMED('assetsBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,liabilities,Examples),NAMED('liabilitiesBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,casetype,Examples),NAMED('casetypeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,assoccode,Examples),NAMED('assoccodeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,splitcase,Examples),NAMED('splitcaseBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,filedinerror,Examples),NAMED('filedinerrorBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_last_seen,Examples),NAMED('date_last_seenBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_first_seen,Examples),NAMED('date_first_seenBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_vendor_first_reported,Examples),NAMED('date_vendor_first_reportedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,date_vendor_last_reported,Examples),NAMED('date_vendor_last_reportedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,reopen_date,Examples),NAMED('reopen_dateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,case_closing_date,Examples),NAMED('case_closing_dateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,datereclosed,Examples),NAMED('datereclosedBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteename,Examples),NAMED('trusteenameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteeaddress,Examples),NAMED('trusteeaddressBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteecity,Examples),NAMED('trusteecityBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteestate,Examples),NAMED('trusteestateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteezip,Examples),NAMED('trusteezipBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteezip4,Examples),NAMED('trusteezip4Bysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteephone,Examples),NAMED('trusteephoneBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteeid,Examples),NAMED('trusteeidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,caseid,Examples),NAMED('caseidBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,bardate,Examples),NAMED('bardateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,transferin,Examples),NAMED('transferinBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,trusteeemail,Examples),NAMED('trusteeemailBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,planconfdate,Examples),NAMED('planconfdateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,confheardate,Examples),NAMED('confheardateBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,title,Examples),NAMED('titleBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,fname,Examples),NAMED('fnameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,mname,Examples),NAMED('mnameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,lname,Examples),NAMED('lnameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,name_suffix,Examples),NAMED('name_suffixBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,name_score,Examples),NAMED('name_scoreBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_range,Examples),NAMED('prim_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,predir,Examples),NAMED('predirBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,prim_name,Examples),NAMED('prim_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,addr_suffix,Examples),NAMED('addr_suffixBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,postdir,Examples),NAMED('postdirBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,unit_desig,Examples),NAMED('unit_desigBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,sec_range,Examples),NAMED('sec_rangeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,p_city_name,Examples),NAMED('p_city_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,v_city_name,Examples),NAMED('v_city_nameBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,st,Examples),NAMED('stBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,zip,Examples),NAMED('zipBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,zip4,Examples),NAMED('zip4Bysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cart,Examples),NAMED('cartBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,cr_sort_sz,Examples),NAMED('cr_sort_szBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,lot,Examples),NAMED('lotBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,lot_order,Examples),NAMED('lot_orderBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,dbpc,Examples),NAMED('dbpcBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,chk_digit,Examples),NAMED('chk_digitBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,rec_type,Examples),NAMED('rec_typeBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,county,Examples),NAMED('countyBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,geo_lat,Examples),NAMED('geo_latBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,geo_long,Examples),NAMED('geo_longBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,msa,Examples),NAMED('msaBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,geo_blk,Examples),NAMED('geo_blkBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,geo_match,Examples),NAMED('geo_matchBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,err_stat,Examples),NAMED('err_statBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,did,Examples),NAMED('didBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,app_ssn,Examples),NAMED('app_ssnBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,delete_flag,Examples),NAMED('delete_flagBysource'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source,unique_id,Examples),NAMED('unique_idBysource'));
