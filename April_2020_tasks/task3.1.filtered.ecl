// TASK 3
//////////////////////////////////////////////////////////////
/*
This block of code is importing the key files into my program. They represent the data
I am going to analyze. 
*/

import dx_header;
import data_services; 

// s_did is the index 
kv_index_Rec := RECORD
  unsigned6 s_did;
  end;

// record including all the other non-index fields
kv_otherFields_rec := record
  unsigned6 did;
  unsigned6 rid;
  string1 pflag1;
  string1 pflag2;
  string1 pflag3;
  string2 src;
  unsigned3 dt_first_seen;
  unsigned3 dt_last_seen;
  unsigned3 dt_vendor_last_reported;
  unsigned3 dt_vendor_first_reported;
  unsigned3 dt_nonglb_last_seen;
  string1 rec_type;
  qstring18 vendor_id;
  qstring10 phone;
  qstring9 ssn;
  integer4 dob;
  qstring5 title;
  qstring20 fname;
  qstring20 mname;
  qstring20 lname;
  qstring5 name_suffix;
  qstring10 prim_range;
  string2 predir;
  qstring28 prim_name;
  qstring4 suffix;
  string2 postdir;
  qstring10 unit_desig;
  qstring8 sec_range;
  qstring25 city_name;
  string2 st;
  qstring5 zip;
  qstring4 zip4;
  string3 county;
  qstring7 geo_blk;
  qstring5 cbsa;
  string1 tnt;
  string1 valid_ssn;
  string1 jflag1;
  string1 jflag2;
  string1 jflag3;
  unsigned8 rawaid;
  unsigned8 persistent_record_id;
  unsigned4 global_sid;
  unsigned8 record_sid;
  string1 valid_dob;
  unsigned6 hhid;
  string18 county_name;
  string120 listed_name;
  string10 listed_phone;
  unsigned4 dod;
  string1 death_code;
  unsigned4 lookup_did;
 END;
 

/*
These are the two most updated version of the ingest keys. kv2 has rid (index) and first 
ingest date as fields while kv3 has rid only and a bunch of other fields. I use kv2 and
kv3 as variables to hold the keys I want to analyze and pull is used as an optimization step.
*/

kv2:=pull(INDEX(dx_header.key_first_ingest(),data_services.foreign_prod+'thor_data400::key::header::20200320::first_ingest_date'));

kv3 := pull(index(kv_index_Rec, kv_otherFields_rec, data_services.foreign_prod+'thor_data400::key::header::20200223::data'));

// two versions of kv4 to switch between the two key files
// kv4 := pull(index(kv_index_Rec, kv_otherFields_rec, data_services.foreign_prod+'thor_data400::key::header::20200119::data'));
kv4 := pull(index(kv_index_Rec, kv_otherFields_rec, data_services.foreign_prod+'thor_data400::key::header::20190324::data'));

// There was a skew error, so I distributed on the field in common (rid) using HASH
distributeKv2 := distribute(kv2, HASH32(rid));
distributeKv3 := distribute(kv3, HASH32(rid));
distributeKv4 := distribute(kv4, HASH32(rid));
///////////////////////////////////////////////////
//////////////////////////////////////////////////

/*
Joins the left and right keys, kv2 + kv3 AND kv2 + kv4 together in an inner join, in order
 to get the first_ingest_date for the records in kv3 and kv4. I also filter out the sources
 we are not interested in for each of the recordset joins. I output a count of keys with newer
ingested key and older ingested key, and also a sample output of the keys. To clarify,
older and newer ingested key simply means that one of the dates ingested is slightly different.
*/

// joins 2 keys to get the first ingest dates from kv2
// -- kv3 has newer ingested data than kv4
unfilterednewerIngestData := JOIN(distributeKv2, distributeKv3, left.rid = right.rid);

// filters out sources 'TS' and 'TN' for newer ingested keys
newerIngestData := unfilterednewerIngestData(src != 'TS' and src != 'TN');

