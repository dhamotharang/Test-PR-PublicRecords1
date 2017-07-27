#workunit('name', 'Build BBB Base Files');

import ut;

ut.MAC_SF_BuildProcess(bbb.bbb_clean_bdid,'~thor_data400::base::BBB',do1,2);
ut.MAC_SF_BuildProcess(bbb.bbb_non_member_clean_bdid,'~thor_data400::base::BBB_Non_Member',do2,2);


export Make_BBB_Base := sequential(do1, do2);