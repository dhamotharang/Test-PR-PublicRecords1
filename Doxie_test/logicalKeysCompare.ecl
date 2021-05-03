// program that compares the 2 logical files 

/* 
1. Create a version of the key using the current ThorProd code ----- suppressionFalseTestFileGenerator.ecl
-- this is the logical file name for the key thor_data400::key::header_lookups_v2_ (this was found in Doxie/Key_Did_Lookups_v2.ecl

2. Use the code after you apply your changes ----- suppressionTrueTestFileGenerator.ecl

3. Take the 2 logical key files (the files created by suppression true and false) and run a few comparisons: 
record count (count_of_total_records) 
difference between 2 record counts (count_diff_suppressed_not_suppressed)
counts of identical rows (count_identical_records) -- (join and counts)

4. From the records that have a difference - summarize the difference in a way that make sense. 
Maybe how many records had a total drop of 1-10 records, 10-50, 50+ for the 2 sources with input file change
this can be seen in the following output(s):
summary_expected_differences_between_suppressed_and_not_suppressed -- shows the number of records that had a total drop between each threshold 
NOTE- ALL THE ADDS SHOULD BE ZERO BECAUSE SUPPRESSION SHOULD NEVER ADD RECORDS 
NOTE- I ALSO ADDED PROF_COUNT TO THIS ANALYSIS- BUT IT SHOWS NO DIFFERENCE 

5. Also, a sanity check that none other counts changed. If you run the test close to each other - that should isolate any differences to your code change. 
output(s):
--- number_of_records_with_differences_not_zero 
-- this shows that there are no chnages in any of the other counts 
only head_cnt and bus_count 
*/

keyRecord := RECORD
  unsigned6 did;
end;

otherFieldsRec := RECORD
  unsigned2 sex_cnt;
  unsigned2 crim_cnt;
  unsigned2 ccw_cnt;
  unsigned2 head_cnt;
  unsigned2 veh_cnt;
  unsigned2 dl_cnt;
  unsigned2 rel_count;
  unsigned2 fire_count;
  unsigned2 faa_count;
  unsigned2 vess_count;
  unsigned2 prof_count;
  unsigned2 bus_count;
  unsigned2 prop_count;
  unsigned2 bk_count;
  unsigned2 prop_asses_count;
  unsigned2 prop_deeds_count;
  unsigned2 paw_count;
  unsigned2 bc_count;
  unsigned2 prov_count;
  unsigned2 sanc_count;
  unsigned6 hhid;
  string1 gender;
  unsigned2 house_size;
  unsigned2 sg_within_7;
  unsigned2 dg_within_7;
  unsigned2 ug_within_7;
  unsigned2 sg_y_8_15;
  unsigned2 dg_y_8_15;
  unsigned2 ug_y_8_15;
  unsigned2 sg_y_16_30;
  unsigned2 dg_y_16_30;
  unsigned2 ug_y_16_30;
  unsigned2 sg_o_8_15;
  unsigned2 dg_o_8_15;
  unsigned2 ug_o_8_15;
  unsigned2 sg_o_16_30;
  unsigned2 dg_o_16_30;
  unsigned2 ug_o_16_30;
  unsigned2 sg_o_30;
  unsigned2 dg_o_30;
  unsigned2 ug_o_30;
  unsigned2 sg_y_30;
  unsigned2 dg_y_30;
  unsigned2 ug_y_30;
  unsigned2 sg;
  unsigned2 dg;
  unsigned2 ug;
  unsigned2 kids;
  unsigned2 parents;
  unsigned2 corp_affil_count;
  unsigned2 comp_prop_count;
  unsigned2 phonesplus_count;
  unsigned2 nonfares_prop_count;
  unsigned2 nofares_prop_asses_count;
  unsigned2 nofares_prop_deeds_count;
  unsigned2 filler5_count;
  unsigned2 filler6_count;
  unsigned2 filler7_count;
  unsigned2 filler8_count;
  unsigned2 filler9_count;
  unsigned2 filler10_count;
 END;


