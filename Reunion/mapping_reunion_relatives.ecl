IMPORT address;

dRelativePairs:=reunion.get_universe.get_relative_pairs;
dBestRelatives:=reunion.fn_apply_main_best_to_relatives(dRelativePairs,reunion.mapping_reunion_main);
dDrop2ndWithoutBest:=dBestRelatives(~(came_from='3' AND TRIM(relative_fname)='' AND TRIM(relative_lname)=''));

EXPORT mapping_reunion_relatives := dDrop2ndWithoutBest:PERSIST('~thor::persist::mylife::mapping_relatives');