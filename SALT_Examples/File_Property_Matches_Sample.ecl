layout_property_matches := record
unsigned6 bdid;
string12 ln_fares_id;
end;
export File_Property_Matches_Sample := dataset('~salt_demo::sample_property_matches',layout_property_matches,THOR);