// false suppression -- step 2
falseSuppression := index(keyRecord, otherFieldsRec,'~thor_data400::key::header::20200716_suppression_test_false::lookups_v2');
output(choosen(falseSuppression, 1000), named('false_sample'));

// true suppression 
trueSuppression := index(keyRecord, otherFieldsRec,'~thor_data400::key::header::20200716_suppression_test_true::lookups_v2');
output(choosen(trueSuppression, 1000), named('true_sample'));

// step 3

// counts records where suppression does not occur
countFalseRecords := count(falseSuppression);


// counts records where suppression does occur
countTrueRecords := count(trueSuppression);

// outputs the counts 
output('num of not suppressed records is:' + countFalseRecords + ', num of suppressed records is:' + countTrueRecords, named('count_of_total_records'));
output('the difference between suppressed and not suppressed is:' + abs(countFalseRecords - countTrueRecords), named('count_diff_suppressed_not_suppressed'));


joinedDatasets := join(falseSuppression, trueSuppression, 
  left.did = right.did and 
  left.sex_cnt = right.sex_cnt and
  left.crim_cnt = right.crim_cnt and
  left.ccw_cnt = right.ccw_cnt and
  left.head_cnt = right.head_cnt and
  left.veh_cnt = right.veh_cnt and
  left.dl_cnt = right.dl_cnt and
  left.rel_count = right.rel_count and
  left.fire_count = right.fire_count and
  left.faa_count = right.faa_count and
  left.vess_count = right.vess_count and
  left.prof_count = right.prof_count and
  left.bus_count = right.bus_count and
  left.prop_count = right.prop_count and
  left.bk_count = right.bk_count and
  left.prop_asses_count = right.prop_asses_count and
  left.prop_deeds_count = right.prop_deeds_count and
  left.paw_count = right.paw_count and
  left.bc_count = right.bc_count and
  left.prov_count = right.prov_count and
  left.sanc_count = right.sanc_count and
  left.hhid = right.hhid and
  left.gender = right.gender and
  left.house_size = right.house_size and
  left.sg_within_7 = right.sg_within_7 and
  left.dg_within_7 = right.dg_within_7 and
  left.ug_within_7 = right.ug_within_7 and
  left.sg_y_8_15 = right.sg_y_8_15 and
  left.dg_y_8_15 = right.dg_y_8_15 and
  left.ug_y_8_15 = right.ug_y_8_15 and
  left.sg_y_16_30 = right.sg_y_16_30 and
  left.dg_y_16_30 = right.dg_y_16_30 and
  left.ug_y_16_30 = right.ug_y_16_30 and
  left.sg_o_8_15 = right.sg_o_8_15 and
  left.dg_o_8_15 = right.dg_o_8_15 and
  left.ug_o_8_15 = right.ug_o_8_15 and
  left.sg_o_16_30 = right.sg_o_16_30 and
  left.dg_o_16_30 = right.dg_o_16_30 and
  left.ug_o_16_30 = right.ug_o_16_30 and
  left.sg_o_30 = right.sg_o_30 and
  left.dg_o_30 = right.dg_o_30 and
  left.ug_o_30 = right.ug_o_30 and
  left.sg_y_30 = right.sg_y_30 and
  left.dg_y_30 = right.dg_y_30 and
  left.ug_y_30 = right.ug_y_30 and
  left.sg = right.sg and
  left.dg = right.dg and
  left.ug = right.ug and
  left.kids = right.kids and
  left.parents = right.parents and
  left.corp_affil_count = right.corp_affil_count and
  left.comp_prop_count = right.comp_prop_count and
  left.phonesplus_count = right.phonesplus_count and
  left.nonfares_prop_count = right.nonfares_prop_count and
  left.nofares_prop_asses_count = right.nofares_prop_asses_count and
  left.nofares_prop_deeds_count = right.nofares_prop_deeds_count and
  left.filler5_count = right.filler5_count and
  left.filler6_count = right.filler6_count and
  left.filler7_count = right.filler7_count and
  left.filler8_count = right.filler8_count and
  left.filler9_count = right.filler9_count and
  left.filler10_count = right.filler10_count
);

