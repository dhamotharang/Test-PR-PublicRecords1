//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Death_Master_SSA.BWR_Hygiene - Hygiene & Stats - SALT V3.0 Beta 2');
IMPORT Scrubs_Death_Master_SSA,SALT30;
// First create an instantiated hygiene module
  infile := Scrubs_Death_Master_SSA.In_Death_Master_SSA;
  h := Scrubs_Death_Master_SSA.Hygiene(infile);
  p := h.AllProfiles; // Detailed profile of every field
  OUTPUT(h.Summary('SummaryReport'),ALL);
  OUTPUT(h.SourceCounts,ALL,NAMED('SourceCounts'));
  OUTPUT(h.CrossLinkingPotential,ALL,NAMED('CrossLinkingPotential'));
  OUTPUT(h.invSummary,NAMED('InvertedSummary'),ALL);
  OUTPUT(p,NAMED('AllProfiles'),ALL); // Detailed profile of every field
  OUTPUT(h.Correlations,NAMED('Correlations'),ALL); // Which fields are related to which other fields
  OUTPUT(h.ValidityErrors,NAMED('ValidityErrors'),ALL); // Violations of FieldType statements
  OUTPUT(SALT30.MAC_Character_Counts.EclRecord(p,'Layout_Death_Master_SSA'),NAMED('OptimizedLayout'));// File layout suggested by data
  // Produces field types that match the most common 99.9% of your data. Change to 100 to match all your data
  OUTPUT(SALT30.MAC_Character_Counts.FieldTypes(p,99.9),NAMED('Types'));
  // ****** Cross Tabs *******
  // It is possible to create a cross table between any two fields, see documentation on SALT30.MAC_CrossTab
  // These commented out lines will create crosstabs from the sourcefield to each individual field
  // IF you find yourself using ALL of these a LOT - let me know, I can make the 'all' case faster
   Examples := 10;
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,filedate,Examples),NAMED('filedateByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,rec_type,Examples),NAMED('rec_typeByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,rec_type_orig,Examples),NAMED('rec_type_origByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,ssn,Examples),NAMED('ssnByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,lname,Examples),NAMED('lnameByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,name_suffix,Examples),NAMED('name_suffixByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,fname,Examples),NAMED('fnameByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,mname,Examples),NAMED('mnameByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,vorp_code,Examples),NAMED('vorp_codeByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,dod8,Examples),NAMED('dod8Byrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,dob8,Examples),NAMED('dob8Byrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,st_country_code,Examples),NAMED('st_country_codeByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,zip_lastres,Examples),NAMED('zip_lastresByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,zip_lastpayment,Examples),NAMED('zip_lastpaymentByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,state,Examples),NAMED('stateByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,fipscounty,Examples),NAMED('fipscountyByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,clean_title,Examples),NAMED('clean_titleByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,clean_fname,Examples),NAMED('clean_fnameByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,clean_mname,Examples),NAMED('clean_mnameByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,clean_lname,Examples),NAMED('clean_lnameByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,clean_name_suffix,Examples),NAMED('clean_name_suffixByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,clean_name_score,Examples),NAMED('clean_name_scoreByrec_type'));
  //  OUTPUT(SALT30.MAC_CrossTab(infile,rec_type,crlf,Examples),NAMED('crlfByrec_type'));
