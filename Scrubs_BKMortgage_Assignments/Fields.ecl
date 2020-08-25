IMPORT SALT311;
EXPORT Fields := MODULE
 
EXPORT NumFields := 62;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_number','invalid_alpha','invalid_AlphaNum','invalid_apn','invalid_zip','invalid_date','invalid_mers','invalid_state','invalid_name','Invalid_RecType','Invalid_DocType');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_number' => 1,'invalid_alpha' => 2,'invalid_AlphaNum' => 3,'invalid_apn' => 4,'invalid_zip' => 5,'invalid_date' => 6,'invalid_mers' => 7,'invalid_state' => 8,'invalid_name' => 9,'Invalid_RecType' => 10,'Invalid_DocType' => 11,0);
 
EXPORT MakeFT_invalid_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,()#.;/'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,()#.;/',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,()#.;/'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' <>{}[]-^=!+&,()#.;/'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -#./&,:'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -#./&,:',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -#./&,:'))));
EXPORT InValidMessageFT_invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' -#./&,:'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apn(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:()#*_+/&'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' -,;.:()#*_+/&',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_apn(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:()#*_+/&'))));
EXPORT InValidMessageFT_invalid_apn(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 -,;.:()#*_+/&'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 _-'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' _-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_zip(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 _-'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 _-'),SALT311.HygieneErrors.NotLength('0,4,5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,4,8,10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mers(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' .-',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_mers(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-'))));
EXPORT InValidMessageFT_invalid_mers(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\''),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' _-&,.():\'`$#+;"\\/*@%!|'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' _-&,.():\'`$#+;"\\/*@%!|',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' _-&,.():\'`$#+;"\\/*@%!|'))));
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\' _-&,.():\'`$#+;"\\/*@%!|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_RecType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_RecType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Z','M','P','']);
EXPORT InValidMessageFT_Invalid_RecType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Z|M|P|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_DocType(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_DocType(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['AM','MS','ML','AL','SZ','CR','MA','RR','PP','SO','']);
EXPORT InValidMessageFT_Invalid_DocType(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('AM|MS|ML|AL|SZ|CR|MA|RR|PP|SO|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ln_filedate','bk_infile_type','rectype','documenttype','fipscode','mersindicator','mainaddendum','assigrecdate','assigeffecdate','assigdoc','assigbk','assigpg','multiplepageimage','bkfsimageid','origdotrecdate','origdotcontractdate','origdotdoc','origdotbk','origdotpg','origlenderben','origloanamnt','assignorname','loannumber','assignee','mers','mersvalidation','assigneepool','mspsvcrloan','borrowername','apn','multiapncode','taxacctid','propertyfulladd','propertyunit','propertycity','propertystate','propertyzip','propertyzip4','dataentrydate','dataentryopercode','vendorsourcecode','hids_recordingflag','hids_docnumber','transfercertificateoftitle','hi_condo_cpr_hpr','hi_situs_unit_number','hids_previous_docnumber','prevtransfercertificateoftitle','pid','matchedororphan','deed_pid','sam_pid','assessorparcelnumber_matched','assessorpropertyfulladd','assessorpropertyunittype','assessorpropertyunit','assessorpropertycity','assessorpropertystate','assessorpropertyzip','assessorpropertyzip4','assessorpropertyaddrsource','raw_file_name');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ln_filedate','bk_infile_type','rectype','documenttype','fipscode','mersindicator','mainaddendum','assigrecdate','assigeffecdate','assigdoc','assigbk','assigpg','multiplepageimage','bkfsimageid','origdotrecdate','origdotcontractdate','origdotdoc','origdotbk','origdotpg','origlenderben','origloanamnt','assignorname','loannumber','assignee','mers','mersvalidation','assigneepool','mspsvcrloan','borrowername','apn','multiapncode','taxacctid','propertyfulladd','propertyunit','propertycity','propertystate','propertyzip','propertyzip4','dataentrydate','dataentryopercode','vendorsourcecode','hids_recordingflag','hids_docnumber','transfercertificateoftitle','hi_condo_cpr_hpr','hi_situs_unit_number','hids_previous_docnumber','prevtransfercertificateoftitle','pid','matchedororphan','deed_pid','sam_pid','assessorparcelnumber_matched','assessorpropertyfulladd','assessorpropertyunittype','assessorpropertyunit','assessorpropertycity','assessorpropertystate','assessorpropertyzip','assessorpropertyzip4','assessorpropertyaddrsource','raw_file_name');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ln_filedate' => 0,'bk_infile_type' => 1,'rectype' => 2,'documenttype' => 3,'fipscode' => 4,'mersindicator' => 5,'mainaddendum' => 6,'assigrecdate' => 7,'assigeffecdate' => 8,'assigdoc' => 9,'assigbk' => 10,'assigpg' => 11,'multiplepageimage' => 12,'bkfsimageid' => 13,'origdotrecdate' => 14,'origdotcontractdate' => 15,'origdotdoc' => 16,'origdotbk' => 17,'origdotpg' => 18,'origlenderben' => 19,'origloanamnt' => 20,'assignorname' => 21,'loannumber' => 22,'assignee' => 23,'mers' => 24,'mersvalidation' => 25,'assigneepool' => 26,'mspsvcrloan' => 27,'borrowername' => 28,'apn' => 29,'multiapncode' => 30,'taxacctid' => 31,'propertyfulladd' => 32,'propertyunit' => 33,'propertycity' => 34,'propertystate' => 35,'propertyzip' => 36,'propertyzip4' => 37,'dataentrydate' => 38,'dataentryopercode' => 39,'vendorsourcecode' => 40,'hids_recordingflag' => 41,'hids_docnumber' => 42,'transfercertificateoftitle' => 43,'hi_condo_cpr_hpr' => 44,'hi_situs_unit_number' => 45,'hids_previous_docnumber' => 46,'prevtransfercertificateoftitle' => 47,'pid' => 48,'matchedororphan' => 49,'deed_pid' => 50,'sam_pid' => 51,'assessorparcelnumber_matched' => 52,'assessorpropertyfulladd' => 53,'assessorpropertyunittype' => 54,'assessorpropertyunit' => 55,'assessorpropertycity' => 56,'assessorpropertystate' => 57,'assessorpropertyzip' => 58,'assessorpropertyzip4' => 59,'assessorpropertyaddrsource' => 60,'raw_file_name' => 61,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],[],['ENUM'],['ENUM'],['ALLOW'],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],['ALLOW'],[],['ALLOW'],[],['ALLOW'],['ALLOW'],[],[],[],['ALLOW'],['ALLOW'],[],[],['ALLOW'],[],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],[],[],[],[],[],[],[],[],[],[],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ln_filedate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_ln_filedate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_ln_filedate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_bk_infile_type(SALT311.StrType s0) := s0;
EXPORT InValid_bk_infile_type(SALT311.StrType s) := 0;
EXPORT InValidMessage_bk_infile_type(UNSIGNED1 wh) := '';
 
