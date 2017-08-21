IMPORT ut,SALT31;
EXPORT SureScripts_Fields := MODULE
// Processing for each FieldType
EXPORT SALT31.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','bdid','bdid_score','best_dob','best_ssn','spi','dea','statelicensenumber','specialtycodeprimary','prefixname','lastname','firstname','middlename','suffixname','clinicname','addressline1','addressline2','city','state','zipcode','phoneprimary','fax','email','phonealt1','phonealt1qualifier','phonealt2','phonealt2qualifier','phonealt3','phonealt3qualifier','phonealt4','phonealt4qualifier','phonealt5','phonealt5qualifier','activestarttime','activeendtime','servicelevel','partneraccount','lastmodifieddate','recordchange','oldservicelevel','textservicelevel','textservicelevelchange','version','npi','npilocation','specialitytype1','specialitytype2','specialitytype3','specialitytype4','fileid','medicarenumber','medicaidnumber','dentistlicensenumber','upin','pponumber','socialsecurity','priorauthorization','mutuallydefined','instorencpdpid','spec_code','spec_desc','activity_code','practice_type_code','practice_type_desc','taxonomy','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order');
EXPORT FieldTypeNum(SALT31.StrType fn) := CASE(fn,'did' => 1,'did_score' => 2,'bdid' => 3,'bdid_score' => 4,'best_dob' => 5,'best_ssn' => 6,'spi' => 7,'dea' => 8,'statelicensenumber' => 9,'specialtycodeprimary' => 10,'prefixname' => 11,'lastname' => 12,'firstname' => 13,'middlename' => 14,'suffixname' => 15,'clinicname' => 16,'addressline1' => 17,'addressline2' => 18,'city' => 19,'state' => 20,'zipcode' => 21,'phoneprimary' => 22,'fax' => 23,'email' => 24,'phonealt1' => 25,'phonealt1qualifier' => 26,'phonealt2' => 27,'phonealt2qualifier' => 28,'phonealt3' => 29,'phonealt3qualifier' => 30,'phonealt4' => 31,'phonealt4qualifier' => 32,'phonealt5' => 33,'phonealt5qualifier' => 34,'activestarttime' => 35,'activeendtime' => 36,'servicelevel' => 37,'partneraccount' => 38,'lastmodifieddate' => 39,'recordchange' => 40,'oldservicelevel' => 41,'textservicelevel' => 42,'textservicelevelchange' => 43,'version' => 44,'npi' => 45,'npilocation' => 46,'specialitytype1' => 47,'specialitytype2' => 48,'specialitytype3' => 49,'specialitytype4' => 50,'fileid' => 51,'medicarenumber' => 52,'medicaidnumber' => 53,'dentistlicensenumber' => 54,'upin' => 55,'pponumber' => 56,'socialsecurity' => 57,'priorauthorization' => 58,'mutuallydefined' => 59,'instorencpdpid' => 60,'spec_code' => 61,'spec_desc' => 62,'activity_code' => 63,'practice_type_code' => 64,'practice_type_desc' => 65,'taxonomy' => 66,'src' => 67,'dt_vendor_first_reported' => 68,'dt_vendor_last_reported' => 69,'dt_first_seen' => 70,'dt_last_seen' => 71,'record_type' => 72,'source_rid' => 73,'lnpid' => 74,'title' => 75,'fname' => 76,'mname' => 77,'lname' => 78,'name_suffix' => 79,'name_type' => 80,'nid' => 81,'clean_clinic_name' => 82,'prepped_addr1' => 83,'prepped_addr2' => 84,'prim_range' => 85,'predir' => 86,'prim_name' => 87,'addr_suffix' => 88,'postdir' => 89,'unit_desig' => 90,'sec_range' => 91,'p_city_name' => 92,'v_city_name' => 93,'st' => 94,'zip' => 95,'zip4' => 96,'cart' => 97,'cr_sort_sz' => 98,'lot' => 99,'lot_order' => 100,0);
EXPORT MakeFT_did(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_did(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_did_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_did_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_did_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_bdid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_bdid_score(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0157 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_bdid_score(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0157 '))));
EXPORT InValidMessageFT_bdid_score(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0157 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_best_dob(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_best_dob(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_best_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_best_ssn(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_best_ssn(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_best_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_spi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_spi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_spi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dea(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dea(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_dea(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_statelicensenumber(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' #:-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_statelicensenumber(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' #:-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuwxyz '))));
EXPORT InValidMessageFT_statelicensenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' #:-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialtycodeprimary(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHILMNOPQRSTUVY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialtycodeprimary(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHILMNOPQRSTUVY '))));
EXPORT InValidMessageFT_specialtycodeprimary(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHILMNOPQRSTUVY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prefixname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -.ABCDEFGHIJKLMNOPQRSTdeghinorst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prefixname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -.ABCDEFGHIJKLMNOPQRSTdeghinorst '))));
EXPORT InValidMessageFT_prefixname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -.ABCDEFGHIJKLMNOPQRSTdeghinorst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lastname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ,.-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lastname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ,.-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ,.-\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_firstname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_firstname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -\'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_middlename(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -\'.ABCDEFGHIJKLMNOPQRSTUVWYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_middlename(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -\'.ABCDEFGHIJKLMNOPQRSTUVWYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_middlename(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -\'.ABCDEFGHIJKLMNOPQRSTUVWYZabcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_suffixname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' (),-.ABCDEFHIJLMNOPQRSTUVWYZdehinrst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_suffixname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' (),-.ABCDEFHIJLMNOPQRSTUVWYZdehinrst '))));
EXPORT InValidMessageFT_suffixname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' (),-.ABCDEFHIJLMNOPQRSTUVWYZdehinrst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clinicname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' `;+#&@\'(),-./\\0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clinicname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' `;+#&@\'(),-./\\0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '))));
EXPORT InValidMessageFT_clinicname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' `;+#&@\'(),-./\\0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_addressline1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' |@`()/#,\':;-&.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addressline1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' |@`()/#,\':;-&.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_addressline1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' |@`()/#,\':;-&.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_addressline2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' |@`()/#\':*,&;\'-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addressline2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' |@`()/#\':*,&;\'-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_addressline2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' |@`()/#\':*,&;\'-./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_city(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' .`\'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_city(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' .`\'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_city(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' .`\'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_state(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_state(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_state(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zipcode(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zipcode(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phoneprimary(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789Xx '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phoneprimary(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789Xx '))));
EXPORT InValidMessageFT_phoneprimary(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789Xx '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fax(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fax(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_fax(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_email(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789@ABCDEFGHIJKLMNOPQRSTUVXWYZ_abcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_email(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789@ABCDEFGHIJKLMNOPQRSTUVXWYZ_abcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_email(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789@ABCDEFGHIJKLMNOPQRSTUVXWYZ_abcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_phonealt1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt1qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BCEFNPTWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt1qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BCEFNPTWX '))));
EXPORT InValidMessageFT_phonealt1qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BCEFNPTWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_phonealt2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt2qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'CEFHNPTWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt2qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'CEFHNPTWX '))));
EXPORT InValidMessageFT_phonealt2qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('CEFHNPTWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_phonealt3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt3qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'EFHPTWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt3qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'EFHPTWX '))));
EXPORT InValidMessageFT_phonealt3qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('EFHPTWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_phonealt4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt4qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'EFPTWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt4qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'EFPTWX '))));
EXPORT InValidMessageFT_phonealt4qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('EFPTWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt5(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt5(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_phonealt5(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_phonealt5qualifier(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'EFPTWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_phonealt5qualifier(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'EFPTWX '))));
EXPORT InValidMessageFT_phonealt5qualifier(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('EFPTWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_activestarttime(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789:TZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_activestarttime(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789:TZ '))));
EXPORT InValidMessageFT_activestarttime(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789:TZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_activeendtime(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789:TZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_activeendtime(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789:TZ '))));
EXPORT InValidMessageFT_activeendtime(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789:TZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_servicelevel(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_servicelevel(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_servicelevel(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_partneraccount(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_partneraccount(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_partneraccount(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lastmodifieddate(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-.0123456789:TZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lastmodifieddate(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-.0123456789:TZ '))));
EXPORT InValidMessageFT_lastmodifieddate(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-.0123456789:TZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_recordchange(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_recordchange(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_recordchange(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_oldservicelevel(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-1 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_oldservicelevel(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-1 '))));
EXPORT InValidMessageFT_oldservicelevel(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-1 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_textservicelevel(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_textservicelevel(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_textservicelevel(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_textservicelevelchange(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_textservicelevelchange(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_textservicelevelchange(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_version(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789CI_vV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_version(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789CI_vV '))));
EXPORT InValidMessageFT_version(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789CI_vV '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npi(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npi(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_npi(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_npilocation(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_npilocation(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_npilocation(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialitytype1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ADNPRcdeinorst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialitytype1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ADNPRcdeinorst '))));
EXPORT InValidMessageFT_specialitytype1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ADNPRcdeinorst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialitytype2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ACNPQRScdeilnorst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialitytype2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ACNPQRScdeilnorst '))));
EXPORT InValidMessageFT_specialitytype2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ACNPQRScdeilnorst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialitytype3(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'NPRdeinst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialitytype3(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'NPRdeinst '))));
EXPORT InValidMessageFT_specialitytype3(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('NPRdeinst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_specialitytype4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_specialitytype4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))));
EXPORT InValidMessageFT_specialitytype4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fileid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-^0123456789ABCDEFGHIJKLMNPQRSTWXYZ_abcdefghiklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fileid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-^0123456789ABCDEFGHIJKLMNPQRSTWXYZ_abcdefghiklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_fileid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-^0123456789ABCDEFGHIJKLMNPQRSTWXYZ_abcdefghiklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_medicarenumber(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZceimnpqrst '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_medicarenumber(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZceimnpqrst '))));
EXPORT InValidMessageFT_medicarenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZceimnpqrst '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_medicaidnumber(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 0123456789ACDEFGLMNOPQRSTZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_medicaidnumber(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 0123456789ACDEFGLMNOPQRSTZ '))));
EXPORT InValidMessageFT_medicaidnumber(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 0123456789ACDEFGLMNOPQRSTZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dentistlicensenumber(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABOPYcs '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dentistlicensenumber(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABOPYcs '))));
EXPORT InValidMessageFT_dentistlicensenumber(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABOPYcs '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_upin(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 0123456789ABCDEFGHIKLMNOPQRSTUVWXZhot '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_upin(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 0123456789ABCDEFGHIKLMNOPQRSTUVWXZhot '))));
EXPORT InValidMessageFT_upin(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIKLMNOPQRSTUVWXZhot '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_pponumber(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCFJKLVWtu '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_pponumber(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCFJKLVWtu '))));
EXPORT InValidMessageFT_pponumber(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCFJKLVWtu '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_socialsecurity(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_socialsecurity(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789 '))));
EXPORT InValidMessageFT_socialsecurity(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_priorauthorization(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789BCFJKLVW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_priorauthorization(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789BCFJKLVW '))));
EXPORT InValidMessageFT_priorauthorization(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789BCFJKLVW '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mutuallydefined(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -0123456789:ABCDEGHIJKLMNORSTU\\abcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mutuallydefined(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -0123456789:ABCDEGHIJKLMNORSTU\\abcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_mutuallydefined(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -0123456789:ABCDEGHIJKLMNORSTU\\abcdefghijklmnopqrstuvwxyz '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_instorencpdpid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_instorencpdpid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' '))),~(LENGTH(TRIM(s)) = 0),~(SALT31.WordCount(SALT31.StringSubstituteOut(s,' ',' ')) = 1));
EXPORT InValidMessageFT_instorencpdpid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' '),SALT31.HygieneErrors.NotLength('0'),SALT31.HygieneErrors.NotWords('1'),SALT31.HygieneErrors.Good);
EXPORT MakeFT_spec_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ABCDEFGHJKMNPQRSTUVWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_spec_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ABCDEFGHJKMNPQRSTUVWX '))));
EXPORT InValidMessageFT_spec_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ABCDEFGHJKMNPQRSTUVWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_spec_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' &,/ACDEFGHIMNOPQRSUabcdefghilmnopqrstuvy '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_spec_desc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' &,/ACDEFGHIMNOPQRSUabcdefghilmnopqrstuvy '))));
EXPORT InValidMessageFT_spec_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' &,/ACDEFGHIMNOPQRSUabcdefghilmnopqrstuvy '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_activity_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACT '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_activity_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACT '))));
EXPORT InValidMessageFT_activity_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACT '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_practice_type_code(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'05GP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_practice_type_code(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'05GP '))));
EXPORT InValidMessageFT_practice_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('05GP '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_practice_type_desc(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'Pachinsy '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_practice_type_desc(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'Pachinsy '))));
EXPORT InValidMessageFT_practice_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('Pachinsy '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_taxonomy(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789ACDEGHILNPQRSTVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_taxonomy(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789ACDEGHILNPQRSTVWXY '))));
EXPORT InValidMessageFT_taxonomy(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789ACDEGHILNPQRSTVWXY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_src(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'126CHMRS_ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_src(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'126CHMRS_ '))));
EXPORT InValidMessageFT_src(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('126CHMRS_ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_first_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_first_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_dt_vendor_first_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_vendor_last_reported(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_vendor_last_reported(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_dt_vendor_last_reported(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_first_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_first_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_dt_last_seen(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_dt_last_seen(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0 '))));
EXPORT InValidMessageFT_dt_last_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_record_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'C '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_record_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'C '))));
EXPORT InValidMessageFT_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('C '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_source_rid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_source_rid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_source_rid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lnpid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lnpid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_lnpid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_title(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'MRS '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_title(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'MRS '))));
EXPORT InValidMessageFT_title(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('MRS '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_fname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_fname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_mname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_mname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_mname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lname(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lname(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'IJRSV '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'IJRSV '))));
EXPORT InValidMessageFT_name_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('IJRSV '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_name_type(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BIP '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_name_type(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BIP '))));
EXPORT InValidMessageFT_name_type(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BIP '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_nid(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_nid(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_nid(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_clean_clinic_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' `+#@&,&0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_clean_clinic_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' `+#@&,&0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '))));
EXPORT InValidMessageFT_clean_clinic_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' `+#@&,&0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr1(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' |@`:()/&#,;\'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr1(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' |@`:()/&#,;\'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_prepped_addr1(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' |@`:()/&#,;\'-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prepped_addr2(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' |@`:()/&,;-.\'0123456789ABCDEFGHIJKLMNOPRQSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prepped_addr2(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' |@`:()/&,;-.\'0123456789ABCDEFGHIJKLMNOPRQSTUVWXYZ '))));
EXPORT InValidMessageFT_prepped_addr2(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' |@`:()/&,;-.\'0123456789ABCDEFGHIJKLMNOPRQSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prim_range(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789AB '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_range(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789AB '))));
EXPORT InValidMessageFT_prim_range(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789AB '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_predir(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_predir(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ENSW '))));
EXPORT InValidMessageFT_predir(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ENSW '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_prim_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_prim_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_prim_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_addr_suffix(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ABCDEFHIKLNOPQRSTVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_addr_suffix(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ABCDEFHIKLNOPQRSTVWXYZ '))));
EXPORT InValidMessageFT_addr_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ABCDEFHIKLNOPQRSTVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_postdir(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'ENSW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_postdir(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'ENSW '))));
EXPORT InValidMessageFT_postdir(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('ENSW '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_unit_desig(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'#ABCDEFGILMNOPQRSTUWX '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_unit_desig(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'#ABCDEFGILMNOPQRSTUWX '))));
EXPORT InValidMessageFT_unit_desig(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('#ABCDEFGILMNOPQRSTUWX '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_sec_range(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_sec_range(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'-0123456789ABCDEFGHIJKLMNOPQRSTUVW '))));
EXPORT InValidMessageFT_sec_range(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('-0123456789ABCDEFGHIJKLMNOPQRSTUVW '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_p_city_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_p_city_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))));
EXPORT InValidMessageFT_p_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_v_city_name(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXY '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_v_city_name(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXY '))));
EXPORT InValidMessageFT_v_city_name(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXY '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_st(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,' ACDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_st(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,' ACDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_st(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars(' ACDEFGHIJKLMNOPQRSTUVWXYZ '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_zip4(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_zip4(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cart(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789CHR '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cart(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789CHR '))));
EXPORT InValidMessageFT_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789CHR '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_cr_sort_sz(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'BCD '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_cr_sort_sz(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'BCD '))));
EXPORT InValidMessageFT_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('BCD '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lot(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('0123456789 '),SALT31.HygieneErrors.Good);
EXPORT MakeFT_lot_order(SALT31.StrType s0) := FUNCTION
  s1 := SALT31.stringfilter(s0,'AD '); // Only allow valid symbols
  s2 := SALT31.stringcleanspaces( SALT31.stringsubstituteout(s1,' ',' ') ); // Insert spaces but avoid doubles
  s3 := TRIM(s2,LEFT); // Left trim
  RETURN  s3;
END;
EXPORT InValidFT_lot_order(SALT31.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT31.StringFilter(s,'AD '))));
EXPORT InValidMessageFT_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT31.HygieneErrors.NotLeft,SALT31.HygieneErrors.NotInChars('AD '),SALT31.HygieneErrors.Good);
EXPORT SALT31.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'did','did_score','bdid','bdid_score','best_dob','best_ssn','spi','dea','statelicensenumber','specialtycodeprimary','prefixname','lastname','firstname','middlename','suffixname','clinicname','addressline1','addressline2','city','state','zipcode','phoneprimary','fax','email','phonealt1','phonealt1qualifier','phonealt2','phonealt2qualifier','phonealt3','phonealt3qualifier','phonealt4','phonealt4qualifier','phonealt5','phonealt5qualifier','activestarttime','activeendtime','servicelevel','partneraccount','lastmodifieddate','recordchange','oldservicelevel','textservicelevel','textservicelevelchange','version','npi','npilocation','specialitytype1','specialitytype2','specialitytype3','specialitytype4','fileid','medicarenumber','medicaidnumber','dentistlicensenumber','upin','pponumber','socialsecurity','priorauthorization','mutuallydefined','instorencpdpid','spec_code','spec_desc','activity_code','practice_type_code','practice_type_desc','taxonomy','src','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','record_type','source_rid','lnpid','title','fname','mname','lname','name_suffix','name_type','nid','clean_clinic_name','prepped_addr1','prepped_addr2','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight');
EXPORT FieldNum(SALT31.StrType fn) := CASE(fn,'did' => 1,'did_score' => 2,'bdid' => 3,'bdid_score' => 4,'best_dob' => 5,'best_ssn' => 6,'spi' => 7,'dea' => 8,'statelicensenumber' => 9,'specialtycodeprimary' => 10,'prefixname' => 11,'lastname' => 12,'firstname' => 13,'middlename' => 14,'suffixname' => 15,'clinicname' => 16,'addressline1' => 17,'addressline2' => 18,'city' => 19,'state' => 20,'zipcode' => 21,'phoneprimary' => 22,'fax' => 23,'email' => 24,'phonealt1' => 25,'phonealt1qualifier' => 26,'phonealt2' => 27,'phonealt2qualifier' => 28,'phonealt3' => 29,'phonealt3qualifier' => 30,'phonealt4' => 31,'phonealt4qualifier' => 32,'phonealt5' => 33,'phonealt5qualifier' => 34,'activestarttime' => 35,'activeendtime' => 36,'servicelevel' => 37,'partneraccount' => 38,'lastmodifieddate' => 39,'recordchange' => 40,'oldservicelevel' => 41,'textservicelevel' => 42,'textservicelevelchange' => 43,'version' => 44,'npi' => 45,'npilocation' => 46,'specialitytype1' => 47,'specialitytype2' => 48,'specialitytype3' => 49,'specialitytype4' => 50,'fileid' => 51,'medicarenumber' => 52,'medicaidnumber' => 53,'dentistlicensenumber' => 54,'upin' => 55,'pponumber' => 56,'socialsecurity' => 57,'priorauthorization' => 58,'mutuallydefined' => 59,'instorencpdpid' => 60,'spec_code' => 61,'spec_desc' => 62,'activity_code' => 63,'practice_type_code' => 64,'practice_type_desc' => 65,'taxonomy' => 66,'src' => 67,'dt_vendor_first_reported' => 68,'dt_vendor_last_reported' => 69,'dt_first_seen' => 70,'dt_last_seen' => 71,'record_type' => 72,'source_rid' => 73,'lnpid' => 74,'title' => 75,'fname' => 76,'mname' => 77,'lname' => 78,'name_suffix' => 79,'name_type' => 80,'nid' => 81,'clean_clinic_name' => 82,'prepped_addr1' => 83,'prepped_addr2' => 84,'prim_range' => 85,'predir' => 86,'prim_name' => 87,'addr_suffix' => 88,'postdir' => 89,'unit_desig' => 90,'sec_range' => 91,'p_city_name' => 92,'v_city_name' => 93,'st' => 94,'zip' => 95,'zip4' => 96,'cart' => 97,'cr_sort_sz' => 98,'lot' => 99,'lot_order' => 100,'dbpc' => 101,'chk_digit' => 102,'rec_type' => 103,'fips_st' => 104,'fips_county' => 105,'geo_lat' => 106,'geo_long' => 107,'msa' => 108,'geo_blk' => 109,'geo_match' => 110,'err_stat' => 111,'rawaid' => 112,'aceaid' => 113,'clean_phone' => 114,'dotid' => 115,'dotscore' => 116,'dotweight' => 117,'empid' => 118,'empscore' => 119,'empweight' => 120,'powid' => 121,'powscore' => 122,'powweight' => 123,'proxid' => 124,'proxscore' => 125,'proxweight' => 126,'seleid' => 127,'selescore' => 128,'seleweight' => 129,'orgid' => 130,'orgscore' => 131,'orgweight' => 132,'ultid' => 133,'ultscore' => 134,'ultweight' => 135,0);
//Individual field level validation
EXPORT Make_did(SALT31.StrType s0) := MakeFT_did(s0);
EXPORT InValid_did(SALT31.StrType s) := InValidFT_did(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_did(wh);
EXPORT Make_did_score(SALT31.StrType s0) := MakeFT_did_score(s0);
EXPORT InValid_did_score(SALT31.StrType s) := InValidFT_did_score(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_did_score(wh);
EXPORT Make_bdid(SALT31.StrType s0) := MakeFT_bdid(s0);
EXPORT InValid_bdid(SALT31.StrType s) := InValidFT_bdid(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_bdid(wh);
EXPORT Make_bdid_score(SALT31.StrType s0) := MakeFT_bdid_score(s0);
EXPORT InValid_bdid_score(SALT31.StrType s) := InValidFT_bdid_score(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_bdid_score(wh);
EXPORT Make_best_dob(SALT31.StrType s0) := MakeFT_best_dob(s0);
EXPORT InValid_best_dob(SALT31.StrType s) := InValidFT_best_dob(s);
EXPORT InValidMessage_best_dob(UNSIGNED1 wh) := InValidMessageFT_best_dob(wh);
EXPORT Make_best_ssn(SALT31.StrType s0) := MakeFT_best_ssn(s0);
EXPORT InValid_best_ssn(SALT31.StrType s) := InValidFT_best_ssn(s);
EXPORT InValidMessage_best_ssn(UNSIGNED1 wh) := InValidMessageFT_best_ssn(wh);
EXPORT Make_spi(SALT31.StrType s0) := MakeFT_spi(s0);
EXPORT InValid_spi(SALT31.StrType s) := InValidFT_spi(s);
EXPORT InValidMessage_spi(UNSIGNED1 wh) := InValidMessageFT_spi(wh);
EXPORT Make_dea(SALT31.StrType s0) := MakeFT_dea(s0);
EXPORT InValid_dea(SALT31.StrType s) := InValidFT_dea(s);
EXPORT InValidMessage_dea(UNSIGNED1 wh) := InValidMessageFT_dea(wh);
EXPORT Make_statelicensenumber(SALT31.StrType s0) := MakeFT_statelicensenumber(s0);
EXPORT InValid_statelicensenumber(SALT31.StrType s) := InValidFT_statelicensenumber(s);
EXPORT InValidMessage_statelicensenumber(UNSIGNED1 wh) := InValidMessageFT_statelicensenumber(wh);
EXPORT Make_specialtycodeprimary(SALT31.StrType s0) := MakeFT_specialtycodeprimary(s0);
EXPORT InValid_specialtycodeprimary(SALT31.StrType s) := InValidFT_specialtycodeprimary(s);
EXPORT InValidMessage_specialtycodeprimary(UNSIGNED1 wh) := InValidMessageFT_specialtycodeprimary(wh);
EXPORT Make_prefixname(SALT31.StrType s0) := MakeFT_prefixname(s0);
EXPORT InValid_prefixname(SALT31.StrType s) := InValidFT_prefixname(s);
EXPORT InValidMessage_prefixname(UNSIGNED1 wh) := InValidMessageFT_prefixname(wh);
EXPORT Make_lastname(SALT31.StrType s0) := MakeFT_lastname(s0);
EXPORT InValid_lastname(SALT31.StrType s) := InValidFT_lastname(s);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_lastname(wh);
EXPORT Make_firstname(SALT31.StrType s0) := MakeFT_firstname(s0);
EXPORT InValid_firstname(SALT31.StrType s) := InValidFT_firstname(s);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_firstname(wh);
EXPORT Make_middlename(SALT31.StrType s0) := MakeFT_middlename(s0);
EXPORT InValid_middlename(SALT31.StrType s) := InValidFT_middlename(s);
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := InValidMessageFT_middlename(wh);
EXPORT Make_suffixname(SALT31.StrType s0) := MakeFT_suffixname(s0);
EXPORT InValid_suffixname(SALT31.StrType s) := InValidFT_suffixname(s);
EXPORT InValidMessage_suffixname(UNSIGNED1 wh) := InValidMessageFT_suffixname(wh);
EXPORT Make_clinicname(SALT31.StrType s0) := MakeFT_clinicname(s0);
EXPORT InValid_clinicname(SALT31.StrType s) := InValidFT_clinicname(s);
EXPORT InValidMessage_clinicname(UNSIGNED1 wh) := InValidMessageFT_clinicname(wh);
EXPORT Make_addressline1(SALT31.StrType s0) := MakeFT_addressline1(s0);
EXPORT InValid_addressline1(SALT31.StrType s) := InValidFT_addressline1(s);
EXPORT InValidMessage_addressline1(UNSIGNED1 wh) := InValidMessageFT_addressline1(wh);
EXPORT Make_addressline2(SALT31.StrType s0) := MakeFT_addressline2(s0);
EXPORT InValid_addressline2(SALT31.StrType s) := InValidFT_addressline2(s);
EXPORT InValidMessage_addressline2(UNSIGNED1 wh) := InValidMessageFT_addressline2(wh);
EXPORT Make_city(SALT31.StrType s0) := MakeFT_city(s0);
EXPORT InValid_city(SALT31.StrType s) := InValidFT_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_city(wh);
EXPORT Make_state(SALT31.StrType s0) := MakeFT_state(s0);
EXPORT InValid_state(SALT31.StrType s) := InValidFT_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_state(wh);
EXPORT Make_zipcode(SALT31.StrType s0) := MakeFT_zipcode(s0);
EXPORT InValid_zipcode(SALT31.StrType s) := InValidFT_zipcode(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_zipcode(wh);
EXPORT Make_phoneprimary(SALT31.StrType s0) := MakeFT_phoneprimary(s0);
EXPORT InValid_phoneprimary(SALT31.StrType s) := InValidFT_phoneprimary(s);
EXPORT InValidMessage_phoneprimary(UNSIGNED1 wh) := InValidMessageFT_phoneprimary(wh);
EXPORT Make_fax(SALT31.StrType s0) := MakeFT_fax(s0);
EXPORT InValid_fax(SALT31.StrType s) := InValidFT_fax(s);
EXPORT InValidMessage_fax(UNSIGNED1 wh) := InValidMessageFT_fax(wh);
EXPORT Make_email(SALT31.StrType s0) := MakeFT_email(s0);
EXPORT InValid_email(SALT31.StrType s) := InValidFT_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_email(wh);
EXPORT Make_phonealt1(SALT31.StrType s0) := MakeFT_phonealt1(s0);
EXPORT InValid_phonealt1(SALT31.StrType s) := InValidFT_phonealt1(s);
EXPORT InValidMessage_phonealt1(UNSIGNED1 wh) := InValidMessageFT_phonealt1(wh);
EXPORT Make_phonealt1qualifier(SALT31.StrType s0) := MakeFT_phonealt1qualifier(s0);
EXPORT InValid_phonealt1qualifier(SALT31.StrType s) := InValidFT_phonealt1qualifier(s);
EXPORT InValidMessage_phonealt1qualifier(UNSIGNED1 wh) := InValidMessageFT_phonealt1qualifier(wh);
EXPORT Make_phonealt2(SALT31.StrType s0) := MakeFT_phonealt2(s0);
EXPORT InValid_phonealt2(SALT31.StrType s) := InValidFT_phonealt2(s);
EXPORT InValidMessage_phonealt2(UNSIGNED1 wh) := InValidMessageFT_phonealt2(wh);
EXPORT Make_phonealt2qualifier(SALT31.StrType s0) := MakeFT_phonealt2qualifier(s0);
EXPORT InValid_phonealt2qualifier(SALT31.StrType s) := InValidFT_phonealt2qualifier(s);
EXPORT InValidMessage_phonealt2qualifier(UNSIGNED1 wh) := InValidMessageFT_phonealt2qualifier(wh);
EXPORT Make_phonealt3(SALT31.StrType s0) := MakeFT_phonealt3(s0);
EXPORT InValid_phonealt3(SALT31.StrType s) := InValidFT_phonealt3(s);
EXPORT InValidMessage_phonealt3(UNSIGNED1 wh) := InValidMessageFT_phonealt3(wh);
EXPORT Make_phonealt3qualifier(SALT31.StrType s0) := MakeFT_phonealt3qualifier(s0);
EXPORT InValid_phonealt3qualifier(SALT31.StrType s) := InValidFT_phonealt3qualifier(s);
EXPORT InValidMessage_phonealt3qualifier(UNSIGNED1 wh) := InValidMessageFT_phonealt3qualifier(wh);
EXPORT Make_phonealt4(SALT31.StrType s0) := MakeFT_phonealt4(s0);
EXPORT InValid_phonealt4(SALT31.StrType s) := InValidFT_phonealt4(s);
EXPORT InValidMessage_phonealt4(UNSIGNED1 wh) := InValidMessageFT_phonealt4(wh);
EXPORT Make_phonealt4qualifier(SALT31.StrType s0) := MakeFT_phonealt4qualifier(s0);
EXPORT InValid_phonealt4qualifier(SALT31.StrType s) := InValidFT_phonealt4qualifier(s);
EXPORT InValidMessage_phonealt4qualifier(UNSIGNED1 wh) := InValidMessageFT_phonealt4qualifier(wh);
EXPORT Make_phonealt5(SALT31.StrType s0) := MakeFT_phonealt5(s0);
EXPORT InValid_phonealt5(SALT31.StrType s) := InValidFT_phonealt5(s);
EXPORT InValidMessage_phonealt5(UNSIGNED1 wh) := InValidMessageFT_phonealt5(wh);
EXPORT Make_phonealt5qualifier(SALT31.StrType s0) := MakeFT_phonealt5qualifier(s0);
EXPORT InValid_phonealt5qualifier(SALT31.StrType s) := InValidFT_phonealt5qualifier(s);
EXPORT InValidMessage_phonealt5qualifier(UNSIGNED1 wh) := InValidMessageFT_phonealt5qualifier(wh);
EXPORT Make_activestarttime(SALT31.StrType s0) := MakeFT_activestarttime(s0);
EXPORT InValid_activestarttime(SALT31.StrType s) := InValidFT_activestarttime(s);
EXPORT InValidMessage_activestarttime(UNSIGNED1 wh) := InValidMessageFT_activestarttime(wh);
EXPORT Make_activeendtime(SALT31.StrType s0) := MakeFT_activeendtime(s0);
EXPORT InValid_activeendtime(SALT31.StrType s) := InValidFT_activeendtime(s);
EXPORT InValidMessage_activeendtime(UNSIGNED1 wh) := InValidMessageFT_activeendtime(wh);
EXPORT Make_servicelevel(SALT31.StrType s0) := MakeFT_servicelevel(s0);
EXPORT InValid_servicelevel(SALT31.StrType s) := InValidFT_servicelevel(s);
EXPORT InValidMessage_servicelevel(UNSIGNED1 wh) := InValidMessageFT_servicelevel(wh);
EXPORT Make_partneraccount(SALT31.StrType s0) := MakeFT_partneraccount(s0);
EXPORT InValid_partneraccount(SALT31.StrType s) := InValidFT_partneraccount(s);
EXPORT InValidMessage_partneraccount(UNSIGNED1 wh) := InValidMessageFT_partneraccount(wh);
EXPORT Make_lastmodifieddate(SALT31.StrType s0) := MakeFT_lastmodifieddate(s0);
EXPORT InValid_lastmodifieddate(SALT31.StrType s) := InValidFT_lastmodifieddate(s);
EXPORT InValidMessage_lastmodifieddate(UNSIGNED1 wh) := InValidMessageFT_lastmodifieddate(wh);
EXPORT Make_recordchange(SALT31.StrType s0) := MakeFT_recordchange(s0);
EXPORT InValid_recordchange(SALT31.StrType s) := InValidFT_recordchange(s);
EXPORT InValidMessage_recordchange(UNSIGNED1 wh) := InValidMessageFT_recordchange(wh);
EXPORT Make_oldservicelevel(SALT31.StrType s0) := MakeFT_oldservicelevel(s0);
EXPORT InValid_oldservicelevel(SALT31.StrType s) := InValidFT_oldservicelevel(s);
EXPORT InValidMessage_oldservicelevel(UNSIGNED1 wh) := InValidMessageFT_oldservicelevel(wh);
EXPORT Make_textservicelevel(SALT31.StrType s0) := MakeFT_textservicelevel(s0);
EXPORT InValid_textservicelevel(SALT31.StrType s) := InValidFT_textservicelevel(s);
EXPORT InValidMessage_textservicelevel(UNSIGNED1 wh) := InValidMessageFT_textservicelevel(wh);
EXPORT Make_textservicelevelchange(SALT31.StrType s0) := MakeFT_textservicelevelchange(s0);
EXPORT InValid_textservicelevelchange(SALT31.StrType s) := InValidFT_textservicelevelchange(s);
EXPORT InValidMessage_textservicelevelchange(UNSIGNED1 wh) := InValidMessageFT_textservicelevelchange(wh);
EXPORT Make_version(SALT31.StrType s0) := MakeFT_version(s0);
EXPORT InValid_version(SALT31.StrType s) := InValidFT_version(s);
EXPORT InValidMessage_version(UNSIGNED1 wh) := InValidMessageFT_version(wh);
EXPORT Make_npi(SALT31.StrType s0) := MakeFT_npi(s0);
EXPORT InValid_npi(SALT31.StrType s) := InValidFT_npi(s);
EXPORT InValidMessage_npi(UNSIGNED1 wh) := InValidMessageFT_npi(wh);
EXPORT Make_npilocation(SALT31.StrType s0) := MakeFT_npilocation(s0);
EXPORT InValid_npilocation(SALT31.StrType s) := InValidFT_npilocation(s);
EXPORT InValidMessage_npilocation(UNSIGNED1 wh) := InValidMessageFT_npilocation(wh);
EXPORT Make_specialitytype1(SALT31.StrType s0) := MakeFT_specialitytype1(s0);
EXPORT InValid_specialitytype1(SALT31.StrType s) := InValidFT_specialitytype1(s);
EXPORT InValidMessage_specialitytype1(UNSIGNED1 wh) := InValidMessageFT_specialitytype1(wh);
EXPORT Make_specialitytype2(SALT31.StrType s0) := MakeFT_specialitytype2(s0);
EXPORT InValid_specialitytype2(SALT31.StrType s) := InValidFT_specialitytype2(s);
EXPORT InValidMessage_specialitytype2(UNSIGNED1 wh) := InValidMessageFT_specialitytype2(wh);
EXPORT Make_specialitytype3(SALT31.StrType s0) := MakeFT_specialitytype3(s0);
EXPORT InValid_specialitytype3(SALT31.StrType s) := InValidFT_specialitytype3(s);
EXPORT InValidMessage_specialitytype3(UNSIGNED1 wh) := InValidMessageFT_specialitytype3(wh);
EXPORT Make_specialitytype4(SALT31.StrType s0) := MakeFT_specialitytype4(s0);
EXPORT InValid_specialitytype4(SALT31.StrType s) := InValidFT_specialitytype4(s);
EXPORT InValidMessage_specialitytype4(UNSIGNED1 wh) := InValidMessageFT_specialitytype4(wh);
EXPORT Make_fileid(SALT31.StrType s0) := MakeFT_fileid(s0);
EXPORT InValid_fileid(SALT31.StrType s) := InValidFT_fileid(s);
EXPORT InValidMessage_fileid(UNSIGNED1 wh) := InValidMessageFT_fileid(wh);
EXPORT Make_medicarenumber(SALT31.StrType s0) := MakeFT_medicarenumber(s0);
EXPORT InValid_medicarenumber(SALT31.StrType s) := InValidFT_medicarenumber(s);
EXPORT InValidMessage_medicarenumber(UNSIGNED1 wh) := InValidMessageFT_medicarenumber(wh);
EXPORT Make_medicaidnumber(SALT31.StrType s0) := MakeFT_medicaidnumber(s0);
EXPORT InValid_medicaidnumber(SALT31.StrType s) := InValidFT_medicaidnumber(s);
EXPORT InValidMessage_medicaidnumber(UNSIGNED1 wh) := InValidMessageFT_medicaidnumber(wh);
EXPORT Make_dentistlicensenumber(SALT31.StrType s0) := MakeFT_dentistlicensenumber(s0);
EXPORT InValid_dentistlicensenumber(SALT31.StrType s) := InValidFT_dentistlicensenumber(s);
EXPORT InValidMessage_dentistlicensenumber(UNSIGNED1 wh) := InValidMessageFT_dentistlicensenumber(wh);
EXPORT Make_upin(SALT31.StrType s0) := MakeFT_upin(s0);
EXPORT InValid_upin(SALT31.StrType s) := InValidFT_upin(s);
EXPORT InValidMessage_upin(UNSIGNED1 wh) := InValidMessageFT_upin(wh);
EXPORT Make_pponumber(SALT31.StrType s0) := MakeFT_pponumber(s0);
EXPORT InValid_pponumber(SALT31.StrType s) := InValidFT_pponumber(s);
EXPORT InValidMessage_pponumber(UNSIGNED1 wh) := InValidMessageFT_pponumber(wh);
EXPORT Make_socialsecurity(SALT31.StrType s0) := MakeFT_socialsecurity(s0);
EXPORT InValid_socialsecurity(SALT31.StrType s) := InValidFT_socialsecurity(s);
EXPORT InValidMessage_socialsecurity(UNSIGNED1 wh) := InValidMessageFT_socialsecurity(wh);
EXPORT Make_priorauthorization(SALT31.StrType s0) := MakeFT_priorauthorization(s0);
EXPORT InValid_priorauthorization(SALT31.StrType s) := InValidFT_priorauthorization(s);
EXPORT InValidMessage_priorauthorization(UNSIGNED1 wh) := InValidMessageFT_priorauthorization(wh);
EXPORT Make_mutuallydefined(SALT31.StrType s0) := MakeFT_mutuallydefined(s0);
EXPORT InValid_mutuallydefined(SALT31.StrType s) := InValidFT_mutuallydefined(s);
EXPORT InValidMessage_mutuallydefined(UNSIGNED1 wh) := InValidMessageFT_mutuallydefined(wh);
EXPORT Make_instorencpdpid(SALT31.StrType s0) := MakeFT_instorencpdpid(s0);
EXPORT InValid_instorencpdpid(SALT31.StrType s) := InValidFT_instorencpdpid(s);
EXPORT InValidMessage_instorencpdpid(UNSIGNED1 wh) := InValidMessageFT_instorencpdpid(wh);
EXPORT Make_spec_code(SALT31.StrType s0) := MakeFT_spec_code(s0);
EXPORT InValid_spec_code(SALT31.StrType s) := InValidFT_spec_code(s);
EXPORT InValidMessage_spec_code(UNSIGNED1 wh) := InValidMessageFT_spec_code(wh);
EXPORT Make_spec_desc(SALT31.StrType s0) := MakeFT_spec_desc(s0);
EXPORT InValid_spec_desc(SALT31.StrType s) := InValidFT_spec_desc(s);
EXPORT InValidMessage_spec_desc(UNSIGNED1 wh) := InValidMessageFT_spec_desc(wh);
EXPORT Make_activity_code(SALT31.StrType s0) := MakeFT_activity_code(s0);
EXPORT InValid_activity_code(SALT31.StrType s) := InValidFT_activity_code(s);
EXPORT InValidMessage_activity_code(UNSIGNED1 wh) := InValidMessageFT_activity_code(wh);
EXPORT Make_practice_type_code(SALT31.StrType s0) := MakeFT_practice_type_code(s0);
EXPORT InValid_practice_type_code(SALT31.StrType s) := InValidFT_practice_type_code(s);
EXPORT InValidMessage_practice_type_code(UNSIGNED1 wh) := InValidMessageFT_practice_type_code(wh);
EXPORT Make_practice_type_desc(SALT31.StrType s0) := MakeFT_practice_type_desc(s0);
EXPORT InValid_practice_type_desc(SALT31.StrType s) := InValidFT_practice_type_desc(s);
EXPORT InValidMessage_practice_type_desc(UNSIGNED1 wh) := InValidMessageFT_practice_type_desc(wh);
EXPORT Make_taxonomy(SALT31.StrType s0) := MakeFT_taxonomy(s0);
EXPORT InValid_taxonomy(SALT31.StrType s) := InValidFT_taxonomy(s);
EXPORT InValidMessage_taxonomy(UNSIGNED1 wh) := InValidMessageFT_taxonomy(wh);
EXPORT Make_src(SALT31.StrType s0) := MakeFT_src(s0);
EXPORT InValid_src(SALT31.StrType s) := InValidFT_src(s);
EXPORT InValidMessage_src(UNSIGNED1 wh) := InValidMessageFT_src(wh);
EXPORT Make_dt_vendor_first_reported(SALT31.StrType s0) := MakeFT_dt_vendor_first_reported(s0);
EXPORT InValid_dt_vendor_first_reported(SALT31.StrType s) := InValidFT_dt_vendor_first_reported(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_first_reported(wh);
EXPORT Make_dt_vendor_last_reported(SALT31.StrType s0) := MakeFT_dt_vendor_last_reported(s0);
EXPORT InValid_dt_vendor_last_reported(SALT31.StrType s) := InValidFT_dt_vendor_last_reported(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_dt_vendor_last_reported(wh);
EXPORT Make_dt_first_seen(SALT31.StrType s0) := MakeFT_dt_first_seen(s0);
EXPORT InValid_dt_first_seen(SALT31.StrType s) := InValidFT_dt_first_seen(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_dt_first_seen(wh);
EXPORT Make_dt_last_seen(SALT31.StrType s0) := MakeFT_dt_last_seen(s0);
EXPORT InValid_dt_last_seen(SALT31.StrType s) := InValidFT_dt_last_seen(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_dt_last_seen(wh);
EXPORT Make_record_type(SALT31.StrType s0) := MakeFT_record_type(s0);
EXPORT InValid_record_type(SALT31.StrType s) := InValidFT_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_record_type(wh);
EXPORT Make_source_rid(SALT31.StrType s0) := MakeFT_source_rid(s0);
EXPORT InValid_source_rid(SALT31.StrType s) := InValidFT_source_rid(s);
EXPORT InValidMessage_source_rid(UNSIGNED1 wh) := InValidMessageFT_source_rid(wh);
EXPORT Make_lnpid(SALT31.StrType s0) := MakeFT_lnpid(s0);
EXPORT InValid_lnpid(SALT31.StrType s) := InValidFT_lnpid(s);
EXPORT InValidMessage_lnpid(UNSIGNED1 wh) := InValidMessageFT_lnpid(wh);
EXPORT Make_title(SALT31.StrType s0) := MakeFT_title(s0);
EXPORT InValid_title(SALT31.StrType s) := InValidFT_title(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_title(wh);
EXPORT Make_fname(SALT31.StrType s0) := MakeFT_fname(s0);
EXPORT InValid_fname(SALT31.StrType s) := InValidFT_fname(s);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_fname(wh);
EXPORT Make_mname(SALT31.StrType s0) := MakeFT_mname(s0);
EXPORT InValid_mname(SALT31.StrType s) := InValidFT_mname(s);
EXPORT InValidMessage_mname(UNSIGNED1 wh) := InValidMessageFT_mname(wh);
EXPORT Make_lname(SALT31.StrType s0) := MakeFT_lname(s0);
EXPORT InValid_lname(SALT31.StrType s) := InValidFT_lname(s);
EXPORT InValidMessage_lname(UNSIGNED1 wh) := InValidMessageFT_lname(wh);
EXPORT Make_name_suffix(SALT31.StrType s0) := MakeFT_name_suffix(s0);
EXPORT InValid_name_suffix(SALT31.StrType s) := InValidFT_name_suffix(s);
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := InValidMessageFT_name_suffix(wh);
EXPORT Make_name_type(SALT31.StrType s0) := MakeFT_name_type(s0);
EXPORT InValid_name_type(SALT31.StrType s) := InValidFT_name_type(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_name_type(wh);
EXPORT Make_nid(SALT31.StrType s0) := MakeFT_nid(s0);
EXPORT InValid_nid(SALT31.StrType s) := InValidFT_nid(s);
EXPORT InValidMessage_nid(UNSIGNED1 wh) := InValidMessageFT_nid(wh);
EXPORT Make_clean_clinic_name(SALT31.StrType s0) := MakeFT_clean_clinic_name(s0);
EXPORT InValid_clean_clinic_name(SALT31.StrType s) := InValidFT_clean_clinic_name(s);
EXPORT InValidMessage_clean_clinic_name(UNSIGNED1 wh) := InValidMessageFT_clean_clinic_name(wh);
EXPORT Make_prepped_addr1(SALT31.StrType s0) := MakeFT_prepped_addr1(s0);
EXPORT InValid_prepped_addr1(SALT31.StrType s) := InValidFT_prepped_addr1(s);
EXPORT InValidMessage_prepped_addr1(UNSIGNED1 wh) := InValidMessageFT_prepped_addr1(wh);
EXPORT Make_prepped_addr2(SALT31.StrType s0) := MakeFT_prepped_addr2(s0);
EXPORT InValid_prepped_addr2(SALT31.StrType s) := InValidFT_prepped_addr2(s);
EXPORT InValidMessage_prepped_addr2(UNSIGNED1 wh) := InValidMessageFT_prepped_addr2(wh);
EXPORT Make_prim_range(SALT31.StrType s0) := MakeFT_prim_range(s0);
EXPORT InValid_prim_range(SALT31.StrType s) := InValidFT_prim_range(s);
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := InValidMessageFT_prim_range(wh);
EXPORT Make_predir(SALT31.StrType s0) := MakeFT_predir(s0);
EXPORT InValid_predir(SALT31.StrType s) := InValidFT_predir(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_predir(wh);
EXPORT Make_prim_name(SALT31.StrType s0) := MakeFT_prim_name(s0);
EXPORT InValid_prim_name(SALT31.StrType s) := InValidFT_prim_name(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_prim_name(wh);
EXPORT Make_addr_suffix(SALT31.StrType s0) := MakeFT_addr_suffix(s0);
EXPORT InValid_addr_suffix(SALT31.StrType s) := InValidFT_addr_suffix(s);
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_addr_suffix(wh);
EXPORT Make_postdir(SALT31.StrType s0) := MakeFT_postdir(s0);
EXPORT InValid_postdir(SALT31.StrType s) := InValidFT_postdir(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_postdir(wh);
EXPORT Make_unit_desig(SALT31.StrType s0) := MakeFT_unit_desig(s0);
EXPORT InValid_unit_desig(SALT31.StrType s) := InValidFT_unit_desig(s);
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := InValidMessageFT_unit_desig(wh);
EXPORT Make_sec_range(SALT31.StrType s0) := MakeFT_sec_range(s0);
EXPORT InValid_sec_range(SALT31.StrType s) := InValidFT_sec_range(s);
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := InValidMessageFT_sec_range(wh);
EXPORT Make_p_city_name(SALT31.StrType s0) := MakeFT_p_city_name(s0);
EXPORT InValid_p_city_name(SALT31.StrType s) := InValidFT_p_city_name(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_p_city_name(wh);
EXPORT Make_v_city_name(SALT31.StrType s0) := MakeFT_v_city_name(s0);
EXPORT InValid_v_city_name(SALT31.StrType s) := InValidFT_v_city_name(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_v_city_name(wh);
EXPORT Make_st(SALT31.StrType s0) := MakeFT_st(s0);
EXPORT InValid_st(SALT31.StrType s) := InValidFT_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_st(wh);
EXPORT Make_zip(SALT31.StrType s0) := MakeFT_zip(s0);
EXPORT InValid_zip(SALT31.StrType s) := InValidFT_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_zip(wh);
EXPORT Make_zip4(SALT31.StrType s0) := MakeFT_zip4(s0);
EXPORT InValid_zip4(SALT31.StrType s) := InValidFT_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_zip4(wh);
EXPORT Make_cart(SALT31.StrType s0) := MakeFT_cart(s0);
EXPORT InValid_cart(SALT31.StrType s) := InValidFT_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_cart(wh);
EXPORT Make_cr_sort_sz(SALT31.StrType s0) := MakeFT_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT31.StrType s) := InValidFT_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_cr_sort_sz(wh);
EXPORT Make_lot(SALT31.StrType s0) := MakeFT_lot(s0);
EXPORT InValid_lot(SALT31.StrType s) := InValidFT_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_lot(wh);
EXPORT Make_lot_order(SALT31.StrType s0) := MakeFT_lot_order(s0);
EXPORT InValid_lot_order(SALT31.StrType s) := InValidFT_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_lot_order(wh);
EXPORT Make_dbpc(SALT31.StrType s0) := s0;
EXPORT InValid_dbpc(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := '';
EXPORT Make_chk_digit(SALT31.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
EXPORT Make_rec_type(SALT31.StrType s0) := s0;
EXPORT InValid_rec_type(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
EXPORT Make_fips_st(SALT31.StrType s0) := s0;
EXPORT InValid_fips_st(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_fips_st(UNSIGNED1 wh) := '';
EXPORT Make_fips_county(SALT31.StrType s0) := s0;
EXPORT InValid_fips_county(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := '';
EXPORT Make_geo_lat(SALT31.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
EXPORT Make_geo_long(SALT31.StrType s0) := s0;
EXPORT InValid_geo_long(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
EXPORT Make_msa(SALT31.StrType s0) := s0;
EXPORT InValid_msa(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
EXPORT Make_geo_blk(SALT31.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
EXPORT Make_geo_match(SALT31.StrType s0) := s0;
EXPORT InValid_geo_match(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
EXPORT Make_err_stat(SALT31.StrType s0) := s0;
EXPORT InValid_err_stat(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
EXPORT Make_rawaid(SALT31.StrType s0) := s0;
EXPORT InValid_rawaid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_rawaid(UNSIGNED1 wh) := '';
EXPORT Make_aceaid(SALT31.StrType s0) := s0;
EXPORT InValid_aceaid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_aceaid(UNSIGNED1 wh) := '';
EXPORT Make_clean_phone(SALT31.StrType s0) := s0;
EXPORT InValid_clean_phone(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := '';
EXPORT Make_dotid(SALT31.StrType s0) := s0;
EXPORT InValid_dotid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := '';
EXPORT Make_dotscore(SALT31.StrType s0) := s0;
EXPORT InValid_dotscore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := '';
EXPORT Make_dotweight(SALT31.StrType s0) := s0;
EXPORT InValid_dotweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := '';
EXPORT Make_empid(SALT31.StrType s0) := s0;
EXPORT InValid_empid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_empid(UNSIGNED1 wh) := '';
EXPORT Make_empscore(SALT31.StrType s0) := s0;
EXPORT InValid_empscore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := '';
EXPORT Make_empweight(SALT31.StrType s0) := s0;
EXPORT InValid_empweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := '';
EXPORT Make_powid(SALT31.StrType s0) := s0;
EXPORT InValid_powid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_powid(UNSIGNED1 wh) := '';
EXPORT Make_powscore(SALT31.StrType s0) := s0;
EXPORT InValid_powscore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := '';
EXPORT Make_powweight(SALT31.StrType s0) := s0;
EXPORT InValid_powweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := '';
EXPORT Make_proxid(SALT31.StrType s0) := s0;
EXPORT InValid_proxid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := '';
EXPORT Make_proxscore(SALT31.StrType s0) := s0;
EXPORT InValid_proxscore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := '';
EXPORT Make_proxweight(SALT31.StrType s0) := s0;
EXPORT InValid_proxweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := '';
EXPORT Make_seleid(SALT31.StrType s0) := s0;
EXPORT InValid_seleid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := '';
EXPORT Make_selescore(SALT31.StrType s0) := s0;
EXPORT InValid_selescore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := '';
EXPORT Make_seleweight(SALT31.StrType s0) := s0;
EXPORT InValid_seleweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := '';
EXPORT Make_orgid(SALT31.StrType s0) := s0;
EXPORT InValid_orgid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := '';
EXPORT Make_orgscore(SALT31.StrType s0) := s0;
EXPORT InValid_orgscore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := '';
EXPORT Make_orgweight(SALT31.StrType s0) := s0;
EXPORT InValid_orgweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := '';
EXPORT Make_ultid(SALT31.StrType s0) := s0;
EXPORT InValid_ultid(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := '';
EXPORT Make_ultscore(SALT31.StrType s0) := s0;
EXPORT InValid_ultscore(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := '';
EXPORT Make_ultweight(SALT31.StrType s0) := s0;
EXPORT InValid_ultweight(SALT31.StrType s) := FALSE;
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := '';
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT31,Scrubs_SureScripts;
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
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_best_dob;
    BOOLEAN Diff_best_ssn;
    BOOLEAN Diff_spi;
    BOOLEAN Diff_dea;
    BOOLEAN Diff_statelicensenumber;
    BOOLEAN Diff_specialtycodeprimary;
    BOOLEAN Diff_prefixname;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middlename;
    BOOLEAN Diff_suffixname;
    BOOLEAN Diff_clinicname;
    BOOLEAN Diff_addressline1;
    BOOLEAN Diff_addressline2;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_phoneprimary;
    BOOLEAN Diff_fax;
    BOOLEAN Diff_email;
    BOOLEAN Diff_phonealt1;
    BOOLEAN Diff_phonealt1qualifier;
    BOOLEAN Diff_phonealt2;
    BOOLEAN Diff_phonealt2qualifier;
    BOOLEAN Diff_phonealt3;
    BOOLEAN Diff_phonealt3qualifier;
    BOOLEAN Diff_phonealt4;
    BOOLEAN Diff_phonealt4qualifier;
    BOOLEAN Diff_phonealt5;
    BOOLEAN Diff_phonealt5qualifier;
    BOOLEAN Diff_activestarttime;
    BOOLEAN Diff_activeendtime;
    BOOLEAN Diff_servicelevel;
    BOOLEAN Diff_partneraccount;
    BOOLEAN Diff_lastmodifieddate;
    BOOLEAN Diff_recordchange;
    BOOLEAN Diff_oldservicelevel;
    BOOLEAN Diff_textservicelevel;
    BOOLEAN Diff_textservicelevelchange;
    BOOLEAN Diff_version;
    BOOLEAN Diff_npi;
    BOOLEAN Diff_npilocation;
    BOOLEAN Diff_specialitytype1;
    BOOLEAN Diff_specialitytype2;
    BOOLEAN Diff_specialitytype3;
    BOOLEAN Diff_specialitytype4;
    BOOLEAN Diff_fileid;
    BOOLEAN Diff_medicarenumber;
    BOOLEAN Diff_medicaidnumber;
    BOOLEAN Diff_dentistlicensenumber;
    BOOLEAN Diff_upin;
    BOOLEAN Diff_pponumber;
    BOOLEAN Diff_socialsecurity;
    BOOLEAN Diff_priorauthorization;
    BOOLEAN Diff_mutuallydefined;
    BOOLEAN Diff_instorencpdpid;
    BOOLEAN Diff_spec_code;
    BOOLEAN Diff_spec_desc;
    BOOLEAN Diff_activity_code;
    BOOLEAN Diff_practice_type_code;
    BOOLEAN Diff_practice_type_desc;
    BOOLEAN Diff_taxonomy;
    BOOLEAN Diff_src;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_source_rid;
    BOOLEAN Diff_lnpid;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_nid;
    BOOLEAN Diff_clean_clinic_name;
    BOOLEAN Diff_prepped_addr1;
    BOOLEAN Diff_prepped_addr2;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_rawaid;
    BOOLEAN Diff_aceaid;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    UNSIGNED Num_Diffs;
    SALT31.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_best_dob := le.best_dob <> ri.best_dob;
    SELF.Diff_best_ssn := le.best_ssn <> ri.best_ssn;
    SELF.Diff_spi := le.spi <> ri.spi;
    SELF.Diff_dea := le.dea <> ri.dea;
    SELF.Diff_statelicensenumber := le.statelicensenumber <> ri.statelicensenumber;
    SELF.Diff_specialtycodeprimary := le.specialtycodeprimary <> ri.specialtycodeprimary;
    SELF.Diff_prefixname := le.prefixname <> ri.prefixname;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middlename := le.middlename <> ri.middlename;
    SELF.Diff_suffixname := le.suffixname <> ri.suffixname;
    SELF.Diff_clinicname := le.clinicname <> ri.clinicname;
    SELF.Diff_addressline1 := le.addressline1 <> ri.addressline1;
    SELF.Diff_addressline2 := le.addressline2 <> ri.addressline2;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_phoneprimary := le.phoneprimary <> ri.phoneprimary;
    SELF.Diff_fax := le.fax <> ri.fax;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_phonealt1 := le.phonealt1 <> ri.phonealt1;
    SELF.Diff_phonealt1qualifier := le.phonealt1qualifier <> ri.phonealt1qualifier;
    SELF.Diff_phonealt2 := le.phonealt2 <> ri.phonealt2;
    SELF.Diff_phonealt2qualifier := le.phonealt2qualifier <> ri.phonealt2qualifier;
    SELF.Diff_phonealt3 := le.phonealt3 <> ri.phonealt3;
    SELF.Diff_phonealt3qualifier := le.phonealt3qualifier <> ri.phonealt3qualifier;
    SELF.Diff_phonealt4 := le.phonealt4 <> ri.phonealt4;
    SELF.Diff_phonealt4qualifier := le.phonealt4qualifier <> ri.phonealt4qualifier;
    SELF.Diff_phonealt5 := le.phonealt5 <> ri.phonealt5;
    SELF.Diff_phonealt5qualifier := le.phonealt5qualifier <> ri.phonealt5qualifier;
    SELF.Diff_activestarttime := le.activestarttime <> ri.activestarttime;
    SELF.Diff_activeendtime := le.activeendtime <> ri.activeendtime;
    SELF.Diff_servicelevel := le.servicelevel <> ri.servicelevel;
    SELF.Diff_partneraccount := le.partneraccount <> ri.partneraccount;
    SELF.Diff_lastmodifieddate := le.lastmodifieddate <> ri.lastmodifieddate;
    SELF.Diff_recordchange := le.recordchange <> ri.recordchange;
    SELF.Diff_oldservicelevel := le.oldservicelevel <> ri.oldservicelevel;
    SELF.Diff_textservicelevel := le.textservicelevel <> ri.textservicelevel;
    SELF.Diff_textservicelevelchange := le.textservicelevelchange <> ri.textservicelevelchange;
    SELF.Diff_version := le.version <> ri.version;
    SELF.Diff_npi := le.npi <> ri.npi;
    SELF.Diff_npilocation := le.npilocation <> ri.npilocation;
    SELF.Diff_specialitytype1 := le.specialitytype1 <> ri.specialitytype1;
    SELF.Diff_specialitytype2 := le.specialitytype2 <> ri.specialitytype2;
    SELF.Diff_specialitytype3 := le.specialitytype3 <> ri.specialitytype3;
    SELF.Diff_specialitytype4 := le.specialitytype4 <> ri.specialitytype4;
    SELF.Diff_fileid := le.fileid <> ri.fileid;
    SELF.Diff_medicarenumber := le.medicarenumber <> ri.medicarenumber;
    SELF.Diff_medicaidnumber := le.medicaidnumber <> ri.medicaidnumber;
    SELF.Diff_dentistlicensenumber := le.dentistlicensenumber <> ri.dentistlicensenumber;
    SELF.Diff_upin := le.upin <> ri.upin;
    SELF.Diff_pponumber := le.pponumber <> ri.pponumber;
    SELF.Diff_socialsecurity := le.socialsecurity <> ri.socialsecurity;
    SELF.Diff_priorauthorization := le.priorauthorization <> ri.priorauthorization;
    SELF.Diff_mutuallydefined := le.mutuallydefined <> ri.mutuallydefined;
    SELF.Diff_instorencpdpid := le.instorencpdpid <> ri.instorencpdpid;
    SELF.Diff_spec_code := le.spec_code <> ri.spec_code;
    SELF.Diff_spec_desc := le.spec_desc <> ri.spec_desc;
    SELF.Diff_activity_code := le.activity_code <> ri.activity_code;
    SELF.Diff_practice_type_code := le.practice_type_code <> ri.practice_type_code;
    SELF.Diff_practice_type_desc := le.practice_type_desc <> ri.practice_type_desc;
    SELF.Diff_taxonomy := le.taxonomy <> ri.taxonomy;
    SELF.Diff_src := le.src <> ri.src;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_source_rid := le.source_rid <> ri.source_rid;
    SELF.Diff_lnpid := le.lnpid <> ri.lnpid;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_nid := le.nid <> ri.nid;
    SELF.Diff_clean_clinic_name := le.clean_clinic_name <> ri.clean_clinic_name;
    SELF.Diff_prepped_addr1 := le.prepped_addr1 <> ri.prepped_addr1;
    SELF.Diff_prepped_addr2 := le.prepped_addr2 <> ri.prepped_addr2;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_st := le.fips_st <> ri.fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_rawaid := le.rawaid <> ri.rawaid;
    SELF.Diff_aceaid := le.aceaid <> ri.aceaid;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Val := (SALT31.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_best_dob,1,0)+ IF( SELF.Diff_best_ssn,1,0)+ IF( SELF.Diff_spi,1,0)+ IF( SELF.Diff_dea,1,0)+ IF( SELF.Diff_statelicensenumber,1,0)+ IF( SELF.Diff_specialtycodeprimary,1,0)+ IF( SELF.Diff_prefixname,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_suffixname,1,0)+ IF( SELF.Diff_clinicname,1,0)+ IF( SELF.Diff_addressline1,1,0)+ IF( SELF.Diff_addressline2,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_phoneprimary,1,0)+ IF( SELF.Diff_fax,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_phonealt1,1,0)+ IF( SELF.Diff_phonealt1qualifier,1,0)+ IF( SELF.Diff_phonealt2,1,0)+ IF( SELF.Diff_phonealt2qualifier,1,0)+ IF( SELF.Diff_phonealt3,1,0)+ IF( SELF.Diff_phonealt3qualifier,1,0)+ IF( SELF.Diff_phonealt4,1,0)+ IF( SELF.Diff_phonealt4qualifier,1,0)+ IF( SELF.Diff_phonealt5,1,0)+ IF( SELF.Diff_phonealt5qualifier,1,0)+ IF( SELF.Diff_activestarttime,1,0)+ IF( SELF.Diff_activeendtime,1,0)+ IF( SELF.Diff_servicelevel,1,0)+ IF( SELF.Diff_partneraccount,1,0)+ IF( SELF.Diff_lastmodifieddate,1,0)+ IF( SELF.Diff_recordchange,1,0)+ IF( SELF.Diff_oldservicelevel,1,0)+ IF( SELF.Diff_textservicelevel,1,0)+ IF( SELF.Diff_textservicelevelchange,1,0)+ IF( SELF.Diff_version,1,0)+ IF( SELF.Diff_npi,1,0)+ IF( SELF.Diff_npilocation,1,0)+ IF( SELF.Diff_specialitytype1,1,0)+ IF( SELF.Diff_specialitytype2,1,0)+ IF( SELF.Diff_specialitytype3,1,0)+ IF( SELF.Diff_specialitytype4,1,0)+ IF( SELF.Diff_fileid,1,0)+ IF( SELF.Diff_medicarenumber,1,0)+ IF( SELF.Diff_medicaidnumber,1,0)+ IF( SELF.Diff_dentistlicensenumber,1,0)+ IF( SELF.Diff_upin,1,0)+ IF( SELF.Diff_pponumber,1,0)+ IF( SELF.Diff_socialsecurity,1,0)+ IF( SELF.Diff_priorauthorization,1,0)+ IF( SELF.Diff_mutuallydefined,1,0)+ IF( SELF.Diff_instorencpdpid,1,0)+ IF( SELF.Diff_spec_code,1,0)+ IF( SELF.Diff_spec_desc,1,0)+ IF( SELF.Diff_activity_code,1,0)+ IF( SELF.Diff_practice_type_code,1,0)+ IF( SELF.Diff_practice_type_desc,1,0)+ IF( SELF.Diff_taxonomy,1,0)+ IF( SELF.Diff_src,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_source_rid,1,0)+ IF( SELF.Diff_lnpid,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_nid,1,0)+ IF( SELF.Diff_clean_clinic_name,1,0)+ IF( SELF.Diff_prepped_addr1,1,0)+ IF( SELF.Diff_prepped_addr2,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_rawaid,1,0)+ IF( SELF.Diff_aceaid,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0);
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
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_best_dob := COUNT(GROUP,%Closest%.Diff_best_dob);
    Count_Diff_best_ssn := COUNT(GROUP,%Closest%.Diff_best_ssn);
    Count_Diff_spi := COUNT(GROUP,%Closest%.Diff_spi);
    Count_Diff_dea := COUNT(GROUP,%Closest%.Diff_dea);
    Count_Diff_statelicensenumber := COUNT(GROUP,%Closest%.Diff_statelicensenumber);
    Count_Diff_specialtycodeprimary := COUNT(GROUP,%Closest%.Diff_specialtycodeprimary);
    Count_Diff_prefixname := COUNT(GROUP,%Closest%.Diff_prefixname);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middlename := COUNT(GROUP,%Closest%.Diff_middlename);
    Count_Diff_suffixname := COUNT(GROUP,%Closest%.Diff_suffixname);
    Count_Diff_clinicname := COUNT(GROUP,%Closest%.Diff_clinicname);
    Count_Diff_addressline1 := COUNT(GROUP,%Closest%.Diff_addressline1);
    Count_Diff_addressline2 := COUNT(GROUP,%Closest%.Diff_addressline2);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_phoneprimary := COUNT(GROUP,%Closest%.Diff_phoneprimary);
    Count_Diff_fax := COUNT(GROUP,%Closest%.Diff_fax);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_phonealt1 := COUNT(GROUP,%Closest%.Diff_phonealt1);
    Count_Diff_phonealt1qualifier := COUNT(GROUP,%Closest%.Diff_phonealt1qualifier);
    Count_Diff_phonealt2 := COUNT(GROUP,%Closest%.Diff_phonealt2);
    Count_Diff_phonealt2qualifier := COUNT(GROUP,%Closest%.Diff_phonealt2qualifier);
    Count_Diff_phonealt3 := COUNT(GROUP,%Closest%.Diff_phonealt3);
    Count_Diff_phonealt3qualifier := COUNT(GROUP,%Closest%.Diff_phonealt3qualifier);
    Count_Diff_phonealt4 := COUNT(GROUP,%Closest%.Diff_phonealt4);
    Count_Diff_phonealt4qualifier := COUNT(GROUP,%Closest%.Diff_phonealt4qualifier);
    Count_Diff_phonealt5 := COUNT(GROUP,%Closest%.Diff_phonealt5);
    Count_Diff_phonealt5qualifier := COUNT(GROUP,%Closest%.Diff_phonealt5qualifier);
    Count_Diff_activestarttime := COUNT(GROUP,%Closest%.Diff_activestarttime);
    Count_Diff_activeendtime := COUNT(GROUP,%Closest%.Diff_activeendtime);
    Count_Diff_servicelevel := COUNT(GROUP,%Closest%.Diff_servicelevel);
    Count_Diff_partneraccount := COUNT(GROUP,%Closest%.Diff_partneraccount);
    Count_Diff_lastmodifieddate := COUNT(GROUP,%Closest%.Diff_lastmodifieddate);
    Count_Diff_recordchange := COUNT(GROUP,%Closest%.Diff_recordchange);
    Count_Diff_oldservicelevel := COUNT(GROUP,%Closest%.Diff_oldservicelevel);
    Count_Diff_textservicelevel := COUNT(GROUP,%Closest%.Diff_textservicelevel);
    Count_Diff_textservicelevelchange := COUNT(GROUP,%Closest%.Diff_textservicelevelchange);
    Count_Diff_version := COUNT(GROUP,%Closest%.Diff_version);
    Count_Diff_npi := COUNT(GROUP,%Closest%.Diff_npi);
    Count_Diff_npilocation := COUNT(GROUP,%Closest%.Diff_npilocation);
    Count_Diff_specialitytype1 := COUNT(GROUP,%Closest%.Diff_specialitytype1);
    Count_Diff_specialitytype2 := COUNT(GROUP,%Closest%.Diff_specialitytype2);
    Count_Diff_specialitytype3 := COUNT(GROUP,%Closest%.Diff_specialitytype3);
    Count_Diff_specialitytype4 := COUNT(GROUP,%Closest%.Diff_specialitytype4);
    Count_Diff_fileid := COUNT(GROUP,%Closest%.Diff_fileid);
    Count_Diff_medicarenumber := COUNT(GROUP,%Closest%.Diff_medicarenumber);
    Count_Diff_medicaidnumber := COUNT(GROUP,%Closest%.Diff_medicaidnumber);
    Count_Diff_dentistlicensenumber := COUNT(GROUP,%Closest%.Diff_dentistlicensenumber);
    Count_Diff_upin := COUNT(GROUP,%Closest%.Diff_upin);
    Count_Diff_pponumber := COUNT(GROUP,%Closest%.Diff_pponumber);
    Count_Diff_socialsecurity := COUNT(GROUP,%Closest%.Diff_socialsecurity);
    Count_Diff_priorauthorization := COUNT(GROUP,%Closest%.Diff_priorauthorization);
    Count_Diff_mutuallydefined := COUNT(GROUP,%Closest%.Diff_mutuallydefined);
    Count_Diff_instorencpdpid := COUNT(GROUP,%Closest%.Diff_instorencpdpid);
    Count_Diff_spec_code := COUNT(GROUP,%Closest%.Diff_spec_code);
    Count_Diff_spec_desc := COUNT(GROUP,%Closest%.Diff_spec_desc);
    Count_Diff_activity_code := COUNT(GROUP,%Closest%.Diff_activity_code);
    Count_Diff_practice_type_code := COUNT(GROUP,%Closest%.Diff_practice_type_code);
    Count_Diff_practice_type_desc := COUNT(GROUP,%Closest%.Diff_practice_type_desc);
    Count_Diff_taxonomy := COUNT(GROUP,%Closest%.Diff_taxonomy);
    Count_Diff_src := COUNT(GROUP,%Closest%.Diff_src);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_source_rid := COUNT(GROUP,%Closest%.Diff_source_rid);
    Count_Diff_lnpid := COUNT(GROUP,%Closest%.Diff_lnpid);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_nid := COUNT(GROUP,%Closest%.Diff_nid);
    Count_Diff_clean_clinic_name := COUNT(GROUP,%Closest%.Diff_clean_clinic_name);
    Count_Diff_prepped_addr1 := COUNT(GROUP,%Closest%.Diff_prepped_addr1);
    Count_Diff_prepped_addr2 := COUNT(GROUP,%Closest%.Diff_prepped_addr2);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_st := COUNT(GROUP,%Closest%.Diff_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_rawaid := COUNT(GROUP,%Closest%.Diff_rawaid);
    Count_Diff_aceaid := COUNT(GROUP,%Closest%.Diff_aceaid);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
