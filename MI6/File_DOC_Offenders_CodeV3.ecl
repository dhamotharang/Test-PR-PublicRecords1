

import codes;
import crim_common;
import crim_cp_ln;

Layout_DOC_Offenders_CodeV3_sex := RECORD
crim_common.Layout_Moxie_Crim_Offender2.previous;
crim_cp_ln.Layout_cross_case_master.OLD_RECORD_SUPPLIER_CD_C;
crim_cp_ln.Layout_cross_case_master.RECORD_SUPPLIER_CD_C;
Layout_LN_Cross_Extract_Driver.court_id;
Crim_Common.Layout_In_DOC_Offenses.previous.court_cd;	
Crim_Common.Layout_In_DOC_Offenses.previous.court_desc;	
string330 Sex_descr;
end;


Layout_DOC_Offenders_CodeV3_sex  tr_get_sex_descr(File_DOC_Offenders L) := TRANSFORM
SELF := L;
SELF.OLD_RECORD_SUPPLIER_CD_C := L.OLD_RECORD_SUPPLIER_CD;
SELF.RECORD_SUPPLIER_CD_C := L.RECORD_SUPPLIER_CD;
SELF.Sex_descr := CASE(TRIM(L.sex,LEFT,RIGHT),'F' => 'Female',
                                              '2' => 'Female', 
																							'M'=> 'Male',
																							'0'=> 'Unknown',
																							'U'=> 'Unknown',
																							'1'=> 'Male',																							
																							'Unknown');
END;

//From codesV3 sex lookup
//                  N	Unknown                                                                                                                                                                                                                                                                                                                                   
// F              	N	Female                                                                                                                                                                                                                                                                                                                                    
// 2              	N	Female                                                                                                                                                                                                                                                                                                                                    
// M              	N	Male                                                                                                                                                                                                                                                                                                                                      
// 0              	N	Unknown                                                                                                                                                                                                                                                                                                                                   
// U              	N	Unknown                                                                                                                                                                                                                                                                                                                                   
// 1              	N	Male 

File_DOC_Offenders_CodeV3_sex := PROJECT(File_DOC_Offenders,tr_get_sex_descr(LEFT));

export File_DOC_Offenders_CodeV3 := File_DOC_Offenders_CodeV3_sex;

