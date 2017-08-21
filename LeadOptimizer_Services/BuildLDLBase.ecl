IMPORT RoxieKeyBuild, Insurance_iesp, ut, lib_date;
//
// Process the sprayed lead distribution list exported file and create a base file
//
EXPORT BuildLDLBase(string build_date) := FUNCTION

bFileName := buildConstants().lead_ldl_file;
SprayedLDLFile  := DATASET(BuildConstants(bFileName).spray_subfile, BuildLayouts.Layout_ldl_Rec,
                            CSV(SEPARATOR(BuildConstants().MBSI_FieldSeparator),TERMINATOR(BuildConstants().RecordTerminator), MAXLENGTH(1000100),NOTRIM));

cleanstring(STRING s) := stringlib.stringfindreplace(stringlib.stringfindreplace(s,'\\N','  '),'\\\\','\\');

//Convert the strings into number etc. over here..... 
SprayedLDLFileC := Project(SprayedLDLFile, Transform(BuildLayouts.Layout_ldl_Rec,      Self.Customer_Num  			:= cleanstring(Left.Customer_Num);
																																									Self.Zip 				 			  := cleanstring(Left.Zip);
																																									Self.Zip4             	:= cleanstring(Left.Zip4);
																																									Self.State        	    := cleanstring(Left.State);
																																									Self.RoutingInformation	:= cleanstring(left.RoutingInformation);
																																									Self := Left;));

//We are supposed to get a full extract everytime so we dont need to do any processing with the existing file just distribute by customernum and build the file
output(SprayedLDLFileC);
NewLDLFile_D := distribute(SprayedLDLFileC,hash64(Customer_Num));

// Deltabase_Report := Files.DS_BASE_DELTA_REPORT;
// D_Deltabase_Report := sorted(DISTRIBUTED(Deltabase_Report,HASH64(Reference_Num)),Reference_Num);
// Sorted_Daily_DeltaReport := SORT(Daily_DeltaReport,Reference_Num,local);
// D_DeltaReport := MERGE(D_Deltabase_Report, Sorted_Daily_DeltaReport,
                       // SORTED(Reference_Num),
											 // DEDUP,
											 // LOCAL);

RoxieKeyBuild.Mac_SF_BuildProcess_V2(NewLDLFile_D, Files.BASE_PREFIX_NAME, Files.SUFFIX_NAME_LDL_FILE, build_date, LDLFileBase, 3, false, true);

RETURN LDLFileBase;
END;
