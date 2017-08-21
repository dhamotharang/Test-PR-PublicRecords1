Import Data_Services, PRTE2_Liens, liensv2, Doxie, ut;

export Key_liens_filing(boolean isFCRA = false) := FUNCTION

get_recs := PRTE2_Liens.files.Main_out;

slim_rec := record
get_recs.tmsid;
get_recs.rmsid;
get_recs.filing_number;
get_recs.orig_filing_number;
string2 filing_state;
end;

slim_rec tslim(get_recs L, integer cnt) := transform
self.filing_state := if(length(trim(L.filing_jurisdiction, left, right)) = 2, L.filing_jurisdiction, L.filing_state);
self.filing_number := choose(cnt, L.filing_number, L.orig_filing_number);
self := L;
end;
					   
slim_main := normalize(get_recs(filing_number <> '' or orig_filing_number <> ''),2, tslim(left, counter));
slim_dist := distribute(slim_main, hash(tmsid, rmsid, filing_number,filing_state));
slim_sort  := sort(slim_dist, tmsid, rmsid, filing_number,filing_state, local);
slim_dedup := dedup(slim_sort(trim(filing_number) <> ''), tmsid, rmsid, filing_number,filing_state, local);

file_prefix := if(IsFCRA, 
                  Constants.KEY_PREFIX + 'fcra::',
                  Constants.KEY_PREFIX);

RETURN index(slim_dedup,{filing_number, filing_state},{TMSID,RMSID}, file_prefix + doxie.Version_SuperKey + '::filing_number');

END;