output(choosen(joinedDatasets, 1000), named('joined'));
output(count(joinedDatasets), named('count_identical_records'));


/// Analyze differences

// This record literally just combines the index and other fields records together, for use
// in the transform function below.
combinedRecord := RECORD
  keyRecord;
  otherFieldsRec;
END;

// This record combines the index and the other fields into one big record, for use
// in the transform function below, and it converts most fields into integers to allow for
// negative values from the subtraction in the transform function
resultRecord := RECORD
  unsigned6 did;
  integer sex_cnt;
  integer crim_cnt;
  integer ccw_cnt;
  integer head_cnt;
  integer veh_cnt;
  integer dl_cnt;
  integer rel_count;
  integer fire_count;
  integer faa_count;
  integer vess_count;
  integer prof_count;
  integer bus_count;
  integer prop_count;
  integer bk_count;
  integer prop_asses_count;
  integer prop_deeds_count;
  integer paw_count;
  integer bc_count;
  integer prov_count;
  integer sanc_count;
  integer hhid;
  string1 gender;
  integer house_size;
  integer sg_within_7;
  integer dg_within_7;
  integer ug_within_7;
  integer sg_y_8_15;
  integer dg_y_8_15;
  integer ug_y_8_15;
  integer sg_y_16_30;
  integer dg_y_16_30;
  integer ug_y_16_30;
  integer sg_o_8_15;
  integer dg_o_8_15;
  integer ug_o_8_15;
  integer sg_o_16_30;
  integer dg_o_16_30;
  integer ug_o_16_30;
  integer sg_o_30;
  integer dg_o_30;
  integer ug_o_30;
  integer sg_y_30;
  integer dg_y_30;
  integer ug_y_30;
  integer sg;
  integer dg;
  integer ug;
  integer kids;
  integer parents;
  integer corp_affil_count;
  integer comp_prop_count;
  integer phonesplus_count;
  integer nonfares_prop_count;
  integer nofares_prop_asses_count;
  integer nofares_prop_deeds_count;
  integer filler5_count;
  integer filler6_count;
  integer filler7_count;
  integer filler8_count;
  integer filler9_count;
  integer filler10_count;
END;