// provides a count for the newerIngestData and prints out a sample of the newerIngestData recordset 
count_of_NewerIngestData := count(newerIngestData);
output(count_of_newerIngestData, named('count_of_newerIngestData'));
output(choosen(newerIngestData, 100), named('sample_of_newerIngestData'));

// joins 2 keys to get the first ingest dates
// -- kv4 has older ingest dates than kv3
unfilteredolderIngestData := JOIN(distributeKv2, distributeKv4, left.rid = right.rid);

// filters out sources 'TS' and 'TN' for older ingest keys
olderIngestData := unfilteredolderIngestData(src != 'TS' and src != 'TN');

// provides a count for the olderIngestData and prints out a sample of the olderIngestData recordset 
count_of_olderIngestData := count(olderIngestData);
output(count_of_olderIngestData, named('count_of_olderIngestData'));
output(choosen(olderIngestData, 100), named('sample_of_olderIngestData'));


//////////////////////////////////////////////////
//////////////////////////////////////////////////

/*
Generates a table for each of the two datasets that gives a record count per did, 
per source, per first_ingest_date 
*/

// newer ingest dates record - grouped by did, src, and first_ingest_date
newerIngest_per_DID_per_src_per_date_Rec := RECORD
  newerIngestData.did;
  newerIngestData.src;
  newerIngestData.first_ingest_date;
  integer newerRecordCount := count(group);
END;

// older ingest dates record - grouped by did, src, and first_ingest_date
olderIngest_per_DID_per_src_per_date_Rec := RECORD
  olderIngestData.did;
  olderIngestData.src;
  olderIngestData.first_ingest_date;
  integer olderRecordCount := count(group);
END;


// cross tab report with grouping to generate the count per did, src and first_ingest_date combo 
// which is grouped in the records above-- creates a new field that holds the count for the group
newerIngest_per_DID_per_src_per_date := table(newerIngestData, newerIngest_per_DID_per_src_per_date_Rec, did, src, first_ingest_date);
olderIngest_per_DID_per_src_per_date := table(olderIngestData, olderIngest_per_DID_per_src_per_date_Rec, did, src, first_ingest_date);


///////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

/*
Joins the key that has the newer ingested data to the key that has the older
ingested data. This is joined on did, src, and first_ingest_date. This is a full 
outer join, which combines the tables together. Full outer joins gives us all the
data from each of the keys, regardless if there are matches. 
*/

// joins the data from both keys newer and older keys together-- 
// necessary as an intermediate step to join on all three fields to identify matches for comparison
combinedPreComparison := join(newerIngest_per_DID_per_src_per_date, olderIngest_per_DID_per_src_per_date,
                      left.did = right.did
                      and left.src = right.src
                      and left.first_ingest_date = right.first_ingest_date,
                      full outer);

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

/*
Adds fields to the combined table above and takes previously existing fields.
The new fields are:
- diff_type = 'drop' if the newer keys group count > older keys group count,
    'add' if the newer keys group count < older keys group count
    else: 'same'
- diff_count = the absolute value of the difference between the two group counts.
- minimum_diffs := abs(combinedPreComparison.newerRecordCount - combinedPreComparison.olderRecordCount) + min(combinedPreComparison.newerRecordCount, combinedPreComparison.olderRecordCount);
     this is the logic, but can just use max as seen below:
*/

unfilteredComparedNewerAndOlder_Rec := RECORD
    combinedPreComparison.did;
    combinedPreComparison.src;
    combinedPreComparison.first_ingest_date;
    string diff_type := if(combinedPreComparison.newerRecordCount > combinedPreComparison.olderRecordCount, 'drop', 
        if(combinedPreComparison.newerRecordCount < combinedPreComparison.olderRecordCount, 'add', 'same'));
    integer diff_count := abs(combinedPreComparison.newerRecordCount - combinedPreComparison.olderRecordCount);
    integer minimum_diffs := max(combinedPreComparison.newerRecordCount, combinedPreComparison.olderRecordCount);
    
