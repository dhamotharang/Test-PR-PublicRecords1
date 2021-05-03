/*
  test ingest of limited set of sources to isolate problems 
  might need to sandbox the as linking mappers to comment out the #OPTION('multiplePersistInstances',FALSE);
  if you want to separate your persist names from any production processes, i.e. you want to make them unique.
*/

#workunit('name','Test ingests');
#OPTION('multiplePersistInstances',true);

// -- populate this with the as linking mappers of the sources that you are testing(you can the list from here: BIPV2.Business_Sources)
// -- this example is testing commercial clue, experian CRDB, FDIC and watercraft
ds_aslinkings := 
    CClue.As_Business_Linking()
  + Experian_CRDB.As_Business_Linking()
  + Govdata.FDIC_As_Business_Linking()
  + Watercraft.Watercraft_as_Business_Linking
  ;

// -- This should be the set of sources to test.  The base file and the ingest file are filtered for only these sources.
set_sources := [mdr.sourcetools.src_Cclue,mdr.sourcetools.src_Experian_CRDB,MDR.sourceTools.src_FDIC] + MDR.sourceTools.set_WC;

ds_bip_base := bipv2.commonbase.ds_built;

// -- Run the test ingest
BIPV2_Ingest._Test_Ingest(
   ds_aslinkings   //as linking mapper(s) for sources you are testing
  ,set_sources     //set of source codes for sources you are testing.
  ,ds_bip_base
  ,pShould_Reclean_base_file  := true //can speed it up by setting to false
  ,pShould_Xlink_file         := true //can speed it up by setting to false
);