// Transform function to calculate the difference in all counts
resultRecord differenceJoinFunction(combinedRecord L, combinedRecord R) := TRANSFORM
  // These two are kept the same
  SELF.did := L.did;
  SELF.gender := L.gender;
  // The remainder fields are equal to the differences in value (falseSuppression - trueSuppression)
  SELF.sex_cnt := L.sex_cnt - R.sex_cnt;
  SELF.crim_cnt := L.crim_cnt - R.crim_cnt;
  SELF.ccw_cnt := L.ccw_cnt - R.ccw_cnt;
  SELF.head_cnt := L.head_cnt - R.head_cnt;
  SELF.veh_cnt := L.veh_cnt - R.veh_cnt;
  SELF.dl_cnt := L.dl_cnt - R.dl_cnt;
  SELF.rel_count := L.rel_count - R.rel_count;
  SELF.fire_count := L.fire_count - R.fire_count;
  SELF.faa_count := L.faa_count - R.faa_count;
  SELF.vess_count := L.vess_count - R.vess_count;
  SELF.prof_count := L.prof_count - R.prof_count;
  SELF.bus_count := L.bus_count - R.bus_count;
  SELF.prop_count := L.prop_count - R.prop_count;
  SELF.bk_count := L.bk_count - R.bk_count;
  SELF.prop_asses_count := L.prop_asses_count - R.prop_asses_count;
  SELF.prop_deeds_count := L.prop_deeds_count - R.prop_deeds_count;
  SELF.paw_count := L.paw_count - R.paw_count;
  SELF.bc_count := L.bc_count - R.bc_count;
  SELF.prov_count := L.prov_count - R.prov_count;
  SELF.sanc_count := L.sanc_count - R.sanc_count;
  SELF.hhid := L.hhid - R.hhid;
  SELF.house_size := L.house_size - R.house_size;
  SELF.sg_within_7 := L.sg_within_7 - R.sg_within_7;
  SELF.dg_within_7 := L.dg_within_7 - R.dg_within_7;
  SELF.ug_within_7 := L.ug_within_7 - R.ug_within_7;
  SELF.sg_y_8_15 := L.sg_y_8_15 - R.sg_y_8_15;
  SELF.dg_y_8_15 := L.dg_y_8_15 - R.dg_y_8_15;
  SELF.ug_y_8_15 := L.ug_y_8_15 - R.ug_y_8_15;
  SELF.sg_y_16_30 := L.sg_y_16_30 - R.sg_y_16_30;
  SELF.dg_y_16_30 := L.dg_y_16_30 - R.dg_y_16_30;
  SELF.ug_y_16_30 := L.ug_y_16_30 - R.ug_y_16_30;
  SELF.sg_o_8_15 := L.sg_o_8_15 - R.sg_o_8_15;
  SELF.dg_o_8_15 := L.dg_o_8_15 - R.dg_o_8_15;
  SELF.ug_o_8_15 := L.ug_o_8_15 - R.ug_o_8_15;
  SELF.sg_o_16_30 := L.sg_o_16_30 - R.sg_o_16_30;
  SELF.dg_o_16_30 := L.dg_o_16_30 - R.dg_o_16_30;
  SELF.ug_o_16_30 := L.ug_o_16_30 - R.ug_o_16_30;
  SELF.sg_o_30 := L.sg_o_30 - R.sg_o_30;
  SELF.dg_o_30 := L.dg_o_30 - R.dg_o_30;
  SELF.ug_o_30 := L.ug_o_30 - R.ug_o_30;
  SELF.sg_y_30 := L.sg_y_30 - R.sg_y_30;
  SELF.dg_y_30 := L.dg_y_30 - R.dg_y_30;
  SELF.ug_y_30 := L.ug_y_30 - R.ug_y_30;
  SELF.sg := L.sg - R.sg;
  SELF.dg := L.dg - R.dg;
  SELF.ug := L.ug - R.ug;
  SELF.kids := L.kids - R.kids;
  SELF.parents := L.parents - R.parents;
  SELF.corp_affil_count := L.corp_affil_count - R.corp_affil_count;
  SELF.comp_prop_count := L.comp_prop_count - R.comp_prop_count;
  SELF.phonesplus_count := L.phonesplus_count - R.phonesplus_count;
  SELF.nonfares_prop_count := L.nonfares_prop_count - R.nonfares_prop_count;
  SELF.nofares_prop_asses_count := L.nofares_prop_asses_count - R.nofares_prop_asses_count;
  SELF.nofares_prop_deeds_count := L.nofares_prop_deeds_count - R.nofares_prop_deeds_count;
  SELF.filler5_count := L.filler5_count - R.filler5_count;
  SELF.filler6_count := L.filler6_count - R.filler6_count;
  SELF.filler7_count := L.filler7_count - R.filler7_count;
  SELF.filler8_count := L.filler8_count - R.filler8_count;
  SELF.filler9_count := L.filler9_count - R.filler9_count;
  SELF.filler10_count := L.filler10_count - R.filler10_count;
END;

