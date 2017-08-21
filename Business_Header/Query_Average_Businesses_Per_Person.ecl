// Determine average Businesses per Person, and Average Persons per Business
// And frequency distributions
score_threshold := 6;  // combined_score for contact must be greater than this number for people at work
bc := Business_Header.File_Business_Contacts_Stats(NOT Business_Header.CheckUCC(source, company_name, fname, mname, lname, name_suffix));

output(count(bc(combined_score > score_threshold)), named('Total_PAW'));
output(count(bc(combined_score > score_threshold, did <> 0)), named('PAW_with_DID'));
output(count(bc(combined_score > score_threshold, did = 0)), named('PAW_with_No_DID'));
output(count(bc(combined_score > score_threshold, bdid <> 0)), named('PAW_with_BDID'));
output(count(bc(combined_score > score_threshold, bdid = 0)), named('PAW_with_No_BDID'));
output(count(bc(combined_score > score_threshold, did <> 0, bdid <> 0)), named('PAW_with_DID_BDID'));
output(count(bc(combined_score > score_threshold, did = 0, bdid = 0)), named('PAW_with_No_DID_BDID'));

// Businesses per Person (with DID and with or without BDID)
layout_did_stat := record
unsigned6 did := bc.did;
integer cnt := count(group);
end;

BP_DID_BDID := table(bc(combined_score > score_threshold, did <> 0, bdid <> 0), layout_did_stat, did);
BP_DID := table(bc(combined_score > score_threshold, did <> 0), layout_did_stat, did);

AVG_BP_DID_BDID := ave(BP_DID_BDID, cnt);
AVG_BP_DID := ave(BP_DID, cnt);

output(AVG_BP_DID, named('Average_Businesses_Per_Person_With_DID'));
output(AVG_BP_DID_BDID, named('Average_Businesses_Per_Person_With_DID_and_BDID'));

layout_bp_did_stat := record
BP_DID.cnt;
number_of_dids := count(group);
end;

BP_DID_Stat := table(BP_DID, layout_bp_did_stat, cnt, few);

output(BP_DID_Stat, all);

// Persons per Business (with BDID and with or without DID)
layout_bdid_stat := record
unsigned6 bdid := bc.bdid;
integer cnt := count(group);
end;

PB_BDID_DID := table(bc(combined_score > score_threshold, bdid <> 0, did <> 0), layout_bdid_stat, bdid);
PB_BDID := table(bc(combined_score > score_threshold, bdid <> 0), layout_bdid_stat, bdid);

AVG_PB_BDID_DID := ave(PB_BDID_DID, cnt);
AVG_PB_BDID := ave(PB_BDID, cnt);

output(AVG_PB_BDID, named('Average_Persons_Per_Business_With_DID'));
output(AVG_PB_BDID_DID, named('Average_Persons_Per_Business_With_DID_and_BDID'));

layout_pb_bdid_stat := record
PB_BDID.cnt;
number_of_bdids := count(group);
end;

PB_BDID_Stat := table(PB_BDID, layout_pb_bdid_stat, cnt, few);

output(PB_BDID_Stat, all);
