layout_vehicle_matches := record
string17 vin;
unsigned6 bdid;
end;
export File_Vehicle_Matches_Sample := dataset('~salt_demo::sample_vehicle_matches',layout_vehicle_matches,THOR);