// find all records that have matching did's but one or more of their counts
// do not match. For those records, calculate the difference in all counts.
joinedDifferenceDatasets := join(falseSuppression, trueSuppression, 
  left.did = right.did and 
  not (
    left.sex_cnt = right.sex_cnt and
    left.crim_cnt = right.crim_cnt and
    left.ccw_cnt = right.ccw_cnt and
    left.head_cnt = right.head_cnt and
    left.veh_cnt = right.veh_cnt and
    left.dl_cnt = right.dl_cnt and
    left.rel_count = right.rel_count and
    left.fire_count = right.fire_count and
    left.faa_count = right.faa_count and
    left.vess_count = right.vess_count and
    left.prof_count = right.prof_count and
    left.bus_count = right.bus_count and
    left.prop_count = right.prop_count and
    left.bk_count = right.bk_count and
    left.prop_asses_count = right.prop_asses_count and
    left.prop_deeds_count = right.prop_deeds_count and
    left.paw_count = right.paw_count and
    left.bc_count = right.bc_count and
    left.prov_count = right.prov_count and
    left.sanc_count = right.sanc_count and
    left.hhid = right.hhid and
    left.gender = right.gender and
    left.house_size = right.house_size and
    left.sg_within_7 = right.sg_within_7 and
    left.dg_within_7 = right.dg_within_7 and
    left.ug_within_7 = right.ug_within_7 and
    left.sg_y_8_15 = right.sg_y_8_15 and
    left.dg_y_8_15 = right.dg_y_8_15 and
    left.ug_y_8_15 = right.ug_y_8_15 and
    left.sg_y_16_30 = right.sg_y_16_30 and
    left.dg_y_16_30 = right.dg_y_16_30 and
    left.ug_y_16_30 = right.ug_y_16_30 and
    left.sg_o_8_15 = right.sg_o_8_15 and
    left.dg_o_8_15 = right.dg_o_8_15 and
    left.ug_o_8_15 = right.ug_o_8_15 and
    left.sg_o_16_30 = right.sg_o_16_30 and
    left.dg_o_16_30 = right.dg_o_16_30 and
    left.ug_o_16_30 = right.ug_o_16_30 and
    left.sg_o_30 = right.sg_o_30 and
    left.dg_o_30 = right.dg_o_30 and
    left.ug_o_30 = right.ug_o_30 and
    left.sg_y_30 = right.sg_y_30 and
    left.dg_y_30 = right.dg_y_30 and
    left.ug_y_30 = right.ug_y_30 and
    left.sg = right.sg and
    left.dg = right.dg and
    left.ug = right.ug and
    left.kids = right.kids and
    left.parents = right.parents and
    left.corp_affil_count = right.corp_affil_count and
    left.comp_prop_count = right.comp_prop_count and
    left.phonesplus_count = right.phonesplus_count and
    left.nonfares_prop_count = right.nonfares_prop_count and
    left.nofares_prop_asses_count = right.nofares_prop_asses_count and
    left.nofares_prop_deeds_count = right.nofares_prop_deeds_count and
    left.filler5_count = right.filler5_count and
    left.filler6_count = right.filler6_count and
    left.filler7_count = right.filler7_count and
    left.filler8_count = right.filler8_count and
    left.filler9_count = right.filler9_count and
    left.filler10_count = right.filler10_count
  ),
  differenceJoinFunction(LEFT, RIGHT)
);

// summary results
// Maybe how many records had a total drop of 1-10 records, 10-50, 50+ for the 2 sources with input file change. 

differenceSummaryResultsRecord := RECORD
  // business header- business contacts
  unsigned drop1to10_bus_count;
  unsigned drop10to50_bus_count;
  unsigned drop51plus_bus_count;
  unsigned add_bus_count;

  // person header
  unsigned drop1to10_head_cnt;
  unsigned drop10to50_head_cnt;
  unsigned drop51plus_head_cnt;
  unsigned add_head_cnt;

  // professional licenses 
  unsigned drop1to10_prof_count;
  unsigned drop10to50_prof_count;
  unsigned drop51plus_prof_count;
  unsigned add_prof_count;

  // paw 
  unsigned drop1to10_paw_count;
  unsigned drop10to50_paw_count;
  unsigned drop51plus_paw_count;
  unsigned add_paw_count;

    // vehicles
  unsigned drop1to10_veh_cnt;
  unsigned drop10to50_veh_cnt;
  unsigned drop51plus_veh_cnt;
  unsigned add_veh_cnt;
END;

