IMPORT STD, FLAccidents_Ecrash;
EXPORT fn_Citation_BadDataRemoval() := FUNCTION												
																
  ds_Citation := FLAccidents_Ecrash.Infiles.citation;
  Layout_Citation := FLAccidents_Ecrash.Layout_Infiles.citation;
  Layout_CitationWithFlag := RECORD
    layout_Citation;
	  BOOLEAN isCitationRecPop;
  END;
	Citation_Issued_Set := ['UNKNOWN', 'NULL'];	
	
  Layout_CitationWithFlag xfmUpdateCitationFile(ds_Citation l) := TRANSFORM
    SELF.isCitationRecPop := 
												 (std.str.Touppercase(TRIM(l.citation_number1, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.citation_number2, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.section_number1, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.court_date, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.court_time, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.citation_detail1, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.local_code, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.violation_code1, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.violation_code2, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.multiple_charges_indicator, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.dui_indicator, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.court_time_am, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.court_time_pm, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.violator_name, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.type_hazardous, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.type_other, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.citation_status, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.citation_type, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.violation_code3, LEFT, RIGHT)) NOT IN ['', 'NULL'] OR
													std.str.Touppercase(TRIM(l.violation_code4, LEFT, RIGHT)) NOT IN ['', 'NULL']);
    SELF := l;
	END;
																									 
 ds_Citation_WithFlag := PROJECT(ds_Citation, xfmUpdateCitationFile(LEFT));
 
 ds_Citation_FilterOutBadData := ds_Citation_WithFlag(~(isCitationRecPop = FALSE AND
                                                        std.str.Touppercase(TRIM(citation_issued, LEFT, RIGHT)) IN Citation_Issued_Set));
																												
 ds_Citation_Upd := PROJECT(ds_Citation_FilterOutBadData, TRANSFORM(layout_citation, 
                                                 SELF.citation_number1 := IF(TRIM(LEFT.citation_number1,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.citation_number1);
                                                 SELF.Citation_Number2 := IF(TRIM(LEFT.Citation_Number2,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Citation_Number2);
                                                 SELF.Section_Number1 := IF(TRIM(LEFT.Section_Number1,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Section_Number1);
                                                 SELF.Court_Date := IF(TRIM(LEFT.Court_Date,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Court_Date);
                                                 SELF.Court_Time := IF(TRIM(LEFT.Court_Time,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Court_Time);
                                                 SELF.Citation_Detail1 := IF(TRIM(LEFT.Citation_Detail1,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Citation_Detail1);
                                                 SELF.Local_Code := IF(TRIM(LEFT.Local_Code,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Local_Code);
                                                 SELF.Violation_Code1 := IF(TRIM(LEFT.Violation_Code1,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Violation_Code1);
                                                 SELF.Violation_Code2 := IF(TRIM(LEFT.Violation_Code2,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Violation_Code2);
                                                 SELF.Multiple_Charges_Indicator := IF(TRIM(LEFT.Multiple_Charges_Indicator,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Multiple_Charges_Indicator);
                                                 SELF.DUI_Indicator := IF(TRIM(LEFT.DUI_Indicator,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.DUI_Indicator);
                                                 SELF.Court_Time_AM := IF(TRIM(LEFT.Court_Time_AM,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Court_Time_AM);
                                                 SELF.Court_Time_PM := IF(TRIM(LEFT.Court_Time_PM,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Court_Time_PM);
                                                 SELF.Violator_Name := IF(TRIM(LEFT.Violator_Name,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Violator_Name);
                                                 SELF.Type_Hazardous := IF(TRIM(LEFT.Type_Hazardous,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Type_Hazardous);
                                                 SELF.Type_Other := IF(TRIM(LEFT.Type_Other,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Type_Other);
                                                 SELF.Citation_Status := IF(TRIM(LEFT.Citation_Status,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Citation_Status);
                                                 SELF.Citation_Type := IF(TRIM(LEFT.Citation_Type,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Citation_Type);
                                                 SELF.Violation_Code3 := IF(TRIM(LEFT.Violation_Code3,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Violation_Code3);
                                                 SELF.Violation_Code4 := IF(TRIM(LEFT.Violation_Code4,LEFT,RIGHT) IN ['\\N', 'NULL'],  '', LEFT.Violation_Code4);
											                           SELF := LEFT;));
 					
 ds_Citation_Upd_Out := OUTPUT(ds_Citation_Upd,,'~thor_data400::in::ecrash::citation_BadDataRemoval_' + WORKUNIT, OVERWRITE, __COMPRESSED__,
					                       CSV(TERMINATOR('\n'), SEPARATOR(','), QUOTE('"')));

 Build_Citation_Upd := SEQUENTIAL(
                                  ds_Citation_Upd_Out,
												          STD.File.StartSuperFileTransaction(),
												          STD.File.ClearSuperFile('~thor_data400::in::ecrash::citatn_raw', FALSE),
												          STD.File.AddSuperFile('~thor_data400::in::ecrash::citatn_raw', 
																	                      '~thor_data400::in::ecrash::citation_BadDataRemoval_' + WORKUNIT),
												          STD.File.FinishSuperFileTransaction()
												         );
 RETURN Build_Citation_Upd;
END;