EXPORT Make_rectype(SALT311.StrType s0) := MakeFT_Invalid_RecType(s0);
EXPORT InValid_rectype(SALT311.StrType s) := InValidFT_Invalid_RecType(s);
EXPORT InValidMessage_rectype(UNSIGNED1 wh) := InValidMessageFT_Invalid_RecType(wh);
 
EXPORT Make_documenttype(SALT311.StrType s0) := MakeFT_Invalid_DocType(s0);
EXPORT InValid_documenttype(SALT311.StrType s) := InValidFT_Invalid_DocType(s);
EXPORT InValidMessage_documenttype(UNSIGNED1 wh) := InValidMessageFT_Invalid_DocType(wh);
 
EXPORT Make_fipscode(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_fipscode(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_fipscode(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_mersindicator(SALT311.StrType s0) := s0;
EXPORT InValid_mersindicator(SALT311.StrType s) := 0;
EXPORT InValidMessage_mersindicator(UNSIGNED1 wh) := '';
 
EXPORT Make_mainaddendum(SALT311.StrType s0) := s0;
EXPORT InValid_mainaddendum(SALT311.StrType s) := 0;
EXPORT InValidMessage_mainaddendum(UNSIGNED1 wh) := '';
 
EXPORT Make_assigrecdate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_assigrecdate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_assigrecdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_assigeffecdate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_assigeffecdate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_assigeffecdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_assigdoc(SALT311.StrType s0) := s0;
EXPORT InValid_assigdoc(SALT311.StrType s) := 0;
EXPORT InValidMessage_assigdoc(UNSIGNED1 wh) := '';
 
EXPORT Make_assigbk(SALT311.StrType s0) := s0;
EXPORT InValid_assigbk(SALT311.StrType s) := 0;
EXPORT InValidMessage_assigbk(UNSIGNED1 wh) := '';
 
EXPORT Make_assigpg(SALT311.StrType s0) := s0;
EXPORT InValid_assigpg(SALT311.StrType s) := 0;
EXPORT InValidMessage_assigpg(UNSIGNED1 wh) := '';
 
EXPORT Make_multiplepageimage(SALT311.StrType s0) := s0;
EXPORT InValid_multiplepageimage(SALT311.StrType s) := 0;
EXPORT InValidMessage_multiplepageimage(UNSIGNED1 wh) := '';
 
EXPORT Make_bkfsimageid(SALT311.StrType s0) := s0;
EXPORT InValid_bkfsimageid(SALT311.StrType s) := 0;
EXPORT InValidMessage_bkfsimageid(UNSIGNED1 wh) := '';
 
EXPORT Make_origdotrecdate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_origdotrecdate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_origdotrecdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_origdotcontractdate(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_origdotcontractdate(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_origdotcontractdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_origdotdoc(SALT311.StrType s0) := s0;
EXPORT InValid_origdotdoc(SALT311.StrType s) := 0;
EXPORT InValidMessage_origdotdoc(UNSIGNED1 wh) := '';
 
EXPORT Make_origdotbk(SALT311.StrType s0) := s0;
EXPORT InValid_origdotbk(SALT311.StrType s) := 0;
EXPORT InValidMessage_origdotbk(UNSIGNED1 wh) := '';
 
EXPORT Make_origdotpg(SALT311.StrType s0) := s0;
EXPORT InValid_origdotpg(SALT311.StrType s) := 0;
EXPORT InValidMessage_origdotpg(UNSIGNED1 wh) := '';
 
EXPORT Make_origlenderben(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_origlenderben(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_origlenderben(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_origloanamnt(SALT311.StrType s0) := s0;
EXPORT InValid_origloanamnt(SALT311.StrType s) := 0;
EXPORT InValidMessage_origloanamnt(UNSIGNED1 wh) := '';
 
EXPORT Make_assignorname(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_assignorname(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_assignorname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_loannumber(SALT311.StrType s0) := s0;
EXPORT InValid_loannumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_loannumber(UNSIGNED1 wh) := '';
 
EXPORT Make_assignee(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_assignee(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_assignee(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_mers(SALT311.StrType s0) := MakeFT_invalid_mers(s0);
EXPORT InValid_mers(SALT311.StrType s) := InValidFT_invalid_mers(s);
EXPORT InValidMessage_mers(UNSIGNED1 wh) := InValidMessageFT_invalid_mers(wh);
 
EXPORT Make_mersvalidation(SALT311.StrType s0) := s0;
EXPORT InValid_mersvalidation(SALT311.StrType s) := 0;
EXPORT InValidMessage_mersvalidation(UNSIGNED1 wh) := '';
 
EXPORT Make_assigneepool(SALT311.StrType s0) := s0;
EXPORT InValid_assigneepool(SALT311.StrType s) := 0;
EXPORT InValidMessage_assigneepool(UNSIGNED1 wh) := '';
 
EXPORT Make_mspsvcrloan(SALT311.StrType s0) := s0;
EXPORT InValid_mspsvcrloan(SALT311.StrType s) := 0;
EXPORT InValidMessage_mspsvcrloan(UNSIGNED1 wh) := '';
 
EXPORT Make_borrowername(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_borrowername(SALT311.StrType s) := InValidFT_invalid_name(s);
EXPORT InValidMessage_borrowername(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_apn(SALT311.StrType s0) := MakeFT_invalid_apn(s0);
EXPORT InValid_apn(SALT311.StrType s) := InValidFT_invalid_apn(s);
EXPORT InValidMessage_apn(UNSIGNED1 wh) := InValidMessageFT_invalid_apn(wh);
 
EXPORT Make_multiapncode(SALT311.StrType s0) := s0;
EXPORT InValid_multiapncode(SALT311.StrType s) := 0;
EXPORT InValidMessage_multiapncode(UNSIGNED1 wh) := '';
 
EXPORT Make_taxacctid(SALT311.StrType s0) := s0;
EXPORT InValid_taxacctid(SALT311.StrType s) := 0;
EXPORT InValidMessage_taxacctid(UNSIGNED1 wh) := '';
 
EXPORT Make_propertyfulladd(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_propertyfulladd(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_propertyfulladd(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_propertyunit(SALT311.StrType s0) := s0;
EXPORT InValid_propertyunit(SALT311.StrType s) := 0;
EXPORT InValidMessage_propertyunit(UNSIGNED1 wh) := '';
 
EXPORT Make_propertycity(SALT311.StrType s0) := MakeFT_invalid_AlphaNum(s0);
EXPORT InValid_propertycity(SALT311.StrType s) := InValidFT_invalid_AlphaNum(s);
EXPORT InValidMessage_propertycity(UNSIGNED1 wh) := InValidMessageFT_invalid_AlphaNum(wh);
 
EXPORT Make_propertystate(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_propertystate(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_propertystate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_propertyzip(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_propertyzip(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_propertyzip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_propertyzip4(SALT311.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_propertyzip4(SALT311.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_propertyzip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_dataentrydate(SALT311.StrType s0) := s0;
EXPORT InValid_dataentrydate(SALT311.StrType s) := 0;
EXPORT InValidMessage_dataentrydate(UNSIGNED1 wh) := '';
 
EXPORT Make_dataentryopercode(SALT311.StrType s0) := s0;
EXPORT InValid_dataentryopercode(SALT311.StrType s) := 0;
EXPORT InValidMessage_dataentryopercode(UNSIGNED1 wh) := '';
 
EXPORT Make_vendorsourcecode(SALT311.StrType s0) := s0;
EXPORT InValid_vendorsourcecode(SALT311.StrType s) := 0;
EXPORT InValidMessage_vendorsourcecode(UNSIGNED1 wh) := '';
 
EXPORT Make_hids_recordingflag(SALT311.StrType s0) := s0;
EXPORT InValid_hids_recordingflag(SALT311.StrType s) := 0;
EXPORT InValidMessage_hids_recordingflag(UNSIGNED1 wh) := '';
 
EXPORT Make_hids_docnumber(SALT311.StrType s0) := s0;
EXPORT InValid_hids_docnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_hids_docnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_transfercertificateoftitle(SALT311.StrType s0) := s0;
EXPORT InValid_transfercertificateoftitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_transfercertificateoftitle(UNSIGNED1 wh) := '';
 
EXPORT Make_hi_condo_cpr_hpr(SALT311.StrType s0) := s0;
EXPORT InValid_hi_condo_cpr_hpr(SALT311.StrType s) := 0;
EXPORT InValidMessage_hi_condo_cpr_hpr(UNSIGNED1 wh) := '';
 
EXPORT Make_hi_situs_unit_number(SALT311.StrType s0) := s0;
EXPORT InValid_hi_situs_unit_number(SALT311.StrType s) := 0;
EXPORT InValidMessage_hi_situs_unit_number(UNSIGNED1 wh) := '';
 
EXPORT Make_hids_previous_docnumber(SALT311.StrType s0) := s0;
EXPORT InValid_hids_previous_docnumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_hids_previous_docnumber(UNSIGNED1 wh) := '';
 
EXPORT Make_prevtransfercertificateoftitle(SALT311.StrType s0) := s0;
EXPORT InValid_prevtransfercertificateoftitle(SALT311.StrType s) := 0;
EXPORT InValidMessage_prevtransfercertificateoftitle(UNSIGNED1 wh) := '';
 
EXPORT Make_pid(SALT311.StrType s0) := MakeFT_invalid_number(s0);
EXPORT InValid_pid(SALT311.StrType s) := InValidFT_invalid_number(s);
EXPORT InValidMessage_pid(UNSIGNED1 wh) := InValidMessageFT_invalid_number(wh);
 
EXPORT Make_matchedororphan(SALT311.StrType s0) := s0;
EXPORT InValid_matchedororphan(SALT311.StrType s) := 0;
EXPORT InValidMessage_matchedororphan(UNSIGNED1 wh) := '';
 
EXPORT Make_deed_pid(SALT311.StrType s0) := s0;
EXPORT InValid_deed_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_deed_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_sam_pid(SALT311.StrType s0) := s0;
EXPORT InValid_sam_pid(SALT311.StrType s) := 0;
EXPORT InValidMessage_sam_pid(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorparcelnumber_matched(SALT311.StrType s0) := s0;
EXPORT InValid_assessorparcelnumber_matched(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorparcelnumber_matched(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertyfulladd(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertyfulladd(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertyfulladd(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertyunittype(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertyunittype(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertyunittype(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertyunit(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertyunit(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertyunit(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertycity(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertycity(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertycity(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertystate(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertystate(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertystate(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertyzip(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertyzip(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertyzip(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertyzip4(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertyzip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertyzip4(UNSIGNED1 wh) := '';
 
EXPORT Make_assessorpropertyaddrsource(SALT311.StrType s0) := s0;
EXPORT InValid_assessorpropertyaddrsource(SALT311.StrType s) := 0;
EXPORT InValidMessage_assessorpropertyaddrsource(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_file_name(SALT311.StrType s0) := s0;
EXPORT InValid_raw_file_name(SALT311.StrType s) := 0;
EXPORT InValidMessage_raw_file_name(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_BKMortgage_Assignments;
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
    BOOLEAN Diff_ln_filedate;
    BOOLEAN Diff_bk_infile_type;
    BOOLEAN Diff_rectype;
    BOOLEAN Diff_documenttype;
    BOOLEAN Diff_fipscode;
    BOOLEAN Diff_mersindicator;
    BOOLEAN Diff_mainaddendum;
    BOOLEAN Diff_assigrecdate;
    BOOLEAN Diff_assigeffecdate;
    BOOLEAN Diff_assigdoc;
    BOOLEAN Diff_assigbk;
    BOOLEAN Diff_assigpg;
    BOOLEAN Diff_multiplepageimage;
    BOOLEAN Diff_bkfsimageid;
    BOOLEAN Diff_origdotrecdate;
    BOOLEAN Diff_origdotcontractdate;
    BOOLEAN Diff_origdotdoc;
    BOOLEAN Diff_origdotbk;
    BOOLEAN Diff_origdotpg;
    BOOLEAN Diff_origlenderben;
    BOOLEAN Diff_origloanamnt;
    BOOLEAN Diff_assignorname;
    BOOLEAN Diff_loannumber;
    BOOLEAN Diff_assignee;
    BOOLEAN Diff_mers;
    BOOLEAN Diff_mersvalidation;
    BOOLEAN Diff_assigneepool;
    BOOLEAN Diff_mspsvcrloan;
    BOOLEAN Diff_borrowername;
    BOOLEAN Diff_apn;
    BOOLEAN Diff_multiapncode;
    BOOLEAN Diff_taxacctid;
    BOOLEAN Diff_propertyfulladd;
    BOOLEAN Diff_propertyunit;
    BOOLEAN Diff_propertycity;
    BOOLEAN Diff_propertystate;
    BOOLEAN Diff_propertyzip;
    BOOLEAN Diff_propertyzip4;
    BOOLEAN Diff_dataentrydate;
    BOOLEAN Diff_dataentryopercode;
    BOOLEAN Diff_vendorsourcecode;
    BOOLEAN Diff_hids_recordingflag;
    BOOLEAN Diff_hids_docnumber;
    BOOLEAN Diff_transfercertificateoftitle;
    BOOLEAN Diff_hi_condo_cpr_hpr;
    BOOLEAN Diff_hi_situs_unit_number;
    BOOLEAN Diff_hids_previous_docnumber;
    BOOLEAN Diff_prevtransfercertificateoftitle;
    BOOLEAN Diff_pid;
    BOOLEAN Diff_matchedororphan;
    BOOLEAN Diff_deed_pid;
    BOOLEAN Diff_sam_pid;
    BOOLEAN Diff_assessorparcelnumber_matched;
    BOOLEAN Diff_assessorpropertyfulladd;
    BOOLEAN Diff_assessorpropertyunittype;
    BOOLEAN Diff_assessorpropertyunit;
    BOOLEAN Diff_assessorpropertycity;
    BOOLEAN Diff_assessorpropertystate;
    BOOLEAN Diff_assessorpropertyzip;
    BOOLEAN Diff_assessorpropertyzip4;
    BOOLEAN Diff_assessorpropertyaddrsource;
    BOOLEAN Diff_raw_file_name;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ln_filedate := le.ln_filedate <> ri.ln_filedate;
    SELF.Diff_bk_infile_type := le.bk_infile_type <> ri.bk_infile_type;
    SELF.Diff_rectype := le.rectype <> ri.rectype;
    SELF.Diff_documenttype := le.documenttype <> ri.documenttype;
    SELF.Diff_fipscode := le.fipscode <> ri.fipscode;
    SELF.Diff_mersindicator := le.mersindicator <> ri.mersindicator;
    SELF.Diff_mainaddendum := le.mainaddendum <> ri.mainaddendum;
    SELF.Diff_assigrecdate := le.assigrecdate <> ri.assigrecdate;
    SELF.Diff_assigeffecdate := le.assigeffecdate <> ri.assigeffecdate;
    SELF.Diff_assigdoc := le.assigdoc <> ri.assigdoc;
    SELF.Diff_assigbk := le.assigbk <> ri.assigbk;
    SELF.Diff_assigpg := le.assigpg <> ri.assigpg;
    SELF.Diff_multiplepageimage := le.multiplepageimage <> ri.multiplepageimage;
    SELF.Diff_bkfsimageid := le.bkfsimageid <> ri.bkfsimageid;
    SELF.Diff_origdotrecdate := le.origdotrecdate <> ri.origdotrecdate;
    SELF.Diff_origdotcontractdate := le.origdotcontractdate <> ri.origdotcontractdate;
    SELF.Diff_origdotdoc := le.origdotdoc <> ri.origdotdoc;
    SELF.Diff_origdotbk := le.origdotbk <> ri.origdotbk;
    SELF.Diff_origdotpg := le.origdotpg <> ri.origdotpg;
    SELF.Diff_origlenderben := le.origlenderben <> ri.origlenderben;
    SELF.Diff_origloanamnt := le.origloanamnt <> ri.origloanamnt;
    SELF.Diff_assignorname := le.assignorname <> ri.assignorname;
    SELF.Diff_loannumber := le.loannumber <> ri.loannumber;
    SELF.Diff_assignee := le.assignee <> ri.assignee;
    SELF.Diff_mers := le.mers <> ri.mers;
    SELF.Diff_mersvalidation := le.mersvalidation <> ri.mersvalidation;
    SELF.Diff_assigneepool := le.assigneepool <> ri.assigneepool;
    SELF.Diff_mspsvcrloan := le.mspsvcrloan <> ri.mspsvcrloan;
    SELF.Diff_borrowername := le.borrowername <> ri.borrowername;
    SELF.Diff_apn := le.apn <> ri.apn;
    SELF.Diff_multiapncode := le.multiapncode <> ri.multiapncode;
    SELF.Diff_taxacctid := le.taxacctid <> ri.taxacctid;
    SELF.Diff_propertyfulladd := le.propertyfulladd <> ri.propertyfulladd;
    SELF.Diff_propertyunit := le.propertyunit <> ri.propertyunit;
    SELF.Diff_propertycity := le.propertycity <> ri.propertycity;
    SELF.Diff_propertystate := le.propertystate <> ri.propertystate;
    SELF.Diff_propertyzip := le.propertyzip <> ri.propertyzip;
    SELF.Diff_propertyzip4 := le.propertyzip4 <> ri.propertyzip4;
    SELF.Diff_dataentrydate := le.dataentrydate <> ri.dataentrydate;
    SELF.Diff_dataentryopercode := le.dataentryopercode <> ri.dataentryopercode;
    SELF.Diff_vendorsourcecode := le.vendorsourcecode <> ri.vendorsourcecode;
    SELF.Diff_hids_recordingflag := le.hids_recordingflag <> ri.hids_recordingflag;
    SELF.Diff_hids_docnumber := le.hids_docnumber <> ri.hids_docnumber;
    SELF.Diff_transfercertificateoftitle := le.transfercertificateoftitle <> ri.transfercertificateoftitle;
    SELF.Diff_hi_condo_cpr_hpr := le.hi_condo_cpr_hpr <> ri.hi_condo_cpr_hpr;
    SELF.Diff_hi_situs_unit_number := le.hi_situs_unit_number <> ri.hi_situs_unit_number;
    SELF.Diff_hids_previous_docnumber := le.hids_previous_docnumber <> ri.hids_previous_docnumber;
    SELF.Diff_prevtransfercertificateoftitle := le.prevtransfercertificateoftitle <> ri.prevtransfercertificateoftitle;
    SELF.Diff_pid := le.pid <> ri.pid;
    SELF.Diff_matchedororphan := le.matchedororphan <> ri.matchedororphan;
    SELF.Diff_deed_pid := le.deed_pid <> ri.deed_pid;
    SELF.Diff_sam_pid := le.sam_pid <> ri.sam_pid;
    SELF.Diff_assessorparcelnumber_matched := le.assessorparcelnumber_matched <> ri.assessorparcelnumber_matched;
    SELF.Diff_assessorpropertyfulladd := le.assessorpropertyfulladd <> ri.assessorpropertyfulladd;
    SELF.Diff_assessorpropertyunittype := le.assessorpropertyunittype <> ri.assessorpropertyunittype;
    SELF.Diff_assessorpropertyunit := le.assessorpropertyunit <> ri.assessorpropertyunit;
    SELF.Diff_assessorpropertycity := le.assessorpropertycity <> ri.assessorpropertycity;
    SELF.Diff_assessorpropertystate := le.assessorpropertystate <> ri.assessorpropertystate;
    SELF.Diff_assessorpropertyzip := le.assessorpropertyzip <> ri.assessorpropertyzip;
    SELF.Diff_assessorpropertyzip4 := le.assessorpropertyzip4 <> ri.assessorpropertyzip4;
    SELF.Diff_assessorpropertyaddrsource := le.assessorpropertyaddrsource <> ri.assessorpropertyaddrsource;
    SELF.Diff_raw_file_name := le.raw_file_name <> ri.raw_file_name;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ln_filedate,1,0)+ IF( SELF.Diff_bk_infile_type,1,0)+ IF( SELF.Diff_rectype,1,0)+ IF( SELF.Diff_documenttype,1,0)+ IF( SELF.Diff_fipscode,1,0)+ IF( SELF.Diff_mersindicator,1,0)+ IF( SELF.Diff_mainaddendum,1,0)+ IF( SELF.Diff_assigrecdate,1,0)+ IF( SELF.Diff_assigeffecdate,1,0)+ IF( SELF.Diff_assigdoc,1,0)+ IF( SELF.Diff_assigbk,1,0)+ IF( SELF.Diff_assigpg,1,0)+ IF( SELF.Diff_multiplepageimage,1,0)+ IF( SELF.Diff_bkfsimageid,1,0)+ IF( SELF.Diff_origdotrecdate,1,0)+ IF( SELF.Diff_origdotcontractdate,1,0)+ IF( SELF.Diff_origdotdoc,1,0)+ IF( SELF.Diff_origdotbk,1,0)+ IF( SELF.Diff_origdotpg,1,0)+ IF( SELF.Diff_origlenderben,1,0)+ IF( SELF.Diff_origloanamnt,1,0)+ IF( SELF.Diff_assignorname,1,0)+ IF( SELF.Diff_loannumber,1,0)+ IF( SELF.Diff_assignee,1,0)+ IF( SELF.Diff_mers,1,0)+ IF( SELF.Diff_mersvalidation,1,0)+ IF( SELF.Diff_assigneepool,1,0)+ IF( SELF.Diff_mspsvcrloan,1,0)+ IF( SELF.Diff_borrowername,1,0)+ IF( SELF.Diff_apn,1,0)+ IF( SELF.Diff_multiapncode,1,0)+ IF( SELF.Diff_taxacctid,1,0)+ IF( SELF.Diff_propertyfulladd,1,0)+ IF( SELF.Diff_propertyunit,1,0)+ IF( SELF.Diff_propertycity,1,0)+ IF( SELF.Diff_propertystate,1,0)+ IF( SELF.Diff_propertyzip,1,0)+ IF( SELF.Diff_propertyzip4,1,0)+ IF( SELF.Diff_dataentrydate,1,0)+ IF( SELF.Diff_dataentryopercode,1,0)+ IF( SELF.Diff_vendorsourcecode,1,0)+ IF( SELF.Diff_hids_recordingflag,1,0)+ IF( SELF.Diff_hids_docnumber,1,0)+ IF( SELF.Diff_transfercertificateoftitle,1,0)+ IF( SELF.Diff_hi_condo_cpr_hpr,1,0)+ IF( SELF.Diff_hi_situs_unit_number,1,0)+ IF( SELF.Diff_hids_previous_docnumber,1,0)+ IF( SELF.Diff_prevtransfercertificateoftitle,1,0)+ IF( SELF.Diff_pid,1,0)+ IF( SELF.Diff_matchedororphan,1,0)+ IF( SELF.Diff_deed_pid,1,0)+ IF( SELF.Diff_sam_pid,1,0)+ IF( SELF.Diff_assessorparcelnumber_matched,1,0)+ IF( SELF.Diff_assessorpropertyfulladd,1,0)+ IF( SELF.Diff_assessorpropertyunittype,1,0)+ IF( SELF.Diff_assessorpropertyunit,1,0)+ IF( SELF.Diff_assessorpropertycity,1,0)+ IF( SELF.Diff_assessorpropertystate,1,0)+ IF( SELF.Diff_assessorpropertyzip,1,0)+ IF( SELF.Diff_assessorpropertyzip4,1,0)+ IF( SELF.Diff_assessorpropertyaddrsource,1,0)+ IF( SELF.Diff_raw_file_name,1,0);
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
    Count_Diff_ln_filedate := COUNT(GROUP,%Closest%.Diff_ln_filedate);
    Count_Diff_bk_infile_type := COUNT(GROUP,%Closest%.Diff_bk_infile_type);
    Count_Diff_rectype := COUNT(GROUP,%Closest%.Diff_rectype);
    Count_Diff_documenttype := COUNT(GROUP,%Closest%.Diff_documenttype);
    Count_Diff_fipscode := COUNT(GROUP,%Closest%.Diff_fipscode);
    Count_Diff_mersindicator := COUNT(GROUP,%Closest%.Diff_mersindicator);
    Count_Diff_mainaddendum := COUNT(GROUP,%Closest%.Diff_mainaddendum);
    Count_Diff_assigrecdate := COUNT(GROUP,%Closest%.Diff_assigrecdate);
    Count_Diff_assigeffecdate := COUNT(GROUP,%Closest%.Diff_assigeffecdate);
    Count_Diff_assigdoc := COUNT(GROUP,%Closest%.Diff_assigdoc);
    Count_Diff_assigbk := COUNT(GROUP,%Closest%.Diff_assigbk);
    Count_Diff_assigpg := COUNT(GROUP,%Closest%.Diff_assigpg);
    Count_Diff_multiplepageimage := COUNT(GROUP,%Closest%.Diff_multiplepageimage);
    Count_Diff_bkfsimageid := COUNT(GROUP,%Closest%.Diff_bkfsimageid);
    Count_Diff_origdotrecdate := COUNT(GROUP,%Closest%.Diff_origdotrecdate);
    Count_Diff_origdotcontractdate := COUNT(GROUP,%Closest%.Diff_origdotcontractdate);
    Count_Diff_origdotdoc := COUNT(GROUP,%Closest%.Diff_origdotdoc);
    Count_Diff_origdotbk := COUNT(GROUP,%Closest%.Diff_origdotbk);
    Count_Diff_origdotpg := COUNT(GROUP,%Closest%.Diff_origdotpg);
    Count_Diff_origlenderben := COUNT(GROUP,%Closest%.Diff_origlenderben);
    Count_Diff_origloanamnt := COUNT(GROUP,%Closest%.Diff_origloanamnt);
    Count_Diff_assignorname := COUNT(GROUP,%Closest%.Diff_assignorname);
    Count_Diff_loannumber := COUNT(GROUP,%Closest%.Diff_loannumber);
    Count_Diff_assignee := COUNT(GROUP,%Closest%.Diff_assignee);
    Count_Diff_mers := COUNT(GROUP,%Closest%.Diff_mers);
    Count_Diff_mersvalidation := COUNT(GROUP,%Closest%.Diff_mersvalidation);
    Count_Diff_assigneepool := COUNT(GROUP,%Closest%.Diff_assigneepool);
    Count_Diff_mspsvcrloan := COUNT(GROUP,%Closest%.Diff_mspsvcrloan);
    Count_Diff_borrowername := COUNT(GROUP,%Closest%.Diff_borrowername);
    Count_Diff_apn := COUNT(GROUP,%Closest%.Diff_apn);
    Count_Diff_multiapncode := COUNT(GROUP,%Closest%.Diff_multiapncode);
    Count_Diff_taxacctid := COUNT(GROUP,%Closest%.Diff_taxacctid);
    Count_Diff_propertyfulladd := COUNT(GROUP,%Closest%.Diff_propertyfulladd);
    Count_Diff_propertyunit := COUNT(GROUP,%Closest%.Diff_propertyunit);
    Count_Diff_propertycity := COUNT(GROUP,%Closest%.Diff_propertycity);
    Count_Diff_propertystate := COUNT(GROUP,%Closest%.Diff_propertystate);
    Count_Diff_propertyzip := COUNT(GROUP,%Closest%.Diff_propertyzip);
    Count_Diff_propertyzip4 := COUNT(GROUP,%Closest%.Diff_propertyzip4);
    Count_Diff_dataentrydate := COUNT(GROUP,%Closest%.Diff_dataentrydate);
    Count_Diff_dataentryopercode := COUNT(GROUP,%Closest%.Diff_dataentryopercode);
    Count_Diff_vendorsourcecode := COUNT(GROUP,%Closest%.Diff_vendorsourcecode);
    Count_Diff_hids_recordingflag := COUNT(GROUP,%Closest%.Diff_hids_recordingflag);
    Count_Diff_hids_docnumber := COUNT(GROUP,%Closest%.Diff_hids_docnumber);
    Count_Diff_transfercertificateoftitle := COUNT(GROUP,%Closest%.Diff_transfercertificateoftitle);
    Count_Diff_hi_condo_cpr_hpr := COUNT(GROUP,%Closest%.Diff_hi_condo_cpr_hpr);
    Count_Diff_hi_situs_unit_number := COUNT(GROUP,%Closest%.Diff_hi_situs_unit_number);
    Count_Diff_hids_previous_docnumber := COUNT(GROUP,%Closest%.Diff_hids_previous_docnumber);
    Count_Diff_prevtransfercertificateoftitle := COUNT(GROUP,%Closest%.Diff_prevtransfercertificateoftitle);
    Count_Diff_pid := COUNT(GROUP,%Closest%.Diff_pid);
    Count_Diff_matchedororphan := COUNT(GROUP,%Closest%.Diff_matchedororphan);
    Count_Diff_deed_pid := COUNT(GROUP,%Closest%.Diff_deed_pid);
    Count_Diff_sam_pid := COUNT(GROUP,%Closest%.Diff_sam_pid);
    Count_Diff_assessorparcelnumber_matched := COUNT(GROUP,%Closest%.Diff_assessorparcelnumber_matched);
    Count_Diff_assessorpropertyfulladd := COUNT(GROUP,%Closest%.Diff_assessorpropertyfulladd);
    Count_Diff_assessorpropertyunittype := COUNT(GROUP,%Closest%.Diff_assessorpropertyunittype);
    Count_Diff_assessorpropertyunit := COUNT(GROUP,%Closest%.Diff_assessorpropertyunit);
    Count_Diff_assessorpropertycity := COUNT(GROUP,%Closest%.Diff_assessorpropertycity);
    Count_Diff_assessorpropertystate := COUNT(GROUP,%Closest%.Diff_assessorpropertystate);
    Count_Diff_assessorpropertyzip := COUNT(GROUP,%Closest%.Diff_assessorpropertyzip);
    Count_Diff_assessorpropertyzip4 := COUNT(GROUP,%Closest%.Diff_assessorpropertyzip4);
    Count_Diff_assessorpropertyaddrsource := COUNT(GROUP,%Closest%.Diff_assessorpropertyaddrsource);
    Count_Diff_raw_file_name := COUNT(GROUP,%Closest%.Diff_raw_file_name);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