END;

// creates a vertical slice table from the above record, which adds all of the fields from the record into the table
unfilteredcomparedNewerAndOlder := table(combinedPreComparison, unfilteredComparedNewerAndOlder_Rec);

// filters where diff_count > 0 
unsortedcomparedNewerAndOlder := unfilteredcomparedNewerAndOlder(diff_count > 0);

// sorts the table on did and src in ascending order, and diff_type, diff_count in descending order
comparedNewerAndOlder := sort(unsortedcomparedNewerAndOlder, did, src, -diff_type, -diff_count, -minimum_diffs);

// outputs a sample containing the first 100 records in the table
output(choosen(comparedNewerAndOlder, 100), named('sample_of_comparedNewerAndOlder'));

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

/*
Table cross tab report that groups by diff_type, src, and did, and it counts
the number of records with that combo.
*/

numRecords_per_src_per_difftype_per_did_Rec := RECORD
    comparedNewerAndOlder.src;
    comparedNewerAndOlder.diff_type;
    comparedNewerAndOlder.did;
    integer recordCount := count(group);
END;

// cross tab table-- creates a field that contains the count of the group (src, diff_type, did)
numRecords_per_src_per_difftype_per_did := table(comparedNewerAndOlder, numRecords_per_src_per_difftype_per_did_Rec, src, diff_type, did);

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

// counts of number of DIDs per source with at least one first ingest count difference
preCount_of_DID_per_Src_Rec := RECORD
    comparedNewerAndOlder.src;
    comparedNewerAndOlder.did;
END;

// table that groups by src and did 
// the purpose is to remove any duplicate src and did combo rows, so we get an accurate count
preCount_of_DID_per_Src := table(comparedNewerAndOlder, preCount_of_DID_per_Src_Rec, src, did);

unsortedCount_of_DID_per_Src_Rec := RECORD
    preCount_of_DID_per_Src.src;
    integer count_of_DID_per_Src := count(group);
END;

// table that groups by source and gets the count for number of did per src
unsortedCount_of_DID_per_Src := table(preCount_of_DID_per_Src, unsortedCount_of_DID_per_Src_Rec, src);


// sorted from highest count to lowest count 
count_of_DID_per_Src := sort(unsortedCount_of_DID_per_Src, -count_of_DID_per_Src);

output(count_of_DID_per_Src, named('count_of_DID_per_Src'));


///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////

/*
This finds the sum of all the recordCount values for each src
It also sorts the sums in decreasing order and counts the number of rows per sum 
and outputs by decreasing order of sums (as recordCount)
*/

unsortedNumRecords_per_src_Rec := RECORD 
    numRecords_per_src_per_difftype_per_did.src;
    integer recordCount := sum(group, numRecords_per_src_per_difftype_per_did.recordCount); 
END;

unsortedNumRecords_per_src := table(numRecords_per_src_per_difftype_per_did, unsortedNumRecords_per_src_Rec, src);

// sort by recordCount in descending order then by src 
// NOTE: this used to be called count_of_date_diff_per_src
numRecords_per_src := sort(unsortedNumRecords_per_src, -recordCount, src); 


// counts per src, instances where diff_count>0 (this filter was done earlier)
output(numRecords_per_src, named('numRecords_per_src'));

// This compares, per src, the number of DID's versus the number of records
preCompareDIDtoRecordCount := JOIN(Count_of_DID_per_Src, numRecords_per_src, left.src = right.src);

unsortedCompare_DID_to_unsortedNumRecords_per_src_Rec := RECORD
    preCompareDIDtoRecordCount;
    integer differenceBetweenCounts := abs(preCompareDIDtoRecordCount.recordCount - preCompareDIDtoRecordCount.count_of_DID_per_Src);
END;

