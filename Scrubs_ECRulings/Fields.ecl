IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 60;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'Invalid_No','Invalid_Alpha','Invalid_AlphaChar','Invalid_AlphaNum','Invalid_AlphaNumChar','Invalid_Date','Invalid_Future','Invalid_State');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'Invalid_No' => 1,'Invalid_Alpha' => 2,'Invalid_AlphaChar' => 3,'Invalid_AlphaNum' => 4,'Invalid_AlphaNumChar' => 5,'Invalid_Date' => 6,'Invalid_Future' => 7,'Invalid_State' => 8,0);
 
EXPORT MakeFT_Invalid_No(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_No(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_Invalid_No(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Alpha(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_Alpha(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,:;-\'/()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ .,:;-\'/()'))));
EXPORT InValidMessageFT_Invalid_AlphaChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ .,:;-\'/()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNum(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNum(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_Invalid_AlphaNum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_AlphaNumChar(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,:;-\'/()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_Invalid_AlphaNumChar(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,:;-\'/()'))));
EXPORT InValidMessageFT_Invalid_AlphaNumChar(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,:;-\'/()'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_Invalid_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_Future(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_Invalid_Future(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s,'future')>0);
EXPORT InValidMessageFT_Invalid_Future(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_Invalid_State(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_Invalid_Alpha(s1);
END;
EXPORT InValidFT_Invalid_State(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_Invalid_State(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','euid','policyarea','casenumber','memberstate','lastdecisiondate','title','businessname','region','primaryobjective','aidinstrument','casetype','durationdatefrom','durationdateto','notificationregistrationdate','dgresponsible','relatedcasenumber1','relatedcaseinformation1','relatedcasenumber2','relatedcaseinformation2','relatedcasenumber3','relatedcaseinformation3','relatedcasenumber4','relatedcaseinformation4','relatedcasenumber5','relatedcaseinformation5','provisionaldeadlinedate','provisionaldeadlinearticle','provisionaldeadlinestatus','regulation','relatedlink','decpubid','decisiondate','decisionarticle','decisiondetails','pressrelease','pressreleasedate','publicationjournaldate','publicationjournal','publicationjournaledition','publicationjournalyear','publicationpriorjournal','publicationpriorjournaldate','econactid','economicactivity','compeventid','eventdate','eventdoctype','eventdocument','did','bdid','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','eu_country_code');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dartid','dateadded','dateupdated','website','state','euid','policyarea','casenumber','memberstate','lastdecisiondate','title','businessname','region','primaryobjective','aidinstrument','casetype','durationdatefrom','durationdateto','notificationregistrationdate','dgresponsible','relatedcasenumber1','relatedcaseinformation1','relatedcasenumber2','relatedcaseinformation2','relatedcasenumber3','relatedcaseinformation3','relatedcasenumber4','relatedcaseinformation4','relatedcasenumber5','relatedcaseinformation5','provisionaldeadlinedate','provisionaldeadlinearticle','provisionaldeadlinestatus','regulation','relatedlink','decpubid','decisiondate','decisionarticle','decisiondetails','pressrelease','pressreleasedate','publicationjournaldate','publicationjournal','publicationjournaledition','publicationjournalyear','publicationpriorjournal','publicationpriorjournaldate','econactid','economicactivity','compeventid','eventdate','eventdoctype','eventdocument','did','bdid','dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','eu_country_code');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dartid' => 0,'dateadded' => 1,'dateupdated' => 2,'website' => 3,'state' => 4,'euid' => 5,'policyarea' => 6,'casenumber' => 7,'memberstate' => 8,'lastdecisiondate' => 9,'title' => 10,'businessname' => 11,'region' => 12,'primaryobjective' => 13,'aidinstrument' => 14,'casetype' => 15,'durationdatefrom' => 16,'durationdateto' => 17,'notificationregistrationdate' => 18,'dgresponsible' => 19,'relatedcasenumber1' => 20,'relatedcaseinformation1' => 21,'relatedcasenumber2' => 22,'relatedcaseinformation2' => 23,'relatedcasenumber3' => 24,'relatedcaseinformation3' => 25,'relatedcasenumber4' => 26,'relatedcaseinformation4' => 27,'relatedcasenumber5' => 28,'relatedcaseinformation5' => 29,'provisionaldeadlinedate' => 30,'provisionaldeadlinearticle' => 31,'provisionaldeadlinestatus' => 32,'regulation' => 33,'relatedlink' => 34,'decpubid' => 35,'decisiondate' => 36,'decisionarticle' => 37,'decisiondetails' => 38,'pressrelease' => 39,'pressreleasedate' => 40,'publicationjournaldate' => 41,'publicationjournal' => 42,'publicationjournaledition' => 43,'publicationjournalyear' => 44,'publicationpriorjournal' => 45,'publicationpriorjournaldate' => 46,'econactid' => 47,'economicactivity' => 48,'compeventid' => 49,'eventdate' => 50,'eventdoctype' => 51,'eventdocument' => 52,'did' => 53,'bdid' => 54,'dt_vendor_first_reported' => 55,'dt_vendor_last_reported' => 56,'dt_first_seen' => 57,'dt_last_seen' => 58,'eu_country_code' => 59,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],['ALLOW'],[],['ALLOW'],[],['ALLOW'],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dartid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_dartid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dateadded(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateadded(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateadded(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dateupdated(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dateupdated(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dateupdated(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_website(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_website(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_website(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
EXPORT Make_euid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_euid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_euid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_policyarea(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_policyarea(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_policyarea(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_casenumber(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_casenumber(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_casenumber(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_memberstate(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_memberstate(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_memberstate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_lastdecisiondate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_lastdecisiondate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_lastdecisiondate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_title(SALT311.StrType s0) := s0;
EXPORT InValid_title(SALT311.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_businessname(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_businessname(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_businessname(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_region(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_region(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_region(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_primaryobjective(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_primaryobjective(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_primaryobjective(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_aidinstrument(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_aidinstrument(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_aidinstrument(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_casetype(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_casetype(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_casetype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_durationdatefrom(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_durationdatefrom(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_durationdatefrom(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_durationdateto(SALT311.StrType s0) := MakeFT_Invalid_Future(s0);
EXPORT InValid_durationdateto(SALT311.StrType s) := InValidFT_Invalid_Future(s);
EXPORT InValidMessage_durationdateto(UNSIGNED1 wh) := InValidMessageFT_Invalid_Future(wh);
 
EXPORT Make_notificationregistrationdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_notificationregistrationdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_notificationregistrationdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dgresponsible(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_dgresponsible(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_dgresponsible(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_relatedcasenumber1(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_relatedcasenumber1(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_relatedcasenumber1(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_relatedcaseinformation1(SALT311.StrType s0) := s0;
EXPORT InValid_relatedcaseinformation1(SALT311.StrType s) := 0;
EXPORT InValidMessage_relatedcaseinformation1(UNSIGNED1 wh) := '';
 
EXPORT Make_relatedcasenumber2(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_relatedcasenumber2(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_relatedcasenumber2(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_relatedcaseinformation2(SALT311.StrType s0) := s0;
EXPORT InValid_relatedcaseinformation2(SALT311.StrType s) := 0;
EXPORT InValidMessage_relatedcaseinformation2(UNSIGNED1 wh) := '';
 
EXPORT Make_relatedcasenumber3(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_relatedcasenumber3(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_relatedcasenumber3(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_relatedcaseinformation3(SALT311.StrType s0) := s0;
EXPORT InValid_relatedcaseinformation3(SALT311.StrType s) := 0;
EXPORT InValidMessage_relatedcaseinformation3(UNSIGNED1 wh) := '';
 
EXPORT Make_relatedcasenumber4(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_relatedcasenumber4(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_relatedcasenumber4(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_relatedcaseinformation4(SALT311.StrType s0) := s0;
EXPORT InValid_relatedcaseinformation4(SALT311.StrType s) := 0;
EXPORT InValidMessage_relatedcaseinformation4(UNSIGNED1 wh) := '';
 
EXPORT Make_relatedcasenumber5(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_relatedcasenumber5(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_relatedcasenumber5(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_relatedcaseinformation5(SALT311.StrType s0) := s0;
EXPORT InValid_relatedcaseinformation5(SALT311.StrType s) := 0;
EXPORT InValidMessage_relatedcaseinformation5(UNSIGNED1 wh) := '';
 
EXPORT Make_provisionaldeadlinedate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_provisionaldeadlinedate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_provisionaldeadlinedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_provisionaldeadlinearticle(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_provisionaldeadlinearticle(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_provisionaldeadlinearticle(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_provisionaldeadlinestatus(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_provisionaldeadlinestatus(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_provisionaldeadlinestatus(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_regulation(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_regulation(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_regulation(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_relatedlink(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_relatedlink(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_relatedlink(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_decpubid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_decpubid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_decpubid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_decisiondate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_decisiondate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_decisiondate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_decisionarticle(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_decisionarticle(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_decisionarticle(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_decisiondetails(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_decisiondetails(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_decisiondetails(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_pressrelease(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_pressrelease(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_pressrelease(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_pressreleasedate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_pressreleasedate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_pressreleasedate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_publicationjournaldate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_publicationjournaldate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_publicationjournaldate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_publicationjournal(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_publicationjournal(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_publicationjournal(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_publicationjournaledition(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_publicationjournaledition(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_publicationjournaledition(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_publicationjournalyear(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_publicationjournalyear(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_publicationjournalyear(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_publicationpriorjournal(SALT311.StrType s0) := MakeFT_Invalid_AlphaNum(s0);
EXPORT InValid_publicationpriorjournal(SALT311.StrType s) := InValidFT_Invalid_AlphaNum(s);
EXPORT InValidMessage_publicationpriorjournal(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNum(wh);
 
EXPORT Make_publicationpriorjournaldate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_publicationpriorjournaldate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_publicationpriorjournaldate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_econactid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_econactid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_econactid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_economicactivity(SALT311.StrType s0) := MakeFT_Invalid_AlphaNumChar(s0);
EXPORT InValid_economicactivity(SALT311.StrType s) := InValidFT_Invalid_AlphaNumChar(s);
EXPORT InValidMessage_economicactivity(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaNumChar(wh);
 
EXPORT Make_compeventid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_compeventid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_compeventid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_eventdate(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_eventdate(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_eventdate(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_eventdoctype(SALT311.StrType s0) := MakeFT_Invalid_Alpha(s0);
EXPORT InValid_eventdoctype(SALT311.StrType s) := InValidFT_Invalid_Alpha(s);
EXPORT InValidMessage_eventdoctype(UNSIGNED1 wh) := InValidMessageFT_Invalid_Alpha(wh);
 
EXPORT Make_eventdocument(SALT311.StrType s0) := MakeFT_Invalid_AlphaChar(s0);
EXPORT InValid_eventdocument(SALT311.StrType s) := InValidFT_Invalid_AlphaChar(s);
EXPORT InValidMessage_eventdocument(UNSIGNED1 wh) := InValidMessageFT_Invalid_AlphaChar(wh);
 
EXPORT Make_did(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_did(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_Invalid_No(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_Invalid_No(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_Invalid_No(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_Invalid_Date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_Invalid_Date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_Invalid_Date(wh);
 
EXPORT Make_eu_country_code(SALT311.StrType s0) := MakeFT_Invalid_State(s0);
EXPORT InValid_eu_country_code(SALT311.StrType s) := InValidFT_Invalid_State(s);
EXPORT InValidMessage_eu_country_code(UNSIGNED1 wh) := InValidMessageFT_Invalid_State(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_ECRulings;
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
    BOOLEAN Diff_dartid;
    BOOLEAN Diff_dateadded;
    BOOLEAN Diff_dateupdated;
    BOOLEAN Diff_website;
    BOOLEAN Diff_state;
    BOOLEAN Diff_euid;
    BOOLEAN Diff_policyarea;
    BOOLEAN Diff_casenumber;
    BOOLEAN Diff_memberstate;
    BOOLEAN Diff_lastdecisiondate;
    BOOLEAN Diff_title;
    BOOLEAN Diff_businessname;
    BOOLEAN Diff_region;
    BOOLEAN Diff_primaryobjective;
    BOOLEAN Diff_aidinstrument;
    BOOLEAN Diff_casetype;
    BOOLEAN Diff_durationdatefrom;
    BOOLEAN Diff_durationdateto;
    BOOLEAN Diff_notificationregistrationdate;
    BOOLEAN Diff_dgresponsible;
    BOOLEAN Diff_relatedcasenumber1;
    BOOLEAN Diff_relatedcaseinformation1;
    BOOLEAN Diff_relatedcasenumber2;
    BOOLEAN Diff_relatedcaseinformation2;
    BOOLEAN Diff_relatedcasenumber3;
    BOOLEAN Diff_relatedcaseinformation3;
    BOOLEAN Diff_relatedcasenumber4;
    BOOLEAN Diff_relatedcaseinformation4;
    BOOLEAN Diff_relatedcasenumber5;
    BOOLEAN Diff_relatedcaseinformation5;
    BOOLEAN Diff_provisionaldeadlinedate;
    BOOLEAN Diff_provisionaldeadlinearticle;
    BOOLEAN Diff_provisionaldeadlinestatus;
    BOOLEAN Diff_regulation;
    BOOLEAN Diff_relatedlink;
    BOOLEAN Diff_decpubid;
    BOOLEAN Diff_decisiondate;
    BOOLEAN Diff_decisionarticle;
    BOOLEAN Diff_decisiondetails;
    BOOLEAN Diff_pressrelease;
    BOOLEAN Diff_pressreleasedate;
    BOOLEAN Diff_publicationjournaldate;
    BOOLEAN Diff_publicationjournal;
    BOOLEAN Diff_publicationjournaledition;
    BOOLEAN Diff_publicationjournalyear;
    BOOLEAN Diff_publicationpriorjournal;
    BOOLEAN Diff_publicationpriorjournaldate;
    BOOLEAN Diff_econactid;
    BOOLEAN Diff_economicactivity;
    BOOLEAN Diff_compeventid;
    BOOLEAN Diff_eventdate;
    BOOLEAN Diff_eventdoctype;
    BOOLEAN Diff_eventdocument;
    BOOLEAN Diff_did;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_eu_country_code;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dartid := le.dartid <> ri.dartid;
    SELF.Diff_dateadded := le.dateadded <> ri.dateadded;
    SELF.Diff_dateupdated := le.dateupdated <> ri.dateupdated;
    SELF.Diff_website := le.website <> ri.website;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_euid := le.euid <> ri.euid;
    SELF.Diff_policyarea := le.policyarea <> ri.policyarea;
    SELF.Diff_casenumber := le.casenumber <> ri.casenumber;
    SELF.Diff_memberstate := le.memberstate <> ri.memberstate;
    SELF.Diff_lastdecisiondate := le.lastdecisiondate <> ri.lastdecisiondate;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_businessname := le.businessname <> ri.businessname;
    SELF.Diff_region := le.region <> ri.region;
    SELF.Diff_primaryobjective := le.primaryobjective <> ri.primaryobjective;
    SELF.Diff_aidinstrument := le.aidinstrument <> ri.aidinstrument;
    SELF.Diff_casetype := le.casetype <> ri.casetype;
    SELF.Diff_durationdatefrom := le.durationdatefrom <> ri.durationdatefrom;
    SELF.Diff_durationdateto := le.durationdateto <> ri.durationdateto;
    SELF.Diff_notificationregistrationdate := le.notificationregistrationdate <> ri.notificationregistrationdate;
    SELF.Diff_dgresponsible := le.dgresponsible <> ri.dgresponsible;
    SELF.Diff_relatedcasenumber1 := le.relatedcasenumber1 <> ri.relatedcasenumber1;
    SELF.Diff_relatedcaseinformation1 := le.relatedcaseinformation1 <> ri.relatedcaseinformation1;
    SELF.Diff_relatedcasenumber2 := le.relatedcasenumber2 <> ri.relatedcasenumber2;
    SELF.Diff_relatedcaseinformation2 := le.relatedcaseinformation2 <> ri.relatedcaseinformation2;
    SELF.Diff_relatedcasenumber3 := le.relatedcasenumber3 <> ri.relatedcasenumber3;
    SELF.Diff_relatedcaseinformation3 := le.relatedcaseinformation3 <> ri.relatedcaseinformation3;
    SELF.Diff_relatedcasenumber4 := le.relatedcasenumber4 <> ri.relatedcasenumber4;
    SELF.Diff_relatedcaseinformation4 := le.relatedcaseinformation4 <> ri.relatedcaseinformation4;
    SELF.Diff_relatedcasenumber5 := le.relatedcasenumber5 <> ri.relatedcasenumber5;
    SELF.Diff_relatedcaseinformation5 := le.relatedcaseinformation5 <> ri.relatedcaseinformation5;
    SELF.Diff_provisionaldeadlinedate := le.provisionaldeadlinedate <> ri.provisionaldeadlinedate;
    SELF.Diff_provisionaldeadlinearticle := le.provisionaldeadlinearticle <> ri.provisionaldeadlinearticle;
    SELF.Diff_provisionaldeadlinestatus := le.provisionaldeadlinestatus <> ri.provisionaldeadlinestatus;
    SELF.Diff_regulation := le.regulation <> ri.regulation;
    SELF.Diff_relatedlink := le.relatedlink <> ri.relatedlink;
    SELF.Diff_decpubid := le.decpubid <> ri.decpubid;
    SELF.Diff_decisiondate := le.decisiondate <> ri.decisiondate;
    SELF.Diff_decisionarticle := le.decisionarticle <> ri.decisionarticle;
    SELF.Diff_decisiondetails := le.decisiondetails <> ri.decisiondetails;
    SELF.Diff_pressrelease := le.pressrelease <> ri.pressrelease;
    SELF.Diff_pressreleasedate := le.pressreleasedate <> ri.pressreleasedate;
    SELF.Diff_publicationjournaldate := le.publicationjournaldate <> ri.publicationjournaldate;
    SELF.Diff_publicationjournal := le.publicationjournal <> ri.publicationjournal;
    SELF.Diff_publicationjournaledition := le.publicationjournaledition <> ri.publicationjournaledition;
    SELF.Diff_publicationjournalyear := le.publicationjournalyear <> ri.publicationjournalyear;
    SELF.Diff_publicationpriorjournal := le.publicationpriorjournal <> ri.publicationpriorjournal;
    SELF.Diff_publicationpriorjournaldate := le.publicationpriorjournaldate <> ri.publicationpriorjournaldate;
    SELF.Diff_econactid := le.econactid <> ri.econactid;
    SELF.Diff_economicactivity := le.economicactivity <> ri.economicactivity;
    SELF.Diff_compeventid := le.compeventid <> ri.compeventid;
    SELF.Diff_eventdate := le.eventdate <> ri.eventdate;
    SELF.Diff_eventdoctype := le.eventdoctype <> ri.eventdoctype;
    SELF.Diff_eventdocument := le.eventdocument <> ri.eventdocument;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_eu_country_code := le.eu_country_code <> ri.eu_country_code;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_dateadded,1,0)+ IF( SELF.Diff_dateupdated,1,0)+ IF( SELF.Diff_website,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_euid,1,0)+ IF( SELF.Diff_policyarea,1,0)+ IF( SELF.Diff_casenumber,1,0)+ IF( SELF.Diff_memberstate,1,0)+ IF( SELF.Diff_lastdecisiondate,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_businessname,1,0)+ IF( SELF.Diff_region,1,0)+ IF( SELF.Diff_primaryobjective,1,0)+ IF( SELF.Diff_aidinstrument,1,0)+ IF( SELF.Diff_casetype,1,0)+ IF( SELF.Diff_durationdatefrom,1,0)+ IF( SELF.Diff_durationdateto,1,0)+ IF( SELF.Diff_notificationregistrationdate,1,0)+ IF( SELF.Diff_dgresponsible,1,0)+ IF( SELF.Diff_relatedcasenumber1,1,0)+ IF( SELF.Diff_relatedcaseinformation1,1,0)+ IF( SELF.Diff_relatedcasenumber2,1,0)+ IF( SELF.Diff_relatedcaseinformation2,1,0)+ IF( SELF.Diff_relatedcasenumber3,1,0)+ IF( SELF.Diff_relatedcaseinformation3,1,0)+ IF( SELF.Diff_relatedcasenumber4,1,0)+ IF( SELF.Diff_relatedcaseinformation4,1,0)+ IF( SELF.Diff_relatedcasenumber5,1,0)+ IF( SELF.Diff_relatedcaseinformation5,1,0)+ IF( SELF.Diff_provisionaldeadlinedate,1,0)+ IF( SELF.Diff_provisionaldeadlinearticle,1,0)+ IF( SELF.Diff_provisionaldeadlinestatus,1,0)+ IF( SELF.Diff_regulation,1,0)+ IF( SELF.Diff_relatedlink,1,0)+ IF( SELF.Diff_decpubid,1,0)+ IF( SELF.Diff_decisiondate,1,0)+ IF( SELF.Diff_decisionarticle,1,0)+ IF( SELF.Diff_decisiondetails,1,0)+ IF( SELF.Diff_pressrelease,1,0)+ IF( SELF.Diff_pressreleasedate,1,0)+ IF( SELF.Diff_publicationjournaldate,1,0)+ IF( SELF.Diff_publicationjournal,1,0)+ IF( SELF.Diff_publicationjournaledition,1,0)+ IF( SELF.Diff_publicationjournalyear,1,0)+ IF( SELF.Diff_publicationpriorjournal,1,0)+ IF( SELF.Diff_publicationpriorjournaldate,1,0)+ IF( SELF.Diff_econactid,1,0)+ IF( SELF.Diff_economicactivity,1,0)+ IF( SELF.Diff_compeventid,1,0)+ IF( SELF.Diff_eventdate,1,0)+ IF( SELF.Diff_eventdoctype,1,0)+ IF( SELF.Diff_eventdocument,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_eu_country_code,1,0);
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
    Count_Diff_dartid := COUNT(GROUP,%Closest%.Diff_dartid);
    Count_Diff_dateadded := COUNT(GROUP,%Closest%.Diff_dateadded);
    Count_Diff_dateupdated := COUNT(GROUP,%Closest%.Diff_dateupdated);
    Count_Diff_website := COUNT(GROUP,%Closest%.Diff_website);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_euid := COUNT(GROUP,%Closest%.Diff_euid);
    Count_Diff_policyarea := COUNT(GROUP,%Closest%.Diff_policyarea);
    Count_Diff_casenumber := COUNT(GROUP,%Closest%.Diff_casenumber);
    Count_Diff_memberstate := COUNT(GROUP,%Closest%.Diff_memberstate);
    Count_Diff_lastdecisiondate := COUNT(GROUP,%Closest%.Diff_lastdecisiondate);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_businessname := COUNT(GROUP,%Closest%.Diff_businessname);
    Count_Diff_region := COUNT(GROUP,%Closest%.Diff_region);
    Count_Diff_primaryobjective := COUNT(GROUP,%Closest%.Diff_primaryobjective);
    Count_Diff_aidinstrument := COUNT(GROUP,%Closest%.Diff_aidinstrument);
    Count_Diff_casetype := COUNT(GROUP,%Closest%.Diff_casetype);
    Count_Diff_durationdatefrom := COUNT(GROUP,%Closest%.Diff_durationdatefrom);
    Count_Diff_durationdateto := COUNT(GROUP,%Closest%.Diff_durationdateto);
    Count_Diff_notificationregistrationdate := COUNT(GROUP,%Closest%.Diff_notificationregistrationdate);
    Count_Diff_dgresponsible := COUNT(GROUP,%Closest%.Diff_dgresponsible);
    Count_Diff_relatedcasenumber1 := COUNT(GROUP,%Closest%.Diff_relatedcasenumber1);
    Count_Diff_relatedcaseinformation1 := COUNT(GROUP,%Closest%.Diff_relatedcaseinformation1);
    Count_Diff_relatedcasenumber2 := COUNT(GROUP,%Closest%.Diff_relatedcasenumber2);
    Count_Diff_relatedcaseinformation2 := COUNT(GROUP,%Closest%.Diff_relatedcaseinformation2);
    Count_Diff_relatedcasenumber3 := COUNT(GROUP,%Closest%.Diff_relatedcasenumber3);
    Count_Diff_relatedcaseinformation3 := COUNT(GROUP,%Closest%.Diff_relatedcaseinformation3);
    Count_Diff_relatedcasenumber4 := COUNT(GROUP,%Closest%.Diff_relatedcasenumber4);
    Count_Diff_relatedcaseinformation4 := COUNT(GROUP,%Closest%.Diff_relatedcaseinformation4);
    Count_Diff_relatedcasenumber5 := COUNT(GROUP,%Closest%.Diff_relatedcasenumber5);
    Count_Diff_relatedcaseinformation5 := COUNT(GROUP,%Closest%.Diff_relatedcaseinformation5);
    Count_Diff_provisionaldeadlinedate := COUNT(GROUP,%Closest%.Diff_provisionaldeadlinedate);
    Count_Diff_provisionaldeadlinearticle := COUNT(GROUP,%Closest%.Diff_provisionaldeadlinearticle);
    Count_Diff_provisionaldeadlinestatus := COUNT(GROUP,%Closest%.Diff_provisionaldeadlinestatus);
    Count_Diff_regulation := COUNT(GROUP,%Closest%.Diff_regulation);
    Count_Diff_relatedlink := COUNT(GROUP,%Closest%.Diff_relatedlink);
    Count_Diff_decpubid := COUNT(GROUP,%Closest%.Diff_decpubid);
    Count_Diff_decisiondate := COUNT(GROUP,%Closest%.Diff_decisiondate);
    Count_Diff_decisionarticle := COUNT(GROUP,%Closest%.Diff_decisionarticle);
    Count_Diff_decisiondetails := COUNT(GROUP,%Closest%.Diff_decisiondetails);
    Count_Diff_pressrelease := COUNT(GROUP,%Closest%.Diff_pressrelease);
    Count_Diff_pressreleasedate := COUNT(GROUP,%Closest%.Diff_pressreleasedate);
    Count_Diff_publicationjournaldate := COUNT(GROUP,%Closest%.Diff_publicationjournaldate);
    Count_Diff_publicationjournal := COUNT(GROUP,%Closest%.Diff_publicationjournal);
    Count_Diff_publicationjournaledition := COUNT(GROUP,%Closest%.Diff_publicationjournaledition);
    Count_Diff_publicationjournalyear := COUNT(GROUP,%Closest%.Diff_publicationjournalyear);
    Count_Diff_publicationpriorjournal := COUNT(GROUP,%Closest%.Diff_publicationpriorjournal);
    Count_Diff_publicationpriorjournaldate := COUNT(GROUP,%Closest%.Diff_publicationpriorjournaldate);
    Count_Diff_econactid := COUNT(GROUP,%Closest%.Diff_econactid);
    Count_Diff_economicactivity := COUNT(GROUP,%Closest%.Diff_economicactivity);
    Count_Diff_compeventid := COUNT(GROUP,%Closest%.Diff_compeventid);
    Count_Diff_eventdate := COUNT(GROUP,%Closest%.Diff_eventdate);
    Count_Diff_eventdoctype := COUNT(GROUP,%Closest%.Diff_eventdoctype);
    Count_Diff_eventdocument := COUNT(GROUP,%Closest%.Diff_eventdocument);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_eu_country_code := COUNT(GROUP,%Closest%.Diff_eu_country_code);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
