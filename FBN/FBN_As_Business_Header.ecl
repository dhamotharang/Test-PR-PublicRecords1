IMPORT Business_Header, ut;

//*************************************************************************
// Translate FBN to Common Business Header Format
//*************************************************************************

/*
Layout_FBN_Local := RECORD
UNSIGNED6 record_id := 0;
UNSIGNED6 group_id := 0;
Layout_FBN;
END;

// Add unique record id to FBN file
Layout_FBN_Local AddRecordID(Layout_FBN L) := TRANSFORM
SELF := L;
END;

FBN_Init := PROJECT(File_FBN, AddRecordID(LEFT));

ut.MAC_Sequence_Records(FBN_Init, record_id, FBN_Seq)

FBN_Dist := DISTRIBUTE(FBN_Seq, HASH(file_st, filing_num, filing_dt));
FBN_Sort := SORT(FBN_Dist, file_st, filing_num, filing_dt,
                                   MAP(name_typ = 'B' => 1,
                                       name_typ = 'O' => 2,
                                       name_typ = 'R' => 3,
                                       name_typ = 'A' => 4,
                                       name_typ = 'L' => 5,
                                       name_typ = 'W' => 6,
                                       7),
                                   IF(orig_zip='', 1, 0),
                                   LOCAL);

FBN_Grpd := GROUP(FBN_Sort, file_st, filing_num, filing_dt, LOCAL);

// Iterate through group to Assign Group ID
Layout_FBN_Local AssignGroupID(Layout_FBN_Local L, Layout_FBN_Local R) := TRANSFORM
SELF.group_id := MAP(L.group_id=0 AND R.name_typ = 'B' => R.record_id,
                    L.group_id<>0 AND R.name_typ = 'B' => L.record_id,
                    0);
SELF := R;
END;

FBN_Assigned := GROUP(ITERATE(FBN_Grpd, AssignGroupID(LEFT, RIGHT)));
*/

// Project FBN Business Records which appear to be businesses to Business Header Format
FBN_Bus := File_FBN(name_typ = 'B' OR (name_typ <> 'B' AND lname=''));

Business_Header.Layout_Business_Header Translate_FBN_To_BHF(Layout_FBN L) := TRANSFORM
//SELF.group1_id := L.group_id;
SELF.company_name := StringLib.StringToUpperCase(L.display_name);
SELF.vendor_id := (QSTRING34)((STRING34)(L.file_st + L.filing_num + L.filing_dt));
SELF.city := L.p_city_name;
SELF.state := L.st;
SELF.zip := (UNSIGNED3)L.zip5;
SELF.zip4 := (UNSIGNED2)L.zip4;
SELF.phone := (UNSIGNED6)(UNSIGNED8)L.phone10;
SELF.source := 'F';
SELF.dt_first_seen := (UNSIGNED4)L.filing_dt;
SELF.dt_vendor_first_reported := (UNSIGNED4)IF(L.dt_first_rpt <> '', L.dt_first_rpt + '00', L.filing_dt);
SELF.dt_vendor_last_reported := IF(L.dt_last_rpt <> '', (UNSIGNED4)(L.dt_last_rpt + '00'), SELF.dt_vendor_first_reported);
SELF.dt_last_seen := SELF.dt_vendor_last_reported;
SELF.current := NOT (L.filing_num[1..3]='EXP' OR
                    ((INTEGER)L.expiration_dt <> 0 AND ((INTEGER)(L.expiration_dt[5..8]+L.expiration_dt[1..4]) < (INTEGER)Stringlib.GetDateYYYYMMDD())));
SELF := L;
END;

EXPORT FBN_As_Business_Header := PROJECT(FBN_Bus, Translate_FBN_to_BHF(LEFT)) : PERSIST('FBN::Bus_Header');