IMPORT doxie, VotersV2_Services, doxie_crs;

EXPORT Voter_Records (dataset(doxie.layout_references) dids) := FUNCTION

doxie.MAC_Header_Field_Declare(); //ssn_mask_value, dateVal, score_threshold_value

// new data; projected into the old format (until switching to new data completely);
// 'dppa_purpose', 'glb_purpose' weren't used; 'dateVal' is handled after fetch
ds_voters := VotersV2_Services.raw.MOXIE_VIEW.by_did (dids, ssn_mask_value);

fetched := IF (dateVal = 0, ds_voters, ds_voters ((unsigned3) (date_first_seen[1..6]) <= dateVal));

doxie.MAC_Header_Result_Rank(fname,mname,lname,
                             best_ssn,dob,did,
                             predir,prim_range,prim_name,suffix,postdir,sec_range,
                             p_city_name,county_name,st,zip,
                             phone,false)
														 
outrec := doxie_crs.layout_voter_records;
ut.MAC_Slim_back(outf1, outrec, outfile)

return outfile;

END;
