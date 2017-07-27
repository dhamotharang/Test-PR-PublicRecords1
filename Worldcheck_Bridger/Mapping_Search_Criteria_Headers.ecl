#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, lib_stringlib, worldcheck, worldcheck_bridger;

export Mapping_Search_Criteria_Headers (string filedate):= function

return sequential(worldcheck_bridger.Mapping_Search_Criteria_Region_1(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_2(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_3(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_4(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_5(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_6(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_7(filedate),
					worldcheck_bridger.Mapping_Search_Criteria_Region_8(filedate));

end;

