import crim_common;

mac_get_delta_file(vfilename,delta_vfilename) := macro
 #uniquename(to_vfilename);
 recordof(vfilename) %to_vfilename%(vfilename l, changed_vendors_aoc r) := transform
 self := l;
 end;
 delta_vfilename := join(vfilename,changed_vendors_aoc, left.vendor=right.vendor,%to_vfilename%(left,right),lookup);
endmacro;

mac_get_delta_file(file_offender_aoc, delta_crim_offender);
mac_get_delta_file(file_Court_Offenses_aoc,	delta_court_offenses);

export  Files_IN_for_build_aoc := MODULE

export offender					:= delta_crim_offender 	: persist('~thor_data400::persist::crim_offender2_did_delta_for_cp_aoc');
export court_offenses		:= delta_court_offenses : persist('~thor_data400::persist::court_offenses_delta_for_cp_aoc');

END;