// vertical slice table in order to add a field that contains the difference between recordCount and count_of_DID_per_Src
unsortedCompare_DID_to_NumRecords_per_src := table(preCompareDIDtoRecordCount, unsortedCompare_DID_to_unsortedNumRecords_per_src_Rec);

// sorted the table by the difference in descending order and then the src 
Compare_DID_to_NumRecords_per_src := sort(unsortedCompare_DID_to_NumRecords_per_src, -differenceBetweenCounts, src);

output(Compare_DID_to_NumRecords_per_src, named('Compare_DID_to_NumRecords_per_src'));



///////////////////////////////////////////////////////////////////////////////////////////////////////
// Get a sample of all rows related to 2 did's per top 10 src (by number of differences)
////////////////////////////////////////////////////////////////////////////////////////////////////////

// table that sums diff_count per src
Diff_Count_Per_Src_Rec := RECORD
    comparedNewerAndOlder.src;
    integer diff_count := sum(group, comparedNewerAndOlder.diff_count);
END;

// cross tab table that groups by src to calculate the sum of diff_count per src
Diff_count_Per_Src := table(comparedNewerAndOlder, Diff_Count_Per_Src_Rec, src);

// gives the top 10 sources by count of differences in descending order
top_sources := SET(topn(Diff_count_Per_Src, 10, -diff_count), src);

// filter records to have only the top 10 sources
// only doing the next few steps for older ingest dates so results are comparable at the end
top10olderData := olderIngestData(src in top_sources);

// needed for the upcoming dedup
sortedOlderIngestData := sort(top10olderData, src, did);

// Gets rid of duplicate did rows
dedupedOlderIngestData := dedup(sortedOlderIngestData, src, did);

// Keeps 2 did's per src
// Called pre because I want to get rid of unnecessary fields in a later step
pre_two_DIDs_per_src := dedup(dedupedOlderIngestData, src, keep 2);

// Use table to simplify the rows into just did and src
two_DIDs_per_src_Rec := RECORD
    pre_two_DIDs_per_src.did;
    pre_two_DIDs_per_src.src;
END;

two_DIDs_per_src := table(pre_two_DIDs_per_src, two_DIDs_per_src_Rec);

// Get all the records from each dataset associated with these did's
// inner join on older and newer to just get the desired rows
unsorted_Two_DIDs_per_SRC_from_OlderIngestData := JOIN(olderIngestData, two_DIDs_per_src, LEFT.src = RIGHT.src and LEFT.did = RIGHT.did);
unsorted_Two_DIDs_per_SRC_from_NewerIngestData := JOIN(newerIngestData, two_DIDs_per_src, LEFT.src = RIGHT.src and LEFT.did = RIGHT.did);

// Sort them by src then did
two_DIDs_per_SRC_from_OlderIngestData := SORT(unsorted_Two_DIDs_per_SRC_from_OlderIngestData, src, did);
two_DIDs_per_SRC_from_NewerIngestData := SORT(unsorted_Two_DIDs_per_SRC_from_NewerIngestData, src, did);

// Output them
output(two_DIDs_per_SRC_from_OlderIngestData, named('two_DIDs_per_SRC_from_OlderIngestData'));
output(two_DIDs_per_SRC_from_NewerIngestData, named('two_DIDs_per_SRC_from_NewerIngestData'));

///////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////


/*
This finds the sum of all the recordCount values for BOTH src and did 
It also sorts the sums in decreasing order
*/

unsortedNumRecords_per_src_per_did_Rec := RECORD 
    numRecords_per_src_per_difftype_per_did.src;
    numRecords_per_src_per_difftype_per_did.did;
    integer recordCount := sum(group, numRecords_per_src_per_difftype_per_did.recordCount); 
END;

unsortedNumRecords_per_src_per_did := table(numRecords_per_src_per_difftype_per_did, unsortedNumRecords_per_src_per_did_Rec, src, did);

// sort by biggest count to smallest 
numRecords_per_src_per_did := sort(unsortedNumRecords_per_src_per_did, -recordCount, src, DID); 

