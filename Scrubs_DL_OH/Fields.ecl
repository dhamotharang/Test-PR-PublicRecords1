IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_OH; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_boolean_yn_empty','invalid_wordbag','invalid_8pastdate','invalid_08pastdate','invalid_8generaldate','invalid_08generaldate','invalid_dbkoln','invalid_pinss4','invalid_dvnlic','invalid_dvccls','invalid_dvctyp','invalid_pifdon','invalid_pichcl','invalid_picecl','invalid_piqwgt','invalid_height','invalid_picsex','invalid_drnagy','invalid_dvfocd','invalid_dvcatt','invalid_dvcded','invalid_dvcgen','invalid_dvqdup','invalid_dbkmtk','invalid_dvnwbi','invalid_sycpgm','invalid_sytda1','invalid_dvctsa','invalid_dvcsce','invalid_dvdmce','invalid_pigsta','invalid_pigzip','invalid_name');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_num_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_blank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_boolean_yn_empty' => 8,'invalid_wordbag' => 9,'invalid_8pastdate' => 10,'invalid_08pastdate' => 11,'invalid_8generaldate' => 12,'invalid_08generaldate' => 13,'invalid_dbkoln' => 14,'invalid_pinss4' => 15,'invalid_dvnlic' => 16,'invalid_dvccls' => 17,'invalid_dvctyp' => 18,'invalid_pifdon' => 19,'invalid_pichcl' => 20,'invalid_picecl' => 21,'invalid_piqwgt' => 22,'invalid_height' => 23,'invalid_picsex' => 24,'invalid_drnagy' => 25,'invalid_dvfocd' => 26,'invalid_dvcatt' => 27,'invalid_dvcded' => 28,'invalid_dvcgen' => 29,'invalid_dvqdup' => 30,'invalid_dbkmtk' => 31,'invalid_dvnwbi' => 32,'invalid_sycpgm' => 33,'invalid_sytda1' => 34,'invalid_dvctsa' => 35,'invalid_dvcsce' => 36,'invalid_dvdmce' => 37,'invalid_pigsta' => 38,'invalid_pigzip' => 39,'invalid_name' => 40,0);
 