differenceSummaryResultsDataset := DATASET(
  [
    {
      // bus_count
      //a drop would be a positive number since count in falseSuppression > count in trueSuppression)
      count(joinedDifferenceDatasets(bus_count > 0 and bus_count < 11)),
      count(joinedDifferenceDatasets(bus_count > 10 and bus_count < 51)),
      count(joinedDifferenceDatasets(bus_count > 50)),
      // count the number that were added as a sanity check. should be zero
      count(joinedDifferenceDatasets(bus_count < 0)),

      // same set of things for head_cnt
      count(joinedDifferenceDatasets(head_cnt > 0 and head_cnt < 11)),
      count(joinedDifferenceDatasets(head_cnt > 10 and head_cnt < 51)),
      count(joinedDifferenceDatasets(head_cnt > 50)),
      count(joinedDifferenceDatasets(head_cnt < 0)),

      // same set of things for prof_count
      count(joinedDifferenceDatasets(prof_count > 0 and prof_count < 11)),
      count(joinedDifferenceDatasets(prof_count > 10 and prof_count < 51)),
      count(joinedDifferenceDatasets(prof_count > 50)),
      count(joinedDifferenceDatasets(prof_count < 0)),

         // same set of things for paw_count
      count(joinedDifferenceDatasets(paw_count > 0 and paw_count < 11)),
      count(joinedDifferenceDatasets(paw_count > 10 and paw_count < 51)),
      count(joinedDifferenceDatasets(paw_count > 50)),
      count(joinedDifferenceDatasets(paw_count < 0)),

         // same set of things for veh_cnt
      count(joinedDifferenceDatasets(veh_cnt > 0 and veh_cnt < 11)),
      count(joinedDifferenceDatasets(veh_cnt > 10 and veh_cnt < 51)),
      count(joinedDifferenceDatasets(veh_cnt > 50)),
      count(joinedDifferenceDatasets(veh_cnt < 0))
    }
  ],
  differenceSummaryResultsRecord
);

output(differenceSummaryResultsDataset, named('summary_expected_differences_between_suppressed_and_not_suppressed'));

// 5. Also, a sanity check that none other counts changed. If you run the test close to each other - that should isolate any differences to your code change.

// Record that holds counts for each of the count fields
numWithDifferencesRecord := RECORD
    unsigned sex_cnt;
    unsigned crim_cnt;
    unsigned ccw_cnt;
    unsigned head_cnt;
    unsigned veh_cnt;
    unsigned dl_cnt;
    unsigned rel_count;
    unsigned fire_count;
    unsigned faa_count;
    unsigned vess_count;
    unsigned prof_count;
    unsigned bus_count;
    unsigned prop_count;
    unsigned bk_count;
    unsigned prop_asses_count;
    unsigned prop_deeds_count;
    unsigned paw_count;
    unsigned bc_count;
    unsigned prov_count;
    unsigned sanc_count;
    unsigned hhid;
    unsigned house_size;
    unsigned sg_within_7;
    unsigned dg_within_7;
    unsigned ug_within_7;
    unsigned sg_y_8_15;
    unsigned dg_y_8_15;
    unsigned ug_y_8_15;
    unsigned sg_y_16_30;
    unsigned dg_y_16_30;
    unsigned ug_y_16_30;
    unsigned sg_o_8_15;
    unsigned dg_o_8_15;
    unsigned ug_o_8_15;
    unsigned sg_o_16_30;
    unsigned dg_o_16_30;
    unsigned ug_o_16_30;
    unsigned sg_o_30;
    unsigned dg_o_30;
    unsigned ug_o_30;
    unsigned sg_y_30;
    unsigned dg_y_30;
    unsigned ug_y_30;
    unsigned sg;
    unsigned dg;
    unsigned ug;
    unsigned kids;
    unsigned parents;
    unsigned corp_affil_count;
    unsigned comp_prop_count;
    unsigned phonesplus_count;
    unsigned nonfares_prop_count;
    unsigned nofares_prop_asses_count;
    unsigned nofares_prop_deeds_count;
    unsigned filler5_count;
    unsigned filler6_count;
    unsigned filler7_count;
    unsigned filler8_count;
    unsigned filler9_count;
    unsigned filler10_count;
END;

