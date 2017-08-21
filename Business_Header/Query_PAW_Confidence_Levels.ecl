score_threshold := 6;  // combined_score for contact must be greater than this number for people at work
bc := Business_Header.File_Business_Contacts_Stats(NOT Business_Header.CheckUCC(source, company_name, fname, mname, lname, name_suffix));

// All Confidence levels
output(count(bc(combined_score > score_threshold)), named('Total_PAW'));
output(count(bc(combined_score > score_threshold, did <> 0)), named('Total_PAW_With_ADL'));
output(count(dedup(bc(combined_score > score_threshold,  did <> 0), did, all)), named('Total_PAW_Unique_ADL'));
output(count(dedup(bc(combined_score > score_threshold,  did <> 0, bdid <> 0), did, all)), named('Total_PAW_Unique_ADL_With_BDID'));

// High  Confidence
output(count(bc(combined_score >= 100)), named('HC_PAW'));
output(count(bc(combined_score >= 100, did <> 0)), named('HC_PAW_With_ADL'));
output(count(dedup(bc(combined_score >= 100,  did <> 0), did, all)), named('HC_PAW_Unique_ADL'));
output(count(dedup(bc(combined_score >= 100,  did <> 0, bdid <> 0), did, all)), named('HC_PAW_Unique_ADL_With_BDID'));

// High and Medium Confidence
output(count(bc(combined_score >= 50)), named('MHC_PAW'));
output(count(bc(combined_score >= 50, did <> 0)), named('MHC_PAW_With_ADL'));
output(count(dedup(bc(combined_score >= 50,  did <> 0), did, all)), named('MHC_PAW_Unique_ADL'));
output(count(dedup(bc(combined_score >= 50,  did <> 0, bdid <> 0), did, all)), named('MHC_PAW_Unique_ADL_With_BDID'));

// Low Confidence
output(count(bc(combined_score > score_threshold, combined_score < 50)), named('LC_PAW'));
output(count(bc(combined_score > score_threshold, combined_score < 50, did <> 0)), named('LC_PAW_With_ADL'));
output(count(dedup(bc(combined_score > score_threshold,  combined_score < 50, did <> 0), did, all)), named('LC_PAW_Unique_ADL'));
output(count(dedup(bc(combined_score > score_threshold,  combined_score < 50, did <> 0, bdid <> 0), did, all)), named('LC_PAW_Unique_ADL_With_BDID'));


// Businesses with a contact
output(count(dedup(bc(combined_score > score_threshold,  bdid <> 0), bdid, all)), named('Total_PAW_Unique_BDID'));
output(count(dedup(bc(combined_score > score_threshold,  did <> 0, bdid <> 0), bdid, all)), named('Total_PAW_Unique_BDID_With_ADL'));
output(count(dedup(bc(combined_score >= 100,  bdid <> 0), bdid, all)), named('HC_PAW_Unique_BDID'));
output(count(dedup(bc(combined_score >= 100,  did <> 0, bdid <> 0), bdid, all)), named('HC_PAW_Unique_BDID_With_ADL'));
output(count(dedup(bc(combined_score >= 50,  bdid <> 0), bdid, all)), named('MHC_PAW_Unique_BDID'));
output(count(dedup(bc(combined_score >= 50,  did <> 0, bdid <> 0), bdid, all)), named('MHC_PAW_Unique_BDID_With_ADL'));
output(count(dedup(bc(combined_score > score_threshold,  combined_score < 50, bdid <> 0), bdid, all)), named('LC_PAW_Unique_BDID'));
output(count(dedup(bc(combined_score > score_threshold,  combined_score < 50, did <> 0, bdid <> 0), bdid, all)), named('LC_PAW_Unique_BDID_With_ADL'));
