IMPORT STD;

// EXPORT eCrashBaseAgencyExclusion := FLAccidents_Ecrash.BaseFile((STD.Str.ToUpperCase(TRIM(agency_ori, ALL)) NOT IN Agency_exclusion.Agency_ori_list OR
                                                                 // STD.Str.ToUpperCase(TRIM(agency_ori, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list)
																					                       // OR 
																				                        // (STD.Str.ToUpperCase(TRIM(ori_number, ALL)) NOT IN Agency_exclusion.Agency_ori_list OR
                                                                 // STD.Str.ToUpperCase(TRIM(ori_number, ALL))[1..2] NOT IN Agency_exclusion.Agency_ori_jurisdiction_list)
																				                        // );
EXPORT eCrashBaseAgencyExclusion := FLAccidents_Ecrash.BaseFile;