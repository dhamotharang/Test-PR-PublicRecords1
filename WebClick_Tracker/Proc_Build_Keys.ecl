// Function - Proc_Build_Keys
// Parameters - filedate (date of spray)
// Purpose - build all webclick roxie keys and move to the qa superkeys

import RoxieKeyBuild;

export Proc_Build_Keys(string filedate) := function

// Build Keys

roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.DSIndex.Key_SessionID_dis,'foo',
						'~thor_data400::key::WebClick::' + filedate + '::Session_dis',build1);
roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.DSIndex.Key_EventID_dis,'foo',
					'~thor_data400::key::WebClick::' + filedate + '::Event_dis',build2);
roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.DSIndex.Key_AppID_dis,'foo',
					'~thor_data400::key::WebClick::' + filedate + '::Vert_dis',build3);
roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.build_freq,'foo',
					'~thor_data400::key::WebClick::' + filedate + '::freq_nl',build4);
roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.DSIndex.Key_userID_dis,'foo',
					'~thor_data400::key::WebClick::' + filedate + '::userid_dis',build5);
roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.DSIndex.date_key,'foo',
					'~thor_data400::key::WebClick::' + filedate + '::date_info',build6);
roxiekeybuild.mac_sk_buildprocess_v2_local(WebClick_Tracker.key_Event_Description,'foo',
					'~thor_data400::key::WebClick::' + filedate + '::Event_desc',build7,true);					


// Move Keys

// Macro creates all the necessary superkeys
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::Session_dis','D',mv1,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::Event_dis','D',mv2,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::Vert_dis','D',mv3,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::freq_nl','D',mv4,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::userid_dis','D',mv5,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::date_info','D',mv6,filedate);
roxiekeybuild.Mac_SK_Move_V3('~thor_data400::key::WebClick::@version@::Event_desc','D',mv7,filedate);

retval := sequential(build1,mv1,build2,mv2,build3,build4,build5,build6,build7,
					mv3,mv4,mv5,mv6,mv7);

return retval;

end;