EXPORT MakeFT_invalid_mandatory(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('1..'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_specials(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'))));
EXPORT InValidMessageFT_invalid_alpha_num_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789 '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('0'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_empty(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('N|Y|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"%'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,./#*\'\\|_"%',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"%'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"%'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_08pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_08pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_08pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('0,8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8generaldate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8generaldate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_08generaldate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_08generaldate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_08generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT35.HygieneErrors.NotLength('0,8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dbkoln(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHI{'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dbkoln(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHI{'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_dbkoln(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHI{'),SALT35.HygieneErrors.NotLength('9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pinss4(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0{'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_pinss4(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0{'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_pinss4(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0{'),SALT35.HygieneErrors.NotLength('9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvnlic(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvnlic(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_dl_number(s)>0);
EXPORT InValidMessageFT_invalid_dvnlic(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_dl_number'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvccls(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvccls(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_class(s)>0);
EXPORT InValidMessageFT_invalid_dvccls(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_class'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvctyp(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvctyp(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_license_type(s)>0);
EXPORT InValidMessageFT_invalid_dvctyp(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_license_type'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pifdon(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pifdon(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_donor(s)>0);
EXPORT InValidMessageFT_invalid_pifdon(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_donor'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pichcl(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pichcl(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_hair_color(s)>0);
EXPORT InValidMessageFT_invalid_pichcl(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_hair_color'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_picecl(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_picecl(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_eye_color(s)>0);
EXPORT InValidMessageFT_invalid_picecl(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_eye_color'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_piqwgt(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_piqwgt(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_weight(s)>0);
EXPORT InValidMessageFT_invalid_piqwgt(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_weight'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_height(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_height(SALT35.StrType s,SALT35.StrType pinhin) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_height(s,pinhin)>0);
EXPORT InValidMessageFT_invalid_height(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_height'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_picsex(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_picsex(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['F','M','U','']);
EXPORT InValidMessageFT_invalid_picsex(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('F|M|U|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_drnagy(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_drnagy(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_invalid_drnagy(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('0,4'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvfocd(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvfocd(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['C','N','T','Y','']);
EXPORT InValidMessageFT_invalid_dvfocd(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('C|N|T|Y|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvcatt(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvcatt(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_trans_type(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_dvcatt(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_trans_type'),SALT35.HygieneErrors.NotLength('0,3'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvcded(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvcded(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['0','1','2','3','']);
EXPORT InValidMessageFT_invalid_dvcded(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('0|1|2|3|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvcgen(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'HMNPRSTX'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dvcgen(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'HMNPRSTX'))));
EXPORT InValidMessageFT_invalid_dvcgen(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('HMNPRSTX'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvqdup(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvqdup(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['0','1','2','3','4','']);
EXPORT InValidMessageFT_invalid_dvqdup(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('0|1|2|3|4|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dbkmtk(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num_specials(s1);
END;
EXPORT InValidFT_invalid_dbkmtk(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_dbkmtk(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'),SALT35.HygieneErrors.NotLength('9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvnwbi(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num_specials(s1);
END;
EXPORT InValidFT_invalid_dvnwbi(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'))),~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_dvnwbi(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'),SALT35.HygieneErrors.NotLength('2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sycpgm(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sycpgm(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_check_sycpgm(s)>0);
EXPORT InValidMessageFT_invalid_sycpgm(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_check_sycpgm'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sytda1(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_sytda1(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~Scrubs_DL_OH.Functions.fn_yyyymmddHHMMsss0(s)>0,~(LENGTH(TRIM(s)) = 16));
EXPORT InValidMessageFT_invalid_sytda1(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_yyyymmddHHMMsss0'),SALT35.HygieneErrors.NotLength('16'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvctsa(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvctsa(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['E','N','Y','0','1','2','3','']);
EXPORT InValidMessageFT_invalid_dvctsa(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('E|N|Y|0|1|2|3|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvcsce(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dvcsce(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['0','1','2','3','4','']);
EXPORT InValidMessageFT_invalid_dvcsce(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('0|1|2|3|4|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dvdmce(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num_specials(s1);
END;
EXPORT InValidFT_invalid_dvdmce(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_dvdmce(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ {-'),SALT35.HygieneErrors.NotLength('0,3,8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pigsta(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pigsta(SALT35.StrType s) := WHICH(~Scrubs_DL_OH.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_pigsta(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pigzip(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric_blank(s1);
END;
EXPORT InValidFT_invalid_pigzip(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9 OR LENGTH(TRIM(s)) = 11));
EXPORT InValidMessageFT_invalid_pigzip(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789 '),SALT35.HygieneErrors.NotLength('0,5,9,11'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"%'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,./#*\'\\|_"%',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_invalid_wordbag(s3);
END;
EXPORT InValidFT_invalid_name(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"%'))),~Scrubs_DL_OH.Functions.fn_valid_name(s,fname,mname)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,./#*\'\\|_"%'),SALT35.HygieneErrors.CustomFail('Scrubs_DL_OH.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','dbkoln','pinss4','dvnlic','dvccls','dvctyp','pifdon','pichcl','picecl','piqwgt','pinhft','pinhin','picsex','dvddoi','dvc2pl','dvdexp','drnagy','dvfocd','dvfopd','dvnapp','dvcatt','dvdnov','dvcded','dvcgrs','dvfdup','dvcgen','dvflsd','dvqdup','dvfohr','dbkmtk','dvfrcs','dvnwbi','sycpgm','sytda1','sycuid','dvffrd','dvctsa','dvdtsa','dvdtex','dvcsce','dvdmce','filler','pimnam','pigstr','pigcty','pigsta','pigzip','pincnt','pidd01','piddod','pidaup','crlf','title','fname','mname','lname','name_suffix','cleaning_score','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'process_date' => 0,'dbkoln' => 1,'pinss4' => 2,'dvnlic' => 3,'dvccls' => 4,'dvctyp' => 5,'pifdon' => 6,'pichcl' => 7,'picecl' => 8,'piqwgt' => 9,'pinhft' => 10,'pinhin' => 11,'picsex' => 12,'dvddoi' => 13,'dvc2pl' => 14,'dvdexp' => 15,'drnagy' => 16,'dvfocd' => 17,'dvfopd' => 18,'dvnapp' => 19,'dvcatt' => 20,'dvdnov' => 21,'dvcded' => 22,'dvcgrs' => 23,'dvfdup' => 24,'dvcgen' => 25,'dvflsd' => 26,'dvqdup' => 27,'dvfohr' => 28,'dbkmtk' => 29,'dvfrcs' => 30,'dvnwbi' => 31,'sycpgm' => 32,'sytda1' => 33,'sycuid' => 34,'dvffrd' => 35,'dvctsa' => 36,'dvdtsa' => 37,'dvdtex' => 38,'dvcsce' => 39,'dvdmce' => 40,'filler' => 41,'pimnam' => 42,'pigstr' => 43,'pigcty' => 44,'pigsta' => 45,'pigzip' => 46,'pincnt' => 47,'pidd01' => 48,'piddod' => 49,'pidaup' => 50,'crlf' => 51,'title' => 52,'fname' => 53,'mname' => 54,'lname' => 55,'name_suffix' => 56,'cleaning_score' => 57,'prim_range' => 58,'predir' => 59,'prim_name' => 60,'suffix' => 61,'postdir' => 62,'unit_desig' => 63,'sec_range' => 64,'p_city_name' => 65,'v_city_name' => 66,'state' => 67,'zip' => 68,'zip4' => 69,'cart' => 70,'cr_sort_sz' => 71,'lot' => 72,'lot_order' => 73,'dbpc' => 74,'chk_digit' => 75,'rec_type' => 76,'ace_fips_st' => 77,'county' => 78,'geo_lat' => 79,'geo_long' => 80,'msa' => 81,'geo_blk' => 82,'geo_match' => 83,'err_stat' => 84,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_dbkoln(SALT35.StrType s0) := MakeFT_invalid_dbkoln(s0);
EXPORT InValid_dbkoln(SALT35.StrType s) := InValidFT_invalid_dbkoln(s);
EXPORT InValidMessage_dbkoln(UNSIGNED1 wh) := InValidMessageFT_invalid_dbkoln(wh);
 
EXPORT Make_pinss4(SALT35.StrType s0) := MakeFT_invalid_pinss4(s0);
EXPORT InValid_pinss4(SALT35.StrType s) := InValidFT_invalid_pinss4(s);
EXPORT InValidMessage_pinss4(UNSIGNED1 wh) := InValidMessageFT_invalid_pinss4(wh);
 
EXPORT Make_dvnlic(SALT35.StrType s0) := MakeFT_invalid_dvnlic(s0);
EXPORT InValid_dvnlic(SALT35.StrType s) := InValidFT_invalid_dvnlic(s);
EXPORT InValidMessage_dvnlic(UNSIGNED1 wh) := InValidMessageFT_invalid_dvnlic(wh);
 
EXPORT Make_dvccls(SALT35.StrType s0) := MakeFT_invalid_dvccls(s0);
EXPORT InValid_dvccls(SALT35.StrType s) := InValidFT_invalid_dvccls(s);
EXPORT InValidMessage_dvccls(UNSIGNED1 wh) := InValidMessageFT_invalid_dvccls(wh);
 
EXPORT Make_dvctyp(SALT35.StrType s0) := MakeFT_invalid_dvctyp(s0);
EXPORT InValid_dvctyp(SALT35.StrType s) := InValidFT_invalid_dvctyp(s);
EXPORT InValidMessage_dvctyp(UNSIGNED1 wh) := InValidMessageFT_invalid_dvctyp(wh);
 
EXPORT Make_pifdon(SALT35.StrType s0) := MakeFT_invalid_pifdon(s0);
EXPORT InValid_pifdon(SALT35.StrType s) := InValidFT_invalid_pifdon(s);
EXPORT InValidMessage_pifdon(UNSIGNED1 wh) := InValidMessageFT_invalid_pifdon(wh);
 
EXPORT Make_pichcl(SALT35.StrType s0) := MakeFT_invalid_pichcl(s0);
EXPORT InValid_pichcl(SALT35.StrType s) := InValidFT_invalid_pichcl(s);
EXPORT InValidMessage_pichcl(UNSIGNED1 wh) := InValidMessageFT_invalid_pichcl(wh);
 
EXPORT Make_picecl(SALT35.StrType s0) := MakeFT_invalid_picecl(s0);
EXPORT InValid_picecl(SALT35.StrType s) := InValidFT_invalid_picecl(s);
EXPORT InValidMessage_picecl(UNSIGNED1 wh) := InValidMessageFT_invalid_picecl(wh);
 
EXPORT Make_piqwgt(SALT35.StrType s0) := MakeFT_invalid_piqwgt(s0);
EXPORT InValid_piqwgt(SALT35.StrType s) := InValidFT_invalid_piqwgt(s);
EXPORT InValidMessage_piqwgt(UNSIGNED1 wh) := InValidMessageFT_invalid_piqwgt(wh);
 
EXPORT Make_pinhft(SALT35.StrType s0) := MakeFT_invalid_height(s0);
EXPORT InValid_pinhft(SALT35.StrType s,SALT35.StrType pinhin) := InValidFT_invalid_height(s,pinhin);
EXPORT InValidMessage_pinhft(UNSIGNED1 wh) := InValidMessageFT_invalid_height(wh);
 
EXPORT Make_pinhin(SALT35.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_pinhin(SALT35.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_pinhin(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_picsex(SALT35.StrType s0) := MakeFT_invalid_picsex(s0);
EXPORT InValid_picsex(SALT35.StrType s) := InValidFT_invalid_picsex(s);
EXPORT InValidMessage_picsex(UNSIGNED1 wh) := InValidMessageFT_invalid_picsex(wh);
 
EXPORT Make_dvddoi(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_dvddoi(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_dvddoi(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_dvc2pl(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvc2pl(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvc2pl(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dvdexp(SALT35.StrType s0) := MakeFT_invalid_8generaldate(s0);
EXPORT InValid_dvdexp(SALT35.StrType s) := InValidFT_invalid_8generaldate(s);
EXPORT InValidMessage_dvdexp(UNSIGNED1 wh) := InValidMessageFT_invalid_8generaldate(wh);
 
EXPORT Make_drnagy(SALT35.StrType s0) := MakeFT_invalid_drnagy(s0);
EXPORT InValid_drnagy(SALT35.StrType s) := InValidFT_invalid_drnagy(s);
EXPORT InValidMessage_drnagy(UNSIGNED1 wh) := InValidMessageFT_invalid_drnagy(wh);
 
EXPORT Make_dvfocd(SALT35.StrType s0) := MakeFT_invalid_dvfocd(s0);
EXPORT InValid_dvfocd(SALT35.StrType s) := InValidFT_invalid_dvfocd(s);
EXPORT InValidMessage_dvfocd(UNSIGNED1 wh) := InValidMessageFT_invalid_dvfocd(wh);
 
EXPORT Make_dvfopd(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvfopd(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvfopd(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dvnapp(SALT35.StrType s0) := MakeFT_invalid_dvnlic(s0);
EXPORT InValid_dvnapp(SALT35.StrType s) := InValidFT_invalid_dvnlic(s);
EXPORT InValidMessage_dvnapp(UNSIGNED1 wh) := InValidMessageFT_invalid_dvnlic(wh);
 
EXPORT Make_dvcatt(SALT35.StrType s0) := MakeFT_invalid_dvcatt(s0);
EXPORT InValid_dvcatt(SALT35.StrType s) := InValidFT_invalid_dvcatt(s);
EXPORT InValidMessage_dvcatt(UNSIGNED1 wh) := InValidMessageFT_invalid_dvcatt(wh);
 
EXPORT Make_dvdnov(SALT35.StrType s0) := MakeFT_invalid_08generaldate(s0);
EXPORT InValid_dvdnov(SALT35.StrType s) := InValidFT_invalid_08generaldate(s);
EXPORT InValidMessage_dvdnov(UNSIGNED1 wh) := InValidMessageFT_invalid_08generaldate(wh);
 
EXPORT Make_dvcded(SALT35.StrType s0) := MakeFT_invalid_dvcded(s0);
EXPORT InValid_dvcded(SALT35.StrType s) := InValidFT_invalid_dvcded(s);
EXPORT InValidMessage_dvcded(UNSIGNED1 wh) := InValidMessageFT_invalid_dvcded(wh);
 
EXPORT Make_dvcgrs(SALT35.StrType s0) := MakeFT_invalid_alpha_num(s0);
EXPORT InValid_dvcgrs(SALT35.StrType s) := InValidFT_invalid_alpha_num(s);
EXPORT InValidMessage_dvcgrs(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num(wh);
 
EXPORT Make_dvfdup(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvfdup(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvfdup(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dvcgen(SALT35.StrType s0) := MakeFT_invalid_dvcgen(s0);
EXPORT InValid_dvcgen(SALT35.StrType s) := InValidFT_invalid_dvcgen(s);
EXPORT InValidMessage_dvcgen(UNSIGNED1 wh) := InValidMessageFT_invalid_dvcgen(wh);
 
EXPORT Make_dvflsd(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvflsd(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvflsd(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dvqdup(SALT35.StrType s0) := MakeFT_invalid_dvqdup(s0);
EXPORT InValid_dvqdup(SALT35.StrType s) := InValidFT_invalid_dvqdup(s);
EXPORT InValidMessage_dvqdup(UNSIGNED1 wh) := InValidMessageFT_invalid_dvqdup(wh);
 
EXPORT Make_dvfohr(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvfohr(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvfohr(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dbkmtk(SALT35.StrType s0) := MakeFT_invalid_dbkmtk(s0);
EXPORT InValid_dbkmtk(SALT35.StrType s) := InValidFT_invalid_dbkmtk(s);
EXPORT InValidMessage_dbkmtk(UNSIGNED1 wh) := InValidMessageFT_invalid_dbkmtk(wh);
 
EXPORT Make_dvfrcs(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvfrcs(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvfrcs(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dvnwbi(SALT35.StrType s0) := MakeFT_invalid_dvnwbi(s0);
EXPORT InValid_dvnwbi(SALT35.StrType s) := InValidFT_invalid_dvnwbi(s);
EXPORT InValidMessage_dvnwbi(UNSIGNED1 wh) := InValidMessageFT_invalid_dvnwbi(wh);
 
EXPORT Make_sycpgm(SALT35.StrType s0) := MakeFT_invalid_sycpgm(s0);
EXPORT InValid_sycpgm(SALT35.StrType s) := InValidFT_invalid_sycpgm(s);
EXPORT InValidMessage_sycpgm(UNSIGNED1 wh) := InValidMessageFT_invalid_sycpgm(wh);
 
EXPORT Make_sytda1(SALT35.StrType s0) := MakeFT_invalid_sytda1(s0);
EXPORT InValid_sytda1(SALT35.StrType s) := InValidFT_invalid_sytda1(s);
EXPORT InValidMessage_sytda1(UNSIGNED1 wh) := InValidMessageFT_invalid_sytda1(wh);
 
EXPORT Make_sycuid(SALT35.StrType s0) := MakeFT_invalid_alpha_num(s0);
EXPORT InValid_sycuid(SALT35.StrType s) := InValidFT_invalid_alpha_num(s);
EXPORT InValidMessage_sycuid(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num(wh);
 
EXPORT Make_dvffrd(SALT35.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_dvffrd(SALT35.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_dvffrd(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_dvctsa(SALT35.StrType s0) := MakeFT_invalid_dvctsa(s0);
EXPORT InValid_dvctsa(SALT35.StrType s) := InValidFT_invalid_dvctsa(s);
EXPORT InValidMessage_dvctsa(UNSIGNED1 wh) := InValidMessageFT_invalid_dvctsa(wh);
 
EXPORT Make_dvdtsa(SALT35.StrType s0) := s0;
EXPORT InValid_dvdtsa(SALT35.StrType s) := 0;
EXPORT InValidMessage_dvdtsa(UNSIGNED1 wh) := '';
 
EXPORT Make_dvdtex(SALT35.StrType s0) := s0;
EXPORT InValid_dvdtex(SALT35.StrType s) := 0;
EXPORT InValidMessage_dvdtex(UNSIGNED1 wh) := '';
 
EXPORT Make_dvcsce(SALT35.StrType s0) := MakeFT_invalid_dvcsce(s0);
EXPORT InValid_dvcsce(SALT35.StrType s) := InValidFT_invalid_dvcsce(s);
EXPORT InValidMessage_dvcsce(UNSIGNED1 wh) := InValidMessageFT_invalid_dvcsce(wh);
 
EXPORT Make_dvdmce(SALT35.StrType s0) := MakeFT_invalid_dvdmce(s0);
EXPORT InValid_dvdmce(SALT35.StrType s) := InValidFT_invalid_dvdmce(s);
EXPORT InValidMessage_dvdmce(UNSIGNED1 wh) := InValidMessageFT_invalid_dvdmce(wh);
 
EXPORT Make_filler(SALT35.StrType s0) := s0;
EXPORT InValid_filler(SALT35.StrType s) := 0;
EXPORT InValidMessage_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_pimnam(SALT35.StrType s0) := s0;
EXPORT InValid_pimnam(SALT35.StrType s) := 0;
EXPORT InValidMessage_pimnam(UNSIGNED1 wh) := '';
 
EXPORT Make_pigstr(SALT35.StrType s0) := s0;
EXPORT InValid_pigstr(SALT35.StrType s) := 0;
EXPORT InValidMessage_pigstr(UNSIGNED1 wh) := '';
 
EXPORT Make_pigcty(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_pigcty(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_pigcty(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_pigsta(SALT35.StrType s0) := MakeFT_invalid_pigsta(s0);
EXPORT InValid_pigsta(SALT35.StrType s) := InValidFT_invalid_pigsta(s);
EXPORT InValidMessage_pigsta(UNSIGNED1 wh) := InValidMessageFT_invalid_pigsta(wh);
 
EXPORT Make_pigzip(SALT35.StrType s0) := MakeFT_invalid_pigzip(s0);
EXPORT InValid_pigzip(SALT35.StrType s) := InValidFT_invalid_pigzip(s);
EXPORT InValidMessage_pigzip(UNSIGNED1 wh) := InValidMessageFT_invalid_pigzip(wh);
 
EXPORT Make_pincnt(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_pincnt(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_pincnt(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_pidd01(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_pidd01(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_pidd01(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_piddod(SALT35.StrType s0) := MakeFT_invalid_08pastdate(s0);
EXPORT InValid_piddod(SALT35.StrType s) := InValidFT_invalid_08pastdate(s);
EXPORT InValidMessage_piddod(UNSIGNED1 wh) := InValidMessageFT_invalid_08pastdate(wh);
 
EXPORT Make_pidaup(SALT35.StrType s0) := MakeFT_invalid_08pastdate(s0);
EXPORT InValid_pidaup(SALT35.StrType s) := InValidFT_invalid_08pastdate(s);
EXPORT InValidMessage_pidaup(UNSIGNED1 wh) := InValidMessageFT_invalid_08pastdate(wh);
 
EXPORT Make_crlf(SALT35.StrType s0) := s0;
EXPORT InValid_crlf(SALT35.StrType s) := 0;
EXPORT InValidMessage_crlf(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT35.StrType s0) := s0;
EXPORT InValid_title(SALT35.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT35.StrType s0) := s0;
EXPORT InValid_fname(SALT35.StrType s) := 0;
EXPORT InValidMessage_fname(UNSIGNED1 wh) := '';
 
EXPORT Make_mname(SALT35.StrType s0) := s0;
EXPORT InValid_mname(SALT35.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT35.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_lname(SALT35.StrType s,SALT35.StrType fname,SALT35.StrType mname) := InValidFT_invalid_name(s,fname,mname);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_name_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaning_score(SALT35.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_cleaning_score(SALT35.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_cleaning_score(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT35.StrType s0) := s0;
EXPORT InValid_predir(SALT35.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT35.StrType s0) := s0;
EXPORT InValid_postdir(SALT35.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_state(SALT35.StrType s0) := s0;
EXPORT InValid_state(SALT35.StrType s) := 0;
EXPORT InValidMessage_state(UNSIGNED1 wh) := '';
 
EXPORT Make_zip(SALT35.StrType s0) := s0;
EXPORT InValid_zip(SALT35.StrType s) := 0;
EXPORT InValidMessage_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT35.StrType s0) := s0;
EXPORT InValid_zip4(SALT35.StrType s) := 0;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT35.StrType s0) := s0;
EXPORT InValid_cart(SALT35.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT35.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT35.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT35.StrType s0) := s0;
EXPORT InValid_lot(SALT35.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT35.StrType s0) := s0;
EXPORT InValid_lot_order(SALT35.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dbpc(SALT35.StrType s0) := s0;
EXPORT InValid_dbpc(SALT35.StrType s) := 0;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT35.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT35.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT35.StrType s0) := s0;
EXPORT InValid_rec_type(SALT35.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT35.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT35.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT35.StrType s0) := s0;
EXPORT InValid_county(SALT35.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT35.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT35.StrType s0) := s0;
EXPORT InValid_geo_long(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT35.StrType s0) := s0;
EXPORT InValid_msa(SALT35.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT35.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT35.StrType s0) := s0;
EXPORT InValid_geo_match(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT35.StrType s0) := s0;
EXPORT InValid_err_stat(SALT35.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,Scrubs_DL_OH;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_dbkoln;
    BOOLEAN Diff_pinss4;
    BOOLEAN Diff_dvnlic;
    BOOLEAN Diff_dvccls;
    BOOLEAN Diff_dvctyp;
    BOOLEAN Diff_pifdon;
    BOOLEAN Diff_pichcl;
    BOOLEAN Diff_picecl;
    BOOLEAN Diff_piqwgt;
    BOOLEAN Diff_pinhft;
    BOOLEAN Diff_pinhin;
    BOOLEAN Diff_picsex;
    BOOLEAN Diff_dvddoi;
    BOOLEAN Diff_dvc2pl;
    BOOLEAN Diff_dvdexp;
    BOOLEAN Diff_drnagy;
    BOOLEAN Diff_dvfocd;
    BOOLEAN Diff_dvfopd;
    BOOLEAN Diff_dvnapp;
    BOOLEAN Diff_dvcatt;
    BOOLEAN Diff_dvdnov;
    BOOLEAN Diff_dvcded;
    BOOLEAN Diff_dvcgrs;
    BOOLEAN Diff_dvfdup;
    BOOLEAN Diff_dvcgen;
    BOOLEAN Diff_dvflsd;
    BOOLEAN Diff_dvqdup;
    BOOLEAN Diff_dvfohr;
    BOOLEAN Diff_dbkmtk;
    BOOLEAN Diff_dvfrcs;
    BOOLEAN Diff_dvnwbi;
    BOOLEAN Diff_sycpgm;
    BOOLEAN Diff_sytda1;
    BOOLEAN Diff_sycuid;
    BOOLEAN Diff_dvffrd;
    BOOLEAN Diff_dvctsa;
    BOOLEAN Diff_dvdtsa;
    BOOLEAN Diff_dvdtex;
    BOOLEAN Diff_dvcsce;
    BOOLEAN Diff_dvdmce;
    BOOLEAN Diff_filler;
    BOOLEAN Diff_pimnam;
    BOOLEAN Diff_pigstr;
    BOOLEAN Diff_pigcty;
    BOOLEAN Diff_pigsta;
    BOOLEAN Diff_pigzip;
    BOOLEAN Diff_pincnt;
    BOOLEAN Diff_pidd01;
    BOOLEAN Diff_piddod;
    BOOLEAN Diff_pidaup;
    BOOLEAN Diff_crlf;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cleaning_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_dbkoln := le.dbkoln <> ri.dbkoln;
    SELF.Diff_pinss4 := le.pinss4 <> ri.pinss4;
    SELF.Diff_dvnlic := le.dvnlic <> ri.dvnlic;
    SELF.Diff_dvccls := le.dvccls <> ri.dvccls;
    SELF.Diff_dvctyp := le.dvctyp <> ri.dvctyp;
    SELF.Diff_pifdon := le.pifdon <> ri.pifdon;
    SELF.Diff_pichcl := le.pichcl <> ri.pichcl;
    SELF.Diff_picecl := le.picecl <> ri.picecl;
    SELF.Diff_piqwgt := le.piqwgt <> ri.piqwgt;
    SELF.Diff_pinhft := le.pinhft <> ri.pinhft;
    SELF.Diff_pinhin := le.pinhin <> ri.pinhin;
    SELF.Diff_picsex := le.picsex <> ri.picsex;
    SELF.Diff_dvddoi := le.dvddoi <> ri.dvddoi;
    SELF.Diff_dvc2pl := le.dvc2pl <> ri.dvc2pl;
    SELF.Diff_dvdexp := le.dvdexp <> ri.dvdexp;
    SELF.Diff_drnagy := le.drnagy <> ri.drnagy;
    SELF.Diff_dvfocd := le.dvfocd <> ri.dvfocd;
    SELF.Diff_dvfopd := le.dvfopd <> ri.dvfopd;
    SELF.Diff_dvnapp := le.dvnapp <> ri.dvnapp;
    SELF.Diff_dvcatt := le.dvcatt <> ri.dvcatt;
    SELF.Diff_dvdnov := le.dvdnov <> ri.dvdnov;
    SELF.Diff_dvcded := le.dvcded <> ri.dvcded;
    SELF.Diff_dvcgrs := le.dvcgrs <> ri.dvcgrs;
    SELF.Diff_dvfdup := le.dvfdup <> ri.dvfdup;
    SELF.Diff_dvcgen := le.dvcgen <> ri.dvcgen;
    SELF.Diff_dvflsd := le.dvflsd <> ri.dvflsd;
    SELF.Diff_dvqdup := le.dvqdup <> ri.dvqdup;
    SELF.Diff_dvfohr := le.dvfohr <> ri.dvfohr;
    SELF.Diff_dbkmtk := le.dbkmtk <> ri.dbkmtk;
    SELF.Diff_dvfrcs := le.dvfrcs <> ri.dvfrcs;
    SELF.Diff_dvnwbi := le.dvnwbi <> ri.dvnwbi;
    SELF.Diff_sycpgm := le.sycpgm <> ri.sycpgm;
    SELF.Diff_sytda1 := le.sytda1 <> ri.sytda1;
    SELF.Diff_sycuid := le.sycuid <> ri.sycuid;
    SELF.Diff_dvffrd := le.dvffrd <> ri.dvffrd;
    SELF.Diff_dvctsa := le.dvctsa <> ri.dvctsa;
    SELF.Diff_dvdtsa := le.dvdtsa <> ri.dvdtsa;
    SELF.Diff_dvdtex := le.dvdtex <> ri.dvdtex;
    SELF.Diff_dvcsce := le.dvcsce <> ri.dvcsce;
    SELF.Diff_dvdmce := le.dvdmce <> ri.dvdmce;
    SELF.Diff_filler := le.filler <> ri.filler;
    SELF.Diff_pimnam := le.pimnam <> ri.pimnam;
    SELF.Diff_pigstr := le.pigstr <> ri.pigstr;
    SELF.Diff_pigcty := le.pigcty <> ri.pigcty;
    SELF.Diff_pigsta := le.pigsta <> ri.pigsta;
    SELF.Diff_pigzip := le.pigzip <> ri.pigzip;
    SELF.Diff_pincnt := le.pincnt <> ri.pincnt;
    SELF.Diff_pidd01 := le.pidd01 <> ri.pidd01;
    SELF.Diff_piddod := le.piddod <> ri.piddod;
    SELF.Diff_pidaup := le.pidaup <> ri.pidaup;
    SELF.Diff_crlf := le.crlf <> ri.crlf;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cleaning_score := le.cleaning_score <> ri.cleaning_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_dbkoln,1,0)+ IF( SELF.Diff_pinss4,1,0)+ IF( SELF.Diff_dvnlic,1,0)+ IF( SELF.Diff_dvccls,1,0)+ IF( SELF.Diff_dvctyp,1,0)+ IF( SELF.Diff_pifdon,1,0)+ IF( SELF.Diff_pichcl,1,0)+ IF( SELF.Diff_picecl,1,0)+ IF( SELF.Diff_piqwgt,1,0)+ IF( SELF.Diff_pinhft,1,0)+ IF( SELF.Diff_pinhin,1,0)+ IF( SELF.Diff_picsex,1,0)+ IF( SELF.Diff_dvddoi,1,0)+ IF( SELF.Diff_dvc2pl,1,0)+ IF( SELF.Diff_dvdexp,1,0)+ IF( SELF.Diff_drnagy,1,0)+ IF( SELF.Diff_dvfocd,1,0)+ IF( SELF.Diff_dvfopd,1,0)+ IF( SELF.Diff_dvnapp,1,0)+ IF( SELF.Diff_dvcatt,1,0)+ IF( SELF.Diff_dvdnov,1,0)+ IF( SELF.Diff_dvcded,1,0)+ IF( SELF.Diff_dvcgrs,1,0)+ IF( SELF.Diff_dvfdup,1,0)+ IF( SELF.Diff_dvcgen,1,0)+ IF( SELF.Diff_dvflsd,1,0)+ IF( SELF.Diff_dvqdup,1,0)+ IF( SELF.Diff_dvfohr,1,0)+ IF( SELF.Diff_dbkmtk,1,0)+ IF( SELF.Diff_dvfrcs,1,0)+ IF( SELF.Diff_dvnwbi,1,0)+ IF( SELF.Diff_sycpgm,1,0)+ IF( SELF.Diff_sytda1,1,0)+ IF( SELF.Diff_sycuid,1,0)+ IF( SELF.Diff_dvffrd,1,0)+ IF( SELF.Diff_dvctsa,1,0)+ IF( SELF.Diff_dvdtsa,1,0)+ IF( SELF.Diff_dvdtex,1,0)+ IF( SELF.Diff_dvcsce,1,0)+ IF( SELF.Diff_dvdmce,1,0)+ IF( SELF.Diff_filler,1,0)+ IF( SELF.Diff_pimnam,1,0)+ IF( SELF.Diff_pigstr,1,0)+ IF( SELF.Diff_pigcty,1,0)+ IF( SELF.Diff_pigsta,1,0)+ IF( SELF.Diff_pigzip,1,0)+ IF( SELF.Diff_pincnt,1,0)+ IF( SELF.Diff_pidd01,1,0)+ IF( SELF.Diff_piddod,1,0)+ IF( SELF.Diff_pidaup,1,0)+ IF( SELF.Diff_crlf,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cleaning_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_dbkoln := COUNT(GROUP,%Closest%.Diff_dbkoln);
    Count_Diff_pinss4 := COUNT(GROUP,%Closest%.Diff_pinss4);
    Count_Diff_dvnlic := COUNT(GROUP,%Closest%.Diff_dvnlic);
    Count_Diff_dvccls := COUNT(GROUP,%Closest%.Diff_dvccls);
    Count_Diff_dvctyp := COUNT(GROUP,%Closest%.Diff_dvctyp);
    Count_Diff_pifdon := COUNT(GROUP,%Closest%.Diff_pifdon);
    Count_Diff_pichcl := COUNT(GROUP,%Closest%.Diff_pichcl);
    Count_Diff_picecl := COUNT(GROUP,%Closest%.Diff_picecl);
    Count_Diff_piqwgt := COUNT(GROUP,%Closest%.Diff_piqwgt);
    Count_Diff_pinhft := COUNT(GROUP,%Closest%.Diff_pinhft);
    Count_Diff_pinhin := COUNT(GROUP,%Closest%.Diff_pinhin);
    Count_Diff_picsex := COUNT(GROUP,%Closest%.Diff_picsex);
    Count_Diff_dvddoi := COUNT(GROUP,%Closest%.Diff_dvddoi);
    Count_Diff_dvc2pl := COUNT(GROUP,%Closest%.Diff_dvc2pl);
    Count_Diff_dvdexp := COUNT(GROUP,%Closest%.Diff_dvdexp);
    Count_Diff_drnagy := COUNT(GROUP,%Closest%.Diff_drnagy);
    Count_Diff_dvfocd := COUNT(GROUP,%Closest%.Diff_dvfocd);
    Count_Diff_dvfopd := COUNT(GROUP,%Closest%.Diff_dvfopd);
    Count_Diff_dvnapp := COUNT(GROUP,%Closest%.Diff_dvnapp);
    Count_Diff_dvcatt := COUNT(GROUP,%Closest%.Diff_dvcatt);
    Count_Diff_dvdnov := COUNT(GROUP,%Closest%.Diff_dvdnov);
    Count_Diff_dvcded := COUNT(GROUP,%Closest%.Diff_dvcded);
    Count_Diff_dvcgrs := COUNT(GROUP,%Closest%.Diff_dvcgrs);
    Count_Diff_dvfdup := COUNT(GROUP,%Closest%.Diff_dvfdup);
    Count_Diff_dvcgen := COUNT(GROUP,%Closest%.Diff_dvcgen);
    Count_Diff_dvflsd := COUNT(GROUP,%Closest%.Diff_dvflsd);
    Count_Diff_dvqdup := COUNT(GROUP,%Closest%.Diff_dvqdup);
    Count_Diff_dvfohr := COUNT(GROUP,%Closest%.Diff_dvfohr);
    Count_Diff_dbkmtk := COUNT(GROUP,%Closest%.Diff_dbkmtk);
    Count_Diff_dvfrcs := COUNT(GROUP,%Closest%.Diff_dvfrcs);
    Count_Diff_dvnwbi := COUNT(GROUP,%Closest%.Diff_dvnwbi);
    Count_Diff_sycpgm := COUNT(GROUP,%Closest%.Diff_sycpgm);
    Count_Diff_sytda1 := COUNT(GROUP,%Closest%.Diff_sytda1);
    Count_Diff_sycuid := COUNT(GROUP,%Closest%.Diff_sycuid);
    Count_Diff_dvffrd := COUNT(GROUP,%Closest%.Diff_dvffrd);
    Count_Diff_dvctsa := COUNT(GROUP,%Closest%.Diff_dvctsa);
    Count_Diff_dvdtsa := COUNT(GROUP,%Closest%.Diff_dvdtsa);
    Count_Diff_dvdtex := COUNT(GROUP,%Closest%.Diff_dvdtex);
    Count_Diff_dvcsce := COUNT(GROUP,%Closest%.Diff_dvcsce);
    Count_Diff_dvdmce := COUNT(GROUP,%Closest%.Diff_dvdmce);
    Count_Diff_filler := COUNT(GROUP,%Closest%.Diff_filler);
    Count_Diff_pimnam := COUNT(GROUP,%Closest%.Diff_pimnam);
    Count_Diff_pigstr := COUNT(GROUP,%Closest%.Diff_pigstr);
    Count_Diff_pigcty := COUNT(GROUP,%Closest%.Diff_pigcty);
    Count_Diff_pigsta := COUNT(GROUP,%Closest%.Diff_pigsta);
    Count_Diff_pigzip := COUNT(GROUP,%Closest%.Diff_pigzip);
    Count_Diff_pincnt := COUNT(GROUP,%Closest%.Diff_pincnt);
    Count_Diff_pidd01 := COUNT(GROUP,%Closest%.Diff_pidd01);
    Count_Diff_piddod := COUNT(GROUP,%Closest%.Diff_piddod);
    Count_Diff_pidaup := COUNT(GROUP,%Closest%.Diff_pidaup);
    Count_Diff_crlf := COUNT(GROUP,%Closest%.Diff_crlf);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cleaning_score := COUNT(GROUP,%Closest%.Diff_cleaning_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
