#option('skipFileFormatCrcCheck', 1);
#option('maxLength', 131072);

import ut, lib_stringlib, worldcheck, worldcheck_bridger;

export Proc_Build_Worldcheck_Standard (string filedate) := function

return sequential(worldcheck_bridger.Mapping_Search_Criteria_Headers(filedate),
					worldcheck_bridger.Mapping_Standard_Entity(filedate),
					worldcheck_bridger.Out_File_Standard_Entity_Stats_Population(filedate),
					worldcheck_bridger.Out_File_Standard_Entity_Region_Stats_Population(filedate),
					worldcheck_bridger.Move_Superfiles_Despray_Standard(filedate));

end;