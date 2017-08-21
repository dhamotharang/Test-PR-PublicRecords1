IMPORT RoxieKeyBuild, Insurance_iesp, ut, lib_date;
//
// Process the sprayed Delta exported files and create a base file
//
EXPORT BuildDeltaBase(string bFileName, string build_date) := FUNCTION
/*
** delta Report build from DBA SQLs from HPCC side (deltabase report file)
*/

SprayedDeltaRep0  := DATASET(BuildConstants(bFileName).spray_subfile, BuildLayouts.Layout_Delta_Rec_Unload,
                            // CSV(SEPARATOR(BuildConstants().FieldSeparator),TERMINATOR(BuildConstants().RecordTerminator), MAXLENGTH(1000100),NOTRIM));
                            CSV(SEPARATOR(BuildConstants().MBSI_FieldSeparator),TERMINATOR(BuildConstants().RecordTerminator), MAXLENGTH(1000100),NOTRIM));

cleanstring(STRING s) := stringlib.stringfindreplace(stringlib.stringfindreplace(s,'\\N','  '),'\\\\','\\');
//Convert the strings into number etc. over here..... 
SprayedDeltaRep := Project(SprayedDeltaRep0, Transform(BuildLayouts.Layout_Delta_Rec, Self.Customer_Num  			:= CleanString(Left.Customer_Num);
																																									Self.LexId 				 			:= (INTEGER)cleanstring(Left.LexId);
																																									Self.Line_Of_Business 	:= cleanstring(Left.Line_Of_Business);
																																									Self.Reference_Num 	    := cleanstring(Left.Reference_Num);
																																									DateF 									:= stringlib.stringfindreplace(cleanstring(Left.Date_Added[1..10]), '-', '');
																																									Self.Date_Added    			:= (INTEGER)DateF;
																																									Self := Left;));

output(SprayedDeltaRep);
Daily_DeltaReport := dedup(sort(distribute(SprayedDeltaRep,hash64(Reference_Num)),Reference_Num,local),Reference_Num,local);

Deltabase_Report := Files.DS_BASE_DELTA_REPORT;
D_Deltabase_Report := sorted(DISTRIBUTED(Deltabase_Report,HASH64(Reference_Num)),Reference_Num);
Sorted_Daily_DeltaReport := SORT(Daily_DeltaReport,Reference_Num,local);
D_DeltaReport := MERGE(D_Deltabase_Report, Sorted_Daily_DeltaReport,
                       SORTED(Reference_Num),
											 DEDUP,
											 LOCAL);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(D_DeltaReport, Files.BASE_PREFIX_NAME, Files.SUFFIX_NAME_DELTA_REPORT, build_date, DeltaReportBase, 3, false, true);

RETURN MAP (bFileName = BuildConstants().lead_delta_report => sequential(DeltaReportBase), //Lead Delta Base,
						FAIL(bFileName + ' is not supported for build base and key'));
END;
