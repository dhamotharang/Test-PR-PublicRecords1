//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LiensV2_Main.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Alpha 18');
IMPORT Scrubs_LiensV2_Main,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_LiensV2_Main.In_File_Liens_Main;
  h := Scrubs_LiensV2_Main.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_File_Liens_Main'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,tmsid,Examples),NAMED('tmsidBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,rmsid,Examples),NAMED('rmsidBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,orig_rmsid,Examples),NAMED('orig_rmsidBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,process_date,Examples),NAMED('process_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,record_code,Examples),NAMED('record_codeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,date_vendor_removed,Examples),NAMED('date_vendor_removedBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_jurisdiction,Examples),NAMED('filing_jurisdictionBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_state,Examples),NAMED('filing_stateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,orig_filing_number,Examples),NAMED('orig_filing_numberBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,orig_filing_type,Examples),NAMED('orig_filing_typeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,orig_filing_date,Examples),NAMED('orig_filing_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,orig_filing_time,Examples),NAMED('orig_filing_timeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,case_number,Examples),NAMED('case_numberBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_number,Examples),NAMED('filing_numberBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_type_desc,Examples),NAMED('filing_type_descBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_date,Examples),NAMED('filing_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_time,Examples),NAMED('filing_timeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,vendor_entry_date,Examples),NAMED('vendor_entry_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,judge,Examples),NAMED('judgeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,case_title,Examples),NAMED('case_titleBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_book,Examples),NAMED('filing_bookBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,filing_page,Examples),NAMED('filing_pageBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,release_date,Examples),NAMED('release_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,amount,Examples),NAMED('amountBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,eviction,Examples),NAMED('evictionBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,satisifaction_type,Examples),NAMED('satisifaction_typeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,judg_satisfied_date,Examples),NAMED('judg_satisfied_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,judg_vacated_date,Examples),NAMED('judg_vacated_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,tax_code,Examples),NAMED('tax_codeBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,irs_serial_number,Examples),NAMED('irs_serial_numberBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,effective_date,Examples),NAMED('effective_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,lapse_date,Examples),NAMED('lapse_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,accident_date,Examples),NAMED('accident_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,sherrif_indc,Examples),NAMED('sherrif_indcBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,expiration_date,Examples),NAMED('expiration_dateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,agency,Examples),NAMED('agencyBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,agency_city,Examples),NAMED('agency_cityBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,agency_state,Examples),NAMED('agency_stateBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,agency_county,Examples),NAMED('agency_countyBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,legal_lot,Examples),NAMED('legal_lotBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,legal_block,Examples),NAMED('legal_blockBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,legal_borough,Examples),NAMED('legal_boroughBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,certificate_number,Examples),NAMED('certificate_numberBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,persistent_record_id,Examples),NAMED('persistent_record_idBysource_file'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,source_file,source_file,Examples),NAMED('source_fileBysource_file'));