output(numRecords_per_src_per_did, named('numRecords_per_src_per_did'));

/////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////

/*
This finds the total diff_count per did
Sorted by diff_count descending 
*/

unsortedDiff_count_per_did_Rec := RECORD
    comparedNewerAndOlder.did;
    integer diff_count := sum(group, comparedNewerAndOlder.diff_count);
END;

unsortedDiff_count_per_did := table(comparedNewerAndOlder, unsortedDiff_count_per_did_Rec, did);
diff_count_per_did := sort(unsortedDiff_count_per_did, -diff_count);
output(diff_count_per_did, named('diff_count_per_did'));


// counts per source of the DID, instances where diff_count>0 (this part is done earlier)

unsortedNumRecords_per_did_Rec := RECORD 
    numRecords_per_src_per_difftype_per_did.did;
    integer recordCount := sum(group, numRecords_per_src_per_difftype_per_did.recordCount); 
END;

unsortedNumRecords_per_did := table(numRecords_per_src_per_difftype_per_did, unsortedNumRecords_per_did_Rec, did);

// sort by biggest count to smallest 
numRecords_per_DID := sort(unsortedNumRecords_per_did, -recordCount, did); 

// NOTE: this used to be called count_of_date_diff_per_DID
output(numRecords_per_DID, named('numRecords_per_DID'));

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/*
This outputs the count of did's per minimum_diffs value
 */

// First get rid of duplicate did and minimum_diffs combos
// for example, if did of '1' has 2 records with minimum_diffs = 4, then that 
// should only be counted once-- need to dedup to get rid of the duplicate

// sort dataset by did, minimum_diffs
comparedNewerAndOlderForMinDiffs := sort(comparedNewerAndOlder, did, minimum_diffs);
// gets rid of duplicate records where did and minimum_diffs are the same
deduped_by_DID_MinDiffs := dedup(comparedNewerAndOlderForMinDiffs, did, minimum_diffs);

sortedUnfilteredComparedNewerAndOlder := sort(unfilteredComparedNewerAndOlder, did);
deduped_by_DID := dedup(sortedUnfilteredComparedNewerAndOlder, did);

// Count total number of did's
integer totalDID := count(deduped_by_DID);

// Count number of dids based on number of minimum_diffs using filtering:

// counts the number of dids that have a min value of 1
count_DIDs_with_1_MinDiffs := count(deduped_by_DID_MinDiffs(minimum_diffs = 1));
// counts the number of dids that have a min value of 2
count_DIDs_with_2_MinDiffs := count(deduped_by_DID_MinDiffs(minimum_diffs = 2));
// counts the number of dids that have a min value of 3
count_DIDs_with_3_MinDiffs := count(deduped_by_DID_MinDiffs(minimum_diffs = 3));
// counts the number of dids that have a min value of 4+
count_DIDs_with_4plus_MinDiffs := count(deduped_by_DID_MinDiffs(minimum_diffs > 3));

// Make an inline dataset for the above counts
minimum_diffs_summary_Rec := RECORD
    string minimum_diff;
    integer count_of_did;
    decimal5_2 percentDID;
END;

// creates a dataset that includes a field for the count of each of these minimum_diff values
minimum_diffs_summary := DATASET(
    [
        { '1', count_DIDs_with_1_MinDiffs, count_DIDs_with_1_MinDiffs / totalDID * 100 },
        { '2', count_DIDs_with_2_MinDiffs, count_DIDs_with_2_MinDiffs / totalDID * 100},
        { '3', count_DIDs_with_3_MinDiffs, count_DIDs_with_3_MinDiffs / totalDID * 100 },
        { '4 or more', count_DIDs_with_4plus_MinDiffs, count_DIDs_with_4plus_MinDiffs / totalDID * 100 }
    ], minimum_diffs_summary_Rec
);

// NOTE: used to be called DIDMinDiffOutputTable
output(minimum_diffs_summary, named('minimum_diffs_summary'));


////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
