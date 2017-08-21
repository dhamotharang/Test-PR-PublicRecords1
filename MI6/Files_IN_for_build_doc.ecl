
import crim_common;

mac_get_delta_file(vfilename,delta_vfilename) := macro
 #uniquename(to_vfilename);
 recordof(vfilename) %to_vfilename%(vfilename l, changed_vendors_doc r) := transform
 self := l;
 end;
 delta_vfilename := join(vfilename,changed_vendors_doc, left.vendor=right.vendor,%to_vfilename%(left,right),lookup);
endmacro;

mac_get_delta_file(file_offender_doc, delta_crim_offender);
mac_get_delta_file(file_crim_offenses_doc, delta_crim_offenses);
mac_get_delta_file(file_crim_punishment_doc,	delta_crim_punishment);

export  Files_IN_for_build_doc := MODULE

export offender					:= delta_crim_offender 	: persist('~thor_data400::persist::crim_offender2_did_delta_for_cp_doc');
export crim_offenses		:= delta_crim_offenses : persist('~thor_data400::persist::crim_offenses_delta_for_cp_doc');
export crim_punishment		:= delta_crim_punishment : persist('~thor_data400::persist::crim_punishment_delta_for_cp_doc');

END;

