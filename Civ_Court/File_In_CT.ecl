Export File_In_CT := Module
//Shared VersionDate := 'ct_20130307';
//Lookup Files
Export	File_AddressType := Dataset('~thor_data400::in::civil::ct::addresstype_lkp', Civ_Court.Layout_In_CT.Lay_AddressType, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_CaseType := Dataset('~thor_data400::in::civil::ct::casetype_lkp', Civ_Court.Layout_In_CT.Lay_CaseType, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_CompanionType := Dataset('~thor_data400::in::civil::ct::companiontype_lkp', Civ_Court.Layout_In_CT.Lay_CompanionType, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_CourtLocation := Dataset('~thor_data400::in::civil::ct::courtlocation_lkp', Civ_Court.Layout_In_CT.Lay_CourtLocation, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_DocumentType := Dataset('~thor_data400::in::civil::ct::documenttype_lkp', Civ_Court.Layout_In_CT.Lay_DocumentType, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_ListType := Dataset('~thor_data400::in::civil::ct::listtype_lkp', Civ_Court.Layout_In_CT.Lay_ListType, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_MarkingCode := Dataset('~thor_data400::in::civil::ct::markingcode_lkp', Civ_Court.Layout_In_CT.Lay_MarkingCode, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_OrderCode := Dataset('~thor_data400::in::civil::ct::ordercode_lkp', Civ_Court.Layout_In_CT.Lay_OrderCode, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_PartyCategory := Dataset('~thor_data400::in::civil::ct::partycategory_lkp', Civ_Court.Layout_In_CT.Lay_PartyCategory, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_PartySubCategory := Dataset('~thor_data400::in::civil::ct::partysubcategory_lkp', Civ_Court.Layout_In_CT.Lay_PartySubCategory, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_PartyType := Dataset('~thor_data400::in::civil::ct::partytype_lkp', Civ_Court.Layout_In_CT.Lay_PartyType, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_Privileged := Dataset('~thor_data400::in::civil::ct::privileged_lkp', Civ_Court.Layout_In_CT.Lay_Privileged, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_SCRAM := Dataset('~thor_data400::in::civil::ct::scram_lkp', Civ_Court.Layout_In_CT.Lay_SCRAM, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_StatusDetail := Dataset('~thor_data400::in::civil::ct::statusdetail_lkp', Civ_Court.Layout_In_CT.Lay_StatusDetail, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_vendor_BarMaster := Dataset('~thor_data400::in::civil::ct::vendor_barmaster_lkp', Civ_Court.Layout_In_CT.Lay_vendor_BarMaster, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_WhoFiled := Dataset('~thor_data400::in::civil::ct::whofiled_lkp', Civ_Court.Layout_In_CT.Lay_WhoFiled, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));

//Data Files
Export	File_CompanionCase := Dataset('~thor_data400::in::civil::ct::CompanionCase', Civ_Court.Layout_In_CT.Lay_CompanionCase, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_eAttyAppearance := Dataset('~thor_data400::in::civil::ct::eAttyAppearance', Civ_Court.Layout_In_CT.Lay_eAttyAppearance, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_eParty := Dataset('~thor_data400::in::civil::ct::eParty', Civ_Court.Layout_In_CT.Lay_eParty, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_eSelfRepAppearance := Dataset('~thor_data400::in::civil::ct::eSelfRepAppearance', Civ_Court.Layout_In_CT.Lay_eSelfRepAppearance, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_JUDCase := Dataset('~thor_data400::in::civil::ct::JudCase', Civ_Court.Layout_In_CT.Lay_JUDCase, CSV(Separator('|'), Quote('"'), Terminator('\r\n')))(length(trim(CaseYY, left, right))<3);
Export	File_KeyPointDates := Dataset('~thor_data400::in::civil::ct::KeyPointDates', Civ_Court.Layout_In_CT.Lay_KeyPointDates, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));
Export	File_ResactEntry := Dataset('~thor_data400::in::civil::ct::ResactEntry', Civ_Court.Layout_In_CT.Lay_ResactEntry, CSV(Separator('|'), Quote('"'), Terminator('\r\n')));


// Export DateConversion(String dt) := Function
// month := Map( stringlib.StringtoUpperCase(dt[1..3]) = 'JAN' => '01',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'FEB' => '02',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'MAR' => '03',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'APR' => '04',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'MAY' => '05',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'JUN' => '06',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'JUL' => '07',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'AUG' => '08',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'SEP' => '09',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'OCT' => '10',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'NOV' => '11',
								// stringlib.StringtoUpperCase(dt[1..3]) = 'DEC' => '12', '');
// day := If(length(Trim(dt[5..6],left, right)) = 1, '0'+ Trim(dt[5..6],left, right), dt[5..6]);
// Year := dt[8..11];
// frmtDate := If(dt <> '', If(length(trim(dt, left, right)) >8, year+month+day, dt), '');
// Return frmtDate;
// End;

// Added new function to accomodate the new date format
Export DateConversion(String dt) := Function
frmtdate := (dt[1..4] + dt[6..7] + dt[9..10]);
Return frmtDate;
End;


End;