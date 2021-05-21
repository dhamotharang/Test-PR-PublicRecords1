IMPORT STD;

eCrashBaseAgencyExclusionAgencyOri := BaseFile(STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN Agency_exclusion.Agency_ori_list AND
                                                                   STD.Str.ToUpperCase(TRIM(agency_ori, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list
																					                         );
																																					
EXPORT eCrashBaseAgencyExclusion := eCrashBaseAgencyExclusionAgencyOri(STD.Str.ToUpperCase(TRIM(ori_number, ALL)) NOT IN Agency_exclusion.Agency_ori_list AND
                                                                       STD.Str.ToUpperCase(TRIM(ori_number, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list
																				                               );