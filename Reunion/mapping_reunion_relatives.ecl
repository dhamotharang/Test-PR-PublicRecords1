IMPORT address;

EXPORT mapping_reunion_relatives(unsigned1 mode, STRING sVersion) := MODULE

dRelativePairs:=reunion.get_universe(mode).get_relative_pairs;
dBestRelatives:=reunion.fn_apply_main_best_to_relatives(dRelativePairs,reunion.mapping_reunion_main(mode, sVersion).all);
dDrop2ndWithoutBest:=dBestRelatives(~(came_from='3' AND TRIM(relative_fname)='' AND TRIM(relative_lname)=''));

EXPORT  all := dDrop2ndWithoutBest:PERSIST('~thor::persist::mylife::mapping_relatives::' + reunion.Constants.sMode(mode));

END;