// Compute the number of records with non-zero differences for each count field
numWithDifferences := DATASET(
  [
    {
      count(joinedDifferenceDatasets(sex_cnt != 0)),
      count(joinedDifferenceDatasets(crim_cnt != 0)),
      count(joinedDifferenceDatasets(ccw_cnt != 0)),
      count(joinedDifferenceDatasets(head_cnt != 0)),
      count(joinedDifferenceDatasets(veh_cnt != 0)),
      count(joinedDifferenceDatasets(dl_cnt != 0)),
      count(joinedDifferenceDatasets(rel_count != 0)),
      count(joinedDifferenceDatasets(fire_count != 0)),
      count(joinedDifferenceDatasets(faa_count != 0)),
      count(joinedDifferenceDatasets(vess_count != 0)),
      count(joinedDifferenceDatasets(prof_count != 0)),
      count(joinedDifferenceDatasets(bus_count != 0)),
      count(joinedDifferenceDatasets(prop_count != 0)),
      count(joinedDifferenceDatasets(bk_count != 0)),
      count(joinedDifferenceDatasets(prop_asses_count != 0)),
      count(joinedDifferenceDatasets(prop_deeds_count != 0)),
      count(joinedDifferenceDatasets(paw_count != 0)),
      count(joinedDifferenceDatasets(bc_count != 0)),
      count(joinedDifferenceDatasets(prov_count != 0)),
      count(joinedDifferenceDatasets(sanc_count != 0)),
      count(joinedDifferenceDatasets(hhid != 0)),
      count(joinedDifferenceDatasets(house_size != 0)),
      count(joinedDifferenceDatasets(sg_within_7 != 0)),
      count(joinedDifferenceDatasets(dg_within_7 != 0)),
      count(joinedDifferenceDatasets(ug_within_7 != 0)),
      count(joinedDifferenceDatasets(sg_y_8_15 != 0)),
      count(joinedDifferenceDatasets(dg_y_8_15 != 0)),
      count(joinedDifferenceDatasets(ug_y_8_15 != 0)),
      count(joinedDifferenceDatasets(sg_y_16_30 != 0)),
      count(joinedDifferenceDatasets(dg_y_16_30 != 0)),
      count(joinedDifferenceDatasets(ug_y_16_30 != 0)),
      count(joinedDifferenceDatasets(sg_o_8_15 != 0)),
      count(joinedDifferenceDatasets(dg_o_8_15 != 0)),
      count(joinedDifferenceDatasets(ug_o_8_15 != 0)),
      count(joinedDifferenceDatasets(sg_o_16_30 != 0)),
      count(joinedDifferenceDatasets(dg_o_16_30 != 0)),
      count(joinedDifferenceDatasets(ug_o_16_30 != 0)),
      count(joinedDifferenceDatasets(sg_o_30 != 0)),
      count(joinedDifferenceDatasets(dg_o_30 != 0)),
      count(joinedDifferenceDatasets(ug_o_30 != 0)),
      count(joinedDifferenceDatasets(sg_y_30 != 0)),
      count(joinedDifferenceDatasets(dg_y_30 != 0)),
      count(joinedDifferenceDatasets(ug_y_30 != 0)),
      count(joinedDifferenceDatasets(sg != 0)),
      count(joinedDifferenceDatasets(dg != 0)),
      count(joinedDifferenceDatasets(ug != 0)),
      count(joinedDifferenceDatasets(kids != 0)),
      count(joinedDifferenceDatasets(parents != 0)),
      count(joinedDifferenceDatasets(corp_affil_count != 0)),
      count(joinedDifferenceDatasets(comp_prop_count != 0)),
      count(joinedDifferenceDatasets(phonesplus_count != 0)),
      count(joinedDifferenceDatasets(nonfares_prop_count != 0)),
      count(joinedDifferenceDatasets(nofares_prop_asses_count != 0)),
      count(joinedDifferenceDatasets(nofares_prop_deeds_count != 0)),
      count(joinedDifferenceDatasets(filler5_count != 0)),
      count(joinedDifferenceDatasets(filler6_count != 0)),
      count(joinedDifferenceDatasets(filler7_count != 0)),
      count(joinedDifferenceDatasets(filler8_count != 0)),
      count(joinedDifferenceDatasets(filler9_count != 0)),
      count(joinedDifferenceDatasets(filler10_count != 0)),
    }
  ], 
  numWithDifferencesRecord
);

output(numWithDifferences, named('number_of_records_with_differences_not_zero'));