

import codes;
import crim_common;
import crim_cp_ln;

Layout_AOC_Offenders_CodeV3_sex := RECORD
crim_common.Layout_Moxie_Crim_Offender2.previous;
//Sex_descr := Codes.layout_codes_v3.long_desc;
//Codes.layout_codes_v3.long_desc;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
Layout_LN_Cross_Extract_Driver.court_id;
Crim_Common.Layout_Moxie_Court_Offenses.court_cd;
Crim_Common.Layout_Moxie_Court_Offenses.court_desc;	
string330 Sex_descr;
end;


Layout_AOC_Offenders_CodeV3_sex  tr_get_sex_descr(File_AOC_Offenders L, File_CodesV3_Crim_Offender2 R) := TRANSFORM
SELF := L;
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD;
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD;
SELF.Sex_descr := R.long_desc;
END;


File_AOC_Offenders_CodeV3_sex := JOIN(File_AOC_Offenders,File_CodesV3_Crim_Offender2,
                                            StringLib.StringToUpperCase(LEFT.sex) = RIGHT.code and RIGHT.field_name = 'SEX',
																						  tr_get_sex_descr(LEFT,RIGHT),LEFT OUTER, lookup);


// Layout_AOC_Offenders_CodeV3_sex_vendor := RECORD
// Layout_AOC_Offenders_CodeV3_sex; 
// string330 Vendor_descr;
// end;


// Layout_AOC_Offenders_CodeV3_sex_vendor tr_get_vendor_descr(File_AOC_Offenders_CodeV3_sex L, File_CodesV3_Crim_Offender2 R) := TRANSFORM
// SELF := L;
// SELF.Vendor_descr := R.long_desc;
// END;
																						
// File_AOC_Offenders_CodeV3_sex_vendor := JOIN(File_AOC_Offenders_CodeV3_sex,File_CodesV3_Crim_Offender2,
                                            // LEFT.vendor = RIGHT.code and RIGHT.field_name = 'VENDOR',
																						  // tr_get_vendor_descr(LEFT,RIGHT),LEFT OUTER,lookup);

export File_AOC_Offenders_CodeV3 := File_AOC_Offenders_CodeV3_sex;