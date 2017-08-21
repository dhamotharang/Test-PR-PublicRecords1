//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','scrubs_sexoffender_offense.BWR_Hygiene - Hygiene & Stats - SALT V3.3.2');
IMPORT scrubs_sexoffender_offense,SALT33;
// First create an instantiated hygiene module
  infile := scrubs_sexoffender_offense.In_sexoffender_offense;
  ip := DISTRIBUTE(infile, SKEW(0.1));
  h := scrubs_sexoffender_offense.Hygiene(ip);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT33.MAC_Character_Counts.EclRecord(p,'Layout_sexoffender_offense'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT33.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT33.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,orig_state,Examples),NAMED('orig_stateByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,vendor_code,Examples),NAMED('vendor_codeByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,source_file,Examples),NAMED('source_fileByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,seisint_primary_key,Examples),NAMED('seisint_primary_keyByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,conviction_jurisdiction,Examples),NAMED('conviction_jurisdictionByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,conviction_date,Examples),NAMED('conviction_dateByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,court,Examples),NAMED('courtByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,court_case_number,Examples),NAMED('court_case_numberByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_date,Examples),NAMED('offense_dateByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_code_or_statute,Examples),NAMED('offense_code_or_statuteByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_description,Examples),NAMED('offense_descriptionByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_description_2,Examples),NAMED('offense_description_2Byorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_category,Examples),NAMED('offense_categoryByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,victim_minor,Examples),NAMED('victim_minorByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,victim_age,Examples),NAMED('victim_ageByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,victim_gender,Examples),NAMED('victim_genderByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,victim_relationship,Examples),NAMED('victim_relationshipByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,sentence_description,Examples),NAMED('sentence_descriptionByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,sentence_description_2,Examples),NAMED('sentence_description_2Byorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,arrest_date,Examples),NAMED('arrest_dateByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,arrest_warrant,Examples),NAMED('arrest_warrantByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,fcra_conviction_flag,Examples),NAMED('fcra_conviction_flagByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,fcra_traffic_flag,Examples),NAMED('fcra_traffic_flagByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,fcra_date,Examples),NAMED('fcra_dateByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,fcra_date_type,Examples),NAMED('fcra_date_typeByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,conviction_override_date,Examples),NAMED('conviction_override_dateByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,conviction_override_date_type,Examples),NAMED('conviction_override_date_typeByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_score,Examples),NAMED('offense_scoreByorig_state_code'));
  //  OUTPUT(SALT33.MAC_CrossTab(infile,orig_state_code,offense_persistent_id,Examples),NAMED('offense_persistent_idByorig_state_code'));
