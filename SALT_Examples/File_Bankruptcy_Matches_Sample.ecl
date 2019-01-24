layout_bankruptcy_matches := record
unsigned6 bdid;
string12 court_case_number;
end;
export File_Bankruptcy_Matches_Sample := dataset('~salt_demo::sample_bankruptcy_matches',layout_bankruptcy_matches,THOR);
