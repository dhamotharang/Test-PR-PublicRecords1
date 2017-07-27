import worldcheck_bridger;

export Proc_Build_Worldcheck_Premium_Plus(string filedate) := function

return sequential(Worldcheck_Bridger.Mapping_Search_Criteria_Headers_Premium_Plus(filedate),
						Worldcheck_Bridger.Mapping_WorldCheck_Premium_Plus(filedate),
						Worldcheck_Bridger.Out_File_Premium_Plus_Entity_Stats_Population(filedate),
						Worldcheck_Bridger.Move_Superfiles_Despray_Premium_Plus(filedate));

end;