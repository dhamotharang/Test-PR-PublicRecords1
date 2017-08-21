Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export Key_liens_case_number(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Main_out;

slim_rec := record
get_recs.tmsid;
get_recs.rmsid;
string20 case_number;
string2 filing_state;
end;

slim_rec tslim(get_recs L, integer cnt) := transform
self.case_number := choose(cnt, L.case_number, L.filing_number, L.orig_filing_number);						  
self.filing_state  := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);						                        
self := L;

end;
					   
slim_file := normalize(get_recs(case_number <> '' or filing_number <> '' or orig_filing_number <> ''), 3, tslim(left, counter));
slim_dist  := distribute(slim_file, hash(tmsid, rmsid, case_number, filing_state));
slim_sort  := sort(slim_dist, tmsid, rmsid, case_number,filing_state, local);
slim_dedup := dedup(slim_sort(case_number <> ''), tmsid, rmsid, case_number, filing_state, local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(slim_dedup,{case_number, filing_state},{TMSID,RMSID},file_prefix + doxie.Version_SuperKey + '::case_number');

END;
