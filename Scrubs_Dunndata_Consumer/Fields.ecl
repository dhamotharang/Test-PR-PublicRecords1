IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE

EXPORT NumFields := 633;

// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'DEFAULT','NUMBER','ALPHA','WORDBAG','CITY','ST','FULLNAME','STREET_ADDR','FULL_ADDRESS','ZIP5','HASZIP4','ALPHANUMERIC','GENDER_CODE','INC_CODE','OPC_CODE','EDU_CODE','RELIG_CODE','DWELL_CODE','GENERAL_CODE','invalid_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'DEFAULT' => 1,'NUMBER' => 2,'ALPHA' => 3,'WORDBAG' => 4,'CITY' => 5,'ST' => 6,'FULLNAME' => 7,'STREET_ADDR' => 8,'FULL_ADDRESS' => 9,'ZIP5' => 10,'HASZIP4' => 11,'ALPHANUMERIC' => 12,'GENDER_CODE' => 13,'INC_CODE' => 14,'OPC_CODE' => 15,'EDU_CODE' => 16,'RELIG_CODE' => 17,'DWELL_CODE' => 18,'GENERAL_CODE' => 19,'invalid_date' => 20,0);

EXPORT MakeFT_DEFAULT(SALT311.StrType s0) := FUNCTION
  s1 := if ( SALT311.StringFind('"\'',s0[1],1)>0 and SALT311.StringFind('"\'',s0[LENGTH(TRIM(s0))],1)>0,s0[2..LENGTH(TRIM(s0))-1],s0 );// Remove quotes if required
  s2 := TRIM(s1,LEFT); // Left trim
  RETURN  s2;
END;
EXPORT InValidFT_DEFAULT(SALT311.StrType s) := WHICH(s[1]=' ' AND LENGTH(TRIM(s))>0,SALT311.StringFind('"\'',s[1],1)<>0 and SALT311.StringFind('"\'',s[LENGTH(TRIM(s))],1)<>0);
EXPORT InValidMessageFT_DEFAULT(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLeft,SALT311.HygieneErrors.Inquotes('"\''),SALT311.HygieneErrors.Good);

EXPORT MakeFT_NUMBER(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_NUMBER(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_NUMBER(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_ALPHA(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ALPHA(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'))));
EXPORT InValidMessageFT_ALPHA(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_WORDBAG(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,./()',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_WORDBAG(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'))));
EXPORT InValidMessageFT_WORDBAG(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_CITY(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,./()',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_CITY(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 2));
EXPORT InValidMessageFT_CITY(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'),SALT311.HygieneErrors.NotLength('0,2..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_ST(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&.,;: -'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,'&.,;: -',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_ALPHA(s2);
END;
EXPORT InValidFT_ST(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&.,;: -'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 2),~(SALT311.WordCount(SALT311.StringSubstituteOut(s,'&.,;: -',' ')) = 1));
EXPORT InValidMessageFT_ST(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz&.,;: -'),SALT311.HygieneErrors.NotLength('0,2..'),SALT311.HygieneErrors.NotWords('1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_FULLNAME(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"`#@-_ <>{}[]-^=!+&,./()%;:*'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,./()%;:*',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_FULLNAME(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"`#@-_ <>{}[]-^=!+&,./()%;:*'))));
EXPORT InValidMessageFT_FULLNAME(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"`#@-_ <>{}[]-^=!+&,./()%;:*'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_STREET_ADDR(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,./()',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_STREET_ADDR(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'))));
EXPORT InValidMessageFT_STREET_ADDR(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_FULL_ADDRESS(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,./()',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_FULL_ADDRESS(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'))));
EXPORT InValidMessageFT_FULL_ADDRESS(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_ZIP5(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_ZIP5(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_ZIP5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,5'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_HASZIP4(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_HASZIP4(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 4));
EXPORT InValidMessageFT_HASZIP4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('0,4'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_ALPHANUMERIC(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'); // Only allow valid symbols
  s2 := SALT311.stringcleanspaces( SALT311.stringsubstituteout(s1,' <>{}[]-^=!+&,./()',' ') ); // Insert spaces but avoid doubles
  RETURN  MakeFT_WORDBAG(s2);
END;
EXPORT InValidFT_ALPHANUMERIC(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_ALPHANUMERIC(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$\'"#` <>{}[]-^=!+&,./()'),SALT311.HygieneErrors.NotLength('0,1..'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_GENDER_CODE(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_GENDER_CODE(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U','-','.',' '],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_GENDER_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U|-|.| '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_INC_CODE(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_INC_CODE(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O',' '],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_INC_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|L|M|N|O| '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_OPC_CODE(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_OPC_CODE(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','1','2','3','4','5',' '],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_OPC_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|1|2|3|4|5| '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_EDU_CODE(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_EDU_CODE(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','3','4','5','6','.',' '],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_EDU_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|3|4|5|6|.| '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_RELIG_CODE(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_RELIG_CODE(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['B','C','G','H','I','J','K','L','M','O','P','S','X','E',' '],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_RELIG_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('B|C|G|H|I|J|K|L|M|O|P|S|X|E| '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_DWELL_CODE(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_DWELL_CODE(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['S','M','B','C','A','D','T',' '],~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_DWELL_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('S|M|B|C|A|D|T| '),SALT311.HygieneErrors.NotLength('0,1'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_GENERAL_CODE(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_GENERAL_CODE(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_GENERAL_CODE(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'),SALT311.HygieneErrors.NotLength('0,2'),SALT311.HygieneErrors.Good);

EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_date'),SALT311.HygieneErrors.Good);


EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dtmatch','msname','msaddr1','msaddr2','mscity','msstate','mszip5','mszip4','dthh','mscrrt','msdpbc','msdpv','ms_addrtype','ctysize','lmos','omos','pmos','gen','dob','age','inc','marital_status','poc','noc','ocp','edu','lang','relig','dwell','ownr','eth1','eth2','lor','pool','speak_span','soho','vet_in_hh','ms_mags','ms_books','ms_publish','ms_pub_status_active','ms_pub_status_expire','ms_pub_premsold','ms_pub_autornwl','ms_pub_avgterm','ms_pub_lmos','ms_pub_omos','ms_pub_pmos','ms_pub_cemos','ms_pub_femos','ms_pub_totords','ms_pub_totdlrs','ms_pub_avgdlrs','ms_pub_lastdlrs','ms_pub_paystat_paid','ms_pub_paystat_ub','ms_pub_paymeth_cc','ms_pub_paymeth_cash','ms_pub_payspeed','ms_pub_osrc_dm','ms_pub_lsrc_dm','ms_pub_osrc_agt_cashf','ms_pub_lsrc_agt_cashf','ms_pub_osrc_agt_pds','ms_pub_lsrc_agt_pds','ms_pub_osrc_agt_schplan','ms_pub_lsrc_agt_schplan','ms_pub_osrc_agt_sponsor','ms_pub_lsrc_agt_sponsor','ms_pub_osrc_agt_tm','ms_pub_lsrc_agt_tm','ms_pub_osrc_agt','ms_pub_lsrc_agt','ms_pub_osrc_tm','ms_pub_lsrc_tm','ms_pub_osrc_ins','ms_pub_lsrc_ins','ms_pub_osrc_net','ms_pub_lsrc_net','ms_pub_osrc_print','ms_pub_lsrc_print','ms_pub_osrc_trans','ms_pub_lsrc_trans','ms_pub_osrc_tv','ms_pub_lsrc_tv','ms_pub_osrc_dtp','ms_pub_lsrc_dtp','ms_pub_giftgivr','ms_pub_giftee','ms_catalog','ms_cat_lmos','ms_cat_omos','ms_cat_pmos','ms_cat_totords','ms_cat_totitems','ms_cat_totdlrs','ms_cat_avgdlrs','ms_cat_lastdlrs','ms_cat_paystat_paid','ms_cat_paymeth_cc','ms_cat_paymeth_cash','ms_cat_osrc_dm','ms_cat_lsrc_dm','ms_cat_osrc_net','ms_cat_lsrc_net','ms_cat_giftgivr','pkpubs_corrected','pkcatg_corrected','ms_fundraising','ms_fund_lmos','ms_fund_omos','ms_fund_pmos','ms_fund_totords','ms_fund_totdlrs','ms_fund_avgdlrs','ms_fund_lastdlrs','ms_fund_paystat_paid','ms_other','ms_continuity','ms_cont_status_active','ms_cont_status_cancel','ms_cont_omos','ms_cont_lmos','ms_cont_pmos','ms_cont_totords','ms_cont_totdlrs','ms_cont_avgdlrs','ms_cont_lastdlrs','ms_cont_paystat_paid','ms_cont_paymeth_cc','ms_cont_paymeth_cash','ms_totords','ms_totitems','ms_totdlrs','ms_avgdlrs','ms_lastdlrs','ms_paystat_paid','ms_paymeth_cc','ms_paymeth_cash','ms_osrc_dm','ms_lsrc_dm','ms_osrc_tm','ms_lsrc_tm','ms_osrc_ins','ms_lsrc_ins','ms_osrc_net','ms_lsrc_net','ms_osrc_tv','ms_lsrc_tv','ms_osrc_retail','ms_lsrc_retail','ms_giftgivr','ms_giftee','ms_adult','ms_womapp','ms_menapp','ms_kidapp','ms_accessory','ms_apparel','ms_app_lmos','ms_app_omos','ms_app_pmos','ms_app_totords','ms_app_totitems','ms_app_totdlrs','ms_app_avgdlrs','ms_app_lastdlrs','ms_app_paystat_paid','ms_app_paymeth_cc','ms_app_paymeth_cash','ms_menfash','ms_womfash','ms_wfsh_lmos','ms_wfsh_omos','ms_wfsh_pmos','ms_wfsh_totords','ms_wfsh_totdlrs','ms_wfsh_avgdlrs','ms_wfsh_lastdlrs','ms_wfsh_paystat_paid','ms_wfsh_osrc_dm','ms_wfsh_lsrc_dm','ms_wfsh_osrc_agt','ms_wfsh_lsrc_agt','ms_audio','ms_auto','ms_aviation','ms_bargains','ms_beauty','ms_bible','ms_bible_lmos','ms_bible_omos','ms_bible_pmos','ms_bible_totords','ms_bible_totitems','ms_bible_totdlrs','ms_bible_avgdlrs','ms_bible_lastdlrs','ms_bible_paystat_paid','ms_bible_paymeth_cc','ms_bible_paymeth_cash','ms_business','ms_collectibles','ms_computers','ms_crafts','ms_culturearts','ms_currevent','ms_diy','ms_electronics','ms_equestrian','ms_pub_family','ms_cat_family','ms_family','ms_family_lmos','ms_family_omos','ms_family_pmos','ms_family_totords','ms_family_totitems','ms_family_totdlrs','ms_family_avgdlrs','ms_family_lastdlrs','ms_family_paystat_paid','ms_family_paymeth_cc','ms_family_paymeth_cash','ms_family_osrc_dm','ms_family_lsrc_dm','ms_fiction','ms_food','ms_games','ms_gifts','ms_gourmet','ms_fitness','ms_health','ms_hlth_lmos','ms_hlth_omos','ms_hlth_pmos','ms_hlth_totords','ms_hlth_totdlrs','ms_hlth_avgdlrs','ms_hlth_lastdlrs','ms_hlth_paystat_paid','ms_hlth_paymeth_cc','ms_hlth_osrc_dm','ms_hlth_lsrc_dm','ms_hlth_osrc_agt','ms_hlth_lsrc_agt','ms_hlth_osrc_tv','ms_hlth_lsrc_tv','ms_holiday','ms_history','ms_pub_cooking','ms_cooking','ms_pub_homedecr','ms_cat_homedecr','ms_homedecr','ms_housewares','ms_pub_garden','ms_cat_garden','ms_garden','ms_pub_homeliv','ms_cat_homeliv','ms_homeliv','ms_pub_home_status_active','ms_home_lmos','ms_home_omos','ms_home_pmos','ms_home_totords','ms_home_totitems','ms_home_totdlrs','ms_home_avgdlrs','ms_home_lastdlrs','ms_home_paystat_paid','ms_home_paymeth_cc','ms_home_paymeth_cash','ms_home_osrc_dm','ms_home_lsrc_dm','ms_home_osrc_agt','ms_home_lsrc_agt','ms_home_osrc_net','ms_home_lsrc_net','ms_home_osrc_tv','ms_home_lsrc_tv','ms_humor','ms_inspiration','ms_merchandise','ms_moneymaking','ms_moneymaking_lmos','ms_motorcycles','ms_music','ms_fishing','ms_hunting','ms_boatsail','ms_camp','ms_pub_outdoors','ms_cat_outdoors','ms_outdoors','ms_pub_out_status_active','ms_out_lmos','ms_out_omos','ms_out_pmos','ms_out_totords','ms_out_totitems','ms_out_totdlrs','ms_out_avgdlrs','ms_out_lastdlrs','ms_out_paystat_paid','ms_out_paymeth_cc','ms_out_paymeth_cash','ms_out_osrc_dm','ms_out_lsrc_dm','ms_out_osrc_agt','ms_out_lsrc_agt','ms_pets','ms_pfin','ms_photo','ms_photoproc','ms_rural','ms_science','ms_sports','ms_sports_lmos','ms_travel','ms_tvmovies','ms_wildlife','ms_woman','ms_woman_lmos','ms_ringtones_apps','cpi_mobile_apps_index','cpi_credit_repair_index','cpi_credit_report_index','cpi_education_seekers_index','cpi_insurance_index','cpi_insurance_health_index','cpi_insurance_auto_index','cpi_job_seekers_index','cpi_social_networking_index','cpi_adult_index','cpi_africanamerican_index','cpi_apparel_index','cpi_apparel_accessory_index','cpi_apparel_kids_index','cpi_apparel_men_index','cpi_apparel_menfash_index','cpi_apparel_women_index','cpi_apparel_womfash_index','cpi_asian_index','cpi_auto_index','cpi_auto_racing_index','cpi_auto_trucks_index','cpi_aviation_index','cpi_bargains_index','cpi_beauty_index','cpi_bible_index','cpi_birds_index','cpi_business_index','cpi_business_homeoffice_index','cpi_catalog_index','cpi_cc_index','cpi_collectibles_index','cpi_college_index','cpi_computers_index','cpi_conservative_index','cpi_continuity_index','cpi_cooking_index','cpi_crafts_index','cpi_crafts_crochet_index','cpi_crafts_knit_index','cpi_crafts_needlepoint_index','cpi_crafts_quilt_index','cpi_crafts_sew_index','cpi_culturearts_index','cpi_currevent_index','cpi_diy_index','cpi_donor_index','cpi_ego_index','cpi_electronics_index','cpi_equestrian_index','cpi_family_index','cpi_family_teen_index','cpi_family_young_index','cpi_fiction_index','cpi_gambling_index','cpi_games_index','cpi_gardening_index','cpi_gay_index','cpi_giftgivr_index','cpi_gourmet_index','cpi_grandparents_index','cpi_health_index','cpi_health_diet_index','cpi_health_fitness_index','cpi_hightech_index','cpi_hispanic_index','cpi_history_index','cpi_history_american_index','cpi_hobbies_index','cpi_homedecr_index','cpi_homeliv_index','cpi_humor_index','cpi_inspiration_index','cpi_internet_index','cpi_internet_access_index','cpi_internet_buy_index','cpi_liberal_index','cpi_moneymaking_index','cpi_motorcycles_index','cpi_music_index','cpi_nonfiction_index','cpi_ocean_index','cpi_outdoors_index','cpi_outdoors_boatsail_index','cpi_outdoors_camp_index','cpi_outdoors_fishing_index','cpi_outdoors_huntfish_index','cpi_outdoors_hunting_index','cpi_pets_index','cpi_pets_cats_index','cpi_pets_dogs_index','cpi_pfin_index','cpi_photog_index','cpi_photoproc_index','cpi_publish_index','cpi_publish_books_index','cpi_publish_mags_index','cpi_rural_index','cpi_science_index','cpi_scifi_index','cpi_seniors_index','cpi_sports_index','cpi_sports_baseball_index','cpi_sports_basketball_index','cpi_sports_biking_index','cpi_sports_football_index','cpi_sports_golf_index','cpi_sports_hockey_index','cpi_sports_running_index','cpi_sports_ski_index','cpi_sports_soccer_index','cpi_sports_swimming_index','cpi_sports_tennis_index','cpi_stationery_index','cpi_sweeps_index','cpi_tobacco_index','cpi_travel_index','cpi_travel_cruise_index','cpi_travel_rv_index','cpi_travel_us_index','cpi_tvmovies_index','cpi_wildlife_index','cpi_woman_index','totdlr_index','cpi_totdlr','cpi_totords','cpi_lastdlr','pkcatg','pkpubs','pkcont','pkca01','pkca03','pkca04','pkca05','pkca06','pkca07','pkca08','pkca09','pkca10','pkca11','pkca12','pkca13','pkca14','pkca15','pkca16','pkca17','pkca18','pkca20','pkca21','pkca22','pkca23','pkca24','pkca25','pkca26','pkca28','pkca29','pkca30','pkca31','pkca32','pkca33','pkca34','pkca35','pkca36','pkca37','pkca39','pkca40','pkca41','pkca42','pkca54','pkca61','pkca62','pkca64','pkpu01','pkpu02','pkpu03','pkpu04','pkpu05','pkpu06','pkpu07','pkpu08','pkpu09','pkpu10','pkpu11','pkpu12','pkpu13','pkpu14','pkpu15','pkpu16','pkpu17','pkpu18','pkpu19','pkpu20','pkpu23','pkpu25','pkpu27','pkpu28','pkpu29','pkpu30','pkpu31','pkpu32','pkpu33','pkpu34','pkpu35','pkpu38','pkpu41','pkpu42','pkpu45','pkpu46','pkpu47','pkpu48','pkpu49','pkpu50','pkpu51','pkpu52','pkpu53','pkpu54','pkpu55','pkpu56','pkpu57','pkpu60','pkpu61','pkpu62','pkpu63','pkpu64','pkpu65','pkpu66','pkpu67','pkpu68','pkpu69','pkpu70','censpct_water','cens_pop_density','cens_hu_density','censpct_pop_white','censpct_pop_black','censpct_pop_amerind','censpct_pop_asian','censpct_pop_pacisl','censpct_pop_othrace','censpct_pop_multirace','censpct_pop_hispanic','censpct_pop_agelt18','censpct_pop_males','censpct_adult_age1824','censpct_adult_age2534','censpct_adult_age3544','censpct_adult_age4554','censpct_adult_age5564','censpct_adult_agege65','cens_pop_medage','cens_hh_avgsize','censpct_hh_family','censpct_hh_family_husbwife','censpct_hu_occupied','censpct_hu_owned','censpct_hu_rented','censpct_hu_vacantseasonal','zip_medinc','zip_apparel','zip_apparel_women','zip_apparel_womfash','zip_auto','zip_beauty','zip_booksmusicmovies','zip_business','zip_catalog','zip_cc','zip_collectibles','zip_computers','zip_continuity','zip_cooking','zip_crafts','zip_culturearts','zip_dm_sold','zip_donor','zip_family','zip_gardening','zip_giftgivr','zip_gourmet','zip_health','zip_health_diet','zip_health_fitness','zip_hobbies','zip_homedecr','zip_homeliv','zip_internet','zip_internet_access','zip_internet_buy','zip_music','zip_outdoors','zip_pets','zip_pfin','zip_publish','zip_publish_books','zip_publish_mags','zip_sports','zip_sports_biking','zip_sports_golf','zip_travel','zip_travel_us','zip_tvmovies','zip_woman','zip_proftech','zip_retired','zip_inc100','zip_inc75','zip_inc50');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dtmatch','msname','msaddr1','msaddr2','mscity','msstate','mszip5','mszip4','dthh','mscrrt','msdpbc','msdpv','ms_addrtype','ctysize','lmos','omos','pmos','gen','dob','age','inc','marital_status','poc','noc','ocp','edu','lang','relig','dwell','ownr','eth1','eth2','lor','pool','speak_span','soho','vet_in_hh','ms_mags','ms_books','ms_publish','ms_pub_status_active','ms_pub_status_expire','ms_pub_premsold','ms_pub_autornwl','ms_pub_avgterm','ms_pub_lmos','ms_pub_omos','ms_pub_pmos','ms_pub_cemos','ms_pub_femos','ms_pub_totords','ms_pub_totdlrs','ms_pub_avgdlrs','ms_pub_lastdlrs','ms_pub_paystat_paid','ms_pub_paystat_ub','ms_pub_paymeth_cc','ms_pub_paymeth_cash','ms_pub_payspeed','ms_pub_osrc_dm','ms_pub_lsrc_dm','ms_pub_osrc_agt_cashf','ms_pub_lsrc_agt_cashf','ms_pub_osrc_agt_pds','ms_pub_lsrc_agt_pds','ms_pub_osrc_agt_schplan','ms_pub_lsrc_agt_schplan','ms_pub_osrc_agt_sponsor','ms_pub_lsrc_agt_sponsor','ms_pub_osrc_agt_tm','ms_pub_lsrc_agt_tm','ms_pub_osrc_agt','ms_pub_lsrc_agt','ms_pub_osrc_tm','ms_pub_lsrc_tm','ms_pub_osrc_ins','ms_pub_lsrc_ins','ms_pub_osrc_net','ms_pub_lsrc_net','ms_pub_osrc_print','ms_pub_lsrc_print','ms_pub_osrc_trans','ms_pub_lsrc_trans','ms_pub_osrc_tv','ms_pub_lsrc_tv','ms_pub_osrc_dtp','ms_pub_lsrc_dtp','ms_pub_giftgivr','ms_pub_giftee','ms_catalog','ms_cat_lmos','ms_cat_omos','ms_cat_pmos','ms_cat_totords','ms_cat_totitems','ms_cat_totdlrs','ms_cat_avgdlrs','ms_cat_lastdlrs','ms_cat_paystat_paid','ms_cat_paymeth_cc','ms_cat_paymeth_cash','ms_cat_osrc_dm','ms_cat_lsrc_dm','ms_cat_osrc_net','ms_cat_lsrc_net','ms_cat_giftgivr','pkpubs_corrected','pkcatg_corrected','ms_fundraising','ms_fund_lmos','ms_fund_omos','ms_fund_pmos','ms_fund_totords','ms_fund_totdlrs','ms_fund_avgdlrs','ms_fund_lastdlrs','ms_fund_paystat_paid','ms_other','ms_continuity','ms_cont_status_active','ms_cont_status_cancel','ms_cont_omos','ms_cont_lmos','ms_cont_pmos','ms_cont_totords','ms_cont_totdlrs','ms_cont_avgdlrs','ms_cont_lastdlrs','ms_cont_paystat_paid','ms_cont_paymeth_cc','ms_cont_paymeth_cash','ms_totords','ms_totitems','ms_totdlrs','ms_avgdlrs','ms_lastdlrs','ms_paystat_paid','ms_paymeth_cc','ms_paymeth_cash','ms_osrc_dm','ms_lsrc_dm','ms_osrc_tm','ms_lsrc_tm','ms_osrc_ins','ms_lsrc_ins','ms_osrc_net','ms_lsrc_net','ms_osrc_tv','ms_lsrc_tv','ms_osrc_retail','ms_lsrc_retail','ms_giftgivr','ms_giftee','ms_adult','ms_womapp','ms_menapp','ms_kidapp','ms_accessory','ms_apparel','ms_app_lmos','ms_app_omos','ms_app_pmos','ms_app_totords','ms_app_totitems','ms_app_totdlrs','ms_app_avgdlrs','ms_app_lastdlrs','ms_app_paystat_paid','ms_app_paymeth_cc','ms_app_paymeth_cash','ms_menfash','ms_womfash','ms_wfsh_lmos','ms_wfsh_omos','ms_wfsh_pmos','ms_wfsh_totords','ms_wfsh_totdlrs','ms_wfsh_avgdlrs','ms_wfsh_lastdlrs','ms_wfsh_paystat_paid','ms_wfsh_osrc_dm','ms_wfsh_lsrc_dm','ms_wfsh_osrc_agt','ms_wfsh_lsrc_agt','ms_audio','ms_auto','ms_aviation','ms_bargains','ms_beauty','ms_bible','ms_bible_lmos','ms_bible_omos','ms_bible_pmos','ms_bible_totords','ms_bible_totitems','ms_bible_totdlrs','ms_bible_avgdlrs','ms_bible_lastdlrs','ms_bible_paystat_paid','ms_bible_paymeth_cc','ms_bible_paymeth_cash','ms_business','ms_collectibles','ms_computers','ms_crafts','ms_culturearts','ms_currevent','ms_diy','ms_electronics','ms_equestrian','ms_pub_family','ms_cat_family','ms_family','ms_family_lmos','ms_family_omos','ms_family_pmos','ms_family_totords','ms_family_totitems','ms_family_totdlrs','ms_family_avgdlrs','ms_family_lastdlrs','ms_family_paystat_paid','ms_family_paymeth_cc','ms_family_paymeth_cash','ms_family_osrc_dm','ms_family_lsrc_dm','ms_fiction','ms_food','ms_games','ms_gifts','ms_gourmet','ms_fitness','ms_health','ms_hlth_lmos','ms_hlth_omos','ms_hlth_pmos','ms_hlth_totords','ms_hlth_totdlrs','ms_hlth_avgdlrs','ms_hlth_lastdlrs','ms_hlth_paystat_paid','ms_hlth_paymeth_cc','ms_hlth_osrc_dm','ms_hlth_lsrc_dm','ms_hlth_osrc_agt','ms_hlth_lsrc_agt','ms_hlth_osrc_tv','ms_hlth_lsrc_tv','ms_holiday','ms_history','ms_pub_cooking','ms_cooking','ms_pub_homedecr','ms_cat_homedecr','ms_homedecr','ms_housewares','ms_pub_garden','ms_cat_garden','ms_garden','ms_pub_homeliv','ms_cat_homeliv','ms_homeliv','ms_pub_home_status_active','ms_home_lmos','ms_home_omos','ms_home_pmos','ms_home_totords','ms_home_totitems','ms_home_totdlrs','ms_home_avgdlrs','ms_home_lastdlrs','ms_home_paystat_paid','ms_home_paymeth_cc','ms_home_paymeth_cash','ms_home_osrc_dm','ms_home_lsrc_dm','ms_home_osrc_agt','ms_home_lsrc_agt','ms_home_osrc_net','ms_home_lsrc_net','ms_home_osrc_tv','ms_home_lsrc_tv','ms_humor','ms_inspiration','ms_merchandise','ms_moneymaking','ms_moneymaking_lmos','ms_motorcycles','ms_music','ms_fishing','ms_hunting','ms_boatsail','ms_camp','ms_pub_outdoors','ms_cat_outdoors','ms_outdoors','ms_pub_out_status_active','ms_out_lmos','ms_out_omos','ms_out_pmos','ms_out_totords','ms_out_totitems','ms_out_totdlrs','ms_out_avgdlrs','ms_out_lastdlrs','ms_out_paystat_paid','ms_out_paymeth_cc','ms_out_paymeth_cash','ms_out_osrc_dm','ms_out_lsrc_dm','ms_out_osrc_agt','ms_out_lsrc_agt','ms_pets','ms_pfin','ms_photo','ms_photoproc','ms_rural','ms_science','ms_sports','ms_sports_lmos','ms_travel','ms_tvmovies','ms_wildlife','ms_woman','ms_woman_lmos','ms_ringtones_apps','cpi_mobile_apps_index','cpi_credit_repair_index','cpi_credit_report_index','cpi_education_seekers_index','cpi_insurance_index','cpi_insurance_health_index','cpi_insurance_auto_index','cpi_job_seekers_index','cpi_social_networking_index','cpi_adult_index','cpi_africanamerican_index','cpi_apparel_index','cpi_apparel_accessory_index','cpi_apparel_kids_index','cpi_apparel_men_index','cpi_apparel_menfash_index','cpi_apparel_women_index','cpi_apparel_womfash_index','cpi_asian_index','cpi_auto_index','cpi_auto_racing_index','cpi_auto_trucks_index','cpi_aviation_index','cpi_bargains_index','cpi_beauty_index','cpi_bible_index','cpi_birds_index','cpi_business_index','cpi_business_homeoffice_index','cpi_catalog_index','cpi_cc_index','cpi_collectibles_index','cpi_college_index','cpi_computers_index','cpi_conservative_index','cpi_continuity_index','cpi_cooking_index','cpi_crafts_index','cpi_crafts_crochet_index','cpi_crafts_knit_index','cpi_crafts_needlepoint_index','cpi_crafts_quilt_index','cpi_crafts_sew_index','cpi_culturearts_index','cpi_currevent_index','cpi_diy_index','cpi_donor_index','cpi_ego_index','cpi_electronics_index','cpi_equestrian_index','cpi_family_index','cpi_family_teen_index','cpi_family_young_index','cpi_fiction_index','cpi_gambling_index','cpi_games_index','cpi_gardening_index','cpi_gay_index','cpi_giftgivr_index','cpi_gourmet_index','cpi_grandparents_index','cpi_health_index','cpi_health_diet_index','cpi_health_fitness_index','cpi_hightech_index','cpi_hispanic_index','cpi_history_index','cpi_history_american_index','cpi_hobbies_index','cpi_homedecr_index','cpi_homeliv_index','cpi_humor_index','cpi_inspiration_index','cpi_internet_index','cpi_internet_access_index','cpi_internet_buy_index','cpi_liberal_index','cpi_moneymaking_index','cpi_motorcycles_index','cpi_music_index','cpi_nonfiction_index','cpi_ocean_index','cpi_outdoors_index','cpi_outdoors_boatsail_index','cpi_outdoors_camp_index','cpi_outdoors_fishing_index','cpi_outdoors_huntfish_index','cpi_outdoors_hunting_index','cpi_pets_index','cpi_pets_cats_index','cpi_pets_dogs_index','cpi_pfin_index','cpi_photog_index','cpi_photoproc_index','cpi_publish_index','cpi_publish_books_index','cpi_publish_mags_index','cpi_rural_index','cpi_science_index','cpi_scifi_index','cpi_seniors_index','cpi_sports_index','cpi_sports_baseball_index','cpi_sports_basketball_index','cpi_sports_biking_index','cpi_sports_football_index','cpi_sports_golf_index','cpi_sports_hockey_index','cpi_sports_running_index','cpi_sports_ski_index','cpi_sports_soccer_index','cpi_sports_swimming_index','cpi_sports_tennis_index','cpi_stationery_index','cpi_sweeps_index','cpi_tobacco_index','cpi_travel_index','cpi_travel_cruise_index','cpi_travel_rv_index','cpi_travel_us_index','cpi_tvmovies_index','cpi_wildlife_index','cpi_woman_index','totdlr_index','cpi_totdlr','cpi_totords','cpi_lastdlr','pkcatg','pkpubs','pkcont','pkca01','pkca03','pkca04','pkca05','pkca06','pkca07','pkca08','pkca09','pkca10','pkca11','pkca12','pkca13','pkca14','pkca15','pkca16','pkca17','pkca18','pkca20','pkca21','pkca22','pkca23','pkca24','pkca25','pkca26','pkca28','pkca29','pkca30','pkca31','pkca32','pkca33','pkca34','pkca35','pkca36','pkca37','pkca39','pkca40','pkca41','pkca42','pkca54','pkca61','pkca62','pkca64','pkpu01','pkpu02','pkpu03','pkpu04','pkpu05','pkpu06','pkpu07','pkpu08','pkpu09','pkpu10','pkpu11','pkpu12','pkpu13','pkpu14','pkpu15','pkpu16','pkpu17','pkpu18','pkpu19','pkpu20','pkpu23','pkpu25','pkpu27','pkpu28','pkpu29','pkpu30','pkpu31','pkpu32','pkpu33','pkpu34','pkpu35','pkpu38','pkpu41','pkpu42','pkpu45','pkpu46','pkpu47','pkpu48','pkpu49','pkpu50','pkpu51','pkpu52','pkpu53','pkpu54','pkpu55','pkpu56','pkpu57','pkpu60','pkpu61','pkpu62','pkpu63','pkpu64','pkpu65','pkpu66','pkpu67','pkpu68','pkpu69','pkpu70','censpct_water','cens_pop_density','cens_hu_density','censpct_pop_white','censpct_pop_black','censpct_pop_amerind','censpct_pop_asian','censpct_pop_pacisl','censpct_pop_othrace','censpct_pop_multirace','censpct_pop_hispanic','censpct_pop_agelt18','censpct_pop_males','censpct_adult_age1824','censpct_adult_age2534','censpct_adult_age3544','censpct_adult_age4554','censpct_adult_age5564','censpct_adult_agege65','cens_pop_medage','cens_hh_avgsize','censpct_hh_family','censpct_hh_family_husbwife','censpct_hu_occupied','censpct_hu_owned','censpct_hu_rented','censpct_hu_vacantseasonal','zip_medinc','zip_apparel','zip_apparel_women','zip_apparel_womfash','zip_auto','zip_beauty','zip_booksmusicmovies','zip_business','zip_catalog','zip_cc','zip_collectibles','zip_computers','zip_continuity','zip_cooking','zip_crafts','zip_culturearts','zip_dm_sold','zip_donor','zip_family','zip_gardening','zip_giftgivr','zip_gourmet','zip_health','zip_health_diet','zip_health_fitness','zip_hobbies','zip_homedecr','zip_homeliv','zip_internet','zip_internet_access','zip_internet_buy','zip_music','zip_outdoors','zip_pets','zip_pfin','zip_publish','zip_publish_books','zip_publish_mags','zip_sports','zip_sports_biking','zip_sports_golf','zip_travel','zip_travel_us','zip_tvmovies','zip_woman','zip_proftech','zip_retired','zip_inc100','zip_inc75','zip_inc50');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dtmatch' => 0,'msname' => 1,'msaddr1' => 2,'msaddr2' => 3,'mscity' => 4,'msstate' => 5,'mszip5' => 6,'mszip4' => 7,'dthh' => 8,'mscrrt' => 9,'msdpbc' => 10,'msdpv' => 11,'ms_addrtype' => 12,'ctysize' => 13,'lmos' => 14,'omos' => 15,'pmos' => 16,'gen' => 17,'dob' => 18,'age' => 19,'inc' => 20,'marital_status' => 21,'poc' => 22,'noc' => 23,'ocp' => 24,'edu' => 25,'lang' => 26,'relig' => 27,'dwell' => 28,'ownr' => 29,'eth1' => 30,'eth2' => 31,'lor' => 32,'pool' => 33,'speak_span' => 34,'soho' => 35,'vet_in_hh' => 36,'ms_mags' => 37,'ms_books' => 38,'ms_publish' => 39,'ms_pub_status_active' => 40,'ms_pub_status_expire' => 41,'ms_pub_premsold' => 42,'ms_pub_autornwl' => 43,'ms_pub_avgterm' => 44,'ms_pub_lmos' => 45,'ms_pub_omos' => 46,'ms_pub_pmos' => 47,'ms_pub_cemos' => 48,'ms_pub_femos' => 49,'ms_pub_totords' => 50,'ms_pub_totdlrs' => 51,'ms_pub_avgdlrs' => 52,'ms_pub_lastdlrs' => 53,'ms_pub_paystat_paid' => 54,'ms_pub_paystat_ub' => 55,'ms_pub_paymeth_cc' => 56,'ms_pub_paymeth_cash' => 57,'ms_pub_payspeed' => 58,'ms_pub_osrc_dm' => 59,'ms_pub_lsrc_dm' => 60,'ms_pub_osrc_agt_cashf' => 61,'ms_pub_lsrc_agt_cashf' => 62,'ms_pub_osrc_agt_pds' => 63,'ms_pub_lsrc_agt_pds' => 64,'ms_pub_osrc_agt_schplan' => 65,'ms_pub_lsrc_agt_schplan' => 66,'ms_pub_osrc_agt_sponsor' => 67,'ms_pub_lsrc_agt_sponsor' => 68,'ms_pub_osrc_agt_tm' => 69,'ms_pub_lsrc_agt_tm' => 70,'ms_pub_osrc_agt' => 71,'ms_pub_lsrc_agt' => 72,'ms_pub_osrc_tm' => 73,'ms_pub_lsrc_tm' => 74,'ms_pub_osrc_ins' => 75,'ms_pub_lsrc_ins' => 76,'ms_pub_osrc_net' => 77,'ms_pub_lsrc_net' => 78,'ms_pub_osrc_print' => 79,'ms_pub_lsrc_print' => 80,'ms_pub_osrc_trans' => 81,'ms_pub_lsrc_trans' => 82,'ms_pub_osrc_tv' => 83,'ms_pub_lsrc_tv' => 84,'ms_pub_osrc_dtp' => 85,'ms_pub_lsrc_dtp' => 86,'ms_pub_giftgivr' => 87,'ms_pub_giftee' => 88,'ms_catalog' => 89,'ms_cat_lmos' => 90,'ms_cat_omos' => 91,'ms_cat_pmos' => 92,'ms_cat_totords' => 93,'ms_cat_totitems' => 94,'ms_cat_totdlrs' => 95,'ms_cat_avgdlrs' => 96,'ms_cat_lastdlrs' => 97,'ms_cat_paystat_paid' => 98,'ms_cat_paymeth_cc' => 99,'ms_cat_paymeth_cash' => 100,'ms_cat_osrc_dm' => 101,'ms_cat_lsrc_dm' => 102,'ms_cat_osrc_net' => 103,'ms_cat_lsrc_net' => 104,'ms_cat_giftgivr' => 105,'pkpubs_corrected' => 106,'pkcatg_corrected' => 107,'ms_fundraising' => 108,'ms_fund_lmos' => 109,'ms_fund_omos' => 110,'ms_fund_pmos' => 111,'ms_fund_totords' => 112,'ms_fund_totdlrs' => 113,'ms_fund_avgdlrs' => 114,'ms_fund_lastdlrs' => 115,'ms_fund_paystat_paid' => 116,'ms_other' => 117,'ms_continuity' => 118,'ms_cont_status_active' => 119,'ms_cont_status_cancel' => 120,'ms_cont_omos' => 121,'ms_cont_lmos' => 122,'ms_cont_pmos' => 123,'ms_cont_totords' => 124,'ms_cont_totdlrs' => 125,'ms_cont_avgdlrs' => 126,'ms_cont_lastdlrs' => 127,'ms_cont_paystat_paid' => 128,'ms_cont_paymeth_cc' => 129,'ms_cont_paymeth_cash' => 130,'ms_totords' => 131,'ms_totitems' => 132,'ms_totdlrs' => 133,'ms_avgdlrs' => 134,'ms_lastdlrs' => 135,'ms_paystat_paid' => 136,'ms_paymeth_cc' => 137,'ms_paymeth_cash' => 138,'ms_osrc_dm' => 139,'ms_lsrc_dm' => 140,'ms_osrc_tm' => 141,'ms_lsrc_tm' => 142,'ms_osrc_ins' => 143,'ms_lsrc_ins' => 144,'ms_osrc_net' => 145,'ms_lsrc_net' => 146,'ms_osrc_tv' => 147,'ms_lsrc_tv' => 148,'ms_osrc_retail' => 149,'ms_lsrc_retail' => 150,'ms_giftgivr' => 151,'ms_giftee' => 152,'ms_adult' => 153,'ms_womapp' => 154,'ms_menapp' => 155,'ms_kidapp' => 156,'ms_accessory' => 157,'ms_apparel' => 158,'ms_app_lmos' => 159,'ms_app_omos' => 160,'ms_app_pmos' => 161,'ms_app_totords' => 162,'ms_app_totitems' => 163,'ms_app_totdlrs' => 164,'ms_app_avgdlrs' => 165,'ms_app_lastdlrs' => 166,'ms_app_paystat_paid' => 167,'ms_app_paymeth_cc' => 168,'ms_app_paymeth_cash' => 169,'ms_menfash' => 170,'ms_womfash' => 171,'ms_wfsh_lmos' => 172,'ms_wfsh_omos' => 173,'ms_wfsh_pmos' => 174,'ms_wfsh_totords' => 175,'ms_wfsh_totdlrs' => 176,'ms_wfsh_avgdlrs' => 177,'ms_wfsh_lastdlrs' => 178,'ms_wfsh_paystat_paid' => 179,'ms_wfsh_osrc_dm' => 180,'ms_wfsh_lsrc_dm' => 181,'ms_wfsh_osrc_agt' => 182,'ms_wfsh_lsrc_agt' => 183,'ms_audio' => 184,'ms_auto' => 185,'ms_aviation' => 186,'ms_bargains' => 187,'ms_beauty' => 188,'ms_bible' => 189,'ms_bible_lmos' => 190,'ms_bible_omos' => 191,'ms_bible_pmos' => 192,'ms_bible_totords' => 193,'ms_bible_totitems' => 194,'ms_bible_totdlrs' => 195,'ms_bible_avgdlrs' => 196,'ms_bible_lastdlrs' => 197,'ms_bible_paystat_paid' => 198,'ms_bible_paymeth_cc' => 199,'ms_bible_paymeth_cash' => 200,'ms_business' => 201,'ms_collectibles' => 202,'ms_computers' => 203,'ms_crafts' => 204,'ms_culturearts' => 205,'ms_currevent' => 206,'ms_diy' => 207,'ms_electronics' => 208,'ms_equestrian' => 209,'ms_pub_family' => 210,'ms_cat_family' => 211,'ms_family' => 212,'ms_family_lmos' => 213,'ms_family_omos' => 214,'ms_family_pmos' => 215,'ms_family_totords' => 216,'ms_family_totitems' => 217,'ms_family_totdlrs' => 218,'ms_family_avgdlrs' => 219,'ms_family_lastdlrs' => 220,'ms_family_paystat_paid' => 221,'ms_family_paymeth_cc' => 222,'ms_family_paymeth_cash' => 223,'ms_family_osrc_dm' => 224,'ms_family_lsrc_dm' => 225,'ms_fiction' => 226,'ms_food' => 227,'ms_games' => 228,'ms_gifts' => 229,'ms_gourmet' => 230,'ms_fitness' => 231,'ms_health' => 232,'ms_hlth_lmos' => 233,'ms_hlth_omos' => 234,'ms_hlth_pmos' => 235,'ms_hlth_totords' => 236,'ms_hlth_totdlrs' => 237,'ms_hlth_avgdlrs' => 238,'ms_hlth_lastdlrs' => 239,'ms_hlth_paystat_paid' => 240,'ms_hlth_paymeth_cc' => 241,'ms_hlth_osrc_dm' => 242,'ms_hlth_lsrc_dm' => 243,'ms_hlth_osrc_agt' => 244,'ms_hlth_lsrc_agt' => 245,'ms_hlth_osrc_tv' => 246,'ms_hlth_lsrc_tv' => 247,'ms_holiday' => 248,'ms_history' => 249,'ms_pub_cooking' => 250,'ms_cooking' => 251,'ms_pub_homedecr' => 252,'ms_cat_homedecr' => 253,'ms_homedecr' => 254,'ms_housewares' => 255,'ms_pub_garden' => 256,'ms_cat_garden' => 257,'ms_garden' => 258,'ms_pub_homeliv' => 259,'ms_cat_homeliv' => 260,'ms_homeliv' => 261,'ms_pub_home_status_active' => 262,'ms_home_lmos' => 263,'ms_home_omos' => 264,'ms_home_pmos' => 265,'ms_home_totords' => 266,'ms_home_totitems' => 267,'ms_home_totdlrs' => 268,'ms_home_avgdlrs' => 269,'ms_home_lastdlrs' => 270,'ms_home_paystat_paid' => 271,'ms_home_paymeth_cc' => 272,'ms_home_paymeth_cash' => 273,'ms_home_osrc_dm' => 274,'ms_home_lsrc_dm' => 275,'ms_home_osrc_agt' => 276,'ms_home_lsrc_agt' => 277,'ms_home_osrc_net' => 278,'ms_home_lsrc_net' => 279,'ms_home_osrc_tv' => 280,'ms_home_lsrc_tv' => 281,'ms_humor' => 282,'ms_inspiration' => 283,'ms_merchandise' => 284,'ms_moneymaking' => 285,'ms_moneymaking_lmos' => 286,'ms_motorcycles' => 287,'ms_music' => 288,'ms_fishing' => 289,'ms_hunting' => 290,'ms_boatsail' => 291,'ms_camp' => 292,'ms_pub_outdoors' => 293,'ms_cat_outdoors' => 294,'ms_outdoors' => 295,'ms_pub_out_status_active' => 296,'ms_out_lmos' => 297,'ms_out_omos' => 298,'ms_out_pmos' => 299,'ms_out_totords' => 300,'ms_out_totitems' => 301,'ms_out_totdlrs' => 302,'ms_out_avgdlrs' => 303,'ms_out_lastdlrs' => 304,'ms_out_paystat_paid' => 305,'ms_out_paymeth_cc' => 306,'ms_out_paymeth_cash' => 307,'ms_out_osrc_dm' => 308,'ms_out_lsrc_dm' => 309,'ms_out_osrc_agt' => 310,'ms_out_lsrc_agt' => 311,'ms_pets' => 312,'ms_pfin' => 313,'ms_photo' => 314,'ms_photoproc' => 315,'ms_rural' => 316,'ms_science' => 317,'ms_sports' => 318,'ms_sports_lmos' => 319,'ms_travel' => 320,'ms_tvmovies' => 321,'ms_wildlife' => 322,'ms_woman' => 323,'ms_woman_lmos' => 324,'ms_ringtones_apps' => 325,'cpi_mobile_apps_index' => 326,'cpi_credit_repair_index' => 327,'cpi_credit_report_index' => 328,'cpi_education_seekers_index' => 329,'cpi_insurance_index' => 330,'cpi_insurance_health_index' => 331,'cpi_insurance_auto_index' => 332,'cpi_job_seekers_index' => 333,'cpi_social_networking_index' => 334,'cpi_adult_index' => 335,'cpi_africanamerican_index' => 336,'cpi_apparel_index' => 337,'cpi_apparel_accessory_index' => 338,'cpi_apparel_kids_index' => 339,'cpi_apparel_men_index' => 340,'cpi_apparel_menfash_index' => 341,'cpi_apparel_women_index' => 342,'cpi_apparel_womfash_index' => 343,'cpi_asian_index' => 344,'cpi_auto_index' => 345,'cpi_auto_racing_index' => 346,'cpi_auto_trucks_index' => 347,'cpi_aviation_index' => 348,'cpi_bargains_index' => 349,'cpi_beauty_index' => 350,'cpi_bible_index' => 351,'cpi_birds_index' => 352,'cpi_business_index' => 353,'cpi_business_homeoffice_index' => 354,'cpi_catalog_index' => 355,'cpi_cc_index' => 356,'cpi_collectibles_index' => 357,'cpi_college_index' => 358,'cpi_computers_index' => 359,'cpi_conservative_index' => 360,'cpi_continuity_index' => 361,'cpi_cooking_index' => 362,'cpi_crafts_index' => 363,'cpi_crafts_crochet_index' => 364,'cpi_crafts_knit_index' => 365,'cpi_crafts_needlepoint_index' => 366,'cpi_crafts_quilt_index' => 367,'cpi_crafts_sew_index' => 368,'cpi_culturearts_index' => 369,'cpi_currevent_index' => 370,'cpi_diy_index' => 371,'cpi_donor_index' => 372,'cpi_ego_index' => 373,'cpi_electronics_index' => 374,'cpi_equestrian_index' => 375,'cpi_family_index' => 376,'cpi_family_teen_index' => 377,'cpi_family_young_index' => 378,'cpi_fiction_index' => 379,'cpi_gambling_index' => 380,'cpi_games_index' => 381,'cpi_gardening_index' => 382,'cpi_gay_index' => 383,'cpi_giftgivr_index' => 384,'cpi_gourmet_index' => 385,'cpi_grandparents_index' => 386,'cpi_health_index' => 387,'cpi_health_diet_index' => 388,'cpi_health_fitness_index' => 389,'cpi_hightech_index' => 390,'cpi_hispanic_index' => 391,'cpi_history_index' => 392,'cpi_history_american_index' => 393,'cpi_hobbies_index' => 394,'cpi_homedecr_index' => 395,'cpi_homeliv_index' => 396,'cpi_humor_index' => 397,'cpi_inspiration_index' => 398,'cpi_internet_index' => 399,'cpi_internet_access_index' => 400,'cpi_internet_buy_index' => 401,'cpi_liberal_index' => 402,'cpi_moneymaking_index' => 403,'cpi_motorcycles_index' => 404,'cpi_music_index' => 405,'cpi_nonfiction_index' => 406,'cpi_ocean_index' => 407,'cpi_outdoors_index' => 408,'cpi_outdoors_boatsail_index' => 409,'cpi_outdoors_camp_index' => 410,'cpi_outdoors_fishing_index' => 411,'cpi_outdoors_huntfish_index' => 412,'cpi_outdoors_hunting_index' => 413,'cpi_pets_index' => 414,'cpi_pets_cats_index' => 415,'cpi_pets_dogs_index' => 416,'cpi_pfin_index' => 417,'cpi_photog_index' => 418,'cpi_photoproc_index' => 419,'cpi_publish_index' => 420,'cpi_publish_books_index' => 421,'cpi_publish_mags_index' => 422,'cpi_rural_index' => 423,'cpi_science_index' => 424,'cpi_scifi_index' => 425,'cpi_seniors_index' => 426,'cpi_sports_index' => 427,'cpi_sports_baseball_index' => 428,'cpi_sports_basketball_index' => 429,'cpi_sports_biking_index' => 430,'cpi_sports_football_index' => 431,'cpi_sports_golf_index' => 432,'cpi_sports_hockey_index' => 433,'cpi_sports_running_index' => 434,'cpi_sports_ski_index' => 435,'cpi_sports_soccer_index' => 436,'cpi_sports_swimming_index' => 437,'cpi_sports_tennis_index' => 438,'cpi_stationery_index' => 439,'cpi_sweeps_index' => 440,'cpi_tobacco_index' => 441,'cpi_travel_index' => 442,'cpi_travel_cruise_index' => 443,'cpi_travel_rv_index' => 444,'cpi_travel_us_index' => 445,'cpi_tvmovies_index' => 446,'cpi_wildlife_index' => 447,'cpi_woman_index' => 448,'totdlr_index' => 449,'cpi_totdlr' => 450,'cpi_totords' => 451,'cpi_lastdlr' => 452,'pkcatg' => 453,'pkpubs' => 454,'pkcont' => 455,'pkca01' => 456,'pkca03' => 457,'pkca04' => 458,'pkca05' => 459,'pkca06' => 460,'pkca07' => 461,'pkca08' => 462,'pkca09' => 463,'pkca10' => 464,'pkca11' => 465,'pkca12' => 466,'pkca13' => 467,'pkca14' => 468,'pkca15' => 469,'pkca16' => 470,'pkca17' => 471,'pkca18' => 472,'pkca20' => 473,'pkca21' => 474,'pkca22' => 475,'pkca23' => 476,'pkca24' => 477,'pkca25' => 478,'pkca26' => 479,'pkca28' => 480,'pkca29' => 481,'pkca30' => 482,'pkca31' => 483,'pkca32' => 484,'pkca33' => 485,'pkca34' => 486,'pkca35' => 487,'pkca36' => 488,'pkca37' => 489,'pkca39' => 490,'pkca40' => 491,'pkca41' => 492,'pkca42' => 493,'pkca54' => 494,'pkca61' => 495,'pkca62' => 496,'pkca64' => 497,'pkpu01' => 498,'pkpu02' => 499,'pkpu03' => 500,'pkpu04' => 501,'pkpu05' => 502,'pkpu06' => 503,'pkpu07' => 504,'pkpu08' => 505,'pkpu09' => 506,'pkpu10' => 507,'pkpu11' => 508,'pkpu12' => 509,'pkpu13' => 510,'pkpu14' => 511,'pkpu15' => 512,'pkpu16' => 513,'pkpu17' => 514,'pkpu18' => 515,'pkpu19' => 516,'pkpu20' => 517,'pkpu23' => 518,'pkpu25' => 519,'pkpu27' => 520,'pkpu28' => 521,'pkpu29' => 522,'pkpu30' => 523,'pkpu31' => 524,'pkpu32' => 525,'pkpu33' => 526,'pkpu34' => 527,'pkpu35' => 528,'pkpu38' => 529,'pkpu41' => 530,'pkpu42' => 531,'pkpu45' => 532,'pkpu46' => 533,'pkpu47' => 534,'pkpu48' => 535,'pkpu49' => 536,'pkpu50' => 537,'pkpu51' => 538,'pkpu52' => 539,'pkpu53' => 540,'pkpu54' => 541,'pkpu55' => 542,'pkpu56' => 543,'pkpu57' => 544,'pkpu60' => 545,'pkpu61' => 546,'pkpu62' => 547,'pkpu63' => 548,'pkpu64' => 549,'pkpu65' => 550,'pkpu66' => 551,'pkpu67' => 552,'pkpu68' => 553,'pkpu69' => 554,'pkpu70' => 555,'censpct_water' => 556,'cens_pop_density' => 557,'cens_hu_density' => 558,'censpct_pop_white' => 559,'censpct_pop_black' => 560,'censpct_pop_amerind' => 561,'censpct_pop_asian' => 562,'censpct_pop_pacisl' => 563,'censpct_pop_othrace' => 564,'censpct_pop_multirace' => 565,'censpct_pop_hispanic' => 566,'censpct_pop_agelt18' => 567,'censpct_pop_males' => 568,'censpct_adult_age1824' => 569,'censpct_adult_age2534' => 570,'censpct_adult_age3544' => 571,'censpct_adult_age4554' => 572,'censpct_adult_age5564' => 573,'censpct_adult_agege65' => 574,'cens_pop_medage' => 575,'cens_hh_avgsize' => 576,'censpct_hh_family' => 577,'censpct_hh_family_husbwife' => 578,'censpct_hu_occupied' => 579,'censpct_hu_owned' => 580,'censpct_hu_rented' => 581,'censpct_hu_vacantseasonal' => 582,'zip_medinc' => 583,'zip_apparel' => 584,'zip_apparel_women' => 585,'zip_apparel_womfash' => 586,'zip_auto' => 587,'zip_beauty' => 588,'zip_booksmusicmovies' => 589,'zip_business' => 590,'zip_catalog' => 591,'zip_cc' => 592,'zip_collectibles' => 593,'zip_computers' => 594,'zip_continuity' => 595,'zip_cooking' => 596,'zip_crafts' => 597,'zip_culturearts' => 598,'zip_dm_sold' => 599,'zip_donor' => 600,'zip_family' => 601,'zip_gardening' => 602,'zip_giftgivr' => 603,'zip_gourmet' => 604,'zip_health' => 605,'zip_health_diet' => 606,'zip_health_fitness' => 607,'zip_hobbies' => 608,'zip_homedecr' => 609,'zip_homeliv' => 610,'zip_internet' => 611,'zip_internet_access' => 612,'zip_internet_buy' => 613,'zip_music' => 614,'zip_outdoors' => 615,'zip_pets' => 616,'zip_pfin' => 617,'zip_publish' => 618,'zip_publish_books' => 619,'zip_publish_mags' => 620,'zip_sports' => 621,'zip_sports_biking' => 622,'zip_sports_golf' => 623,'zip_travel' => 624,'zip_travel_us' => 625,'zip_tvmovies' => 626,'zip_woman' => 627,'zip_proftech' => 628,'zip_retired' => 629,'zip_inc100' => 630,'zip_inc75' => 631,'zip_inc50' => 632,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS','WORDS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM','LENGTHS'],['CUSTOM'],['ALLOW'],['ENUM','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ENUM','LENGTHS'],['ALLOW','LENGTHS'],['ENUM','LENGTHS'],['ENUM','LENGTHS'],['ALLOW'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);

//Individual field level validation


EXPORT Make_dtmatch(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_dtmatch(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_dtmatch(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_msname(SALT311.StrType s0) := MakeFT_FULLNAME(s0);
EXPORT InValid_msname(SALT311.StrType s) := InValidFT_FULLNAME(s);
EXPORT InValidMessage_msname(UNSIGNED1 wh) := InValidMessageFT_FULLNAME(wh);


EXPORT Make_msaddr1(SALT311.StrType s0) := MakeFT_FULL_ADDRESS(s0);
EXPORT InValid_msaddr1(SALT311.StrType s) := InValidFT_FULL_ADDRESS(s);
EXPORT InValidMessage_msaddr1(UNSIGNED1 wh) := InValidMessageFT_FULL_ADDRESS(wh);


EXPORT Make_msaddr2(SALT311.StrType s0) := MakeFT_FULL_ADDRESS(s0);
EXPORT InValid_msaddr2(SALT311.StrType s) := InValidFT_FULL_ADDRESS(s);
EXPORT InValidMessage_msaddr2(UNSIGNED1 wh) := InValidMessageFT_FULL_ADDRESS(wh);


EXPORT Make_mscity(SALT311.StrType s0) := MakeFT_CITY(s0);
EXPORT InValid_mscity(SALT311.StrType s) := InValidFT_CITY(s);
EXPORT InValidMessage_mscity(UNSIGNED1 wh) := InValidMessageFT_CITY(wh);


EXPORT Make_msstate(SALT311.StrType s0) := MakeFT_ST(s0);
EXPORT InValid_msstate(SALT311.StrType s) := InValidFT_ST(s);
EXPORT InValidMessage_msstate(UNSIGNED1 wh) := InValidMessageFT_ST(wh);


EXPORT Make_mszip5(SALT311.StrType s0) := MakeFT_ZIP5(s0);
EXPORT InValid_mszip5(SALT311.StrType s) := InValidFT_ZIP5(s);
EXPORT InValidMessage_mszip5(UNSIGNED1 wh) := InValidMessageFT_ZIP5(wh);


EXPORT Make_mszip4(SALT311.StrType s0) := MakeFT_HASZIP4(s0);
EXPORT InValid_mszip4(SALT311.StrType s) := InValidFT_HASZIP4(s);
EXPORT InValidMessage_mszip4(UNSIGNED1 wh) := InValidMessageFT_HASZIP4(wh);


EXPORT Make_dthh(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_dthh(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_dthh(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_mscrrt(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_mscrrt(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_mscrrt(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_msdpbc(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_msdpbc(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_msdpbc(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_msdpv(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_msdpv(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_msdpv(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_ms_addrtype(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_ms_addrtype(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_ms_addrtype(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_ctysize(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_ctysize(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_ctysize(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_gen(SALT311.StrType s0) := MakeFT_GENDER_CODE(s0);
EXPORT InValid_gen(SALT311.StrType s) := InValidFT_GENDER_CODE(s);
EXPORT InValidMessage_gen(UNSIGNED1 wh) := InValidMessageFT_GENDER_CODE(wh);


EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);


EXPORT Make_age(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_age(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_inc(SALT311.StrType s0) := MakeFT_INC_CODE(s0);
EXPORT InValid_inc(SALT311.StrType s) := InValidFT_INC_CODE(s);
EXPORT InValidMessage_inc(UNSIGNED1 wh) := InValidMessageFT_INC_CODE(wh);


EXPORT Make_marital_status(SALT311.StrType s0) := MakeFT_ALPHA(s0);
EXPORT InValid_marital_status(SALT311.StrType s) := InValidFT_ALPHA(s);
EXPORT InValidMessage_marital_status(UNSIGNED1 wh) := InValidMessageFT_ALPHA(wh);


EXPORT Make_poc(SALT311.StrType s0) := MakeFT_ALPHA(s0);
EXPORT InValid_poc(SALT311.StrType s) := InValidFT_ALPHA(s);
EXPORT InValidMessage_poc(UNSIGNED1 wh) := InValidMessageFT_ALPHA(wh);


EXPORT Make_noc(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_noc(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_noc(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_ocp(SALT311.StrType s0) := MakeFT_OPC_CODE(s0);
EXPORT InValid_ocp(SALT311.StrType s) := InValidFT_OPC_CODE(s);
EXPORT InValidMessage_ocp(UNSIGNED1 wh) := InValidMessageFT_OPC_CODE(wh);


EXPORT Make_edu(SALT311.StrType s0) := MakeFT_EDU_CODE(s0);
EXPORT InValid_edu(SALT311.StrType s) := InValidFT_EDU_CODE(s);
EXPORT InValidMessage_edu(UNSIGNED1 wh) := InValidMessageFT_EDU_CODE(wh);


EXPORT Make_lang(SALT311.StrType s0) := MakeFT_GENERAL_CODE(s0);
EXPORT InValid_lang(SALT311.StrType s) := InValidFT_GENERAL_CODE(s);
EXPORT InValidMessage_lang(UNSIGNED1 wh) := InValidMessageFT_GENERAL_CODE(wh);


EXPORT Make_relig(SALT311.StrType s0) := MakeFT_RELIG_CODE(s0);
EXPORT InValid_relig(SALT311.StrType s) := InValidFT_RELIG_CODE(s);
EXPORT InValidMessage_relig(UNSIGNED1 wh) := InValidMessageFT_RELIG_CODE(wh);


EXPORT Make_dwell(SALT311.StrType s0) := MakeFT_DWELL_CODE(s0);
EXPORT InValid_dwell(SALT311.StrType s) := InValidFT_DWELL_CODE(s);
EXPORT InValidMessage_dwell(UNSIGNED1 wh) := InValidMessageFT_DWELL_CODE(wh);


EXPORT Make_ownr(SALT311.StrType s0) := MakeFT_ALPHA(s0);
EXPORT InValid_ownr(SALT311.StrType s) := InValidFT_ALPHA(s);
EXPORT InValidMessage_ownr(UNSIGNED1 wh) := InValidMessageFT_ALPHA(wh);


EXPORT Make_eth1(SALT311.StrType s0) := MakeFT_GENERAL_CODE(s0);
EXPORT InValid_eth1(SALT311.StrType s) := InValidFT_GENERAL_CODE(s);
EXPORT InValidMessage_eth1(UNSIGNED1 wh) := InValidMessageFT_GENERAL_CODE(wh);


EXPORT Make_eth2(SALT311.StrType s0) := MakeFT_GENERAL_CODE(s0);
EXPORT InValid_eth2(SALT311.StrType s) := InValidFT_GENERAL_CODE(s);
EXPORT InValidMessage_eth2(UNSIGNED1 wh) := InValidMessageFT_GENERAL_CODE(wh);


EXPORT Make_lor(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_lor(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_lor(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_pool(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_pool(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_pool(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_speak_span(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_speak_span(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_speak_span(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_soho(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_soho(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_soho(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_vet_in_hh(SALT311.StrType s0) := MakeFT_ALPHANUMERIC(s0);
EXPORT InValid_vet_in_hh(SALT311.StrType s) := InValidFT_ALPHANUMERIC(s);
EXPORT InValidMessage_vet_in_hh(UNSIGNED1 wh) := InValidMessageFT_ALPHANUMERIC(wh);


EXPORT Make_ms_mags(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_mags(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_mags(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_books(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_books(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_books(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_publish(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_publish(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_publish(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_status_active(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_status_active(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_status_active(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_status_expire(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_status_expire(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_status_expire(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_premsold(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_premsold(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_premsold(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_autornwl(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_autornwl(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_autornwl(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_avgterm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_avgterm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_avgterm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_cemos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_cemos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_cemos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_femos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_femos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_femos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_paystat_ub(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_paystat_ub(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_paystat_ub(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_payspeed(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_payspeed(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_payspeed(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_agt_cashf(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_agt_cashf(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_agt_cashf(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_agt_cashf(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_agt_cashf(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_agt_cashf(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_agt_pds(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_agt_pds(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_agt_pds(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_agt_pds(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_agt_pds(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_agt_pds(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_agt_schplan(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_agt_schplan(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_agt_schplan(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_agt_schplan(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_agt_schplan(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_agt_schplan(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_agt_sponsor(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_agt_sponsor(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_agt_sponsor(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_agt_sponsor(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_agt_sponsor(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_agt_sponsor(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_agt_tm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_agt_tm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_agt_tm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_agt_tm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_agt_tm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_agt_tm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_tm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_tm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_tm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_tm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_tm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_tm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_ins(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_ins(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_ins(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_ins(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_ins(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_ins(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_print(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_print(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_print(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_print(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_print(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_print(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_trans(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_trans(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_trans(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_trans(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_trans(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_trans(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_osrc_dtp(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_osrc_dtp(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_osrc_dtp(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_lsrc_dtp(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_lsrc_dtp(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_lsrc_dtp(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_giftgivr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_giftgivr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_giftgivr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_giftee(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_giftee(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_giftee(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_catalog(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_catalog(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_catalog(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_osrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_osrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_osrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_lsrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_lsrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_lsrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_giftgivr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_giftgivr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_giftgivr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpubs_corrected(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpubs_corrected(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpubs_corrected(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkcatg_corrected(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkcatg_corrected(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkcatg_corrected(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fundraising(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fundraising(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fundraising(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fund_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fund_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fund_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_other(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_other(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_other(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_continuity(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_continuity(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_continuity(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_status_active(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_status_active(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_status_active(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_status_cancel(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_status_cancel(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_status_cancel(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cont_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cont_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cont_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_osrc_tm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_osrc_tm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_osrc_tm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lsrc_tm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lsrc_tm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lsrc_tm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_osrc_ins(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_osrc_ins(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_osrc_ins(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lsrc_ins(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lsrc_ins(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lsrc_ins(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_osrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_osrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_osrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lsrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lsrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lsrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_osrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_osrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_osrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lsrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lsrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lsrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_osrc_retail(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_osrc_retail(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_osrc_retail(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_lsrc_retail(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_lsrc_retail(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_lsrc_retail(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_giftgivr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_giftgivr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_giftgivr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_giftee(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_giftee(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_giftee(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_adult(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_adult(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_adult(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_womapp(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_womapp(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_womapp(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_menapp(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_menapp(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_menapp(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_kidapp(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_kidapp(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_kidapp(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_accessory(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_accessory(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_accessory(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_apparel(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_apparel(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_apparel(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_app_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_app_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_app_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_menfash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_menfash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_menfash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_womfash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_womfash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_womfash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_osrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_osrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_osrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wfsh_lsrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wfsh_lsrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wfsh_lsrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_audio(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_audio(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_audio(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_auto(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_auto(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_auto(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_aviation(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_aviation(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_aviation(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bargains(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bargains(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bargains(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_beauty(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_beauty(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_beauty(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_bible_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_bible_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_bible_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_business(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_business(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_business(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_collectibles(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_collectibles(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_collectibles(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_computers(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_computers(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_computers(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_crafts(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_crafts(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_crafts(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_culturearts(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_culturearts(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_culturearts(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_currevent(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_currevent(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_currevent(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_diy(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_diy(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_diy(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_electronics(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_electronics(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_electronics(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_equestrian(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_equestrian(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_equestrian(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_family(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_family(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_family(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_family(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_family(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_family(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_family_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_family_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_family_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fiction(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fiction(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fiction(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_food(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_food(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_food(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_games(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_games(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_games(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_gifts(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_gifts(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_gifts(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_gourmet(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_gourmet(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_gourmet(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fitness(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fitness(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fitness(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_health(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_health(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_health(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_osrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_osrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_osrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_lsrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_lsrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_lsrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_osrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_osrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_osrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hlth_lsrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hlth_lsrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hlth_lsrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_holiday(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_holiday(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_holiday(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_history(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_history(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_history(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_cooking(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_cooking(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_cooking(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cooking(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cooking(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cooking(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_homedecr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_homedecr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_homedecr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_homedecr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_homedecr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_homedecr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_homedecr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_homedecr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_homedecr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_housewares(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_housewares(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_housewares(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_garden(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_garden(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_garden(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_garden(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_garden(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_garden(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_garden(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_garden(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_garden(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_homeliv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_homeliv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_homeliv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_homeliv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_homeliv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_homeliv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_homeliv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_homeliv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_homeliv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_home_status_active(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_home_status_active(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_home_status_active(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_osrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_osrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_osrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_lsrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_lsrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_lsrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_osrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_osrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_osrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_lsrc_net(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_lsrc_net(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_lsrc_net(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_osrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_osrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_osrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_home_lsrc_tv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_home_lsrc_tv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_home_lsrc_tv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_humor(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_humor(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_humor(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_inspiration(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_inspiration(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_inspiration(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_merchandise(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_merchandise(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_merchandise(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_moneymaking(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_moneymaking(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_moneymaking(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_moneymaking_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_moneymaking_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_moneymaking_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_motorcycles(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_motorcycles(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_motorcycles(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_music(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_music(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_music(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_fishing(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_fishing(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_fishing(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_hunting(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_hunting(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_hunting(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_boatsail(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_boatsail(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_boatsail(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_camp(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_camp(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_camp(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_outdoors(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_outdoors(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_outdoors(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_cat_outdoors(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_cat_outdoors(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_cat_outdoors(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_outdoors(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_outdoors(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_outdoors(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pub_out_status_active(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pub_out_status_active(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pub_out_status_active(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_omos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_omos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_omos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_pmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_pmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_pmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_totitems(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_totitems(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_totitems(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_totdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_totdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_totdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_avgdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_avgdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_avgdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_lastdlrs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_lastdlrs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_lastdlrs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_paystat_paid(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_paystat_paid(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_paystat_paid(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_paymeth_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_paymeth_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_paymeth_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_paymeth_cash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_paymeth_cash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_paymeth_cash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_osrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_osrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_osrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_lsrc_dm(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_lsrc_dm(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_lsrc_dm(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_osrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_osrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_osrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_out_lsrc_agt(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_out_lsrc_agt(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_out_lsrc_agt(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pets(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pets(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pets(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_pfin(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_pfin(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_pfin(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_photo(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_photo(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_photo(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_photoproc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_photoproc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_photoproc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_rural(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_rural(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_rural(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_science(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_science(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_science(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_sports(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_sports(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_sports(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_sports_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_sports_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_sports_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_travel(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_travel(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_travel(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_tvmovies(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_tvmovies(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_tvmovies(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_wildlife(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_wildlife(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_wildlife(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_woman(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_woman(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_woman(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_woman_lmos(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_woman_lmos(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_woman_lmos(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_ms_ringtones_apps(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_ms_ringtones_apps(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_ms_ringtones_apps(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_mobile_apps_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_mobile_apps_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_mobile_apps_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_credit_repair_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_credit_repair_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_credit_repair_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_credit_report_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_credit_report_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_credit_report_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_education_seekers_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_education_seekers_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_education_seekers_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_insurance_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_insurance_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_insurance_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_insurance_health_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_insurance_health_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_insurance_health_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_insurance_auto_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_insurance_auto_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_insurance_auto_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_job_seekers_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_job_seekers_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_job_seekers_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_social_networking_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_social_networking_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_social_networking_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_adult_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_adult_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_adult_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_africanamerican_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_africanamerican_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_africanamerican_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_accessory_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_accessory_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_accessory_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_kids_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_kids_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_kids_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_men_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_men_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_men_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_menfash_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_menfash_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_menfash_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_women_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_women_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_women_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_apparel_womfash_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_apparel_womfash_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_apparel_womfash_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_asian_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_asian_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_asian_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_auto_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_auto_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_auto_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_auto_racing_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_auto_racing_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_auto_racing_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_auto_trucks_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_auto_trucks_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_auto_trucks_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_aviation_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_aviation_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_aviation_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_bargains_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_bargains_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_bargains_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_beauty_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_beauty_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_beauty_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_bible_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_bible_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_bible_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_birds_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_birds_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_birds_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_business_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_business_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_business_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_business_homeoffice_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_business_homeoffice_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_business_homeoffice_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_catalog_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_catalog_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_catalog_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_cc_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_cc_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_cc_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_collectibles_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_collectibles_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_collectibles_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_college_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_college_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_college_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_computers_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_computers_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_computers_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_conservative_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_conservative_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_conservative_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_continuity_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_continuity_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_continuity_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_cooking_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_cooking_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_cooking_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_crafts_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_crafts_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_crafts_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_crafts_crochet_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_crafts_crochet_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_crafts_crochet_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_crafts_knit_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_crafts_knit_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_crafts_knit_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_crafts_needlepoint_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_crafts_needlepoint_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_crafts_needlepoint_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_crafts_quilt_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_crafts_quilt_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_crafts_quilt_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_crafts_sew_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_crafts_sew_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_crafts_sew_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_culturearts_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_culturearts_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_culturearts_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_currevent_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_currevent_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_currevent_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_diy_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_diy_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_diy_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_donor_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_donor_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_donor_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_ego_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_ego_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_ego_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_electronics_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_electronics_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_electronics_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_equestrian_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_equestrian_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_equestrian_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_family_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_family_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_family_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_family_teen_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_family_teen_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_family_teen_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_family_young_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_family_young_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_family_young_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_fiction_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_fiction_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_fiction_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_gambling_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_gambling_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_gambling_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_games_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_games_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_games_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_gardening_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_gardening_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_gardening_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_gay_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_gay_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_gay_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_giftgivr_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_giftgivr_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_giftgivr_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_gourmet_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_gourmet_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_gourmet_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_grandparents_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_grandparents_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_grandparents_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_health_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_health_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_health_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_health_diet_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_health_diet_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_health_diet_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_health_fitness_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_health_fitness_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_health_fitness_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_hightech_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_hightech_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_hightech_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_hispanic_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_hispanic_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_hispanic_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_history_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_history_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_history_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_history_american_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_history_american_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_history_american_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_hobbies_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_hobbies_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_hobbies_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_homedecr_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_homedecr_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_homedecr_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_homeliv_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_homeliv_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_homeliv_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_humor_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_humor_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_humor_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_inspiration_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_inspiration_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_inspiration_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_internet_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_internet_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_internet_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_internet_access_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_internet_access_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_internet_access_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_internet_buy_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_internet_buy_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_internet_buy_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_liberal_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_liberal_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_liberal_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_moneymaking_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_moneymaking_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_moneymaking_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_motorcycles_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_motorcycles_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_motorcycles_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_music_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_music_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_music_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_nonfiction_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_nonfiction_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_nonfiction_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_ocean_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_ocean_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_ocean_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_outdoors_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_outdoors_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_outdoors_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_outdoors_boatsail_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_outdoors_boatsail_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_outdoors_boatsail_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_outdoors_camp_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_outdoors_camp_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_outdoors_camp_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_outdoors_fishing_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_outdoors_fishing_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_outdoors_fishing_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_outdoors_huntfish_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_outdoors_huntfish_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_outdoors_huntfish_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_outdoors_hunting_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_outdoors_hunting_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_outdoors_hunting_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_pets_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_pets_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_pets_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_pets_cats_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_pets_cats_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_pets_cats_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_pets_dogs_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_pets_dogs_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_pets_dogs_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_pfin_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_pfin_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_pfin_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_photog_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_photog_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_photog_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_photoproc_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_photoproc_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_photoproc_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_publish_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_publish_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_publish_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_publish_books_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_publish_books_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_publish_books_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_publish_mags_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_publish_mags_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_publish_mags_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_rural_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_rural_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_rural_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_science_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_science_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_science_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_scifi_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_scifi_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_scifi_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_seniors_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_seniors_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_seniors_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_baseball_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_baseball_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_baseball_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_basketball_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_basketball_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_basketball_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_biking_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_biking_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_biking_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_football_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_football_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_football_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_golf_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_golf_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_golf_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_hockey_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_hockey_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_hockey_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_running_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_running_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_running_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_ski_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_ski_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_ski_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_soccer_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_soccer_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_soccer_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_swimming_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_swimming_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_swimming_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sports_tennis_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sports_tennis_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sports_tennis_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_stationery_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_stationery_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_stationery_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_sweeps_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_sweeps_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_sweeps_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_tobacco_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_tobacco_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_tobacco_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_travel_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_travel_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_travel_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_travel_cruise_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_travel_cruise_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_travel_cruise_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_travel_rv_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_travel_rv_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_travel_rv_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_travel_us_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_travel_us_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_travel_us_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_tvmovies_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_tvmovies_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_tvmovies_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_wildlife_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_wildlife_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_wildlife_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_woman_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_woman_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_woman_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_totdlr_index(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_totdlr_index(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_totdlr_index(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_totdlr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_totdlr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_totdlr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_totords(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_totords(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_totords(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cpi_lastdlr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cpi_lastdlr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cpi_lastdlr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkcatg(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkcatg(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkcatg(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpubs(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpubs(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpubs(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkcont(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkcont(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkcont(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca01(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca01(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca01(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca03(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca03(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca03(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca04(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca04(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca04(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca05(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca05(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca05(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca06(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca06(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca06(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca07(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca07(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca07(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca08(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca08(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca08(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca09(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca09(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca09(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca10(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca10(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca10(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca11(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca11(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca11(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca12(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca12(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca12(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca13(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca13(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca13(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca14(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca14(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca14(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca15(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca15(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca15(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca16(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca16(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca16(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca17(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca17(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca17(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca18(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca18(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca18(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca20(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca20(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca20(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca21(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca21(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca21(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca22(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca22(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca22(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca23(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca23(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca23(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca24(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca24(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca24(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca25(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca25(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca25(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca26(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca26(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca26(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca28(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca28(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca28(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca29(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca29(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca29(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca30(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca30(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca30(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca31(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca31(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca31(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca32(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca32(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca32(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca33(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca33(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca33(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca34(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca34(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca34(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca35(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca35(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca35(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca36(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca36(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca36(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca37(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca37(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca37(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca39(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca39(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca39(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca40(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca40(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca40(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca41(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca41(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca41(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca42(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca42(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca42(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca54(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca54(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca54(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca61(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca61(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca61(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca62(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca62(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca62(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkca64(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkca64(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkca64(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu01(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu01(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu01(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu02(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu02(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu02(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu03(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu03(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu03(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu04(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu04(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu04(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu05(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu05(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu05(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu06(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu06(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu06(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu07(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu07(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu07(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu08(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu08(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu08(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu09(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu09(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu09(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu10(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu10(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu10(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu11(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu11(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu11(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu12(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu12(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu12(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu13(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu13(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu13(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu14(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu14(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu14(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu15(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu15(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu15(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu16(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu16(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu16(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu17(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu17(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu17(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu18(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu18(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu18(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu19(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu19(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu19(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu20(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu20(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu20(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu23(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu23(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu23(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu25(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu25(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu25(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu27(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu27(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu27(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu28(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu28(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu28(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu29(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu29(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu29(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu30(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu30(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu30(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu31(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu31(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu31(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu32(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu32(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu32(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu33(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu33(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu33(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu34(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu34(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu34(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu35(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu35(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu35(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu38(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu38(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu38(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu41(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu41(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu41(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu42(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu42(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu42(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu45(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu45(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu45(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu46(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu46(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu46(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu47(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu47(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu47(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu48(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu48(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu48(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu49(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu49(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu49(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu50(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu50(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu50(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu51(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu51(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu51(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu52(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu52(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu52(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu53(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu53(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu53(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu54(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu54(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu54(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu55(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu55(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu55(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu56(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu56(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu56(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu57(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu57(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu57(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu60(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu60(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu60(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu61(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu61(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu61(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu62(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu62(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu62(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu63(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu63(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu63(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu64(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu64(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu64(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu65(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu65(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu65(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu66(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu66(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu66(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu67(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu67(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu67(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu68(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu68(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu68(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu69(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu69(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu69(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_pkpu70(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_pkpu70(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_pkpu70(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_water(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_water(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_water(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cens_pop_density(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cens_pop_density(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cens_pop_density(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cens_hu_density(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cens_hu_density(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cens_hu_density(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_white(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_white(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_white(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_black(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_black(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_black(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_amerind(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_amerind(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_amerind(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_asian(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_asian(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_asian(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_pacisl(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_pacisl(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_pacisl(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_othrace(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_othrace(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_othrace(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_multirace(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_multirace(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_multirace(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_hispanic(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_hispanic(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_hispanic(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_agelt18(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_agelt18(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_agelt18(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_pop_males(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_pop_males(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_pop_males(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_adult_age1824(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_adult_age1824(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_adult_age1824(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_adult_age2534(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_adult_age2534(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_adult_age2534(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_adult_age3544(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_adult_age3544(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_adult_age3544(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_adult_age4554(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_adult_age4554(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_adult_age4554(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_adult_age5564(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_adult_age5564(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_adult_age5564(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_adult_agege65(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_adult_agege65(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_adult_agege65(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cens_pop_medage(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cens_pop_medage(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cens_pop_medage(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_cens_hh_avgsize(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_cens_hh_avgsize(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_cens_hh_avgsize(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_hh_family(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_hh_family(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_hh_family(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_hh_family_husbwife(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_hh_family_husbwife(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_hh_family_husbwife(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_hu_occupied(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_hu_occupied(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_hu_occupied(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_hu_owned(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_hu_owned(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_hu_owned(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_hu_rented(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_hu_rented(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_hu_rented(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_censpct_hu_vacantseasonal(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_censpct_hu_vacantseasonal(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_censpct_hu_vacantseasonal(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_medinc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_medinc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_medinc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_apparel(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_apparel(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_apparel(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_apparel_women(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_apparel_women(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_apparel_women(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_apparel_womfash(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_apparel_womfash(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_apparel_womfash(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_auto(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_auto(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_auto(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_beauty(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_beauty(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_beauty(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_booksmusicmovies(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_booksmusicmovies(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_booksmusicmovies(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_business(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_business(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_business(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_catalog(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_catalog(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_catalog(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_cc(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_cc(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_cc(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_collectibles(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_collectibles(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_collectibles(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_computers(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_computers(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_computers(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_continuity(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_continuity(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_continuity(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_cooking(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_cooking(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_cooking(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_crafts(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_crafts(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_crafts(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_culturearts(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_culturearts(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_culturearts(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_dm_sold(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_dm_sold(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_dm_sold(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_donor(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_donor(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_donor(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_family(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_family(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_family(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_gardening(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_gardening(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_gardening(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_giftgivr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_giftgivr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_giftgivr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_gourmet(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_gourmet(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_gourmet(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_health(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_health(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_health(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_health_diet(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_health_diet(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_health_diet(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_health_fitness(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_health_fitness(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_health_fitness(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_hobbies(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_hobbies(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_hobbies(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_homedecr(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_homedecr(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_homedecr(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_homeliv(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_homeliv(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_homeliv(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_internet(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_internet(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_internet(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_internet_access(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_internet_access(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_internet_access(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_internet_buy(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_internet_buy(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_internet_buy(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_music(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_music(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_music(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_outdoors(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_outdoors(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_outdoors(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_pets(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_pets(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_pets(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_pfin(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_pfin(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_pfin(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_publish(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_publish(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_publish(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_publish_books(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_publish_books(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_publish_books(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_publish_mags(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_publish_mags(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_publish_mags(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_sports(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_sports(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_sports(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_sports_biking(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_sports_biking(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_sports_biking(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_sports_golf(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_sports_golf(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_sports_golf(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_travel(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_travel(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_travel(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_travel_us(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_travel_us(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_travel_us(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_tvmovies(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_tvmovies(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_tvmovies(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_woman(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_woman(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_woman(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_proftech(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_proftech(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_proftech(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_retired(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_retired(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_retired(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_inc100(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_inc100(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_inc100(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_inc75(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_inc75(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_inc75(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);


EXPORT Make_zip_inc50(SALT311.StrType s0) := MakeFT_NUMBER(s0);
EXPORT InValid_zip_inc50(SALT311.StrType s) := InValidFT_NUMBER(s);
EXPORT InValidMessage_zip_inc50(UNSIGNED1 wh) := InValidMessageFT_NUMBER(wh);

// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Dunndata_Consumer;
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
    BOOLEAN Diff_dtmatch;
    BOOLEAN Diff_msname;
    BOOLEAN Diff_msaddr1;
    BOOLEAN Diff_msaddr2;
    BOOLEAN Diff_mscity;
    BOOLEAN Diff_msstate;
    BOOLEAN Diff_mszip5;
    BOOLEAN Diff_mszip4;
    BOOLEAN Diff_dthh;
    BOOLEAN Diff_mscrrt;
    BOOLEAN Diff_msdpbc;
    BOOLEAN Diff_msdpv;
    BOOLEAN Diff_ms_addrtype;
    BOOLEAN Diff_ctysize;
    BOOLEAN Diff_lmos;
    BOOLEAN Diff_omos;
    BOOLEAN Diff_pmos;
    BOOLEAN Diff_gen;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_age;
    BOOLEAN Diff_inc;
    BOOLEAN Diff_marital_status;
    BOOLEAN Diff_poc;
    BOOLEAN Diff_noc;
    BOOLEAN Diff_ocp;
    BOOLEAN Diff_edu;
    BOOLEAN Diff_lang;
    BOOLEAN Diff_relig;
    BOOLEAN Diff_dwell;
    BOOLEAN Diff_ownr;
    BOOLEAN Diff_eth1;
    BOOLEAN Diff_eth2;
    BOOLEAN Diff_lor;
    BOOLEAN Diff_pool;
    BOOLEAN Diff_speak_span;
    BOOLEAN Diff_soho;
    BOOLEAN Diff_vet_in_hh;
    BOOLEAN Diff_ms_mags;
    BOOLEAN Diff_ms_books;
    BOOLEAN Diff_ms_publish;
    BOOLEAN Diff_ms_pub_status_active;
    BOOLEAN Diff_ms_pub_status_expire;
    BOOLEAN Diff_ms_pub_premsold;
    BOOLEAN Diff_ms_pub_autornwl;
    BOOLEAN Diff_ms_pub_avgterm;
    BOOLEAN Diff_ms_pub_lmos;
    BOOLEAN Diff_ms_pub_omos;
    BOOLEAN Diff_ms_pub_pmos;
    BOOLEAN Diff_ms_pub_cemos;
    BOOLEAN Diff_ms_pub_femos;
    BOOLEAN Diff_ms_pub_totords;
    BOOLEAN Diff_ms_pub_totdlrs;
    BOOLEAN Diff_ms_pub_avgdlrs;
    BOOLEAN Diff_ms_pub_lastdlrs;
    BOOLEAN Diff_ms_pub_paystat_paid;
    BOOLEAN Diff_ms_pub_paystat_ub;
    BOOLEAN Diff_ms_pub_paymeth_cc;
    BOOLEAN Diff_ms_pub_paymeth_cash;
    BOOLEAN Diff_ms_pub_payspeed;
    BOOLEAN Diff_ms_pub_osrc_dm;
    BOOLEAN Diff_ms_pub_lsrc_dm;
    BOOLEAN Diff_ms_pub_osrc_agt_cashf;
    BOOLEAN Diff_ms_pub_lsrc_agt_cashf;
    BOOLEAN Diff_ms_pub_osrc_agt_pds;
    BOOLEAN Diff_ms_pub_lsrc_agt_pds;
    BOOLEAN Diff_ms_pub_osrc_agt_schplan;
    BOOLEAN Diff_ms_pub_lsrc_agt_schplan;
    BOOLEAN Diff_ms_pub_osrc_agt_sponsor;
    BOOLEAN Diff_ms_pub_lsrc_agt_sponsor;
    BOOLEAN Diff_ms_pub_osrc_agt_tm;
    BOOLEAN Diff_ms_pub_lsrc_agt_tm;
    BOOLEAN Diff_ms_pub_osrc_agt;
    BOOLEAN Diff_ms_pub_lsrc_agt;
    BOOLEAN Diff_ms_pub_osrc_tm;
    BOOLEAN Diff_ms_pub_lsrc_tm;
    BOOLEAN Diff_ms_pub_osrc_ins;
    BOOLEAN Diff_ms_pub_lsrc_ins;
    BOOLEAN Diff_ms_pub_osrc_net;
    BOOLEAN Diff_ms_pub_lsrc_net;
    BOOLEAN Diff_ms_pub_osrc_print;
    BOOLEAN Diff_ms_pub_lsrc_print;
    BOOLEAN Diff_ms_pub_osrc_trans;
    BOOLEAN Diff_ms_pub_lsrc_trans;
    BOOLEAN Diff_ms_pub_osrc_tv;
    BOOLEAN Diff_ms_pub_lsrc_tv;
    BOOLEAN Diff_ms_pub_osrc_dtp;
    BOOLEAN Diff_ms_pub_lsrc_dtp;
    BOOLEAN Diff_ms_pub_giftgivr;
    BOOLEAN Diff_ms_pub_giftee;
    BOOLEAN Diff_ms_catalog;
    BOOLEAN Diff_ms_cat_lmos;
    BOOLEAN Diff_ms_cat_omos;
    BOOLEAN Diff_ms_cat_pmos;
    BOOLEAN Diff_ms_cat_totords;
    BOOLEAN Diff_ms_cat_totitems;
    BOOLEAN Diff_ms_cat_totdlrs;
    BOOLEAN Diff_ms_cat_avgdlrs;
    BOOLEAN Diff_ms_cat_lastdlrs;
    BOOLEAN Diff_ms_cat_paystat_paid;
    BOOLEAN Diff_ms_cat_paymeth_cc;
    BOOLEAN Diff_ms_cat_paymeth_cash;
    BOOLEAN Diff_ms_cat_osrc_dm;
    BOOLEAN Diff_ms_cat_lsrc_dm;
    BOOLEAN Diff_ms_cat_osrc_net;
    BOOLEAN Diff_ms_cat_lsrc_net;
    BOOLEAN Diff_ms_cat_giftgivr;
    BOOLEAN Diff_pkpubs_corrected;
    BOOLEAN Diff_pkcatg_corrected;
    BOOLEAN Diff_ms_fundraising;
    BOOLEAN Diff_ms_fund_lmos;
    BOOLEAN Diff_ms_fund_omos;
    BOOLEAN Diff_ms_fund_pmos;
    BOOLEAN Diff_ms_fund_totords;
    BOOLEAN Diff_ms_fund_totdlrs;
    BOOLEAN Diff_ms_fund_avgdlrs;
    BOOLEAN Diff_ms_fund_lastdlrs;
    BOOLEAN Diff_ms_fund_paystat_paid;
    BOOLEAN Diff_ms_other;
    BOOLEAN Diff_ms_continuity;
    BOOLEAN Diff_ms_cont_status_active;
    BOOLEAN Diff_ms_cont_status_cancel;
    BOOLEAN Diff_ms_cont_omos;
    BOOLEAN Diff_ms_cont_lmos;
    BOOLEAN Diff_ms_cont_pmos;
    BOOLEAN Diff_ms_cont_totords;
    BOOLEAN Diff_ms_cont_totdlrs;
    BOOLEAN Diff_ms_cont_avgdlrs;
    BOOLEAN Diff_ms_cont_lastdlrs;
    BOOLEAN Diff_ms_cont_paystat_paid;
    BOOLEAN Diff_ms_cont_paymeth_cc;
    BOOLEAN Diff_ms_cont_paymeth_cash;
    BOOLEAN Diff_ms_totords;
    BOOLEAN Diff_ms_totitems;
    BOOLEAN Diff_ms_totdlrs;
    BOOLEAN Diff_ms_avgdlrs;
    BOOLEAN Diff_ms_lastdlrs;
    BOOLEAN Diff_ms_paystat_paid;
    BOOLEAN Diff_ms_paymeth_cc;
    BOOLEAN Diff_ms_paymeth_cash;
    BOOLEAN Diff_ms_osrc_dm;
    BOOLEAN Diff_ms_lsrc_dm;
    BOOLEAN Diff_ms_osrc_tm;
    BOOLEAN Diff_ms_lsrc_tm;
    BOOLEAN Diff_ms_osrc_ins;
    BOOLEAN Diff_ms_lsrc_ins;
    BOOLEAN Diff_ms_osrc_net;
    BOOLEAN Diff_ms_lsrc_net;
    BOOLEAN Diff_ms_osrc_tv;
    BOOLEAN Diff_ms_lsrc_tv;
    BOOLEAN Diff_ms_osrc_retail;
    BOOLEAN Diff_ms_lsrc_retail;
    BOOLEAN Diff_ms_giftgivr;
    BOOLEAN Diff_ms_giftee;
    BOOLEAN Diff_ms_adult;
    BOOLEAN Diff_ms_womapp;
    BOOLEAN Diff_ms_menapp;
    BOOLEAN Diff_ms_kidapp;
    BOOLEAN Diff_ms_accessory;
    BOOLEAN Diff_ms_apparel;
    BOOLEAN Diff_ms_app_lmos;
    BOOLEAN Diff_ms_app_omos;
    BOOLEAN Diff_ms_app_pmos;
    BOOLEAN Diff_ms_app_totords;
    BOOLEAN Diff_ms_app_totitems;
    BOOLEAN Diff_ms_app_totdlrs;
    BOOLEAN Diff_ms_app_avgdlrs;
    BOOLEAN Diff_ms_app_lastdlrs;
    BOOLEAN Diff_ms_app_paystat_paid;
    BOOLEAN Diff_ms_app_paymeth_cc;
    BOOLEAN Diff_ms_app_paymeth_cash;
    BOOLEAN Diff_ms_menfash;
    BOOLEAN Diff_ms_womfash;
    BOOLEAN Diff_ms_wfsh_lmos;
    BOOLEAN Diff_ms_wfsh_omos;
    BOOLEAN Diff_ms_wfsh_pmos;
    BOOLEAN Diff_ms_wfsh_totords;
    BOOLEAN Diff_ms_wfsh_totdlrs;
    BOOLEAN Diff_ms_wfsh_avgdlrs;
    BOOLEAN Diff_ms_wfsh_lastdlrs;
    BOOLEAN Diff_ms_wfsh_paystat_paid;
    BOOLEAN Diff_ms_wfsh_osrc_dm;
    BOOLEAN Diff_ms_wfsh_lsrc_dm;
    BOOLEAN Diff_ms_wfsh_osrc_agt;
    BOOLEAN Diff_ms_wfsh_lsrc_agt;
    BOOLEAN Diff_ms_audio;
    BOOLEAN Diff_ms_auto;
    BOOLEAN Diff_ms_aviation;
    BOOLEAN Diff_ms_bargains;
    BOOLEAN Diff_ms_beauty;
    BOOLEAN Diff_ms_bible;
    BOOLEAN Diff_ms_bible_lmos;
    BOOLEAN Diff_ms_bible_omos;
    BOOLEAN Diff_ms_bible_pmos;
    BOOLEAN Diff_ms_bible_totords;
    BOOLEAN Diff_ms_bible_totitems;
    BOOLEAN Diff_ms_bible_totdlrs;
    BOOLEAN Diff_ms_bible_avgdlrs;
    BOOLEAN Diff_ms_bible_lastdlrs;
    BOOLEAN Diff_ms_bible_paystat_paid;
    BOOLEAN Diff_ms_bible_paymeth_cc;
    BOOLEAN Diff_ms_bible_paymeth_cash;
    BOOLEAN Diff_ms_business;
    BOOLEAN Diff_ms_collectibles;
    BOOLEAN Diff_ms_computers;
    BOOLEAN Diff_ms_crafts;
    BOOLEAN Diff_ms_culturearts;
    BOOLEAN Diff_ms_currevent;
    BOOLEAN Diff_ms_diy;
    BOOLEAN Diff_ms_electronics;
    BOOLEAN Diff_ms_equestrian;
    BOOLEAN Diff_ms_pub_family;
    BOOLEAN Diff_ms_cat_family;
    BOOLEAN Diff_ms_family;
    BOOLEAN Diff_ms_family_lmos;
    BOOLEAN Diff_ms_family_omos;
    BOOLEAN Diff_ms_family_pmos;
    BOOLEAN Diff_ms_family_totords;
    BOOLEAN Diff_ms_family_totitems;
    BOOLEAN Diff_ms_family_totdlrs;
    BOOLEAN Diff_ms_family_avgdlrs;
    BOOLEAN Diff_ms_family_lastdlrs;
    BOOLEAN Diff_ms_family_paystat_paid;
    BOOLEAN Diff_ms_family_paymeth_cc;
    BOOLEAN Diff_ms_family_paymeth_cash;
    BOOLEAN Diff_ms_family_osrc_dm;
    BOOLEAN Diff_ms_family_lsrc_dm;
    BOOLEAN Diff_ms_fiction;
    BOOLEAN Diff_ms_food;
    BOOLEAN Diff_ms_games;
    BOOLEAN Diff_ms_gifts;
    BOOLEAN Diff_ms_gourmet;
    BOOLEAN Diff_ms_fitness;
    BOOLEAN Diff_ms_health;
    BOOLEAN Diff_ms_hlth_lmos;
    BOOLEAN Diff_ms_hlth_omos;
    BOOLEAN Diff_ms_hlth_pmos;
    BOOLEAN Diff_ms_hlth_totords;
    BOOLEAN Diff_ms_hlth_totdlrs;
    BOOLEAN Diff_ms_hlth_avgdlrs;
    BOOLEAN Diff_ms_hlth_lastdlrs;
    BOOLEAN Diff_ms_hlth_paystat_paid;
    BOOLEAN Diff_ms_hlth_paymeth_cc;
    BOOLEAN Diff_ms_hlth_osrc_dm;
    BOOLEAN Diff_ms_hlth_lsrc_dm;
    BOOLEAN Diff_ms_hlth_osrc_agt;
    BOOLEAN Diff_ms_hlth_lsrc_agt;
    BOOLEAN Diff_ms_hlth_osrc_tv;
    BOOLEAN Diff_ms_hlth_lsrc_tv;
    BOOLEAN Diff_ms_holiday;
    BOOLEAN Diff_ms_history;
    BOOLEAN Diff_ms_pub_cooking;
    BOOLEAN Diff_ms_cooking;
    BOOLEAN Diff_ms_pub_homedecr;
    BOOLEAN Diff_ms_cat_homedecr;
    BOOLEAN Diff_ms_homedecr;
    BOOLEAN Diff_ms_housewares;
    BOOLEAN Diff_ms_pub_garden;
    BOOLEAN Diff_ms_cat_garden;
    BOOLEAN Diff_ms_garden;
    BOOLEAN Diff_ms_pub_homeliv;
    BOOLEAN Diff_ms_cat_homeliv;
    BOOLEAN Diff_ms_homeliv;
    BOOLEAN Diff_ms_pub_home_status_active;
    BOOLEAN Diff_ms_home_lmos;
    BOOLEAN Diff_ms_home_omos;
    BOOLEAN Diff_ms_home_pmos;
    BOOLEAN Diff_ms_home_totords;
    BOOLEAN Diff_ms_home_totitems;
    BOOLEAN Diff_ms_home_totdlrs;
    BOOLEAN Diff_ms_home_avgdlrs;
    BOOLEAN Diff_ms_home_lastdlrs;
    BOOLEAN Diff_ms_home_paystat_paid;
    BOOLEAN Diff_ms_home_paymeth_cc;
    BOOLEAN Diff_ms_home_paymeth_cash;
    BOOLEAN Diff_ms_home_osrc_dm;
    BOOLEAN Diff_ms_home_lsrc_dm;
    BOOLEAN Diff_ms_home_osrc_agt;
    BOOLEAN Diff_ms_home_lsrc_agt;
    BOOLEAN Diff_ms_home_osrc_net;
    BOOLEAN Diff_ms_home_lsrc_net;
    BOOLEAN Diff_ms_home_osrc_tv;
    BOOLEAN Diff_ms_home_lsrc_tv;
    BOOLEAN Diff_ms_humor;
    BOOLEAN Diff_ms_inspiration;
    BOOLEAN Diff_ms_merchandise;
    BOOLEAN Diff_ms_moneymaking;
    BOOLEAN Diff_ms_moneymaking_lmos;
    BOOLEAN Diff_ms_motorcycles;
    BOOLEAN Diff_ms_music;
    BOOLEAN Diff_ms_fishing;
    BOOLEAN Diff_ms_hunting;
    BOOLEAN Diff_ms_boatsail;
    BOOLEAN Diff_ms_camp;
    BOOLEAN Diff_ms_pub_outdoors;
    BOOLEAN Diff_ms_cat_outdoors;
    BOOLEAN Diff_ms_outdoors;
    BOOLEAN Diff_ms_pub_out_status_active;
    BOOLEAN Diff_ms_out_lmos;
    BOOLEAN Diff_ms_out_omos;
    BOOLEAN Diff_ms_out_pmos;
    BOOLEAN Diff_ms_out_totords;
    BOOLEAN Diff_ms_out_totitems;
    BOOLEAN Diff_ms_out_totdlrs;
    BOOLEAN Diff_ms_out_avgdlrs;
    BOOLEAN Diff_ms_out_lastdlrs;
    BOOLEAN Diff_ms_out_paystat_paid;
    BOOLEAN Diff_ms_out_paymeth_cc;
    BOOLEAN Diff_ms_out_paymeth_cash;
    BOOLEAN Diff_ms_out_osrc_dm;
    BOOLEAN Diff_ms_out_lsrc_dm;
    BOOLEAN Diff_ms_out_osrc_agt;
    BOOLEAN Diff_ms_out_lsrc_agt;
    BOOLEAN Diff_ms_pets;
    BOOLEAN Diff_ms_pfin;
    BOOLEAN Diff_ms_photo;
    BOOLEAN Diff_ms_photoproc;
    BOOLEAN Diff_ms_rural;
    BOOLEAN Diff_ms_science;
    BOOLEAN Diff_ms_sports;
    BOOLEAN Diff_ms_sports_lmos;
    BOOLEAN Diff_ms_travel;
    BOOLEAN Diff_ms_tvmovies;
    BOOLEAN Diff_ms_wildlife;
    BOOLEAN Diff_ms_woman;
    BOOLEAN Diff_ms_woman_lmos;
    BOOLEAN Diff_ms_ringtones_apps;
    BOOLEAN Diff_cpi_mobile_apps_index;
    BOOLEAN Diff_cpi_credit_repair_index;
    BOOLEAN Diff_cpi_credit_report_index;
    BOOLEAN Diff_cpi_education_seekers_index;
    BOOLEAN Diff_cpi_insurance_index;
    BOOLEAN Diff_cpi_insurance_health_index;
    BOOLEAN Diff_cpi_insurance_auto_index;
    BOOLEAN Diff_cpi_job_seekers_index;
    BOOLEAN Diff_cpi_social_networking_index;
    BOOLEAN Diff_cpi_adult_index;
    BOOLEAN Diff_cpi_africanamerican_index;
    BOOLEAN Diff_cpi_apparel_index;
    BOOLEAN Diff_cpi_apparel_accessory_index;
    BOOLEAN Diff_cpi_apparel_kids_index;
    BOOLEAN Diff_cpi_apparel_men_index;
    BOOLEAN Diff_cpi_apparel_menfash_index;
    BOOLEAN Diff_cpi_apparel_women_index;
    BOOLEAN Diff_cpi_apparel_womfash_index;
    BOOLEAN Diff_cpi_asian_index;
    BOOLEAN Diff_cpi_auto_index;
    BOOLEAN Diff_cpi_auto_racing_index;
    BOOLEAN Diff_cpi_auto_trucks_index;
    BOOLEAN Diff_cpi_aviation_index;
    BOOLEAN Diff_cpi_bargains_index;
    BOOLEAN Diff_cpi_beauty_index;
    BOOLEAN Diff_cpi_bible_index;
    BOOLEAN Diff_cpi_birds_index;
    BOOLEAN Diff_cpi_business_index;
    BOOLEAN Diff_cpi_business_homeoffice_index;
    BOOLEAN Diff_cpi_catalog_index;
    BOOLEAN Diff_cpi_cc_index;
    BOOLEAN Diff_cpi_collectibles_index;
    BOOLEAN Diff_cpi_college_index;
    BOOLEAN Diff_cpi_computers_index;
    BOOLEAN Diff_cpi_conservative_index;
    BOOLEAN Diff_cpi_continuity_index;
    BOOLEAN Diff_cpi_cooking_index;
    BOOLEAN Diff_cpi_crafts_index;
    BOOLEAN Diff_cpi_crafts_crochet_index;
    BOOLEAN Diff_cpi_crafts_knit_index;
    BOOLEAN Diff_cpi_crafts_needlepoint_index;
    BOOLEAN Diff_cpi_crafts_quilt_index;
    BOOLEAN Diff_cpi_crafts_sew_index;
    BOOLEAN Diff_cpi_culturearts_index;
    BOOLEAN Diff_cpi_currevent_index;
    BOOLEAN Diff_cpi_diy_index;
    BOOLEAN Diff_cpi_donor_index;
    BOOLEAN Diff_cpi_ego_index;
    BOOLEAN Diff_cpi_electronics_index;
    BOOLEAN Diff_cpi_equestrian_index;
    BOOLEAN Diff_cpi_family_index;
    BOOLEAN Diff_cpi_family_teen_index;
    BOOLEAN Diff_cpi_family_young_index;
    BOOLEAN Diff_cpi_fiction_index;
    BOOLEAN Diff_cpi_gambling_index;
    BOOLEAN Diff_cpi_games_index;
    BOOLEAN Diff_cpi_gardening_index;
    BOOLEAN Diff_cpi_gay_index;
    BOOLEAN Diff_cpi_giftgivr_index;
    BOOLEAN Diff_cpi_gourmet_index;
    BOOLEAN Diff_cpi_grandparents_index;
    BOOLEAN Diff_cpi_health_index;
    BOOLEAN Diff_cpi_health_diet_index;
    BOOLEAN Diff_cpi_health_fitness_index;
    BOOLEAN Diff_cpi_hightech_index;
    BOOLEAN Diff_cpi_hispanic_index;
    BOOLEAN Diff_cpi_history_index;
    BOOLEAN Diff_cpi_history_american_index;
    BOOLEAN Diff_cpi_hobbies_index;
    BOOLEAN Diff_cpi_homedecr_index;
    BOOLEAN Diff_cpi_homeliv_index;
    BOOLEAN Diff_cpi_humor_index;
    BOOLEAN Diff_cpi_inspiration_index;
    BOOLEAN Diff_cpi_internet_index;
    BOOLEAN Diff_cpi_internet_access_index;
    BOOLEAN Diff_cpi_internet_buy_index;
    BOOLEAN Diff_cpi_liberal_index;
    BOOLEAN Diff_cpi_moneymaking_index;
    BOOLEAN Diff_cpi_motorcycles_index;
    BOOLEAN Diff_cpi_music_index;
    BOOLEAN Diff_cpi_nonfiction_index;
    BOOLEAN Diff_cpi_ocean_index;
    BOOLEAN Diff_cpi_outdoors_index;
    BOOLEAN Diff_cpi_outdoors_boatsail_index;
    BOOLEAN Diff_cpi_outdoors_camp_index;
    BOOLEAN Diff_cpi_outdoors_fishing_index;
    BOOLEAN Diff_cpi_outdoors_huntfish_index;
    BOOLEAN Diff_cpi_outdoors_hunting_index;
    BOOLEAN Diff_cpi_pets_index;
    BOOLEAN Diff_cpi_pets_cats_index;
    BOOLEAN Diff_cpi_pets_dogs_index;
    BOOLEAN Diff_cpi_pfin_index;
    BOOLEAN Diff_cpi_photog_index;
    BOOLEAN Diff_cpi_photoproc_index;
    BOOLEAN Diff_cpi_publish_index;
    BOOLEAN Diff_cpi_publish_books_index;
    BOOLEAN Diff_cpi_publish_mags_index;
    BOOLEAN Diff_cpi_rural_index;
    BOOLEAN Diff_cpi_science_index;
    BOOLEAN Diff_cpi_scifi_index;
    BOOLEAN Diff_cpi_seniors_index;
    BOOLEAN Diff_cpi_sports_index;
    BOOLEAN Diff_cpi_sports_baseball_index;
    BOOLEAN Diff_cpi_sports_basketball_index;
    BOOLEAN Diff_cpi_sports_biking_index;
    BOOLEAN Diff_cpi_sports_football_index;
    BOOLEAN Diff_cpi_sports_golf_index;
    BOOLEAN Diff_cpi_sports_hockey_index;
    BOOLEAN Diff_cpi_sports_running_index;
    BOOLEAN Diff_cpi_sports_ski_index;
    BOOLEAN Diff_cpi_sports_soccer_index;
    BOOLEAN Diff_cpi_sports_swimming_index;
    BOOLEAN Diff_cpi_sports_tennis_index;
    BOOLEAN Diff_cpi_stationery_index;
    BOOLEAN Diff_cpi_sweeps_index;
    BOOLEAN Diff_cpi_tobacco_index;
    BOOLEAN Diff_cpi_travel_index;
    BOOLEAN Diff_cpi_travel_cruise_index;
    BOOLEAN Diff_cpi_travel_rv_index;
    BOOLEAN Diff_cpi_travel_us_index;
    BOOLEAN Diff_cpi_tvmovies_index;
    BOOLEAN Diff_cpi_wildlife_index;
    BOOLEAN Diff_cpi_woman_index;
    BOOLEAN Diff_totdlr_index;
    BOOLEAN Diff_cpi_totdlr;
    BOOLEAN Diff_cpi_totords;
    BOOLEAN Diff_cpi_lastdlr;
    BOOLEAN Diff_pkcatg;
    BOOLEAN Diff_pkpubs;
    BOOLEAN Diff_pkcont;
    BOOLEAN Diff_pkca01;
    BOOLEAN Diff_pkca03;
    BOOLEAN Diff_pkca04;
    BOOLEAN Diff_pkca05;
    BOOLEAN Diff_pkca06;
    BOOLEAN Diff_pkca07;
    BOOLEAN Diff_pkca08;
    BOOLEAN Diff_pkca09;
    BOOLEAN Diff_pkca10;
    BOOLEAN Diff_pkca11;
    BOOLEAN Diff_pkca12;
    BOOLEAN Diff_pkca13;
    BOOLEAN Diff_pkca14;
    BOOLEAN Diff_pkca15;
    BOOLEAN Diff_pkca16;
    BOOLEAN Diff_pkca17;
    BOOLEAN Diff_pkca18;
    BOOLEAN Diff_pkca20;
    BOOLEAN Diff_pkca21;
    BOOLEAN Diff_pkca22;
    BOOLEAN Diff_pkca23;
    BOOLEAN Diff_pkca24;
    BOOLEAN Diff_pkca25;
    BOOLEAN Diff_pkca26;
    BOOLEAN Diff_pkca28;
    BOOLEAN Diff_pkca29;
    BOOLEAN Diff_pkca30;
    BOOLEAN Diff_pkca31;
    BOOLEAN Diff_pkca32;
    BOOLEAN Diff_pkca33;
    BOOLEAN Diff_pkca34;
    BOOLEAN Diff_pkca35;
    BOOLEAN Diff_pkca36;
    BOOLEAN Diff_pkca37;
    BOOLEAN Diff_pkca39;
    BOOLEAN Diff_pkca40;
    BOOLEAN Diff_pkca41;
    BOOLEAN Diff_pkca42;
    BOOLEAN Diff_pkca54;
    BOOLEAN Diff_pkca61;
    BOOLEAN Diff_pkca62;
    BOOLEAN Diff_pkca64;
    BOOLEAN Diff_pkpu01;
    BOOLEAN Diff_pkpu02;
    BOOLEAN Diff_pkpu03;
    BOOLEAN Diff_pkpu04;
    BOOLEAN Diff_pkpu05;
    BOOLEAN Diff_pkpu06;
    BOOLEAN Diff_pkpu07;
    BOOLEAN Diff_pkpu08;
    BOOLEAN Diff_pkpu09;
    BOOLEAN Diff_pkpu10;
    BOOLEAN Diff_pkpu11;
    BOOLEAN Diff_pkpu12;
    BOOLEAN Diff_pkpu13;
    BOOLEAN Diff_pkpu14;
    BOOLEAN Diff_pkpu15;
    BOOLEAN Diff_pkpu16;
    BOOLEAN Diff_pkpu17;
    BOOLEAN Diff_pkpu18;
    BOOLEAN Diff_pkpu19;
    BOOLEAN Diff_pkpu20;
    BOOLEAN Diff_pkpu23;
    BOOLEAN Diff_pkpu25;
    BOOLEAN Diff_pkpu27;
    BOOLEAN Diff_pkpu28;
    BOOLEAN Diff_pkpu29;
    BOOLEAN Diff_pkpu30;
    BOOLEAN Diff_pkpu31;
    BOOLEAN Diff_pkpu32;
    BOOLEAN Diff_pkpu33;
    BOOLEAN Diff_pkpu34;
    BOOLEAN Diff_pkpu35;
    BOOLEAN Diff_pkpu38;
    BOOLEAN Diff_pkpu41;
    BOOLEAN Diff_pkpu42;
    BOOLEAN Diff_pkpu45;
    BOOLEAN Diff_pkpu46;
    BOOLEAN Diff_pkpu47;
    BOOLEAN Diff_pkpu48;
    BOOLEAN Diff_pkpu49;
    BOOLEAN Diff_pkpu50;
    BOOLEAN Diff_pkpu51;
    BOOLEAN Diff_pkpu52;
    BOOLEAN Diff_pkpu53;
    BOOLEAN Diff_pkpu54;
    BOOLEAN Diff_pkpu55;
    BOOLEAN Diff_pkpu56;
    BOOLEAN Diff_pkpu57;
    BOOLEAN Diff_pkpu60;
    BOOLEAN Diff_pkpu61;
    BOOLEAN Diff_pkpu62;
    BOOLEAN Diff_pkpu63;
    BOOLEAN Diff_pkpu64;
    BOOLEAN Diff_pkpu65;
    BOOLEAN Diff_pkpu66;
    BOOLEAN Diff_pkpu67;
    BOOLEAN Diff_pkpu68;
    BOOLEAN Diff_pkpu69;
    BOOLEAN Diff_pkpu70;
    BOOLEAN Diff_censpct_water;
    BOOLEAN Diff_cens_pop_density;
    BOOLEAN Diff_cens_hu_density;
    BOOLEAN Diff_censpct_pop_white;
    BOOLEAN Diff_censpct_pop_black;
    BOOLEAN Diff_censpct_pop_amerind;
    BOOLEAN Diff_censpct_pop_asian;
    BOOLEAN Diff_censpct_pop_pacisl;
    BOOLEAN Diff_censpct_pop_othrace;
    BOOLEAN Diff_censpct_pop_multirace;
    BOOLEAN Diff_censpct_pop_hispanic;
    BOOLEAN Diff_censpct_pop_agelt18;
    BOOLEAN Diff_censpct_pop_males;
    BOOLEAN Diff_censpct_adult_age1824;
    BOOLEAN Diff_censpct_adult_age2534;
    BOOLEAN Diff_censpct_adult_age3544;
    BOOLEAN Diff_censpct_adult_age4554;
    BOOLEAN Diff_censpct_adult_age5564;
    BOOLEAN Diff_censpct_adult_agege65;
    BOOLEAN Diff_cens_pop_medage;
    BOOLEAN Diff_cens_hh_avgsize;
    BOOLEAN Diff_censpct_hh_family;
    BOOLEAN Diff_censpct_hh_family_husbwife;
    BOOLEAN Diff_censpct_hu_occupied;
    BOOLEAN Diff_censpct_hu_owned;
    BOOLEAN Diff_censpct_hu_rented;
    BOOLEAN Diff_censpct_hu_vacantseasonal;
    BOOLEAN Diff_zip_medinc;
    BOOLEAN Diff_zip_apparel;
    BOOLEAN Diff_zip_apparel_women;
    BOOLEAN Diff_zip_apparel_womfash;
    BOOLEAN Diff_zip_auto;
    BOOLEAN Diff_zip_beauty;
    BOOLEAN Diff_zip_booksmusicmovies;
    BOOLEAN Diff_zip_business;
    BOOLEAN Diff_zip_catalog;
    BOOLEAN Diff_zip_cc;
    BOOLEAN Diff_zip_collectibles;
    BOOLEAN Diff_zip_computers;
    BOOLEAN Diff_zip_continuity;
    BOOLEAN Diff_zip_cooking;
    BOOLEAN Diff_zip_crafts;
    BOOLEAN Diff_zip_culturearts;
    BOOLEAN Diff_zip_dm_sold;
    BOOLEAN Diff_zip_donor;
    BOOLEAN Diff_zip_family;
    BOOLEAN Diff_zip_gardening;
    BOOLEAN Diff_zip_giftgivr;
    BOOLEAN Diff_zip_gourmet;
    BOOLEAN Diff_zip_health;
    BOOLEAN Diff_zip_health_diet;
    BOOLEAN Diff_zip_health_fitness;
    BOOLEAN Diff_zip_hobbies;
    BOOLEAN Diff_zip_homedecr;
    BOOLEAN Diff_zip_homeliv;
    BOOLEAN Diff_zip_internet;
    BOOLEAN Diff_zip_internet_access;
    BOOLEAN Diff_zip_internet_buy;
    BOOLEAN Diff_zip_music;
    BOOLEAN Diff_zip_outdoors;
    BOOLEAN Diff_zip_pets;
    BOOLEAN Diff_zip_pfin;
    BOOLEAN Diff_zip_publish;
    BOOLEAN Diff_zip_publish_books;
    BOOLEAN Diff_zip_publish_mags;
    BOOLEAN Diff_zip_sports;
    BOOLEAN Diff_zip_sports_biking;
    BOOLEAN Diff_zip_sports_golf;
    BOOLEAN Diff_zip_travel;
    BOOLEAN Diff_zip_travel_us;
    BOOLEAN Diff_zip_tvmovies;
    BOOLEAN Diff_zip_woman;
    BOOLEAN Diff_zip_proftech;
    BOOLEAN Diff_zip_retired;
    BOOLEAN Diff_zip_inc100;
    BOOLEAN Diff_zip_inc75;
    BOOLEAN Diff_zip_inc50;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dtmatch := le.dtmatch <> ri.dtmatch;
    SELF.Diff_msname := le.msname <> ri.msname;
    SELF.Diff_msaddr1 := le.msaddr1 <> ri.msaddr1;
    SELF.Diff_msaddr2 := le.msaddr2 <> ri.msaddr2;
    SELF.Diff_mscity := le.mscity <> ri.mscity;
    SELF.Diff_msstate := le.msstate <> ri.msstate;
    SELF.Diff_mszip5 := le.mszip5 <> ri.mszip5;
    SELF.Diff_mszip4 := le.mszip4 <> ri.mszip4;
    SELF.Diff_dthh := le.dthh <> ri.dthh;
    SELF.Diff_mscrrt := le.mscrrt <> ri.mscrrt;
    SELF.Diff_msdpbc := le.msdpbc <> ri.msdpbc;
    SELF.Diff_msdpv := le.msdpv <> ri.msdpv;
    SELF.Diff_ms_addrtype := le.ms_addrtype <> ri.ms_addrtype;
    SELF.Diff_ctysize := le.ctysize <> ri.ctysize;
    SELF.Diff_lmos := le.lmos <> ri.lmos;
    SELF.Diff_omos := le.omos <> ri.omos;
    SELF.Diff_pmos := le.pmos <> ri.pmos;
    SELF.Diff_gen := le.gen <> ri.gen;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_inc := le.inc <> ri.inc;
    SELF.Diff_marital_status := le.marital_status <> ri.marital_status;
    SELF.Diff_poc := le.poc <> ri.poc;
    SELF.Diff_noc := le.noc <> ri.noc;
    SELF.Diff_ocp := le.ocp <> ri.ocp;
    SELF.Diff_edu := le.edu <> ri.edu;
    SELF.Diff_lang := le.lang <> ri.lang;
    SELF.Diff_relig := le.relig <> ri.relig;
    SELF.Diff_dwell := le.dwell <> ri.dwell;
    SELF.Diff_ownr := le.ownr <> ri.ownr;
    SELF.Diff_eth1 := le.eth1 <> ri.eth1;
    SELF.Diff_eth2 := le.eth2 <> ri.eth2;
    SELF.Diff_lor := le.lor <> ri.lor;
    SELF.Diff_pool := le.pool <> ri.pool;
    SELF.Diff_speak_span := le.speak_span <> ri.speak_span;
    SELF.Diff_soho := le.soho <> ri.soho;
    SELF.Diff_vet_in_hh := le.vet_in_hh <> ri.vet_in_hh;
    SELF.Diff_ms_mags := le.ms_mags <> ri.ms_mags;
    SELF.Diff_ms_books := le.ms_books <> ri.ms_books;
    SELF.Diff_ms_publish := le.ms_publish <> ri.ms_publish;
    SELF.Diff_ms_pub_status_active := le.ms_pub_status_active <> ri.ms_pub_status_active;
    SELF.Diff_ms_pub_status_expire := le.ms_pub_status_expire <> ri.ms_pub_status_expire;
    SELF.Diff_ms_pub_premsold := le.ms_pub_premsold <> ri.ms_pub_premsold;
    SELF.Diff_ms_pub_autornwl := le.ms_pub_autornwl <> ri.ms_pub_autornwl;
    SELF.Diff_ms_pub_avgterm := le.ms_pub_avgterm <> ri.ms_pub_avgterm;
    SELF.Diff_ms_pub_lmos := le.ms_pub_lmos <> ri.ms_pub_lmos;
    SELF.Diff_ms_pub_omos := le.ms_pub_omos <> ri.ms_pub_omos;
    SELF.Diff_ms_pub_pmos := le.ms_pub_pmos <> ri.ms_pub_pmos;
    SELF.Diff_ms_pub_cemos := le.ms_pub_cemos <> ri.ms_pub_cemos;
    SELF.Diff_ms_pub_femos := le.ms_pub_femos <> ri.ms_pub_femos;
    SELF.Diff_ms_pub_totords := le.ms_pub_totords <> ri.ms_pub_totords;
    SELF.Diff_ms_pub_totdlrs := le.ms_pub_totdlrs <> ri.ms_pub_totdlrs;
    SELF.Diff_ms_pub_avgdlrs := le.ms_pub_avgdlrs <> ri.ms_pub_avgdlrs;
    SELF.Diff_ms_pub_lastdlrs := le.ms_pub_lastdlrs <> ri.ms_pub_lastdlrs;
    SELF.Diff_ms_pub_paystat_paid := le.ms_pub_paystat_paid <> ri.ms_pub_paystat_paid;
    SELF.Diff_ms_pub_paystat_ub := le.ms_pub_paystat_ub <> ri.ms_pub_paystat_ub;
    SELF.Diff_ms_pub_paymeth_cc := le.ms_pub_paymeth_cc <> ri.ms_pub_paymeth_cc;
    SELF.Diff_ms_pub_paymeth_cash := le.ms_pub_paymeth_cash <> ri.ms_pub_paymeth_cash;
    SELF.Diff_ms_pub_payspeed := le.ms_pub_payspeed <> ri.ms_pub_payspeed;
    SELF.Diff_ms_pub_osrc_dm := le.ms_pub_osrc_dm <> ri.ms_pub_osrc_dm;
    SELF.Diff_ms_pub_lsrc_dm := le.ms_pub_lsrc_dm <> ri.ms_pub_lsrc_dm;
    SELF.Diff_ms_pub_osrc_agt_cashf := le.ms_pub_osrc_agt_cashf <> ri.ms_pub_osrc_agt_cashf;
    SELF.Diff_ms_pub_lsrc_agt_cashf := le.ms_pub_lsrc_agt_cashf <> ri.ms_pub_lsrc_agt_cashf;
    SELF.Diff_ms_pub_osrc_agt_pds := le.ms_pub_osrc_agt_pds <> ri.ms_pub_osrc_agt_pds;
    SELF.Diff_ms_pub_lsrc_agt_pds := le.ms_pub_lsrc_agt_pds <> ri.ms_pub_lsrc_agt_pds;
    SELF.Diff_ms_pub_osrc_agt_schplan := le.ms_pub_osrc_agt_schplan <> ri.ms_pub_osrc_agt_schplan;
    SELF.Diff_ms_pub_lsrc_agt_schplan := le.ms_pub_lsrc_agt_schplan <> ri.ms_pub_lsrc_agt_schplan;
    SELF.Diff_ms_pub_osrc_agt_sponsor := le.ms_pub_osrc_agt_sponsor <> ri.ms_pub_osrc_agt_sponsor;
    SELF.Diff_ms_pub_lsrc_agt_sponsor := le.ms_pub_lsrc_agt_sponsor <> ri.ms_pub_lsrc_agt_sponsor;
    SELF.Diff_ms_pub_osrc_agt_tm := le.ms_pub_osrc_agt_tm <> ri.ms_pub_osrc_agt_tm;
    SELF.Diff_ms_pub_lsrc_agt_tm := le.ms_pub_lsrc_agt_tm <> ri.ms_pub_lsrc_agt_tm;
    SELF.Diff_ms_pub_osrc_agt := le.ms_pub_osrc_agt <> ri.ms_pub_osrc_agt;
    SELF.Diff_ms_pub_lsrc_agt := le.ms_pub_lsrc_agt <> ri.ms_pub_lsrc_agt;
    SELF.Diff_ms_pub_osrc_tm := le.ms_pub_osrc_tm <> ri.ms_pub_osrc_tm;
    SELF.Diff_ms_pub_lsrc_tm := le.ms_pub_lsrc_tm <> ri.ms_pub_lsrc_tm;
    SELF.Diff_ms_pub_osrc_ins := le.ms_pub_osrc_ins <> ri.ms_pub_osrc_ins;
    SELF.Diff_ms_pub_lsrc_ins := le.ms_pub_lsrc_ins <> ri.ms_pub_lsrc_ins;
    SELF.Diff_ms_pub_osrc_net := le.ms_pub_osrc_net <> ri.ms_pub_osrc_net;
    SELF.Diff_ms_pub_lsrc_net := le.ms_pub_lsrc_net <> ri.ms_pub_lsrc_net;
    SELF.Diff_ms_pub_osrc_print := le.ms_pub_osrc_print <> ri.ms_pub_osrc_print;
    SELF.Diff_ms_pub_lsrc_print := le.ms_pub_lsrc_print <> ri.ms_pub_lsrc_print;
    SELF.Diff_ms_pub_osrc_trans := le.ms_pub_osrc_trans <> ri.ms_pub_osrc_trans;
    SELF.Diff_ms_pub_lsrc_trans := le.ms_pub_lsrc_trans <> ri.ms_pub_lsrc_trans;
    SELF.Diff_ms_pub_osrc_tv := le.ms_pub_osrc_tv <> ri.ms_pub_osrc_tv;
    SELF.Diff_ms_pub_lsrc_tv := le.ms_pub_lsrc_tv <> ri.ms_pub_lsrc_tv;
    SELF.Diff_ms_pub_osrc_dtp := le.ms_pub_osrc_dtp <> ri.ms_pub_osrc_dtp;
    SELF.Diff_ms_pub_lsrc_dtp := le.ms_pub_lsrc_dtp <> ri.ms_pub_lsrc_dtp;
    SELF.Diff_ms_pub_giftgivr := le.ms_pub_giftgivr <> ri.ms_pub_giftgivr;
    SELF.Diff_ms_pub_giftee := le.ms_pub_giftee <> ri.ms_pub_giftee;
    SELF.Diff_ms_catalog := le.ms_catalog <> ri.ms_catalog;
    SELF.Diff_ms_cat_lmos := le.ms_cat_lmos <> ri.ms_cat_lmos;
    SELF.Diff_ms_cat_omos := le.ms_cat_omos <> ri.ms_cat_omos;
    SELF.Diff_ms_cat_pmos := le.ms_cat_pmos <> ri.ms_cat_pmos;
    SELF.Diff_ms_cat_totords := le.ms_cat_totords <> ri.ms_cat_totords;
    SELF.Diff_ms_cat_totitems := le.ms_cat_totitems <> ri.ms_cat_totitems;
    SELF.Diff_ms_cat_totdlrs := le.ms_cat_totdlrs <> ri.ms_cat_totdlrs;
    SELF.Diff_ms_cat_avgdlrs := le.ms_cat_avgdlrs <> ri.ms_cat_avgdlrs;
    SELF.Diff_ms_cat_lastdlrs := le.ms_cat_lastdlrs <> ri.ms_cat_lastdlrs;
    SELF.Diff_ms_cat_paystat_paid := le.ms_cat_paystat_paid <> ri.ms_cat_paystat_paid;
    SELF.Diff_ms_cat_paymeth_cc := le.ms_cat_paymeth_cc <> ri.ms_cat_paymeth_cc;
    SELF.Diff_ms_cat_paymeth_cash := le.ms_cat_paymeth_cash <> ri.ms_cat_paymeth_cash;
    SELF.Diff_ms_cat_osrc_dm := le.ms_cat_osrc_dm <> ri.ms_cat_osrc_dm;
    SELF.Diff_ms_cat_lsrc_dm := le.ms_cat_lsrc_dm <> ri.ms_cat_lsrc_dm;
    SELF.Diff_ms_cat_osrc_net := le.ms_cat_osrc_net <> ri.ms_cat_osrc_net;
    SELF.Diff_ms_cat_lsrc_net := le.ms_cat_lsrc_net <> ri.ms_cat_lsrc_net;
    SELF.Diff_ms_cat_giftgivr := le.ms_cat_giftgivr <> ri.ms_cat_giftgivr;
    SELF.Diff_pkpubs_corrected := le.pkpubs_corrected <> ri.pkpubs_corrected;
    SELF.Diff_pkcatg_corrected := le.pkcatg_corrected <> ri.pkcatg_corrected;
    SELF.Diff_ms_fundraising := le.ms_fundraising <> ri.ms_fundraising;
    SELF.Diff_ms_fund_lmos := le.ms_fund_lmos <> ri.ms_fund_lmos;
    SELF.Diff_ms_fund_omos := le.ms_fund_omos <> ri.ms_fund_omos;
    SELF.Diff_ms_fund_pmos := le.ms_fund_pmos <> ri.ms_fund_pmos;
    SELF.Diff_ms_fund_totords := le.ms_fund_totords <> ri.ms_fund_totords;
    SELF.Diff_ms_fund_totdlrs := le.ms_fund_totdlrs <> ri.ms_fund_totdlrs;
    SELF.Diff_ms_fund_avgdlrs := le.ms_fund_avgdlrs <> ri.ms_fund_avgdlrs;
    SELF.Diff_ms_fund_lastdlrs := le.ms_fund_lastdlrs <> ri.ms_fund_lastdlrs;
    SELF.Diff_ms_fund_paystat_paid := le.ms_fund_paystat_paid <> ri.ms_fund_paystat_paid;
    SELF.Diff_ms_other := le.ms_other <> ri.ms_other;
    SELF.Diff_ms_continuity := le.ms_continuity <> ri.ms_continuity;
    SELF.Diff_ms_cont_status_active := le.ms_cont_status_active <> ri.ms_cont_status_active;
    SELF.Diff_ms_cont_status_cancel := le.ms_cont_status_cancel <> ri.ms_cont_status_cancel;
    SELF.Diff_ms_cont_omos := le.ms_cont_omos <> ri.ms_cont_omos;
    SELF.Diff_ms_cont_lmos := le.ms_cont_lmos <> ri.ms_cont_lmos;
    SELF.Diff_ms_cont_pmos := le.ms_cont_pmos <> ri.ms_cont_pmos;
    SELF.Diff_ms_cont_totords := le.ms_cont_totords <> ri.ms_cont_totords;
    SELF.Diff_ms_cont_totdlrs := le.ms_cont_totdlrs <> ri.ms_cont_totdlrs;
    SELF.Diff_ms_cont_avgdlrs := le.ms_cont_avgdlrs <> ri.ms_cont_avgdlrs;
    SELF.Diff_ms_cont_lastdlrs := le.ms_cont_lastdlrs <> ri.ms_cont_lastdlrs;
    SELF.Diff_ms_cont_paystat_paid := le.ms_cont_paystat_paid <> ri.ms_cont_paystat_paid;
    SELF.Diff_ms_cont_paymeth_cc := le.ms_cont_paymeth_cc <> ri.ms_cont_paymeth_cc;
    SELF.Diff_ms_cont_paymeth_cash := le.ms_cont_paymeth_cash <> ri.ms_cont_paymeth_cash;
    SELF.Diff_ms_totords := le.ms_totords <> ri.ms_totords;
    SELF.Diff_ms_totitems := le.ms_totitems <> ri.ms_totitems;
    SELF.Diff_ms_totdlrs := le.ms_totdlrs <> ri.ms_totdlrs;
    SELF.Diff_ms_avgdlrs := le.ms_avgdlrs <> ri.ms_avgdlrs;
    SELF.Diff_ms_lastdlrs := le.ms_lastdlrs <> ri.ms_lastdlrs;
    SELF.Diff_ms_paystat_paid := le.ms_paystat_paid <> ri.ms_paystat_paid;
    SELF.Diff_ms_paymeth_cc := le.ms_paymeth_cc <> ri.ms_paymeth_cc;
    SELF.Diff_ms_paymeth_cash := le.ms_paymeth_cash <> ri.ms_paymeth_cash;
    SELF.Diff_ms_osrc_dm := le.ms_osrc_dm <> ri.ms_osrc_dm;
    SELF.Diff_ms_lsrc_dm := le.ms_lsrc_dm <> ri.ms_lsrc_dm;
    SELF.Diff_ms_osrc_tm := le.ms_osrc_tm <> ri.ms_osrc_tm;
    SELF.Diff_ms_lsrc_tm := le.ms_lsrc_tm <> ri.ms_lsrc_tm;
    SELF.Diff_ms_osrc_ins := le.ms_osrc_ins <> ri.ms_osrc_ins;
    SELF.Diff_ms_lsrc_ins := le.ms_lsrc_ins <> ri.ms_lsrc_ins;
    SELF.Diff_ms_osrc_net := le.ms_osrc_net <> ri.ms_osrc_net;
    SELF.Diff_ms_lsrc_net := le.ms_lsrc_net <> ri.ms_lsrc_net;
    SELF.Diff_ms_osrc_tv := le.ms_osrc_tv <> ri.ms_osrc_tv;
    SELF.Diff_ms_lsrc_tv := le.ms_lsrc_tv <> ri.ms_lsrc_tv;
    SELF.Diff_ms_osrc_retail := le.ms_osrc_retail <> ri.ms_osrc_retail;
    SELF.Diff_ms_lsrc_retail := le.ms_lsrc_retail <> ri.ms_lsrc_retail;
    SELF.Diff_ms_giftgivr := le.ms_giftgivr <> ri.ms_giftgivr;
    SELF.Diff_ms_giftee := le.ms_giftee <> ri.ms_giftee;
    SELF.Diff_ms_adult := le.ms_adult <> ri.ms_adult;
    SELF.Diff_ms_womapp := le.ms_womapp <> ri.ms_womapp;
    SELF.Diff_ms_menapp := le.ms_menapp <> ri.ms_menapp;
    SELF.Diff_ms_kidapp := le.ms_kidapp <> ri.ms_kidapp;
    SELF.Diff_ms_accessory := le.ms_accessory <> ri.ms_accessory;
    SELF.Diff_ms_apparel := le.ms_apparel <> ri.ms_apparel;
    SELF.Diff_ms_app_lmos := le.ms_app_lmos <> ri.ms_app_lmos;
    SELF.Diff_ms_app_omos := le.ms_app_omos <> ri.ms_app_omos;
    SELF.Diff_ms_app_pmos := le.ms_app_pmos <> ri.ms_app_pmos;
    SELF.Diff_ms_app_totords := le.ms_app_totords <> ri.ms_app_totords;
    SELF.Diff_ms_app_totitems := le.ms_app_totitems <> ri.ms_app_totitems;
    SELF.Diff_ms_app_totdlrs := le.ms_app_totdlrs <> ri.ms_app_totdlrs;
    SELF.Diff_ms_app_avgdlrs := le.ms_app_avgdlrs <> ri.ms_app_avgdlrs;
    SELF.Diff_ms_app_lastdlrs := le.ms_app_lastdlrs <> ri.ms_app_lastdlrs;
    SELF.Diff_ms_app_paystat_paid := le.ms_app_paystat_paid <> ri.ms_app_paystat_paid;
    SELF.Diff_ms_app_paymeth_cc := le.ms_app_paymeth_cc <> ri.ms_app_paymeth_cc;
    SELF.Diff_ms_app_paymeth_cash := le.ms_app_paymeth_cash <> ri.ms_app_paymeth_cash;
    SELF.Diff_ms_menfash := le.ms_menfash <> ri.ms_menfash;
    SELF.Diff_ms_womfash := le.ms_womfash <> ri.ms_womfash;
    SELF.Diff_ms_wfsh_lmos := le.ms_wfsh_lmos <> ri.ms_wfsh_lmos;
    SELF.Diff_ms_wfsh_omos := le.ms_wfsh_omos <> ri.ms_wfsh_omos;
    SELF.Diff_ms_wfsh_pmos := le.ms_wfsh_pmos <> ri.ms_wfsh_pmos;
    SELF.Diff_ms_wfsh_totords := le.ms_wfsh_totords <> ri.ms_wfsh_totords;
    SELF.Diff_ms_wfsh_totdlrs := le.ms_wfsh_totdlrs <> ri.ms_wfsh_totdlrs;
    SELF.Diff_ms_wfsh_avgdlrs := le.ms_wfsh_avgdlrs <> ri.ms_wfsh_avgdlrs;
    SELF.Diff_ms_wfsh_lastdlrs := le.ms_wfsh_lastdlrs <> ri.ms_wfsh_lastdlrs;
    SELF.Diff_ms_wfsh_paystat_paid := le.ms_wfsh_paystat_paid <> ri.ms_wfsh_paystat_paid;
    SELF.Diff_ms_wfsh_osrc_dm := le.ms_wfsh_osrc_dm <> ri.ms_wfsh_osrc_dm;
    SELF.Diff_ms_wfsh_lsrc_dm := le.ms_wfsh_lsrc_dm <> ri.ms_wfsh_lsrc_dm;
    SELF.Diff_ms_wfsh_osrc_agt := le.ms_wfsh_osrc_agt <> ri.ms_wfsh_osrc_agt;
    SELF.Diff_ms_wfsh_lsrc_agt := le.ms_wfsh_lsrc_agt <> ri.ms_wfsh_lsrc_agt;
    SELF.Diff_ms_audio := le.ms_audio <> ri.ms_audio;
    SELF.Diff_ms_auto := le.ms_auto <> ri.ms_auto;
    SELF.Diff_ms_aviation := le.ms_aviation <> ri.ms_aviation;
    SELF.Diff_ms_bargains := le.ms_bargains <> ri.ms_bargains;
    SELF.Diff_ms_beauty := le.ms_beauty <> ri.ms_beauty;
    SELF.Diff_ms_bible := le.ms_bible <> ri.ms_bible;
    SELF.Diff_ms_bible_lmos := le.ms_bible_lmos <> ri.ms_bible_lmos;
    SELF.Diff_ms_bible_omos := le.ms_bible_omos <> ri.ms_bible_omos;
    SELF.Diff_ms_bible_pmos := le.ms_bible_pmos <> ri.ms_bible_pmos;
    SELF.Diff_ms_bible_totords := le.ms_bible_totords <> ri.ms_bible_totords;
    SELF.Diff_ms_bible_totitems := le.ms_bible_totitems <> ri.ms_bible_totitems;
    SELF.Diff_ms_bible_totdlrs := le.ms_bible_totdlrs <> ri.ms_bible_totdlrs;
    SELF.Diff_ms_bible_avgdlrs := le.ms_bible_avgdlrs <> ri.ms_bible_avgdlrs;
    SELF.Diff_ms_bible_lastdlrs := le.ms_bible_lastdlrs <> ri.ms_bible_lastdlrs;
    SELF.Diff_ms_bible_paystat_paid := le.ms_bible_paystat_paid <> ri.ms_bible_paystat_paid;
    SELF.Diff_ms_bible_paymeth_cc := le.ms_bible_paymeth_cc <> ri.ms_bible_paymeth_cc;
    SELF.Diff_ms_bible_paymeth_cash := le.ms_bible_paymeth_cash <> ri.ms_bible_paymeth_cash;
    SELF.Diff_ms_business := le.ms_business <> ri.ms_business;
    SELF.Diff_ms_collectibles := le.ms_collectibles <> ri.ms_collectibles;
    SELF.Diff_ms_computers := le.ms_computers <> ri.ms_computers;
    SELF.Diff_ms_crafts := le.ms_crafts <> ri.ms_crafts;
    SELF.Diff_ms_culturearts := le.ms_culturearts <> ri.ms_culturearts;
    SELF.Diff_ms_currevent := le.ms_currevent <> ri.ms_currevent;
    SELF.Diff_ms_diy := le.ms_diy <> ri.ms_diy;
    SELF.Diff_ms_electronics := le.ms_electronics <> ri.ms_electronics;
    SELF.Diff_ms_equestrian := le.ms_equestrian <> ri.ms_equestrian;
    SELF.Diff_ms_pub_family := le.ms_pub_family <> ri.ms_pub_family;
    SELF.Diff_ms_cat_family := le.ms_cat_family <> ri.ms_cat_family;
    SELF.Diff_ms_family := le.ms_family <> ri.ms_family;
    SELF.Diff_ms_family_lmos := le.ms_family_lmos <> ri.ms_family_lmos;
    SELF.Diff_ms_family_omos := le.ms_family_omos <> ri.ms_family_omos;
    SELF.Diff_ms_family_pmos := le.ms_family_pmos <> ri.ms_family_pmos;
    SELF.Diff_ms_family_totords := le.ms_family_totords <> ri.ms_family_totords;
    SELF.Diff_ms_family_totitems := le.ms_family_totitems <> ri.ms_family_totitems;
    SELF.Diff_ms_family_totdlrs := le.ms_family_totdlrs <> ri.ms_family_totdlrs;
    SELF.Diff_ms_family_avgdlrs := le.ms_family_avgdlrs <> ri.ms_family_avgdlrs;
    SELF.Diff_ms_family_lastdlrs := le.ms_family_lastdlrs <> ri.ms_family_lastdlrs;
    SELF.Diff_ms_family_paystat_paid := le.ms_family_paystat_paid <> ri.ms_family_paystat_paid;
    SELF.Diff_ms_family_paymeth_cc := le.ms_family_paymeth_cc <> ri.ms_family_paymeth_cc;
    SELF.Diff_ms_family_paymeth_cash := le.ms_family_paymeth_cash <> ri.ms_family_paymeth_cash;
    SELF.Diff_ms_family_osrc_dm := le.ms_family_osrc_dm <> ri.ms_family_osrc_dm;
    SELF.Diff_ms_family_lsrc_dm := le.ms_family_lsrc_dm <> ri.ms_family_lsrc_dm;
    SELF.Diff_ms_fiction := le.ms_fiction <> ri.ms_fiction;
    SELF.Diff_ms_food := le.ms_food <> ri.ms_food;
    SELF.Diff_ms_games := le.ms_games <> ri.ms_games;
    SELF.Diff_ms_gifts := le.ms_gifts <> ri.ms_gifts;
    SELF.Diff_ms_gourmet := le.ms_gourmet <> ri.ms_gourmet;
    SELF.Diff_ms_fitness := le.ms_fitness <> ri.ms_fitness;
    SELF.Diff_ms_health := le.ms_health <> ri.ms_health;
    SELF.Diff_ms_hlth_lmos := le.ms_hlth_lmos <> ri.ms_hlth_lmos;
    SELF.Diff_ms_hlth_omos := le.ms_hlth_omos <> ri.ms_hlth_omos;
    SELF.Diff_ms_hlth_pmos := le.ms_hlth_pmos <> ri.ms_hlth_pmos;
    SELF.Diff_ms_hlth_totords := le.ms_hlth_totords <> ri.ms_hlth_totords;
    SELF.Diff_ms_hlth_totdlrs := le.ms_hlth_totdlrs <> ri.ms_hlth_totdlrs;
    SELF.Diff_ms_hlth_avgdlrs := le.ms_hlth_avgdlrs <> ri.ms_hlth_avgdlrs;
    SELF.Diff_ms_hlth_lastdlrs := le.ms_hlth_lastdlrs <> ri.ms_hlth_lastdlrs;
    SELF.Diff_ms_hlth_paystat_paid := le.ms_hlth_paystat_paid <> ri.ms_hlth_paystat_paid;
    SELF.Diff_ms_hlth_paymeth_cc := le.ms_hlth_paymeth_cc <> ri.ms_hlth_paymeth_cc;
    SELF.Diff_ms_hlth_osrc_dm := le.ms_hlth_osrc_dm <> ri.ms_hlth_osrc_dm;
    SELF.Diff_ms_hlth_lsrc_dm := le.ms_hlth_lsrc_dm <> ri.ms_hlth_lsrc_dm;
    SELF.Diff_ms_hlth_osrc_agt := le.ms_hlth_osrc_agt <> ri.ms_hlth_osrc_agt;
    SELF.Diff_ms_hlth_lsrc_agt := le.ms_hlth_lsrc_agt <> ri.ms_hlth_lsrc_agt;
    SELF.Diff_ms_hlth_osrc_tv := le.ms_hlth_osrc_tv <> ri.ms_hlth_osrc_tv;
    SELF.Diff_ms_hlth_lsrc_tv := le.ms_hlth_lsrc_tv <> ri.ms_hlth_lsrc_tv;
    SELF.Diff_ms_holiday := le.ms_holiday <> ri.ms_holiday;
    SELF.Diff_ms_history := le.ms_history <> ri.ms_history;
    SELF.Diff_ms_pub_cooking := le.ms_pub_cooking <> ri.ms_pub_cooking;
    SELF.Diff_ms_cooking := le.ms_cooking <> ri.ms_cooking;
    SELF.Diff_ms_pub_homedecr := le.ms_pub_homedecr <> ri.ms_pub_homedecr;
    SELF.Diff_ms_cat_homedecr := le.ms_cat_homedecr <> ri.ms_cat_homedecr;
    SELF.Diff_ms_homedecr := le.ms_homedecr <> ri.ms_homedecr;
    SELF.Diff_ms_housewares := le.ms_housewares <> ri.ms_housewares;
    SELF.Diff_ms_pub_garden := le.ms_pub_garden <> ri.ms_pub_garden;
    SELF.Diff_ms_cat_garden := le.ms_cat_garden <> ri.ms_cat_garden;
    SELF.Diff_ms_garden := le.ms_garden <> ri.ms_garden;
    SELF.Diff_ms_pub_homeliv := le.ms_pub_homeliv <> ri.ms_pub_homeliv;
    SELF.Diff_ms_cat_homeliv := le.ms_cat_homeliv <> ri.ms_cat_homeliv;
    SELF.Diff_ms_homeliv := le.ms_homeliv <> ri.ms_homeliv;
    SELF.Diff_ms_pub_home_status_active := le.ms_pub_home_status_active <> ri.ms_pub_home_status_active;
    SELF.Diff_ms_home_lmos := le.ms_home_lmos <> ri.ms_home_lmos;
    SELF.Diff_ms_home_omos := le.ms_home_omos <> ri.ms_home_omos;
    SELF.Diff_ms_home_pmos := le.ms_home_pmos <> ri.ms_home_pmos;
    SELF.Diff_ms_home_totords := le.ms_home_totords <> ri.ms_home_totords;
    SELF.Diff_ms_home_totitems := le.ms_home_totitems <> ri.ms_home_totitems;
    SELF.Diff_ms_home_totdlrs := le.ms_home_totdlrs <> ri.ms_home_totdlrs;
    SELF.Diff_ms_home_avgdlrs := le.ms_home_avgdlrs <> ri.ms_home_avgdlrs;
    SELF.Diff_ms_home_lastdlrs := le.ms_home_lastdlrs <> ri.ms_home_lastdlrs;
    SELF.Diff_ms_home_paystat_paid := le.ms_home_paystat_paid <> ri.ms_home_paystat_paid;
    SELF.Diff_ms_home_paymeth_cc := le.ms_home_paymeth_cc <> ri.ms_home_paymeth_cc;
    SELF.Diff_ms_home_paymeth_cash := le.ms_home_paymeth_cash <> ri.ms_home_paymeth_cash;
    SELF.Diff_ms_home_osrc_dm := le.ms_home_osrc_dm <> ri.ms_home_osrc_dm;
    SELF.Diff_ms_home_lsrc_dm := le.ms_home_lsrc_dm <> ri.ms_home_lsrc_dm;
    SELF.Diff_ms_home_osrc_agt := le.ms_home_osrc_agt <> ri.ms_home_osrc_agt;
    SELF.Diff_ms_home_lsrc_agt := le.ms_home_lsrc_agt <> ri.ms_home_lsrc_agt;
    SELF.Diff_ms_home_osrc_net := le.ms_home_osrc_net <> ri.ms_home_osrc_net;
    SELF.Diff_ms_home_lsrc_net := le.ms_home_lsrc_net <> ri.ms_home_lsrc_net;
    SELF.Diff_ms_home_osrc_tv := le.ms_home_osrc_tv <> ri.ms_home_osrc_tv;
    SELF.Diff_ms_home_lsrc_tv := le.ms_home_lsrc_tv <> ri.ms_home_lsrc_tv;
    SELF.Diff_ms_humor := le.ms_humor <> ri.ms_humor;
    SELF.Diff_ms_inspiration := le.ms_inspiration <> ri.ms_inspiration;
    SELF.Diff_ms_merchandise := le.ms_merchandise <> ri.ms_merchandise;
    SELF.Diff_ms_moneymaking := le.ms_moneymaking <> ri.ms_moneymaking;
    SELF.Diff_ms_moneymaking_lmos := le.ms_moneymaking_lmos <> ri.ms_moneymaking_lmos;
    SELF.Diff_ms_motorcycles := le.ms_motorcycles <> ri.ms_motorcycles;
    SELF.Diff_ms_music := le.ms_music <> ri.ms_music;
    SELF.Diff_ms_fishing := le.ms_fishing <> ri.ms_fishing;
    SELF.Diff_ms_hunting := le.ms_hunting <> ri.ms_hunting;
    SELF.Diff_ms_boatsail := le.ms_boatsail <> ri.ms_boatsail;
    SELF.Diff_ms_camp := le.ms_camp <> ri.ms_camp;
    SELF.Diff_ms_pub_outdoors := le.ms_pub_outdoors <> ri.ms_pub_outdoors;
    SELF.Diff_ms_cat_outdoors := le.ms_cat_outdoors <> ri.ms_cat_outdoors;
    SELF.Diff_ms_outdoors := le.ms_outdoors <> ri.ms_outdoors;
    SELF.Diff_ms_pub_out_status_active := le.ms_pub_out_status_active <> ri.ms_pub_out_status_active;
    SELF.Diff_ms_out_lmos := le.ms_out_lmos <> ri.ms_out_lmos;
    SELF.Diff_ms_out_omos := le.ms_out_omos <> ri.ms_out_omos;
    SELF.Diff_ms_out_pmos := le.ms_out_pmos <> ri.ms_out_pmos;
    SELF.Diff_ms_out_totords := le.ms_out_totords <> ri.ms_out_totords;
    SELF.Diff_ms_out_totitems := le.ms_out_totitems <> ri.ms_out_totitems;
    SELF.Diff_ms_out_totdlrs := le.ms_out_totdlrs <> ri.ms_out_totdlrs;
    SELF.Diff_ms_out_avgdlrs := le.ms_out_avgdlrs <> ri.ms_out_avgdlrs;
    SELF.Diff_ms_out_lastdlrs := le.ms_out_lastdlrs <> ri.ms_out_lastdlrs;
    SELF.Diff_ms_out_paystat_paid := le.ms_out_paystat_paid <> ri.ms_out_paystat_paid;
    SELF.Diff_ms_out_paymeth_cc := le.ms_out_paymeth_cc <> ri.ms_out_paymeth_cc;
    SELF.Diff_ms_out_paymeth_cash := le.ms_out_paymeth_cash <> ri.ms_out_paymeth_cash;
    SELF.Diff_ms_out_osrc_dm := le.ms_out_osrc_dm <> ri.ms_out_osrc_dm;
    SELF.Diff_ms_out_lsrc_dm := le.ms_out_lsrc_dm <> ri.ms_out_lsrc_dm;
    SELF.Diff_ms_out_osrc_agt := le.ms_out_osrc_agt <> ri.ms_out_osrc_agt;
    SELF.Diff_ms_out_lsrc_agt := le.ms_out_lsrc_agt <> ri.ms_out_lsrc_agt;
    SELF.Diff_ms_pets := le.ms_pets <> ri.ms_pets;
    SELF.Diff_ms_pfin := le.ms_pfin <> ri.ms_pfin;
    SELF.Diff_ms_photo := le.ms_photo <> ri.ms_photo;
    SELF.Diff_ms_photoproc := le.ms_photoproc <> ri.ms_photoproc;
    SELF.Diff_ms_rural := le.ms_rural <> ri.ms_rural;
    SELF.Diff_ms_science := le.ms_science <> ri.ms_science;
    SELF.Diff_ms_sports := le.ms_sports <> ri.ms_sports;
    SELF.Diff_ms_sports_lmos := le.ms_sports_lmos <> ri.ms_sports_lmos;
    SELF.Diff_ms_travel := le.ms_travel <> ri.ms_travel;
    SELF.Diff_ms_tvmovies := le.ms_tvmovies <> ri.ms_tvmovies;
    SELF.Diff_ms_wildlife := le.ms_wildlife <> ri.ms_wildlife;
    SELF.Diff_ms_woman := le.ms_woman <> ri.ms_woman;
    SELF.Diff_ms_woman_lmos := le.ms_woman_lmos <> ri.ms_woman_lmos;
    SELF.Diff_ms_ringtones_apps := le.ms_ringtones_apps <> ri.ms_ringtones_apps;
    SELF.Diff_cpi_mobile_apps_index := le.cpi_mobile_apps_index <> ri.cpi_mobile_apps_index;
    SELF.Diff_cpi_credit_repair_index := le.cpi_credit_repair_index <> ri.cpi_credit_repair_index;
    SELF.Diff_cpi_credit_report_index := le.cpi_credit_report_index <> ri.cpi_credit_report_index;
    SELF.Diff_cpi_education_seekers_index := le.cpi_education_seekers_index <> ri.cpi_education_seekers_index;
    SELF.Diff_cpi_insurance_index := le.cpi_insurance_index <> ri.cpi_insurance_index;
    SELF.Diff_cpi_insurance_health_index := le.cpi_insurance_health_index <> ri.cpi_insurance_health_index;
    SELF.Diff_cpi_insurance_auto_index := le.cpi_insurance_auto_index <> ri.cpi_insurance_auto_index;
    SELF.Diff_cpi_job_seekers_index := le.cpi_job_seekers_index <> ri.cpi_job_seekers_index;
    SELF.Diff_cpi_social_networking_index := le.cpi_social_networking_index <> ri.cpi_social_networking_index;
    SELF.Diff_cpi_adult_index := le.cpi_adult_index <> ri.cpi_adult_index;
    SELF.Diff_cpi_africanamerican_index := le.cpi_africanamerican_index <> ri.cpi_africanamerican_index;
    SELF.Diff_cpi_apparel_index := le.cpi_apparel_index <> ri.cpi_apparel_index;
    SELF.Diff_cpi_apparel_accessory_index := le.cpi_apparel_accessory_index <> ri.cpi_apparel_accessory_index;
    SELF.Diff_cpi_apparel_kids_index := le.cpi_apparel_kids_index <> ri.cpi_apparel_kids_index;
    SELF.Diff_cpi_apparel_men_index := le.cpi_apparel_men_index <> ri.cpi_apparel_men_index;
    SELF.Diff_cpi_apparel_menfash_index := le.cpi_apparel_menfash_index <> ri.cpi_apparel_menfash_index;
    SELF.Diff_cpi_apparel_women_index := le.cpi_apparel_women_index <> ri.cpi_apparel_women_index;
    SELF.Diff_cpi_apparel_womfash_index := le.cpi_apparel_womfash_index <> ri.cpi_apparel_womfash_index;
    SELF.Diff_cpi_asian_index := le.cpi_asian_index <> ri.cpi_asian_index;
    SELF.Diff_cpi_auto_index := le.cpi_auto_index <> ri.cpi_auto_index;
    SELF.Diff_cpi_auto_racing_index := le.cpi_auto_racing_index <> ri.cpi_auto_racing_index;
    SELF.Diff_cpi_auto_trucks_index := le.cpi_auto_trucks_index <> ri.cpi_auto_trucks_index;
    SELF.Diff_cpi_aviation_index := le.cpi_aviation_index <> ri.cpi_aviation_index;
    SELF.Diff_cpi_bargains_index := le.cpi_bargains_index <> ri.cpi_bargains_index;
    SELF.Diff_cpi_beauty_index := le.cpi_beauty_index <> ri.cpi_beauty_index;
    SELF.Diff_cpi_bible_index := le.cpi_bible_index <> ri.cpi_bible_index;
    SELF.Diff_cpi_birds_index := le.cpi_birds_index <> ri.cpi_birds_index;
    SELF.Diff_cpi_business_index := le.cpi_business_index <> ri.cpi_business_index;
    SELF.Diff_cpi_business_homeoffice_index := le.cpi_business_homeoffice_index <> ri.cpi_business_homeoffice_index;
    SELF.Diff_cpi_catalog_index := le.cpi_catalog_index <> ri.cpi_catalog_index;
    SELF.Diff_cpi_cc_index := le.cpi_cc_index <> ri.cpi_cc_index;
    SELF.Diff_cpi_collectibles_index := le.cpi_collectibles_index <> ri.cpi_collectibles_index;
    SELF.Diff_cpi_college_index := le.cpi_college_index <> ri.cpi_college_index;
    SELF.Diff_cpi_computers_index := le.cpi_computers_index <> ri.cpi_computers_index;
    SELF.Diff_cpi_conservative_index := le.cpi_conservative_index <> ri.cpi_conservative_index;
    SELF.Diff_cpi_continuity_index := le.cpi_continuity_index <> ri.cpi_continuity_index;
    SELF.Diff_cpi_cooking_index := le.cpi_cooking_index <> ri.cpi_cooking_index;
    SELF.Diff_cpi_crafts_index := le.cpi_crafts_index <> ri.cpi_crafts_index;
    SELF.Diff_cpi_crafts_crochet_index := le.cpi_crafts_crochet_index <> ri.cpi_crafts_crochet_index;
    SELF.Diff_cpi_crafts_knit_index := le.cpi_crafts_knit_index <> ri.cpi_crafts_knit_index;
    SELF.Diff_cpi_crafts_needlepoint_index := le.cpi_crafts_needlepoint_index <> ri.cpi_crafts_needlepoint_index;
    SELF.Diff_cpi_crafts_quilt_index := le.cpi_crafts_quilt_index <> ri.cpi_crafts_quilt_index;
    SELF.Diff_cpi_crafts_sew_index := le.cpi_crafts_sew_index <> ri.cpi_crafts_sew_index;
    SELF.Diff_cpi_culturearts_index := le.cpi_culturearts_index <> ri.cpi_culturearts_index;
    SELF.Diff_cpi_currevent_index := le.cpi_currevent_index <> ri.cpi_currevent_index;
    SELF.Diff_cpi_diy_index := le.cpi_diy_index <> ri.cpi_diy_index;
    SELF.Diff_cpi_donor_index := le.cpi_donor_index <> ri.cpi_donor_index;
    SELF.Diff_cpi_ego_index := le.cpi_ego_index <> ri.cpi_ego_index;
    SELF.Diff_cpi_electronics_index := le.cpi_electronics_index <> ri.cpi_electronics_index;
    SELF.Diff_cpi_equestrian_index := le.cpi_equestrian_index <> ri.cpi_equestrian_index;
    SELF.Diff_cpi_family_index := le.cpi_family_index <> ri.cpi_family_index;
    SELF.Diff_cpi_family_teen_index := le.cpi_family_teen_index <> ri.cpi_family_teen_index;
    SELF.Diff_cpi_family_young_index := le.cpi_family_young_index <> ri.cpi_family_young_index;
    SELF.Diff_cpi_fiction_index := le.cpi_fiction_index <> ri.cpi_fiction_index;
    SELF.Diff_cpi_gambling_index := le.cpi_gambling_index <> ri.cpi_gambling_index;
    SELF.Diff_cpi_games_index := le.cpi_games_index <> ri.cpi_games_index;
    SELF.Diff_cpi_gardening_index := le.cpi_gardening_index <> ri.cpi_gardening_index;
    SELF.Diff_cpi_gay_index := le.cpi_gay_index <> ri.cpi_gay_index;
    SELF.Diff_cpi_giftgivr_index := le.cpi_giftgivr_index <> ri.cpi_giftgivr_index;
    SELF.Diff_cpi_gourmet_index := le.cpi_gourmet_index <> ri.cpi_gourmet_index;
    SELF.Diff_cpi_grandparents_index := le.cpi_grandparents_index <> ri.cpi_grandparents_index;
    SELF.Diff_cpi_health_index := le.cpi_health_index <> ri.cpi_health_index;
    SELF.Diff_cpi_health_diet_index := le.cpi_health_diet_index <> ri.cpi_health_diet_index;
    SELF.Diff_cpi_health_fitness_index := le.cpi_health_fitness_index <> ri.cpi_health_fitness_index;
    SELF.Diff_cpi_hightech_index := le.cpi_hightech_index <> ri.cpi_hightech_index;
    SELF.Diff_cpi_hispanic_index := le.cpi_hispanic_index <> ri.cpi_hispanic_index;
    SELF.Diff_cpi_history_index := le.cpi_history_index <> ri.cpi_history_index;
    SELF.Diff_cpi_history_american_index := le.cpi_history_american_index <> ri.cpi_history_american_index;
    SELF.Diff_cpi_hobbies_index := le.cpi_hobbies_index <> ri.cpi_hobbies_index;
    SELF.Diff_cpi_homedecr_index := le.cpi_homedecr_index <> ri.cpi_homedecr_index;
    SELF.Diff_cpi_homeliv_index := le.cpi_homeliv_index <> ri.cpi_homeliv_index;
    SELF.Diff_cpi_humor_index := le.cpi_humor_index <> ri.cpi_humor_index;
    SELF.Diff_cpi_inspiration_index := le.cpi_inspiration_index <> ri.cpi_inspiration_index;
    SELF.Diff_cpi_internet_index := le.cpi_internet_index <> ri.cpi_internet_index;
    SELF.Diff_cpi_internet_access_index := le.cpi_internet_access_index <> ri.cpi_internet_access_index;
    SELF.Diff_cpi_internet_buy_index := le.cpi_internet_buy_index <> ri.cpi_internet_buy_index;
    SELF.Diff_cpi_liberal_index := le.cpi_liberal_index <> ri.cpi_liberal_index;
    SELF.Diff_cpi_moneymaking_index := le.cpi_moneymaking_index <> ri.cpi_moneymaking_index;
    SELF.Diff_cpi_motorcycles_index := le.cpi_motorcycles_index <> ri.cpi_motorcycles_index;
    SELF.Diff_cpi_music_index := le.cpi_music_index <> ri.cpi_music_index;
    SELF.Diff_cpi_nonfiction_index := le.cpi_nonfiction_index <> ri.cpi_nonfiction_index;
    SELF.Diff_cpi_ocean_index := le.cpi_ocean_index <> ri.cpi_ocean_index;
    SELF.Diff_cpi_outdoors_index := le.cpi_outdoors_index <> ri.cpi_outdoors_index;
    SELF.Diff_cpi_outdoors_boatsail_index := le.cpi_outdoors_boatsail_index <> ri.cpi_outdoors_boatsail_index;
    SELF.Diff_cpi_outdoors_camp_index := le.cpi_outdoors_camp_index <> ri.cpi_outdoors_camp_index;
    SELF.Diff_cpi_outdoors_fishing_index := le.cpi_outdoors_fishing_index <> ri.cpi_outdoors_fishing_index;
    SELF.Diff_cpi_outdoors_huntfish_index := le.cpi_outdoors_huntfish_index <> ri.cpi_outdoors_huntfish_index;
    SELF.Diff_cpi_outdoors_hunting_index := le.cpi_outdoors_hunting_index <> ri.cpi_outdoors_hunting_index;
    SELF.Diff_cpi_pets_index := le.cpi_pets_index <> ri.cpi_pets_index;
    SELF.Diff_cpi_pets_cats_index := le.cpi_pets_cats_index <> ri.cpi_pets_cats_index;
    SELF.Diff_cpi_pets_dogs_index := le.cpi_pets_dogs_index <> ri.cpi_pets_dogs_index;
    SELF.Diff_cpi_pfin_index := le.cpi_pfin_index <> ri.cpi_pfin_index;
    SELF.Diff_cpi_photog_index := le.cpi_photog_index <> ri.cpi_photog_index;
    SELF.Diff_cpi_photoproc_index := le.cpi_photoproc_index <> ri.cpi_photoproc_index;
    SELF.Diff_cpi_publish_index := le.cpi_publish_index <> ri.cpi_publish_index;
    SELF.Diff_cpi_publish_books_index := le.cpi_publish_books_index <> ri.cpi_publish_books_index;
    SELF.Diff_cpi_publish_mags_index := le.cpi_publish_mags_index <> ri.cpi_publish_mags_index;
    SELF.Diff_cpi_rural_index := le.cpi_rural_index <> ri.cpi_rural_index;
    SELF.Diff_cpi_science_index := le.cpi_science_index <> ri.cpi_science_index;
    SELF.Diff_cpi_scifi_index := le.cpi_scifi_index <> ri.cpi_scifi_index;
    SELF.Diff_cpi_seniors_index := le.cpi_seniors_index <> ri.cpi_seniors_index;
    SELF.Diff_cpi_sports_index := le.cpi_sports_index <> ri.cpi_sports_index;
    SELF.Diff_cpi_sports_baseball_index := le.cpi_sports_baseball_index <> ri.cpi_sports_baseball_index;
    SELF.Diff_cpi_sports_basketball_index := le.cpi_sports_basketball_index <> ri.cpi_sports_basketball_index;
    SELF.Diff_cpi_sports_biking_index := le.cpi_sports_biking_index <> ri.cpi_sports_biking_index;
    SELF.Diff_cpi_sports_football_index := le.cpi_sports_football_index <> ri.cpi_sports_football_index;
    SELF.Diff_cpi_sports_golf_index := le.cpi_sports_golf_index <> ri.cpi_sports_golf_index;
    SELF.Diff_cpi_sports_hockey_index := le.cpi_sports_hockey_index <> ri.cpi_sports_hockey_index;
    SELF.Diff_cpi_sports_running_index := le.cpi_sports_running_index <> ri.cpi_sports_running_index;
    SELF.Diff_cpi_sports_ski_index := le.cpi_sports_ski_index <> ri.cpi_sports_ski_index;
    SELF.Diff_cpi_sports_soccer_index := le.cpi_sports_soccer_index <> ri.cpi_sports_soccer_index;
    SELF.Diff_cpi_sports_swimming_index := le.cpi_sports_swimming_index <> ri.cpi_sports_swimming_index;
    SELF.Diff_cpi_sports_tennis_index := le.cpi_sports_tennis_index <> ri.cpi_sports_tennis_index;
    SELF.Diff_cpi_stationery_index := le.cpi_stationery_index <> ri.cpi_stationery_index;
    SELF.Diff_cpi_sweeps_index := le.cpi_sweeps_index <> ri.cpi_sweeps_index;
    SELF.Diff_cpi_tobacco_index := le.cpi_tobacco_index <> ri.cpi_tobacco_index;
    SELF.Diff_cpi_travel_index := le.cpi_travel_index <> ri.cpi_travel_index;
    SELF.Diff_cpi_travel_cruise_index := le.cpi_travel_cruise_index <> ri.cpi_travel_cruise_index;
    SELF.Diff_cpi_travel_rv_index := le.cpi_travel_rv_index <> ri.cpi_travel_rv_index;
    SELF.Diff_cpi_travel_us_index := le.cpi_travel_us_index <> ri.cpi_travel_us_index;
    SELF.Diff_cpi_tvmovies_index := le.cpi_tvmovies_index <> ri.cpi_tvmovies_index;
    SELF.Diff_cpi_wildlife_index := le.cpi_wildlife_index <> ri.cpi_wildlife_index;
    SELF.Diff_cpi_woman_index := le.cpi_woman_index <> ri.cpi_woman_index;
    SELF.Diff_totdlr_index := le.totdlr_index <> ri.totdlr_index;
    SELF.Diff_cpi_totdlr := le.cpi_totdlr <> ri.cpi_totdlr;
    SELF.Diff_cpi_totords := le.cpi_totords <> ri.cpi_totords;
    SELF.Diff_cpi_lastdlr := le.cpi_lastdlr <> ri.cpi_lastdlr;
    SELF.Diff_pkcatg := le.pkcatg <> ri.pkcatg;
    SELF.Diff_pkpubs := le.pkpubs <> ri.pkpubs;
    SELF.Diff_pkcont := le.pkcont <> ri.pkcont;
    SELF.Diff_pkca01 := le.pkca01 <> ri.pkca01;
    SELF.Diff_pkca03 := le.pkca03 <> ri.pkca03;
    SELF.Diff_pkca04 := le.pkca04 <> ri.pkca04;
    SELF.Diff_pkca05 := le.pkca05 <> ri.pkca05;
    SELF.Diff_pkca06 := le.pkca06 <> ri.pkca06;
    SELF.Diff_pkca07 := le.pkca07 <> ri.pkca07;
    SELF.Diff_pkca08 := le.pkca08 <> ri.pkca08;
    SELF.Diff_pkca09 := le.pkca09 <> ri.pkca09;
    SELF.Diff_pkca10 := le.pkca10 <> ri.pkca10;
    SELF.Diff_pkca11 := le.pkca11 <> ri.pkca11;
    SELF.Diff_pkca12 := le.pkca12 <> ri.pkca12;
    SELF.Diff_pkca13 := le.pkca13 <> ri.pkca13;
    SELF.Diff_pkca14 := le.pkca14 <> ri.pkca14;
    SELF.Diff_pkca15 := le.pkca15 <> ri.pkca15;
    SELF.Diff_pkca16 := le.pkca16 <> ri.pkca16;
    SELF.Diff_pkca17 := le.pkca17 <> ri.pkca17;
    SELF.Diff_pkca18 := le.pkca18 <> ri.pkca18;
    SELF.Diff_pkca20 := le.pkca20 <> ri.pkca20;
    SELF.Diff_pkca21 := le.pkca21 <> ri.pkca21;
    SELF.Diff_pkca22 := le.pkca22 <> ri.pkca22;
    SELF.Diff_pkca23 := le.pkca23 <> ri.pkca23;
    SELF.Diff_pkca24 := le.pkca24 <> ri.pkca24;
    SELF.Diff_pkca25 := le.pkca25 <> ri.pkca25;
    SELF.Diff_pkca26 := le.pkca26 <> ri.pkca26;
    SELF.Diff_pkca28 := le.pkca28 <> ri.pkca28;
    SELF.Diff_pkca29 := le.pkca29 <> ri.pkca29;
    SELF.Diff_pkca30 := le.pkca30 <> ri.pkca30;
    SELF.Diff_pkca31 := le.pkca31 <> ri.pkca31;
    SELF.Diff_pkca32 := le.pkca32 <> ri.pkca32;
    SELF.Diff_pkca33 := le.pkca33 <> ri.pkca33;
    SELF.Diff_pkca34 := le.pkca34 <> ri.pkca34;
    SELF.Diff_pkca35 := le.pkca35 <> ri.pkca35;
    SELF.Diff_pkca36 := le.pkca36 <> ri.pkca36;
    SELF.Diff_pkca37 := le.pkca37 <> ri.pkca37;
    SELF.Diff_pkca39 := le.pkca39 <> ri.pkca39;
    SELF.Diff_pkca40 := le.pkca40 <> ri.pkca40;
    SELF.Diff_pkca41 := le.pkca41 <> ri.pkca41;
    SELF.Diff_pkca42 := le.pkca42 <> ri.pkca42;
    SELF.Diff_pkca54 := le.pkca54 <> ri.pkca54;
    SELF.Diff_pkca61 := le.pkca61 <> ri.pkca61;
    SELF.Diff_pkca62 := le.pkca62 <> ri.pkca62;
    SELF.Diff_pkca64 := le.pkca64 <> ri.pkca64;
    SELF.Diff_pkpu01 := le.pkpu01 <> ri.pkpu01;
    SELF.Diff_pkpu02 := le.pkpu02 <> ri.pkpu02;
    SELF.Diff_pkpu03 := le.pkpu03 <> ri.pkpu03;
    SELF.Diff_pkpu04 := le.pkpu04 <> ri.pkpu04;
    SELF.Diff_pkpu05 := le.pkpu05 <> ri.pkpu05;
    SELF.Diff_pkpu06 := le.pkpu06 <> ri.pkpu06;
    SELF.Diff_pkpu07 := le.pkpu07 <> ri.pkpu07;
    SELF.Diff_pkpu08 := le.pkpu08 <> ri.pkpu08;
    SELF.Diff_pkpu09 := le.pkpu09 <> ri.pkpu09;
    SELF.Diff_pkpu10 := le.pkpu10 <> ri.pkpu10;
    SELF.Diff_pkpu11 := le.pkpu11 <> ri.pkpu11;
    SELF.Diff_pkpu12 := le.pkpu12 <> ri.pkpu12;
    SELF.Diff_pkpu13 := le.pkpu13 <> ri.pkpu13;
    SELF.Diff_pkpu14 := le.pkpu14 <> ri.pkpu14;
    SELF.Diff_pkpu15 := le.pkpu15 <> ri.pkpu15;
    SELF.Diff_pkpu16 := le.pkpu16 <> ri.pkpu16;
    SELF.Diff_pkpu17 := le.pkpu17 <> ri.pkpu17;
    SELF.Diff_pkpu18 := le.pkpu18 <> ri.pkpu18;
    SELF.Diff_pkpu19 := le.pkpu19 <> ri.pkpu19;
    SELF.Diff_pkpu20 := le.pkpu20 <> ri.pkpu20;
    SELF.Diff_pkpu23 := le.pkpu23 <> ri.pkpu23;
    SELF.Diff_pkpu25 := le.pkpu25 <> ri.pkpu25;
    SELF.Diff_pkpu27 := le.pkpu27 <> ri.pkpu27;
    SELF.Diff_pkpu28 := le.pkpu28 <> ri.pkpu28;
    SELF.Diff_pkpu29 := le.pkpu29 <> ri.pkpu29;
    SELF.Diff_pkpu30 := le.pkpu30 <> ri.pkpu30;
    SELF.Diff_pkpu31 := le.pkpu31 <> ri.pkpu31;
    SELF.Diff_pkpu32 := le.pkpu32 <> ri.pkpu32;
    SELF.Diff_pkpu33 := le.pkpu33 <> ri.pkpu33;
    SELF.Diff_pkpu34 := le.pkpu34 <> ri.pkpu34;
    SELF.Diff_pkpu35 := le.pkpu35 <> ri.pkpu35;
    SELF.Diff_pkpu38 := le.pkpu38 <> ri.pkpu38;
    SELF.Diff_pkpu41 := le.pkpu41 <> ri.pkpu41;
    SELF.Diff_pkpu42 := le.pkpu42 <> ri.pkpu42;
    SELF.Diff_pkpu45 := le.pkpu45 <> ri.pkpu45;
    SELF.Diff_pkpu46 := le.pkpu46 <> ri.pkpu46;
    SELF.Diff_pkpu47 := le.pkpu47 <> ri.pkpu47;
    SELF.Diff_pkpu48 := le.pkpu48 <> ri.pkpu48;
    SELF.Diff_pkpu49 := le.pkpu49 <> ri.pkpu49;
    SELF.Diff_pkpu50 := le.pkpu50 <> ri.pkpu50;
    SELF.Diff_pkpu51 := le.pkpu51 <> ri.pkpu51;
    SELF.Diff_pkpu52 := le.pkpu52 <> ri.pkpu52;
    SELF.Diff_pkpu53 := le.pkpu53 <> ri.pkpu53;
    SELF.Diff_pkpu54 := le.pkpu54 <> ri.pkpu54;
    SELF.Diff_pkpu55 := le.pkpu55 <> ri.pkpu55;
    SELF.Diff_pkpu56 := le.pkpu56 <> ri.pkpu56;
    SELF.Diff_pkpu57 := le.pkpu57 <> ri.pkpu57;
    SELF.Diff_pkpu60 := le.pkpu60 <> ri.pkpu60;
    SELF.Diff_pkpu61 := le.pkpu61 <> ri.pkpu61;
    SELF.Diff_pkpu62 := le.pkpu62 <> ri.pkpu62;
    SELF.Diff_pkpu63 := le.pkpu63 <> ri.pkpu63;
    SELF.Diff_pkpu64 := le.pkpu64 <> ri.pkpu64;
    SELF.Diff_pkpu65 := le.pkpu65 <> ri.pkpu65;
    SELF.Diff_pkpu66 := le.pkpu66 <> ri.pkpu66;
    SELF.Diff_pkpu67 := le.pkpu67 <> ri.pkpu67;
    SELF.Diff_pkpu68 := le.pkpu68 <> ri.pkpu68;
    SELF.Diff_pkpu69 := le.pkpu69 <> ri.pkpu69;
    SELF.Diff_pkpu70 := le.pkpu70 <> ri.pkpu70;
    SELF.Diff_censpct_water := le.censpct_water <> ri.censpct_water;
    SELF.Diff_cens_pop_density := le.cens_pop_density <> ri.cens_pop_density;
    SELF.Diff_cens_hu_density := le.cens_hu_density <> ri.cens_hu_density;
    SELF.Diff_censpct_pop_white := le.censpct_pop_white <> ri.censpct_pop_white;
    SELF.Diff_censpct_pop_black := le.censpct_pop_black <> ri.censpct_pop_black;
    SELF.Diff_censpct_pop_amerind := le.censpct_pop_amerind <> ri.censpct_pop_amerind;
    SELF.Diff_censpct_pop_asian := le.censpct_pop_asian <> ri.censpct_pop_asian;
    SELF.Diff_censpct_pop_pacisl := le.censpct_pop_pacisl <> ri.censpct_pop_pacisl;
    SELF.Diff_censpct_pop_othrace := le.censpct_pop_othrace <> ri.censpct_pop_othrace;
    SELF.Diff_censpct_pop_multirace := le.censpct_pop_multirace <> ri.censpct_pop_multirace;
    SELF.Diff_censpct_pop_hispanic := le.censpct_pop_hispanic <> ri.censpct_pop_hispanic;
    SELF.Diff_censpct_pop_agelt18 := le.censpct_pop_agelt18 <> ri.censpct_pop_agelt18;
    SELF.Diff_censpct_pop_males := le.censpct_pop_males <> ri.censpct_pop_males;
    SELF.Diff_censpct_adult_age1824 := le.censpct_adult_age1824 <> ri.censpct_adult_age1824;
    SELF.Diff_censpct_adult_age2534 := le.censpct_adult_age2534 <> ri.censpct_adult_age2534;
    SELF.Diff_censpct_adult_age3544 := le.censpct_adult_age3544 <> ri.censpct_adult_age3544;
    SELF.Diff_censpct_adult_age4554 := le.censpct_adult_age4554 <> ri.censpct_adult_age4554;
    SELF.Diff_censpct_adult_age5564 := le.censpct_adult_age5564 <> ri.censpct_adult_age5564;
    SELF.Diff_censpct_adult_agege65 := le.censpct_adult_agege65 <> ri.censpct_adult_agege65;
    SELF.Diff_cens_pop_medage := le.cens_pop_medage <> ri.cens_pop_medage;
    SELF.Diff_cens_hh_avgsize := le.cens_hh_avgsize <> ri.cens_hh_avgsize;
    SELF.Diff_censpct_hh_family := le.censpct_hh_family <> ri.censpct_hh_family;
    SELF.Diff_censpct_hh_family_husbwife := le.censpct_hh_family_husbwife <> ri.censpct_hh_family_husbwife;
    SELF.Diff_censpct_hu_occupied := le.censpct_hu_occupied <> ri.censpct_hu_occupied;
    SELF.Diff_censpct_hu_owned := le.censpct_hu_owned <> ri.censpct_hu_owned;
    SELF.Diff_censpct_hu_rented := le.censpct_hu_rented <> ri.censpct_hu_rented;
    SELF.Diff_censpct_hu_vacantseasonal := le.censpct_hu_vacantseasonal <> ri.censpct_hu_vacantseasonal;
    SELF.Diff_zip_medinc := le.zip_medinc <> ri.zip_medinc;
    SELF.Diff_zip_apparel := le.zip_apparel <> ri.zip_apparel;
    SELF.Diff_zip_apparel_women := le.zip_apparel_women <> ri.zip_apparel_women;
    SELF.Diff_zip_apparel_womfash := le.zip_apparel_womfash <> ri.zip_apparel_womfash;
    SELF.Diff_zip_auto := le.zip_auto <> ri.zip_auto;
    SELF.Diff_zip_beauty := le.zip_beauty <> ri.zip_beauty;
    SELF.Diff_zip_booksmusicmovies := le.zip_booksmusicmovies <> ri.zip_booksmusicmovies;
    SELF.Diff_zip_business := le.zip_business <> ri.zip_business;
    SELF.Diff_zip_catalog := le.zip_catalog <> ri.zip_catalog;
    SELF.Diff_zip_cc := le.zip_cc <> ri.zip_cc;
    SELF.Diff_zip_collectibles := le.zip_collectibles <> ri.zip_collectibles;
    SELF.Diff_zip_computers := le.zip_computers <> ri.zip_computers;
    SELF.Diff_zip_continuity := le.zip_continuity <> ri.zip_continuity;
    SELF.Diff_zip_cooking := le.zip_cooking <> ri.zip_cooking;
    SELF.Diff_zip_crafts := le.zip_crafts <> ri.zip_crafts;
    SELF.Diff_zip_culturearts := le.zip_culturearts <> ri.zip_culturearts;
    SELF.Diff_zip_dm_sold := le.zip_dm_sold <> ri.zip_dm_sold;
    SELF.Diff_zip_donor := le.zip_donor <> ri.zip_donor;
    SELF.Diff_zip_family := le.zip_family <> ri.zip_family;
    SELF.Diff_zip_gardening := le.zip_gardening <> ri.zip_gardening;
    SELF.Diff_zip_giftgivr := le.zip_giftgivr <> ri.zip_giftgivr;
    SELF.Diff_zip_gourmet := le.zip_gourmet <> ri.zip_gourmet;
    SELF.Diff_zip_health := le.zip_health <> ri.zip_health;
    SELF.Diff_zip_health_diet := le.zip_health_diet <> ri.zip_health_diet;
    SELF.Diff_zip_health_fitness := le.zip_health_fitness <> ri.zip_health_fitness;
    SELF.Diff_zip_hobbies := le.zip_hobbies <> ri.zip_hobbies;
    SELF.Diff_zip_homedecr := le.zip_homedecr <> ri.zip_homedecr;
    SELF.Diff_zip_homeliv := le.zip_homeliv <> ri.zip_homeliv;
    SELF.Diff_zip_internet := le.zip_internet <> ri.zip_internet;
    SELF.Diff_zip_internet_access := le.zip_internet_access <> ri.zip_internet_access;
    SELF.Diff_zip_internet_buy := le.zip_internet_buy <> ri.zip_internet_buy;
    SELF.Diff_zip_music := le.zip_music <> ri.zip_music;
    SELF.Diff_zip_outdoors := le.zip_outdoors <> ri.zip_outdoors;
    SELF.Diff_zip_pets := le.zip_pets <> ri.zip_pets;
    SELF.Diff_zip_pfin := le.zip_pfin <> ri.zip_pfin;
    SELF.Diff_zip_publish := le.zip_publish <> ri.zip_publish;
    SELF.Diff_zip_publish_books := le.zip_publish_books <> ri.zip_publish_books;
    SELF.Diff_zip_publish_mags := le.zip_publish_mags <> ri.zip_publish_mags;
    SELF.Diff_zip_sports := le.zip_sports <> ri.zip_sports;
    SELF.Diff_zip_sports_biking := le.zip_sports_biking <> ri.zip_sports_biking;
    SELF.Diff_zip_sports_golf := le.zip_sports_golf <> ri.zip_sports_golf;
    SELF.Diff_zip_travel := le.zip_travel <> ri.zip_travel;
    SELF.Diff_zip_travel_us := le.zip_travel_us <> ri.zip_travel_us;
    SELF.Diff_zip_tvmovies := le.zip_tvmovies <> ri.zip_tvmovies;
    SELF.Diff_zip_woman := le.zip_woman <> ri.zip_woman;
    SELF.Diff_zip_proftech := le.zip_proftech <> ri.zip_proftech;
    SELF.Diff_zip_retired := le.zip_retired <> ri.zip_retired;
    SELF.Diff_zip_inc100 := le.zip_inc100 <> ri.zip_inc100;
    SELF.Diff_zip_inc75 := le.zip_inc75 <> ri.zip_inc75;
    SELF.Diff_zip_inc50 := le.zip_inc50 <> ri.zip_inc50;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dtmatch,1,0)+ IF( SELF.Diff_msname,1,0)+ IF( SELF.Diff_msaddr1,1,0)+ IF( SELF.Diff_msaddr2,1,0)+ IF( SELF.Diff_mscity,1,0)+ IF( SELF.Diff_msstate,1,0)+ IF( SELF.Diff_mszip5,1,0)+ IF( SELF.Diff_mszip4,1,0)+ IF( SELF.Diff_dthh,1,0)+ IF( SELF.Diff_mscrrt,1,0)+ IF( SELF.Diff_msdpbc,1,0)+ IF( SELF.Diff_msdpv,1,0)+ IF( SELF.Diff_ms_addrtype,1,0)+ IF( SELF.Diff_ctysize,1,0)+ IF( SELF.Diff_lmos,1,0)+ IF( SELF.Diff_omos,1,0)+ IF( SELF.Diff_pmos,1,0)+ IF( SELF.Diff_gen,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_inc,1,0)+ IF( SELF.Diff_marital_status,1,0)+ IF( SELF.Diff_poc,1,0)+ IF( SELF.Diff_noc,1,0)+ IF( SELF.Diff_ocp,1,0)+ IF( SELF.Diff_edu,1,0)+ IF( SELF.Diff_lang,1,0)+ IF( SELF.Diff_relig,1,0)+ IF( SELF.Diff_dwell,1,0)+ IF( SELF.Diff_ownr,1,0)+ IF( SELF.Diff_eth1,1,0)+ IF( SELF.Diff_eth2,1,0)+ IF( SELF.Diff_lor,1,0)+ IF( SELF.Diff_pool,1,0)+ IF( SELF.Diff_speak_span,1,0)+ IF( SELF.Diff_soho,1,0)+ IF( SELF.Diff_vet_in_hh,1,0)+ IF( SELF.Diff_ms_mags,1,0)+ IF( SELF.Diff_ms_books,1,0)+ IF( SELF.Diff_ms_publish,1,0)+ IF( SELF.Diff_ms_pub_status_active,1,0)+ IF( SELF.Diff_ms_pub_status_expire,1,0)+ IF( SELF.Diff_ms_pub_premsold,1,0)+ IF( SELF.Diff_ms_pub_autornwl,1,0)+ IF( SELF.Diff_ms_pub_avgterm,1,0)+ IF( SELF.Diff_ms_pub_lmos,1,0)+ IF( SELF.Diff_ms_pub_omos,1,0)+ IF( SELF.Diff_ms_pub_pmos,1,0)+ IF( SELF.Diff_ms_pub_cemos,1,0)+ IF( SELF.Diff_ms_pub_femos,1,0)+ IF( SELF.Diff_ms_pub_totords,1,0)+ IF( SELF.Diff_ms_pub_totdlrs,1,0)+ IF( SELF.Diff_ms_pub_avgdlrs,1,0)+ IF( SELF.Diff_ms_pub_lastdlrs,1,0)+ IF( SELF.Diff_ms_pub_paystat_paid,1,0)+ IF( SELF.Diff_ms_pub_paystat_ub,1,0)+ IF( SELF.Diff_ms_pub_paymeth_cc,1,0)+ IF( SELF.Diff_ms_pub_paymeth_cash,1,0)+ IF( SELF.Diff_ms_pub_payspeed,1,0)+ IF( SELF.Diff_ms_pub_osrc_dm,1,0)+ IF( SELF.Diff_ms_pub_lsrc_dm,1,0)+ IF( SELF.Diff_ms_pub_osrc_agt_cashf,1,0)+ IF( SELF.Diff_ms_pub_lsrc_agt_cashf,1,0)+ IF( SELF.Diff_ms_pub_osrc_agt_pds,1,0)+ IF( SELF.Diff_ms_pub_lsrc_agt_pds,1,0)+ IF( SELF.Diff_ms_pub_osrc_agt_schplan,1,0)+ IF( SELF.Diff_ms_pub_lsrc_agt_schplan,1,0)+ IF( SELF.Diff_ms_pub_osrc_agt_sponsor,1,0)+ IF( SELF.Diff_ms_pub_lsrc_agt_sponsor,1,0)+ IF( SELF.Diff_ms_pub_osrc_agt_tm,1,0)+ IF( SELF.Diff_ms_pub_lsrc_agt_tm,1,0)+ IF( SELF.Diff_ms_pub_osrc_agt,1,0)+ IF( SELF.Diff_ms_pub_lsrc_agt,1,0)+ IF( SELF.Diff_ms_pub_osrc_tm,1,0)+ IF( SELF.Diff_ms_pub_lsrc_tm,1,0)+ IF( SELF.Diff_ms_pub_osrc_ins,1,0)+ IF( SELF.Diff_ms_pub_lsrc_ins,1,0)+ IF( SELF.Diff_ms_pub_osrc_net,1,0)+ IF( SELF.Diff_ms_pub_lsrc_net,1,0)+ IF( SELF.Diff_ms_pub_osrc_print,1,0)+ IF( SELF.Diff_ms_pub_lsrc_print,1,0)+ IF( SELF.Diff_ms_pub_osrc_trans,1,0)+ IF( SELF.Diff_ms_pub_lsrc_trans,1,0)+ IF( SELF.Diff_ms_pub_osrc_tv,1,0)+ IF( SELF.Diff_ms_pub_lsrc_tv,1,0)+ IF( SELF.Diff_ms_pub_osrc_dtp,1,0)+ IF( SELF.Diff_ms_pub_lsrc_dtp,1,0)+ IF( SELF.Diff_ms_pub_giftgivr,1,0)+ IF( SELF.Diff_ms_pub_giftee,1,0)+ IF( SELF.Diff_ms_catalog,1,0)+ IF( SELF.Diff_ms_cat_lmos,1,0)+ IF( SELF.Diff_ms_cat_omos,1,0)+ IF( SELF.Diff_ms_cat_pmos,1,0)+ IF( SELF.Diff_ms_cat_totords,1,0)+ IF( SELF.Diff_ms_cat_totitems,1,0)+ IF( SELF.Diff_ms_cat_totdlrs,1,0)+ IF( SELF.Diff_ms_cat_avgdlrs,1,0)+ IF( SELF.Diff_ms_cat_lastdlrs,1,0)+ IF( SELF.Diff_ms_cat_paystat_paid,1,0)+ IF( SELF.Diff_ms_cat_paymeth_cc,1,0)+ IF( SELF.Diff_ms_cat_paymeth_cash,1,0)+ IF( SELF.Diff_ms_cat_osrc_dm,1,0)+ IF( SELF.Diff_ms_cat_lsrc_dm,1,0)+ IF( SELF.Diff_ms_cat_osrc_net,1,0)+ IF( SELF.Diff_ms_cat_lsrc_net,1,0)+ IF( SELF.Diff_ms_cat_giftgivr,1,0)+ IF( SELF.Diff_pkpubs_corrected,1,0)+ IF( SELF.Diff_pkcatg_corrected,1,0)+ IF( SELF.Diff_ms_fundraising,1,0)+ IF( SELF.Diff_ms_fund_lmos,1,0)+ IF( SELF.Diff_ms_fund_omos,1,0)+ IF( SELF.Diff_ms_fund_pmos,1,0)+ IF( SELF.Diff_ms_fund_totords,1,0)+ IF( SELF.Diff_ms_fund_totdlrs,1,0)+ IF( SELF.Diff_ms_fund_avgdlrs,1,0)+ IF( SELF.Diff_ms_fund_lastdlrs,1,0)+ IF( SELF.Diff_ms_fund_paystat_paid,1,0)+ IF( SELF.Diff_ms_other,1,0)+ IF( SELF.Diff_ms_continuity,1,0)+ IF( SELF.Diff_ms_cont_status_active,1,0)+ IF( SELF.Diff_ms_cont_status_cancel,1,0)+ IF( SELF.Diff_ms_cont_omos,1,0)+ IF( SELF.Diff_ms_cont_lmos,1,0)+ IF( SELF.Diff_ms_cont_pmos,1,0)+ IF( SELF.Diff_ms_cont_totords,1,0)+ IF( SELF.Diff_ms_cont_totdlrs,1,0)+ IF( SELF.Diff_ms_cont_avgdlrs,1,0)+ IF( SELF.Diff_ms_cont_lastdlrs,1,0)+ IF( SELF.Diff_ms_cont_paystat_paid,1,0)+ IF( SELF.Diff_ms_cont_paymeth_cc,1,0)+ IF( SELF.Diff_ms_cont_paymeth_cash,1,0)+ IF( SELF.Diff_ms_totords,1,0)+ IF( SELF.Diff_ms_totitems,1,0)+ IF( SELF.Diff_ms_totdlrs,1,0)+ IF( SELF.Diff_ms_avgdlrs,1,0)+ IF( SELF.Diff_ms_lastdlrs,1,0)+ IF( SELF.Diff_ms_paystat_paid,1,0)+ IF( SELF.Diff_ms_paymeth_cc,1,0)+ IF( SELF.Diff_ms_paymeth_cash,1,0)+ IF( SELF.Diff_ms_osrc_dm,1,0)+ IF( SELF.Diff_ms_lsrc_dm,1,0)+ IF( SELF.Diff_ms_osrc_tm,1,0)+ IF( SELF.Diff_ms_lsrc_tm,1,0)+ IF( SELF.Diff_ms_osrc_ins,1,0)+ IF( SELF.Diff_ms_lsrc_ins,1,0)+ IF( SELF.Diff_ms_osrc_net,1,0)+ IF( SELF.Diff_ms_lsrc_net,1,0)+ IF( SELF.Diff_ms_osrc_tv,1,0)+ IF( SELF.Diff_ms_lsrc_tv,1,0)+ IF( SELF.Diff_ms_osrc_retail,1,0)+ IF( SELF.Diff_ms_lsrc_retail,1,0)+ IF( SELF.Diff_ms_giftgivr,1,0)+ IF( SELF.Diff_ms_giftee,1,0)+ IF( SELF.Diff_ms_adult,1,0)+ IF( SELF.Diff_ms_womapp,1,0)+ IF( SELF.Diff_ms_menapp,1,0)+ IF( SELF.Diff_ms_kidapp,1,0)+ IF( SELF.Diff_ms_accessory,1,0)+ IF( SELF.Diff_ms_apparel,1,0)+ IF( SELF.Diff_ms_app_lmos,1,0)+ IF( SELF.Diff_ms_app_omos,1,0)+ IF( SELF.Diff_ms_app_pmos,1,0)+ IF( SELF.Diff_ms_app_totords,1,0)+ IF( SELF.Diff_ms_app_totitems,1,0)+ IF( SELF.Diff_ms_app_totdlrs,1,0)+ IF( SELF.Diff_ms_app_avgdlrs,1,0)+ IF( SELF.Diff_ms_app_lastdlrs,1,0)+ IF( SELF.Diff_ms_app_paystat_paid,1,0)+ IF( SELF.Diff_ms_app_paymeth_cc,1,0)+ IF( SELF.Diff_ms_app_paymeth_cash,1,0)+ IF( SELF.Diff_ms_menfash,1,0)+ IF( SELF.Diff_ms_womfash,1,0)+ IF( SELF.Diff_ms_wfsh_lmos,1,0)+ IF( SELF.Diff_ms_wfsh_omos,1,0)+ IF( SELF.Diff_ms_wfsh_pmos,1,0)+ IF( SELF.Diff_ms_wfsh_totords,1,0)+ IF( SELF.Diff_ms_wfsh_totdlrs,1,0)+ IF( SELF.Diff_ms_wfsh_avgdlrs,1,0)+ IF( SELF.Diff_ms_wfsh_lastdlrs,1,0)+ IF( SELF.Diff_ms_wfsh_paystat_paid,1,0)+ IF( SELF.Diff_ms_wfsh_osrc_dm,1,0)+ IF( SELF.Diff_ms_wfsh_lsrc_dm,1,0)+ IF( SELF.Diff_ms_wfsh_osrc_agt,1,0)+ IF( SELF.Diff_ms_wfsh_lsrc_agt,1,0)+ IF( SELF.Diff_ms_audio,1,0)+ IF( SELF.Diff_ms_auto,1,0)+ IF( SELF.Diff_ms_aviation,1,0)+ IF( SELF.Diff_ms_bargains,1,0)+ IF( SELF.Diff_ms_beauty,1,0)+ IF( SELF.Diff_ms_bible,1,0)+ IF( SELF.Diff_ms_bible_lmos,1,0)+ IF( SELF.Diff_ms_bible_omos,1,0)+ IF( SELF.Diff_ms_bible_pmos,1,0)+ IF( SELF.Diff_ms_bible_totords,1,0)+ IF( SELF.Diff_ms_bible_totitems,1,0)+ IF( SELF.Diff_ms_bible_totdlrs,1,0)+ IF( SELF.Diff_ms_bible_avgdlrs,1,0)+ IF( SELF.Diff_ms_bible_lastdlrs,1,0)+ IF( SELF.Diff_ms_bible_paystat_paid,1,0)+ IF( SELF.Diff_ms_bible_paymeth_cc,1,0)+ IF( SELF.Diff_ms_bible_paymeth_cash,1,0)+ IF( SELF.Diff_ms_business,1,0)+ IF( SELF.Diff_ms_collectibles,1,0)+ IF( SELF.Diff_ms_computers,1,0)+ IF( SELF.Diff_ms_crafts,1,0)+ IF( SELF.Diff_ms_culturearts,1,0)+ IF( SELF.Diff_ms_currevent,1,0)+ IF( SELF.Diff_ms_diy,1,0)+ IF( SELF.Diff_ms_electronics,1,0)+ IF( SELF.Diff_ms_equestrian,1,0)+ IF( SELF.Diff_ms_pub_family,1,0)+ IF( SELF.Diff_ms_cat_family,1,0)+ IF( SELF.Diff_ms_family,1,0)+ IF( SELF.Diff_ms_family_lmos,1,0)+ IF( SELF.Diff_ms_family_omos,1,0)+ IF( SELF.Diff_ms_family_pmos,1,0)+ IF( SELF.Diff_ms_family_totords,1,0)+ IF( SELF.Diff_ms_family_totitems,1,0)+ IF( SELF.Diff_ms_family_totdlrs,1,0)+ IF( SELF.Diff_ms_family_avgdlrs,1,0)+ IF( SELF.Diff_ms_family_lastdlrs,1,0)+ IF( SELF.Diff_ms_family_paystat_paid,1,0)+ IF( SELF.Diff_ms_family_paymeth_cc,1,0)+ IF( SELF.Diff_ms_family_paymeth_cash,1,0)+ IF( SELF.Diff_ms_family_osrc_dm,1,0)+ IF( SELF.Diff_ms_family_lsrc_dm,1,0)+ IF( SELF.Diff_ms_fiction,1,0)+ IF( SELF.Diff_ms_food,1,0)+ IF( SELF.Diff_ms_games,1,0)+ IF( SELF.Diff_ms_gifts,1,0)+ IF( SELF.Diff_ms_gourmet,1,0)+ IF( SELF.Diff_ms_fitness,1,0)+ IF( SELF.Diff_ms_health,1,0)+ IF( SELF.Diff_ms_hlth_lmos,1,0)+ IF( SELF.Diff_ms_hlth_omos,1,0)+ IF( SELF.Diff_ms_hlth_pmos,1,0)+ IF( SELF.Diff_ms_hlth_totords,1,0)+ IF( SELF.Diff_ms_hlth_totdlrs,1,0)+ IF( SELF.Diff_ms_hlth_avgdlrs,1,0)+ IF( SELF.Diff_ms_hlth_lastdlrs,1,0)+ IF( SELF.Diff_ms_hlth_paystat_paid,1,0)+ IF( SELF.Diff_ms_hlth_paymeth_cc,1,0)+ IF( SELF.Diff_ms_hlth_osrc_dm,1,0)+ IF( SELF.Diff_ms_hlth_lsrc_dm,1,0)+ IF( SELF.Diff_ms_hlth_osrc_agt,1,0)+ IF( SELF.Diff_ms_hlth_lsrc_agt,1,0)+ IF( SELF.Diff_ms_hlth_osrc_tv,1,0)+ IF( SELF.Diff_ms_hlth_lsrc_tv,1,0)+ IF( SELF.Diff_ms_holiday,1,0)+ IF( SELF.Diff_ms_history,1,0)+ IF( SELF.Diff_ms_pub_cooking,1,0)+ IF( SELF.Diff_ms_cooking,1,0)+ IF( SELF.Diff_ms_pub_homedecr,1,0)+ IF( SELF.Diff_ms_cat_homedecr,1,0)+ IF( SELF.Diff_ms_homedecr,1,0)+ IF( SELF.Diff_ms_housewares,1,0)+ IF( SELF.Diff_ms_pub_garden,1,0)+ IF( SELF.Diff_ms_cat_garden,1,0)+ IF( SELF.Diff_ms_garden,1,0)+ IF( SELF.Diff_ms_pub_homeliv,1,0)+ IF( SELF.Diff_ms_cat_homeliv,1,0)+ IF( SELF.Diff_ms_homeliv,1,0)+ IF( SELF.Diff_ms_pub_home_status_active,1,0)+ IF( SELF.Diff_ms_home_lmos,1,0)+ IF( SELF.Diff_ms_home_omos,1,0)+ IF( SELF.Diff_ms_home_pmos,1,0)+ IF( SELF.Diff_ms_home_totords,1,0)+ IF( SELF.Diff_ms_home_totitems,1,0)+ IF( SELF.Diff_ms_home_totdlrs,1,0)+ IF( SELF.Diff_ms_home_avgdlrs,1,0)+ IF( SELF.Diff_ms_home_lastdlrs,1,0)+ IF( SELF.Diff_ms_home_paystat_paid,1,0)+ IF( SELF.Diff_ms_home_paymeth_cc,1,0)+ IF( SELF.Diff_ms_home_paymeth_cash,1,0)+ IF( SELF.Diff_ms_home_osrc_dm,1,0)+ IF( SELF.Diff_ms_home_lsrc_dm,1,0)+ IF( SELF.Diff_ms_home_osrc_agt,1,0)+ IF( SELF.Diff_ms_home_lsrc_agt,1,0)+ IF( SELF.Diff_ms_home_osrc_net,1,0)+ IF( SELF.Diff_ms_home_lsrc_net,1,0)+ IF( SELF.Diff_ms_home_osrc_tv,1,0)+ IF( SELF.Diff_ms_home_lsrc_tv,1,0)+ IF( SELF.Diff_ms_humor,1,0)+ IF( SELF.Diff_ms_inspiration,1,0)+ IF( SELF.Diff_ms_merchandise,1,0)+ IF( SELF.Diff_ms_moneymaking,1,0)+ IF( SELF.Diff_ms_moneymaking_lmos,1,0)+ IF( SELF.Diff_ms_motorcycles,1,0)+ IF( SELF.Diff_ms_music,1,0)+ IF( SELF.Diff_ms_fishing,1,0)+ IF( SELF.Diff_ms_hunting,1,0)+ IF( SELF.Diff_ms_boatsail,1,0)+ IF( SELF.Diff_ms_camp,1,0)+ IF( SELF.Diff_ms_pub_outdoors,1,0)+ IF( SELF.Diff_ms_cat_outdoors,1,0)+ IF( SELF.Diff_ms_outdoors,1,0)+ IF( SELF.Diff_ms_pub_out_status_active,1,0)+ IF( SELF.Diff_ms_out_lmos,1,0)+ IF( SELF.Diff_ms_out_omos,1,0)+ IF( SELF.Diff_ms_out_pmos,1,0)+ IF( SELF.Diff_ms_out_totords,1,0)+ IF( SELF.Diff_ms_out_totitems,1,0)+ IF( SELF.Diff_ms_out_totdlrs,1,0)+ IF( SELF.Diff_ms_out_avgdlrs,1,0)+ IF( SELF.Diff_ms_out_lastdlrs,1,0)+ IF( SELF.Diff_ms_out_paystat_paid,1,0)+ IF( SELF.Diff_ms_out_paymeth_cc,1,0)+ IF( SELF.Diff_ms_out_paymeth_cash,1,0)+ IF( SELF.Diff_ms_out_osrc_dm,1,0)+ IF( SELF.Diff_ms_out_lsrc_dm,1,0)+ IF( SELF.Diff_ms_out_osrc_agt,1,0)+ IF( SELF.Diff_ms_out_lsrc_agt,1,0)+ IF( SELF.Diff_ms_pets,1,0)+ IF( SELF.Diff_ms_pfin,1,0)+ IF( SELF.Diff_ms_photo,1,0)+ IF( SELF.Diff_ms_photoproc,1,0)+ IF( SELF.Diff_ms_rural,1,0)+ IF( SELF.Diff_ms_science,1,0)+ IF( SELF.Diff_ms_sports,1,0)+ IF( SELF.Diff_ms_sports_lmos,1,0)+ IF( SELF.Diff_ms_travel,1,0)+ IF( SELF.Diff_ms_tvmovies,1,0)+ IF( SELF.Diff_ms_wildlife,1,0)+ IF( SELF.Diff_ms_woman,1,0)+ IF( SELF.Diff_ms_woman_lmos,1,0)+ IF( SELF.Diff_ms_ringtones_apps,1,0)+ IF( SELF.Diff_cpi_mobile_apps_index,1,0)+ IF( SELF.Diff_cpi_credit_repair_index,1,0)+ IF( SELF.Diff_cpi_credit_report_index,1,0)+ IF( SELF.Diff_cpi_education_seekers_index,1,0)+ IF( SELF.Diff_cpi_insurance_index,1,0)+ IF( SELF.Diff_cpi_insurance_health_index,1,0)+ IF( SELF.Diff_cpi_insurance_auto_index,1,0)+ IF( SELF.Diff_cpi_job_seekers_index,1,0)+ IF( SELF.Diff_cpi_social_networking_index,1,0)+ IF( SELF.Diff_cpi_adult_index,1,0)+ IF( SELF.Diff_cpi_africanamerican_index,1,0)+ IF( SELF.Diff_cpi_apparel_index,1,0)+ IF( SELF.Diff_cpi_apparel_accessory_index,1,0)+ IF( SELF.Diff_cpi_apparel_kids_index,1,0)+ IF( SELF.Diff_cpi_apparel_men_index,1,0)+ IF( SELF.Diff_cpi_apparel_menfash_index,1,0)+ IF( SELF.Diff_cpi_apparel_women_index,1,0)+ IF( SELF.Diff_cpi_apparel_womfash_index,1,0)+ IF( SELF.Diff_cpi_asian_index,1,0)+ IF( SELF.Diff_cpi_auto_index,1,0)+ IF( SELF.Diff_cpi_auto_racing_index,1,0)+ IF( SELF.Diff_cpi_auto_trucks_index,1,0)+ IF( SELF.Diff_cpi_aviation_index,1,0)+ IF( SELF.Diff_cpi_bargains_index,1,0)+ IF( SELF.Diff_cpi_beauty_index,1,0)+ IF( SELF.Diff_cpi_bible_index,1,0)+ IF( SELF.Diff_cpi_birds_index,1,0)+ IF( SELF.Diff_cpi_business_index,1,0)+ IF( SELF.Diff_cpi_business_homeoffice_index,1,0)+ IF( SELF.Diff_cpi_catalog_index,1,0)+ IF( SELF.Diff_cpi_cc_index,1,0)+ IF( SELF.Diff_cpi_collectibles_index,1,0)+ IF( SELF.Diff_cpi_college_index,1,0)+ IF( SELF.Diff_cpi_computers_index,1,0)+ IF( SELF.Diff_cpi_conservative_index,1,0)+ IF( SELF.Diff_cpi_continuity_index,1,0)+ IF( SELF.Diff_cpi_cooking_index,1,0)+ IF( SELF.Diff_cpi_crafts_index,1,0)+ IF( SELF.Diff_cpi_crafts_crochet_index,1,0)+ IF( SELF.Diff_cpi_crafts_knit_index,1,0)+ IF( SELF.Diff_cpi_crafts_needlepoint_index,1,0)+ IF( SELF.Diff_cpi_crafts_quilt_index,1,0)+ IF( SELF.Diff_cpi_crafts_sew_index,1,0)+ IF( SELF.Diff_cpi_culturearts_index,1,0)+ IF( SELF.Diff_cpi_currevent_index,1,0)+ IF( SELF.Diff_cpi_diy_index,1,0)+ IF( SELF.Diff_cpi_donor_index,1,0)+ IF( SELF.Diff_cpi_ego_index,1,0)+ IF( SELF.Diff_cpi_electronics_index,1,0)+ IF( SELF.Diff_cpi_equestrian_index,1,0)+ IF( SELF.Diff_cpi_family_index,1,0)+ IF( SELF.Diff_cpi_family_teen_index,1,0)+ IF( SELF.Diff_cpi_family_young_index,1,0)+ IF( SELF.Diff_cpi_fiction_index,1,0)+ IF( SELF.Diff_cpi_gambling_index,1,0)+ IF( SELF.Diff_cpi_games_index,1,0)+ IF( SELF.Diff_cpi_gardening_index,1,0)+ IF( SELF.Diff_cpi_gay_index,1,0)+ IF( SELF.Diff_cpi_giftgivr_index,1,0)+ IF( SELF.Diff_cpi_gourmet_index,1,0)+ IF( SELF.Diff_cpi_grandparents_index,1,0)+ IF( SELF.Diff_cpi_health_index,1,0)+ IF( SELF.Diff_cpi_health_diet_index,1,0)+ IF( SELF.Diff_cpi_health_fitness_index,1,0)+ IF( SELF.Diff_cpi_hightech_index,1,0)+ IF( SELF.Diff_cpi_hispanic_index,1,0)+ IF( SELF.Diff_cpi_history_index,1,0)+ IF( SELF.Diff_cpi_history_american_index,1,0)+ IF( SELF.Diff_cpi_hobbies_index,1,0)+ IF( SELF.Diff_cpi_homedecr_index,1,0)+ IF( SELF.Diff_cpi_homeliv_index,1,0)+ IF( SELF.Diff_cpi_humor_index,1,0)+ IF( SELF.Diff_cpi_inspiration_index,1,0)+ IF( SELF.Diff_cpi_internet_index,1,0)+ IF( SELF.Diff_cpi_internet_access_index,1,0)+ IF( SELF.Diff_cpi_internet_buy_index,1,0)+ IF( SELF.Diff_cpi_liberal_index,1,0)+ IF( SELF.Diff_cpi_moneymaking_index,1,0)+ IF( SELF.Diff_cpi_motorcycles_index,1,0)+ IF( SELF.Diff_cpi_music_index,1,0)+ IF( SELF.Diff_cpi_nonfiction_index,1,0)+ IF( SELF.Diff_cpi_ocean_index,1,0)+ IF( SELF.Diff_cpi_outdoors_index,1,0)+ IF( SELF.Diff_cpi_outdoors_boatsail_index,1,0)+ IF( SELF.Diff_cpi_outdoors_camp_index,1,0)+ IF( SELF.Diff_cpi_outdoors_fishing_index,1,0)+ IF( SELF.Diff_cpi_outdoors_huntfish_index,1,0)+ IF( SELF.Diff_cpi_outdoors_hunting_index,1,0)+ IF( SELF.Diff_cpi_pets_index,1,0)+ IF( SELF.Diff_cpi_pets_cats_index,1,0)+ IF( SELF.Diff_cpi_pets_dogs_index,1,0)+ IF( SELF.Diff_cpi_pfin_index,1,0)+ IF( SELF.Diff_cpi_photog_index,1,0)+ IF( SELF.Diff_cpi_photoproc_index,1,0)+ IF( SELF.Diff_cpi_publish_index,1,0)+ IF( SELF.Diff_cpi_publish_books_index,1,0)+ IF( SELF.Diff_cpi_publish_mags_index,1,0)+ IF( SELF.Diff_cpi_rural_index,1,0)+ IF( SELF.Diff_cpi_science_index,1,0)+ IF( SELF.Diff_cpi_scifi_index,1,0)+ IF( SELF.Diff_cpi_seniors_index,1,0)+ IF( SELF.Diff_cpi_sports_index,1,0)+ IF( SELF.Diff_cpi_sports_baseball_index,1,0)+ IF( SELF.Diff_cpi_sports_basketball_index,1,0)+ IF( SELF.Diff_cpi_sports_biking_index,1,0)+ IF( SELF.Diff_cpi_sports_football_index,1,0)+ IF( SELF.Diff_cpi_sports_golf_index,1,0)+ IF( SELF.Diff_cpi_sports_hockey_index,1,0)+ IF( SELF.Diff_cpi_sports_running_index,1,0)+ IF( SELF.Diff_cpi_sports_ski_index,1,0)+ IF( SELF.Diff_cpi_sports_soccer_index,1,0)+ IF( SELF.Diff_cpi_sports_swimming_index,1,0)+ IF( SELF.Diff_cpi_sports_tennis_index,1,0)+ IF( SELF.Diff_cpi_stationery_index,1,0)+ IF( SELF.Diff_cpi_sweeps_index,1,0)+ IF( SELF.Diff_cpi_tobacco_index,1,0)+ IF( SELF.Diff_cpi_travel_index,1,0)+ IF( SELF.Diff_cpi_travel_cruise_index,1,0)+ IF( SELF.Diff_cpi_travel_rv_index,1,0)+ IF( SELF.Diff_cpi_travel_us_index,1,0)+ IF( SELF.Diff_cpi_tvmovies_index,1,0)+ IF( SELF.Diff_cpi_wildlife_index,1,0)+ IF( SELF.Diff_cpi_woman_index,1,0)+ IF( SELF.Diff_totdlr_index,1,0)+ IF( SELF.Diff_cpi_totdlr,1,0)+ IF( SELF.Diff_cpi_totords,1,0)+ IF( SELF.Diff_cpi_lastdlr,1,0)+ IF( SELF.Diff_pkcatg,1,0)+ IF( SELF.Diff_pkpubs,1,0)+ IF( SELF.Diff_pkcont,1,0)+ IF( SELF.Diff_pkca01,1,0)+ IF( SELF.Diff_pkca03,1,0)+ IF( SELF.Diff_pkca04,1,0)+ IF( SELF.Diff_pkca05,1,0)+ IF( SELF.Diff_pkca06,1,0)+ IF( SELF.Diff_pkca07,1,0)+ IF( SELF.Diff_pkca08,1,0)+ IF( SELF.Diff_pkca09,1,0)+ IF( SELF.Diff_pkca10,1,0)+ IF( SELF.Diff_pkca11,1,0)+ IF( SELF.Diff_pkca12,1,0)+ IF( SELF.Diff_pkca13,1,0)+ IF( SELF.Diff_pkca14,1,0)+ IF( SELF.Diff_pkca15,1,0)+ IF( SELF.Diff_pkca16,1,0)+ IF( SELF.Diff_pkca17,1,0)+ IF( SELF.Diff_pkca18,1,0)+ IF( SELF.Diff_pkca20,1,0)+ IF( SELF.Diff_pkca21,1,0)+ IF( SELF.Diff_pkca22,1,0)+ IF( SELF.Diff_pkca23,1,0)+ IF( SELF.Diff_pkca24,1,0)+ IF( SELF.Diff_pkca25,1,0)+ IF( SELF.Diff_pkca26,1,0)+ IF( SELF.Diff_pkca28,1,0)+ IF( SELF.Diff_pkca29,1,0)+ IF( SELF.Diff_pkca30,1,0)+ IF( SELF.Diff_pkca31,1,0)+ IF( SELF.Diff_pkca32,1,0)+ IF( SELF.Diff_pkca33,1,0)+ IF( SELF.Diff_pkca34,1,0)+ IF( SELF.Diff_pkca35,1,0)+ IF( SELF.Diff_pkca36,1,0)+ IF( SELF.Diff_pkca37,1,0)+ IF( SELF.Diff_pkca39,1,0)+ IF( SELF.Diff_pkca40,1,0)+ IF( SELF.Diff_pkca41,1,0)+ IF( SELF.Diff_pkca42,1,0)+ IF( SELF.Diff_pkca54,1,0)+ IF( SELF.Diff_pkca61,1,0)+ IF( SELF.Diff_pkca62,1,0)+ IF( SELF.Diff_pkca64,1,0)+ IF( SELF.Diff_pkpu01,1,0)+ IF( SELF.Diff_pkpu02,1,0)+ IF( SELF.Diff_pkpu03,1,0)+ IF( SELF.Diff_pkpu04,1,0)+ IF( SELF.Diff_pkpu05,1,0)+ IF( SELF.Diff_pkpu06,1,0)+ IF( SELF.Diff_pkpu07,1,0)+ IF( SELF.Diff_pkpu08,1,0)+ IF( SELF.Diff_pkpu09,1,0)+ IF( SELF.Diff_pkpu10,1,0)+ IF( SELF.Diff_pkpu11,1,0)+ IF( SELF.Diff_pkpu12,1,0)+ IF( SELF.Diff_pkpu13,1,0)+ IF( SELF.Diff_pkpu14,1,0)+ IF( SELF.Diff_pkpu15,1,0)+ IF( SELF.Diff_pkpu16,1,0)+ IF( SELF.Diff_pkpu17,1,0)+ IF( SELF.Diff_pkpu18,1,0)+ IF( SELF.Diff_pkpu19,1,0)+ IF( SELF.Diff_pkpu20,1,0)+ IF( SELF.Diff_pkpu23,1,0)+ IF( SELF.Diff_pkpu25,1,0)+ IF( SELF.Diff_pkpu27,1,0)+ IF( SELF.Diff_pkpu28,1,0)+ IF( SELF.Diff_pkpu29,1,0)+ IF( SELF.Diff_pkpu30,1,0)+ IF( SELF.Diff_pkpu31,1,0)+ IF( SELF.Diff_pkpu32,1,0)+ IF( SELF.Diff_pkpu33,1,0)+ IF( SELF.Diff_pkpu34,1,0)+ IF( SELF.Diff_pkpu35,1,0)+ IF( SELF.Diff_pkpu38,1,0)+ IF( SELF.Diff_pkpu41,1,0)+ IF( SELF.Diff_pkpu42,1,0)+ IF( SELF.Diff_pkpu45,1,0)+ IF( SELF.Diff_pkpu46,1,0)+ IF( SELF.Diff_pkpu47,1,0)+ IF( SELF.Diff_pkpu48,1,0)+ IF( SELF.Diff_pkpu49,1,0)+ IF( SELF.Diff_pkpu50,1,0)+ IF( SELF.Diff_pkpu51,1,0)+ IF( SELF.Diff_pkpu52,1,0)+ IF( SELF.Diff_pkpu53,1,0)+ IF( SELF.Diff_pkpu54,1,0)+ IF( SELF.Diff_pkpu55,1,0)+ IF( SELF.Diff_pkpu56,1,0)+ IF( SELF.Diff_pkpu57,1,0)+ IF( SELF.Diff_pkpu60,1,0)+ IF( SELF.Diff_pkpu61,1,0)+ IF( SELF.Diff_pkpu62,1,0)+ IF( SELF.Diff_pkpu63,1,0)+ IF( SELF.Diff_pkpu64,1,0)+ IF( SELF.Diff_pkpu65,1,0)+ IF( SELF.Diff_pkpu66,1,0)+ IF( SELF.Diff_pkpu67,1,0)+ IF( SELF.Diff_pkpu68,1,0)+ IF( SELF.Diff_pkpu69,1,0)+ IF( SELF.Diff_pkpu70,1,0)+ IF( SELF.Diff_censpct_water,1,0)+ IF( SELF.Diff_cens_pop_density,1,0)+ IF( SELF.Diff_cens_hu_density,1,0)+ IF( SELF.Diff_censpct_pop_white,1,0)+ IF( SELF.Diff_censpct_pop_black,1,0)+ IF( SELF.Diff_censpct_pop_amerind,1,0)+ IF( SELF.Diff_censpct_pop_asian,1,0)+ IF( SELF.Diff_censpct_pop_pacisl,1,0)+ IF( SELF.Diff_censpct_pop_othrace,1,0)+ IF( SELF.Diff_censpct_pop_multirace,1,0)+ IF( SELF.Diff_censpct_pop_hispanic,1,0)+ IF( SELF.Diff_censpct_pop_agelt18,1,0)+ IF( SELF.Diff_censpct_pop_males,1,0)+ IF( SELF.Diff_censpct_adult_age1824,1,0)+ IF( SELF.Diff_censpct_adult_age2534,1,0)+ IF( SELF.Diff_censpct_adult_age3544,1,0)+ IF( SELF.Diff_censpct_adult_age4554,1,0)+ IF( SELF.Diff_censpct_adult_age5564,1,0)+ IF( SELF.Diff_censpct_adult_agege65,1,0)+ IF( SELF.Diff_cens_pop_medage,1,0)+ IF( SELF.Diff_cens_hh_avgsize,1,0)+ IF( SELF.Diff_censpct_hh_family,1,0)+ IF( SELF.Diff_censpct_hh_family_husbwife,1,0)+ IF( SELF.Diff_censpct_hu_occupied,1,0)+ IF( SELF.Diff_censpct_hu_owned,1,0)+ IF( SELF.Diff_censpct_hu_rented,1,0)+ IF( SELF.Diff_censpct_hu_vacantseasonal,1,0)+ IF( SELF.Diff_zip_medinc,1,0)+ IF( SELF.Diff_zip_apparel,1,0)+ IF( SELF.Diff_zip_apparel_women,1,0)+ IF( SELF.Diff_zip_apparel_womfash,1,0)+ IF( SELF.Diff_zip_auto,1,0)+ IF( SELF.Diff_zip_beauty,1,0)+ IF( SELF.Diff_zip_booksmusicmovies,1,0)+ IF( SELF.Diff_zip_business,1,0)+ IF( SELF.Diff_zip_catalog,1,0)+ IF( SELF.Diff_zip_cc,1,0)+ IF( SELF.Diff_zip_collectibles,1,0)+ IF( SELF.Diff_zip_computers,1,0)+ IF( SELF.Diff_zip_continuity,1,0)+ IF( SELF.Diff_zip_cooking,1,0)+ IF( SELF.Diff_zip_crafts,1,0)+ IF( SELF.Diff_zip_culturearts,1,0)+ IF( SELF.Diff_zip_dm_sold,1,0)+ IF( SELF.Diff_zip_donor,1,0)+ IF( SELF.Diff_zip_family,1,0)+ IF( SELF.Diff_zip_gardening,1,0)+ IF( SELF.Diff_zip_giftgivr,1,0)+ IF( SELF.Diff_zip_gourmet,1,0)+ IF( SELF.Diff_zip_health,1,0)+ IF( SELF.Diff_zip_health_diet,1,0)+ IF( SELF.Diff_zip_health_fitness,1,0)+ IF( SELF.Diff_zip_hobbies,1,0)+ IF( SELF.Diff_zip_homedecr,1,0)+ IF( SELF.Diff_zip_homeliv,1,0)+ IF( SELF.Diff_zip_internet,1,0)+ IF( SELF.Diff_zip_internet_access,1,0)+ IF( SELF.Diff_zip_internet_buy,1,0)+ IF( SELF.Diff_zip_music,1,0)+ IF( SELF.Diff_zip_outdoors,1,0)+ IF( SELF.Diff_zip_pets,1,0)+ IF( SELF.Diff_zip_pfin,1,0)+ IF( SELF.Diff_zip_publish,1,0)+ IF( SELF.Diff_zip_publish_books,1,0)+ IF( SELF.Diff_zip_publish_mags,1,0)+ IF( SELF.Diff_zip_sports,1,0)+ IF( SELF.Diff_zip_sports_biking,1,0)+ IF( SELF.Diff_zip_sports_golf,1,0)+ IF( SELF.Diff_zip_travel,1,0)+ IF( SELF.Diff_zip_travel_us,1,0)+ IF( SELF.Diff_zip_tvmovies,1,0)+ IF( SELF.Diff_zip_woman,1,0)+ IF( SELF.Diff_zip_proftech,1,0)+ IF( SELF.Diff_zip_retired,1,0)+ IF( SELF.Diff_zip_inc100,1,0)+ IF( SELF.Diff_zip_inc75,1,0)+ IF( SELF.Diff_zip_inc50,1,0);
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
    Count_Diff_dtmatch := COUNT(GROUP,%Closest%.Diff_dtmatch);
    Count_Diff_msname := COUNT(GROUP,%Closest%.Diff_msname);
    Count_Diff_msaddr1 := COUNT(GROUP,%Closest%.Diff_msaddr1);
    Count_Diff_msaddr2 := COUNT(GROUP,%Closest%.Diff_msaddr2);
    Count_Diff_mscity := COUNT(GROUP,%Closest%.Diff_mscity);
    Count_Diff_msstate := COUNT(GROUP,%Closest%.Diff_msstate);
    Count_Diff_mszip5 := COUNT(GROUP,%Closest%.Diff_mszip5);
    Count_Diff_mszip4 := COUNT(GROUP,%Closest%.Diff_mszip4);
    Count_Diff_dthh := COUNT(GROUP,%Closest%.Diff_dthh);
    Count_Diff_mscrrt := COUNT(GROUP,%Closest%.Diff_mscrrt);
    Count_Diff_msdpbc := COUNT(GROUP,%Closest%.Diff_msdpbc);
    Count_Diff_msdpv := COUNT(GROUP,%Closest%.Diff_msdpv);
    Count_Diff_ms_addrtype := COUNT(GROUP,%Closest%.Diff_ms_addrtype);
    Count_Diff_ctysize := COUNT(GROUP,%Closest%.Diff_ctysize);
    Count_Diff_lmos := COUNT(GROUP,%Closest%.Diff_lmos);
    Count_Diff_omos := COUNT(GROUP,%Closest%.Diff_omos);
    Count_Diff_pmos := COUNT(GROUP,%Closest%.Diff_pmos);
    Count_Diff_gen := COUNT(GROUP,%Closest%.Diff_gen);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_inc := COUNT(GROUP,%Closest%.Diff_inc);
    Count_Diff_marital_status := COUNT(GROUP,%Closest%.Diff_marital_status);
    Count_Diff_poc := COUNT(GROUP,%Closest%.Diff_poc);
    Count_Diff_noc := COUNT(GROUP,%Closest%.Diff_noc);
    Count_Diff_ocp := COUNT(GROUP,%Closest%.Diff_ocp);
    Count_Diff_edu := COUNT(GROUP,%Closest%.Diff_edu);
    Count_Diff_lang := COUNT(GROUP,%Closest%.Diff_lang);
    Count_Diff_relig := COUNT(GROUP,%Closest%.Diff_relig);
    Count_Diff_dwell := COUNT(GROUP,%Closest%.Diff_dwell);
    Count_Diff_ownr := COUNT(GROUP,%Closest%.Diff_ownr);
    Count_Diff_eth1 := COUNT(GROUP,%Closest%.Diff_eth1);
    Count_Diff_eth2 := COUNT(GROUP,%Closest%.Diff_eth2);
    Count_Diff_lor := COUNT(GROUP,%Closest%.Diff_lor);
    Count_Diff_pool := COUNT(GROUP,%Closest%.Diff_pool);
    Count_Diff_speak_span := COUNT(GROUP,%Closest%.Diff_speak_span);
    Count_Diff_soho := COUNT(GROUP,%Closest%.Diff_soho);
    Count_Diff_vet_in_hh := COUNT(GROUP,%Closest%.Diff_vet_in_hh);
    Count_Diff_ms_mags := COUNT(GROUP,%Closest%.Diff_ms_mags);
    Count_Diff_ms_books := COUNT(GROUP,%Closest%.Diff_ms_books);
    Count_Diff_ms_publish := COUNT(GROUP,%Closest%.Diff_ms_publish);
    Count_Diff_ms_pub_status_active := COUNT(GROUP,%Closest%.Diff_ms_pub_status_active);
    Count_Diff_ms_pub_status_expire := COUNT(GROUP,%Closest%.Diff_ms_pub_status_expire);
    Count_Diff_ms_pub_premsold := COUNT(GROUP,%Closest%.Diff_ms_pub_premsold);
    Count_Diff_ms_pub_autornwl := COUNT(GROUP,%Closest%.Diff_ms_pub_autornwl);
    Count_Diff_ms_pub_avgterm := COUNT(GROUP,%Closest%.Diff_ms_pub_avgterm);
    Count_Diff_ms_pub_lmos := COUNT(GROUP,%Closest%.Diff_ms_pub_lmos);
    Count_Diff_ms_pub_omos := COUNT(GROUP,%Closest%.Diff_ms_pub_omos);
    Count_Diff_ms_pub_pmos := COUNT(GROUP,%Closest%.Diff_ms_pub_pmos);
    Count_Diff_ms_pub_cemos := COUNT(GROUP,%Closest%.Diff_ms_pub_cemos);
    Count_Diff_ms_pub_femos := COUNT(GROUP,%Closest%.Diff_ms_pub_femos);
    Count_Diff_ms_pub_totords := COUNT(GROUP,%Closest%.Diff_ms_pub_totords);
    Count_Diff_ms_pub_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_pub_totdlrs);
    Count_Diff_ms_pub_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_pub_avgdlrs);
    Count_Diff_ms_pub_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_pub_lastdlrs);
    Count_Diff_ms_pub_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_pub_paystat_paid);
    Count_Diff_ms_pub_paystat_ub := COUNT(GROUP,%Closest%.Diff_ms_pub_paystat_ub);
    Count_Diff_ms_pub_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_pub_paymeth_cc);
    Count_Diff_ms_pub_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_pub_paymeth_cash);
    Count_Diff_ms_pub_payspeed := COUNT(GROUP,%Closest%.Diff_ms_pub_payspeed);
    Count_Diff_ms_pub_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_dm);
    Count_Diff_ms_pub_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_dm);
    Count_Diff_ms_pub_osrc_agt_cashf := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_agt_cashf);
    Count_Diff_ms_pub_lsrc_agt_cashf := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_agt_cashf);
    Count_Diff_ms_pub_osrc_agt_pds := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_agt_pds);
    Count_Diff_ms_pub_lsrc_agt_pds := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_agt_pds);
    Count_Diff_ms_pub_osrc_agt_schplan := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_agt_schplan);
    Count_Diff_ms_pub_lsrc_agt_schplan := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_agt_schplan);
    Count_Diff_ms_pub_osrc_agt_sponsor := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_agt_sponsor);
    Count_Diff_ms_pub_lsrc_agt_sponsor := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_agt_sponsor);
    Count_Diff_ms_pub_osrc_agt_tm := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_agt_tm);
    Count_Diff_ms_pub_lsrc_agt_tm := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_agt_tm);
    Count_Diff_ms_pub_osrc_agt := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_agt);
    Count_Diff_ms_pub_lsrc_agt := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_agt);
    Count_Diff_ms_pub_osrc_tm := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_tm);
    Count_Diff_ms_pub_lsrc_tm := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_tm);
    Count_Diff_ms_pub_osrc_ins := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_ins);
    Count_Diff_ms_pub_lsrc_ins := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_ins);
    Count_Diff_ms_pub_osrc_net := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_net);
    Count_Diff_ms_pub_lsrc_net := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_net);
    Count_Diff_ms_pub_osrc_print := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_print);
    Count_Diff_ms_pub_lsrc_print := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_print);
    Count_Diff_ms_pub_osrc_trans := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_trans);
    Count_Diff_ms_pub_lsrc_trans := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_trans);
    Count_Diff_ms_pub_osrc_tv := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_tv);
    Count_Diff_ms_pub_lsrc_tv := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_tv);
    Count_Diff_ms_pub_osrc_dtp := COUNT(GROUP,%Closest%.Diff_ms_pub_osrc_dtp);
    Count_Diff_ms_pub_lsrc_dtp := COUNT(GROUP,%Closest%.Diff_ms_pub_lsrc_dtp);
    Count_Diff_ms_pub_giftgivr := COUNT(GROUP,%Closest%.Diff_ms_pub_giftgivr);
    Count_Diff_ms_pub_giftee := COUNT(GROUP,%Closest%.Diff_ms_pub_giftee);
    Count_Diff_ms_catalog := COUNT(GROUP,%Closest%.Diff_ms_catalog);
    Count_Diff_ms_cat_lmos := COUNT(GROUP,%Closest%.Diff_ms_cat_lmos);
    Count_Diff_ms_cat_omos := COUNT(GROUP,%Closest%.Diff_ms_cat_omos);
    Count_Diff_ms_cat_pmos := COUNT(GROUP,%Closest%.Diff_ms_cat_pmos);
    Count_Diff_ms_cat_totords := COUNT(GROUP,%Closest%.Diff_ms_cat_totords);
    Count_Diff_ms_cat_totitems := COUNT(GROUP,%Closest%.Diff_ms_cat_totitems);
    Count_Diff_ms_cat_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_cat_totdlrs);
    Count_Diff_ms_cat_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_cat_avgdlrs);
    Count_Diff_ms_cat_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_cat_lastdlrs);
    Count_Diff_ms_cat_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_cat_paystat_paid);
    Count_Diff_ms_cat_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_cat_paymeth_cc);
    Count_Diff_ms_cat_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_cat_paymeth_cash);
    Count_Diff_ms_cat_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_cat_osrc_dm);
    Count_Diff_ms_cat_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_cat_lsrc_dm);
    Count_Diff_ms_cat_osrc_net := COUNT(GROUP,%Closest%.Diff_ms_cat_osrc_net);
    Count_Diff_ms_cat_lsrc_net := COUNT(GROUP,%Closest%.Diff_ms_cat_lsrc_net);
    Count_Diff_ms_cat_giftgivr := COUNT(GROUP,%Closest%.Diff_ms_cat_giftgivr);
    Count_Diff_pkpubs_corrected := COUNT(GROUP,%Closest%.Diff_pkpubs_corrected);
    Count_Diff_pkcatg_corrected := COUNT(GROUP,%Closest%.Diff_pkcatg_corrected);
    Count_Diff_ms_fundraising := COUNT(GROUP,%Closest%.Diff_ms_fundraising);
    Count_Diff_ms_fund_lmos := COUNT(GROUP,%Closest%.Diff_ms_fund_lmos);
    Count_Diff_ms_fund_omos := COUNT(GROUP,%Closest%.Diff_ms_fund_omos);
    Count_Diff_ms_fund_pmos := COUNT(GROUP,%Closest%.Diff_ms_fund_pmos);
    Count_Diff_ms_fund_totords := COUNT(GROUP,%Closest%.Diff_ms_fund_totords);
    Count_Diff_ms_fund_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_fund_totdlrs);
    Count_Diff_ms_fund_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_fund_avgdlrs);
    Count_Diff_ms_fund_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_fund_lastdlrs);
    Count_Diff_ms_fund_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_fund_paystat_paid);
    Count_Diff_ms_other := COUNT(GROUP,%Closest%.Diff_ms_other);
    Count_Diff_ms_continuity := COUNT(GROUP,%Closest%.Diff_ms_continuity);
    Count_Diff_ms_cont_status_active := COUNT(GROUP,%Closest%.Diff_ms_cont_status_active);
    Count_Diff_ms_cont_status_cancel := COUNT(GROUP,%Closest%.Diff_ms_cont_status_cancel);
    Count_Diff_ms_cont_omos := COUNT(GROUP,%Closest%.Diff_ms_cont_omos);
    Count_Diff_ms_cont_lmos := COUNT(GROUP,%Closest%.Diff_ms_cont_lmos);
    Count_Diff_ms_cont_pmos := COUNT(GROUP,%Closest%.Diff_ms_cont_pmos);
    Count_Diff_ms_cont_totords := COUNT(GROUP,%Closest%.Diff_ms_cont_totords);
    Count_Diff_ms_cont_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_cont_totdlrs);
    Count_Diff_ms_cont_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_cont_avgdlrs);
    Count_Diff_ms_cont_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_cont_lastdlrs);
    Count_Diff_ms_cont_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_cont_paystat_paid);
    Count_Diff_ms_cont_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_cont_paymeth_cc);
    Count_Diff_ms_cont_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_cont_paymeth_cash);
    Count_Diff_ms_totords := COUNT(GROUP,%Closest%.Diff_ms_totords);
    Count_Diff_ms_totitems := COUNT(GROUP,%Closest%.Diff_ms_totitems);
    Count_Diff_ms_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_totdlrs);
    Count_Diff_ms_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_avgdlrs);
    Count_Diff_ms_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_lastdlrs);
    Count_Diff_ms_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_paystat_paid);
    Count_Diff_ms_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_paymeth_cc);
    Count_Diff_ms_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_paymeth_cash);
    Count_Diff_ms_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_osrc_dm);
    Count_Diff_ms_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_lsrc_dm);
    Count_Diff_ms_osrc_tm := COUNT(GROUP,%Closest%.Diff_ms_osrc_tm);
    Count_Diff_ms_lsrc_tm := COUNT(GROUP,%Closest%.Diff_ms_lsrc_tm);
    Count_Diff_ms_osrc_ins := COUNT(GROUP,%Closest%.Diff_ms_osrc_ins);
    Count_Diff_ms_lsrc_ins := COUNT(GROUP,%Closest%.Diff_ms_lsrc_ins);
    Count_Diff_ms_osrc_net := COUNT(GROUP,%Closest%.Diff_ms_osrc_net);
    Count_Diff_ms_lsrc_net := COUNT(GROUP,%Closest%.Diff_ms_lsrc_net);
    Count_Diff_ms_osrc_tv := COUNT(GROUP,%Closest%.Diff_ms_osrc_tv);
    Count_Diff_ms_lsrc_tv := COUNT(GROUP,%Closest%.Diff_ms_lsrc_tv);
    Count_Diff_ms_osrc_retail := COUNT(GROUP,%Closest%.Diff_ms_osrc_retail);
    Count_Diff_ms_lsrc_retail := COUNT(GROUP,%Closest%.Diff_ms_lsrc_retail);
    Count_Diff_ms_giftgivr := COUNT(GROUP,%Closest%.Diff_ms_giftgivr);
    Count_Diff_ms_giftee := COUNT(GROUP,%Closest%.Diff_ms_giftee);
    Count_Diff_ms_adult := COUNT(GROUP,%Closest%.Diff_ms_adult);
    Count_Diff_ms_womapp := COUNT(GROUP,%Closest%.Diff_ms_womapp);
    Count_Diff_ms_menapp := COUNT(GROUP,%Closest%.Diff_ms_menapp);
    Count_Diff_ms_kidapp := COUNT(GROUP,%Closest%.Diff_ms_kidapp);
    Count_Diff_ms_accessory := COUNT(GROUP,%Closest%.Diff_ms_accessory);
    Count_Diff_ms_apparel := COUNT(GROUP,%Closest%.Diff_ms_apparel);
    Count_Diff_ms_app_lmos := COUNT(GROUP,%Closest%.Diff_ms_app_lmos);
    Count_Diff_ms_app_omos := COUNT(GROUP,%Closest%.Diff_ms_app_omos);
    Count_Diff_ms_app_pmos := COUNT(GROUP,%Closest%.Diff_ms_app_pmos);
    Count_Diff_ms_app_totords := COUNT(GROUP,%Closest%.Diff_ms_app_totords);
    Count_Diff_ms_app_totitems := COUNT(GROUP,%Closest%.Diff_ms_app_totitems);
    Count_Diff_ms_app_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_app_totdlrs);
    Count_Diff_ms_app_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_app_avgdlrs);
    Count_Diff_ms_app_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_app_lastdlrs);
    Count_Diff_ms_app_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_app_paystat_paid);
    Count_Diff_ms_app_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_app_paymeth_cc);
    Count_Diff_ms_app_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_app_paymeth_cash);
    Count_Diff_ms_menfash := COUNT(GROUP,%Closest%.Diff_ms_menfash);
    Count_Diff_ms_womfash := COUNT(GROUP,%Closest%.Diff_ms_womfash);
    Count_Diff_ms_wfsh_lmos := COUNT(GROUP,%Closest%.Diff_ms_wfsh_lmos);
    Count_Diff_ms_wfsh_omos := COUNT(GROUP,%Closest%.Diff_ms_wfsh_omos);
    Count_Diff_ms_wfsh_pmos := COUNT(GROUP,%Closest%.Diff_ms_wfsh_pmos);
    Count_Diff_ms_wfsh_totords := COUNT(GROUP,%Closest%.Diff_ms_wfsh_totords);
    Count_Diff_ms_wfsh_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_wfsh_totdlrs);
    Count_Diff_ms_wfsh_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_wfsh_avgdlrs);
    Count_Diff_ms_wfsh_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_wfsh_lastdlrs);
    Count_Diff_ms_wfsh_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_wfsh_paystat_paid);
    Count_Diff_ms_wfsh_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_wfsh_osrc_dm);
    Count_Diff_ms_wfsh_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_wfsh_lsrc_dm);
    Count_Diff_ms_wfsh_osrc_agt := COUNT(GROUP,%Closest%.Diff_ms_wfsh_osrc_agt);
    Count_Diff_ms_wfsh_lsrc_agt := COUNT(GROUP,%Closest%.Diff_ms_wfsh_lsrc_agt);
    Count_Diff_ms_audio := COUNT(GROUP,%Closest%.Diff_ms_audio);
    Count_Diff_ms_auto := COUNT(GROUP,%Closest%.Diff_ms_auto);
    Count_Diff_ms_aviation := COUNT(GROUP,%Closest%.Diff_ms_aviation);
    Count_Diff_ms_bargains := COUNT(GROUP,%Closest%.Diff_ms_bargains);
    Count_Diff_ms_beauty := COUNT(GROUP,%Closest%.Diff_ms_beauty);
    Count_Diff_ms_bible := COUNT(GROUP,%Closest%.Diff_ms_bible);
    Count_Diff_ms_bible_lmos := COUNT(GROUP,%Closest%.Diff_ms_bible_lmos);
    Count_Diff_ms_bible_omos := COUNT(GROUP,%Closest%.Diff_ms_bible_omos);
    Count_Diff_ms_bible_pmos := COUNT(GROUP,%Closest%.Diff_ms_bible_pmos);
    Count_Diff_ms_bible_totords := COUNT(GROUP,%Closest%.Diff_ms_bible_totords);
    Count_Diff_ms_bible_totitems := COUNT(GROUP,%Closest%.Diff_ms_bible_totitems);
    Count_Diff_ms_bible_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_bible_totdlrs);
    Count_Diff_ms_bible_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_bible_avgdlrs);
    Count_Diff_ms_bible_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_bible_lastdlrs);
    Count_Diff_ms_bible_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_bible_paystat_paid);
    Count_Diff_ms_bible_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_bible_paymeth_cc);
    Count_Diff_ms_bible_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_bible_paymeth_cash);
    Count_Diff_ms_business := COUNT(GROUP,%Closest%.Diff_ms_business);
    Count_Diff_ms_collectibles := COUNT(GROUP,%Closest%.Diff_ms_collectibles);
    Count_Diff_ms_computers := COUNT(GROUP,%Closest%.Diff_ms_computers);
    Count_Diff_ms_crafts := COUNT(GROUP,%Closest%.Diff_ms_crafts);
    Count_Diff_ms_culturearts := COUNT(GROUP,%Closest%.Diff_ms_culturearts);
    Count_Diff_ms_currevent := COUNT(GROUP,%Closest%.Diff_ms_currevent);
    Count_Diff_ms_diy := COUNT(GROUP,%Closest%.Diff_ms_diy);
    Count_Diff_ms_electronics := COUNT(GROUP,%Closest%.Diff_ms_electronics);
    Count_Diff_ms_equestrian := COUNT(GROUP,%Closest%.Diff_ms_equestrian);
    Count_Diff_ms_pub_family := COUNT(GROUP,%Closest%.Diff_ms_pub_family);
    Count_Diff_ms_cat_family := COUNT(GROUP,%Closest%.Diff_ms_cat_family);
    Count_Diff_ms_family := COUNT(GROUP,%Closest%.Diff_ms_family);
    Count_Diff_ms_family_lmos := COUNT(GROUP,%Closest%.Diff_ms_family_lmos);
    Count_Diff_ms_family_omos := COUNT(GROUP,%Closest%.Diff_ms_family_omos);
    Count_Diff_ms_family_pmos := COUNT(GROUP,%Closest%.Diff_ms_family_pmos);
    Count_Diff_ms_family_totords := COUNT(GROUP,%Closest%.Diff_ms_family_totords);
    Count_Diff_ms_family_totitems := COUNT(GROUP,%Closest%.Diff_ms_family_totitems);
    Count_Diff_ms_family_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_family_totdlrs);
    Count_Diff_ms_family_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_family_avgdlrs);
    Count_Diff_ms_family_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_family_lastdlrs);
    Count_Diff_ms_family_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_family_paystat_paid);
    Count_Diff_ms_family_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_family_paymeth_cc);
    Count_Diff_ms_family_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_family_paymeth_cash);
    Count_Diff_ms_family_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_family_osrc_dm);
    Count_Diff_ms_family_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_family_lsrc_dm);
    Count_Diff_ms_fiction := COUNT(GROUP,%Closest%.Diff_ms_fiction);
    Count_Diff_ms_food := COUNT(GROUP,%Closest%.Diff_ms_food);
    Count_Diff_ms_games := COUNT(GROUP,%Closest%.Diff_ms_games);
    Count_Diff_ms_gifts := COUNT(GROUP,%Closest%.Diff_ms_gifts);
    Count_Diff_ms_gourmet := COUNT(GROUP,%Closest%.Diff_ms_gourmet);
    Count_Diff_ms_fitness := COUNT(GROUP,%Closest%.Diff_ms_fitness);
    Count_Diff_ms_health := COUNT(GROUP,%Closest%.Diff_ms_health);
    Count_Diff_ms_hlth_lmos := COUNT(GROUP,%Closest%.Diff_ms_hlth_lmos);
    Count_Diff_ms_hlth_omos := COUNT(GROUP,%Closest%.Diff_ms_hlth_omos);
    Count_Diff_ms_hlth_pmos := COUNT(GROUP,%Closest%.Diff_ms_hlth_pmos);
    Count_Diff_ms_hlth_totords := COUNT(GROUP,%Closest%.Diff_ms_hlth_totords);
    Count_Diff_ms_hlth_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_hlth_totdlrs);
    Count_Diff_ms_hlth_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_hlth_avgdlrs);
    Count_Diff_ms_hlth_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_hlth_lastdlrs);
    Count_Diff_ms_hlth_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_hlth_paystat_paid);
    Count_Diff_ms_hlth_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_hlth_paymeth_cc);
    Count_Diff_ms_hlth_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_hlth_osrc_dm);
    Count_Diff_ms_hlth_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_hlth_lsrc_dm);
    Count_Diff_ms_hlth_osrc_agt := COUNT(GROUP,%Closest%.Diff_ms_hlth_osrc_agt);
    Count_Diff_ms_hlth_lsrc_agt := COUNT(GROUP,%Closest%.Diff_ms_hlth_lsrc_agt);
    Count_Diff_ms_hlth_osrc_tv := COUNT(GROUP,%Closest%.Diff_ms_hlth_osrc_tv);
    Count_Diff_ms_hlth_lsrc_tv := COUNT(GROUP,%Closest%.Diff_ms_hlth_lsrc_tv);
    Count_Diff_ms_holiday := COUNT(GROUP,%Closest%.Diff_ms_holiday);
    Count_Diff_ms_history := COUNT(GROUP,%Closest%.Diff_ms_history);
    Count_Diff_ms_pub_cooking := COUNT(GROUP,%Closest%.Diff_ms_pub_cooking);
    Count_Diff_ms_cooking := COUNT(GROUP,%Closest%.Diff_ms_cooking);
    Count_Diff_ms_pub_homedecr := COUNT(GROUP,%Closest%.Diff_ms_pub_homedecr);
    Count_Diff_ms_cat_homedecr := COUNT(GROUP,%Closest%.Diff_ms_cat_homedecr);
    Count_Diff_ms_homedecr := COUNT(GROUP,%Closest%.Diff_ms_homedecr);
    Count_Diff_ms_housewares := COUNT(GROUP,%Closest%.Diff_ms_housewares);
    Count_Diff_ms_pub_garden := COUNT(GROUP,%Closest%.Diff_ms_pub_garden);
    Count_Diff_ms_cat_garden := COUNT(GROUP,%Closest%.Diff_ms_cat_garden);
    Count_Diff_ms_garden := COUNT(GROUP,%Closest%.Diff_ms_garden);
    Count_Diff_ms_pub_homeliv := COUNT(GROUP,%Closest%.Diff_ms_pub_homeliv);
    Count_Diff_ms_cat_homeliv := COUNT(GROUP,%Closest%.Diff_ms_cat_homeliv);
    Count_Diff_ms_homeliv := COUNT(GROUP,%Closest%.Diff_ms_homeliv);
    Count_Diff_ms_pub_home_status_active := COUNT(GROUP,%Closest%.Diff_ms_pub_home_status_active);
    Count_Diff_ms_home_lmos := COUNT(GROUP,%Closest%.Diff_ms_home_lmos);
    Count_Diff_ms_home_omos := COUNT(GROUP,%Closest%.Diff_ms_home_omos);
    Count_Diff_ms_home_pmos := COUNT(GROUP,%Closest%.Diff_ms_home_pmos);
    Count_Diff_ms_home_totords := COUNT(GROUP,%Closest%.Diff_ms_home_totords);
    Count_Diff_ms_home_totitems := COUNT(GROUP,%Closest%.Diff_ms_home_totitems);
    Count_Diff_ms_home_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_home_totdlrs);
    Count_Diff_ms_home_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_home_avgdlrs);
    Count_Diff_ms_home_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_home_lastdlrs);
    Count_Diff_ms_home_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_home_paystat_paid);
    Count_Diff_ms_home_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_home_paymeth_cc);
    Count_Diff_ms_home_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_home_paymeth_cash);
    Count_Diff_ms_home_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_home_osrc_dm);
    Count_Diff_ms_home_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_home_lsrc_dm);
    Count_Diff_ms_home_osrc_agt := COUNT(GROUP,%Closest%.Diff_ms_home_osrc_agt);
    Count_Diff_ms_home_lsrc_agt := COUNT(GROUP,%Closest%.Diff_ms_home_lsrc_agt);
    Count_Diff_ms_home_osrc_net := COUNT(GROUP,%Closest%.Diff_ms_home_osrc_net);
    Count_Diff_ms_home_lsrc_net := COUNT(GROUP,%Closest%.Diff_ms_home_lsrc_net);
    Count_Diff_ms_home_osrc_tv := COUNT(GROUP,%Closest%.Diff_ms_home_osrc_tv);
    Count_Diff_ms_home_lsrc_tv := COUNT(GROUP,%Closest%.Diff_ms_home_lsrc_tv);
    Count_Diff_ms_humor := COUNT(GROUP,%Closest%.Diff_ms_humor);
    Count_Diff_ms_inspiration := COUNT(GROUP,%Closest%.Diff_ms_inspiration);
    Count_Diff_ms_merchandise := COUNT(GROUP,%Closest%.Diff_ms_merchandise);
    Count_Diff_ms_moneymaking := COUNT(GROUP,%Closest%.Diff_ms_moneymaking);
    Count_Diff_ms_moneymaking_lmos := COUNT(GROUP,%Closest%.Diff_ms_moneymaking_lmos);
    Count_Diff_ms_motorcycles := COUNT(GROUP,%Closest%.Diff_ms_motorcycles);
    Count_Diff_ms_music := COUNT(GROUP,%Closest%.Diff_ms_music);
    Count_Diff_ms_fishing := COUNT(GROUP,%Closest%.Diff_ms_fishing);
    Count_Diff_ms_hunting := COUNT(GROUP,%Closest%.Diff_ms_hunting);
    Count_Diff_ms_boatsail := COUNT(GROUP,%Closest%.Diff_ms_boatsail);
    Count_Diff_ms_camp := COUNT(GROUP,%Closest%.Diff_ms_camp);
    Count_Diff_ms_pub_outdoors := COUNT(GROUP,%Closest%.Diff_ms_pub_outdoors);
    Count_Diff_ms_cat_outdoors := COUNT(GROUP,%Closest%.Diff_ms_cat_outdoors);
    Count_Diff_ms_outdoors := COUNT(GROUP,%Closest%.Diff_ms_outdoors);
    Count_Diff_ms_pub_out_status_active := COUNT(GROUP,%Closest%.Diff_ms_pub_out_status_active);
    Count_Diff_ms_out_lmos := COUNT(GROUP,%Closest%.Diff_ms_out_lmos);
    Count_Diff_ms_out_omos := COUNT(GROUP,%Closest%.Diff_ms_out_omos);
    Count_Diff_ms_out_pmos := COUNT(GROUP,%Closest%.Diff_ms_out_pmos);
    Count_Diff_ms_out_totords := COUNT(GROUP,%Closest%.Diff_ms_out_totords);
    Count_Diff_ms_out_totitems := COUNT(GROUP,%Closest%.Diff_ms_out_totitems);
    Count_Diff_ms_out_totdlrs := COUNT(GROUP,%Closest%.Diff_ms_out_totdlrs);
    Count_Diff_ms_out_avgdlrs := COUNT(GROUP,%Closest%.Diff_ms_out_avgdlrs);
    Count_Diff_ms_out_lastdlrs := COUNT(GROUP,%Closest%.Diff_ms_out_lastdlrs);
    Count_Diff_ms_out_paystat_paid := COUNT(GROUP,%Closest%.Diff_ms_out_paystat_paid);
    Count_Diff_ms_out_paymeth_cc := COUNT(GROUP,%Closest%.Diff_ms_out_paymeth_cc);
    Count_Diff_ms_out_paymeth_cash := COUNT(GROUP,%Closest%.Diff_ms_out_paymeth_cash);
    Count_Diff_ms_out_osrc_dm := COUNT(GROUP,%Closest%.Diff_ms_out_osrc_dm);
    Count_Diff_ms_out_lsrc_dm := COUNT(GROUP,%Closest%.Diff_ms_out_lsrc_dm);
    Count_Diff_ms_out_osrc_agt := COUNT(GROUP,%Closest%.Diff_ms_out_osrc_agt);
    Count_Diff_ms_out_lsrc_agt := COUNT(GROUP,%Closest%.Diff_ms_out_lsrc_agt);
    Count_Diff_ms_pets := COUNT(GROUP,%Closest%.Diff_ms_pets);
    Count_Diff_ms_pfin := COUNT(GROUP,%Closest%.Diff_ms_pfin);
    Count_Diff_ms_photo := COUNT(GROUP,%Closest%.Diff_ms_photo);
    Count_Diff_ms_photoproc := COUNT(GROUP,%Closest%.Diff_ms_photoproc);
    Count_Diff_ms_rural := COUNT(GROUP,%Closest%.Diff_ms_rural);
    Count_Diff_ms_science := COUNT(GROUP,%Closest%.Diff_ms_science);
    Count_Diff_ms_sports := COUNT(GROUP,%Closest%.Diff_ms_sports);
    Count_Diff_ms_sports_lmos := COUNT(GROUP,%Closest%.Diff_ms_sports_lmos);
    Count_Diff_ms_travel := COUNT(GROUP,%Closest%.Diff_ms_travel);
    Count_Diff_ms_tvmovies := COUNT(GROUP,%Closest%.Diff_ms_tvmovies);
    Count_Diff_ms_wildlife := COUNT(GROUP,%Closest%.Diff_ms_wildlife);
    Count_Diff_ms_woman := COUNT(GROUP,%Closest%.Diff_ms_woman);
    Count_Diff_ms_woman_lmos := COUNT(GROUP,%Closest%.Diff_ms_woman_lmos);
    Count_Diff_ms_ringtones_apps := COUNT(GROUP,%Closest%.Diff_ms_ringtones_apps);
    Count_Diff_cpi_mobile_apps_index := COUNT(GROUP,%Closest%.Diff_cpi_mobile_apps_index);
    Count_Diff_cpi_credit_repair_index := COUNT(GROUP,%Closest%.Diff_cpi_credit_repair_index);
    Count_Diff_cpi_credit_report_index := COUNT(GROUP,%Closest%.Diff_cpi_credit_report_index);
    Count_Diff_cpi_education_seekers_index := COUNT(GROUP,%Closest%.Diff_cpi_education_seekers_index);
    Count_Diff_cpi_insurance_index := COUNT(GROUP,%Closest%.Diff_cpi_insurance_index);
    Count_Diff_cpi_insurance_health_index := COUNT(GROUP,%Closest%.Diff_cpi_insurance_health_index);
    Count_Diff_cpi_insurance_auto_index := COUNT(GROUP,%Closest%.Diff_cpi_insurance_auto_index);
    Count_Diff_cpi_job_seekers_index := COUNT(GROUP,%Closest%.Diff_cpi_job_seekers_index);
    Count_Diff_cpi_social_networking_index := COUNT(GROUP,%Closest%.Diff_cpi_social_networking_index);
    Count_Diff_cpi_adult_index := COUNT(GROUP,%Closest%.Diff_cpi_adult_index);
    Count_Diff_cpi_africanamerican_index := COUNT(GROUP,%Closest%.Diff_cpi_africanamerican_index);
    Count_Diff_cpi_apparel_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_index);
    Count_Diff_cpi_apparel_accessory_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_accessory_index);
    Count_Diff_cpi_apparel_kids_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_kids_index);
    Count_Diff_cpi_apparel_men_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_men_index);
    Count_Diff_cpi_apparel_menfash_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_menfash_index);
    Count_Diff_cpi_apparel_women_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_women_index);
    Count_Diff_cpi_apparel_womfash_index := COUNT(GROUP,%Closest%.Diff_cpi_apparel_womfash_index);
    Count_Diff_cpi_asian_index := COUNT(GROUP,%Closest%.Diff_cpi_asian_index);
    Count_Diff_cpi_auto_index := COUNT(GROUP,%Closest%.Diff_cpi_auto_index);
    Count_Diff_cpi_auto_racing_index := COUNT(GROUP,%Closest%.Diff_cpi_auto_racing_index);
    Count_Diff_cpi_auto_trucks_index := COUNT(GROUP,%Closest%.Diff_cpi_auto_trucks_index);
    Count_Diff_cpi_aviation_index := COUNT(GROUP,%Closest%.Diff_cpi_aviation_index);
    Count_Diff_cpi_bargains_index := COUNT(GROUP,%Closest%.Diff_cpi_bargains_index);
    Count_Diff_cpi_beauty_index := COUNT(GROUP,%Closest%.Diff_cpi_beauty_index);
    Count_Diff_cpi_bible_index := COUNT(GROUP,%Closest%.Diff_cpi_bible_index);
    Count_Diff_cpi_birds_index := COUNT(GROUP,%Closest%.Diff_cpi_birds_index);
    Count_Diff_cpi_business_index := COUNT(GROUP,%Closest%.Diff_cpi_business_index);
    Count_Diff_cpi_business_homeoffice_index := COUNT(GROUP,%Closest%.Diff_cpi_business_homeoffice_index);
    Count_Diff_cpi_catalog_index := COUNT(GROUP,%Closest%.Diff_cpi_catalog_index);
    Count_Diff_cpi_cc_index := COUNT(GROUP,%Closest%.Diff_cpi_cc_index);
    Count_Diff_cpi_collectibles_index := COUNT(GROUP,%Closest%.Diff_cpi_collectibles_index);
    Count_Diff_cpi_college_index := COUNT(GROUP,%Closest%.Diff_cpi_college_index);
    Count_Diff_cpi_computers_index := COUNT(GROUP,%Closest%.Diff_cpi_computers_index);
    Count_Diff_cpi_conservative_index := COUNT(GROUP,%Closest%.Diff_cpi_conservative_index);
    Count_Diff_cpi_continuity_index := COUNT(GROUP,%Closest%.Diff_cpi_continuity_index);
    Count_Diff_cpi_cooking_index := COUNT(GROUP,%Closest%.Diff_cpi_cooking_index);
    Count_Diff_cpi_crafts_index := COUNT(GROUP,%Closest%.Diff_cpi_crafts_index);
    Count_Diff_cpi_crafts_crochet_index := COUNT(GROUP,%Closest%.Diff_cpi_crafts_crochet_index);
    Count_Diff_cpi_crafts_knit_index := COUNT(GROUP,%Closest%.Diff_cpi_crafts_knit_index);
    Count_Diff_cpi_crafts_needlepoint_index := COUNT(GROUP,%Closest%.Diff_cpi_crafts_needlepoint_index);
    Count_Diff_cpi_crafts_quilt_index := COUNT(GROUP,%Closest%.Diff_cpi_crafts_quilt_index);
    Count_Diff_cpi_crafts_sew_index := COUNT(GROUP,%Closest%.Diff_cpi_crafts_sew_index);
    Count_Diff_cpi_culturearts_index := COUNT(GROUP,%Closest%.Diff_cpi_culturearts_index);
    Count_Diff_cpi_currevent_index := COUNT(GROUP,%Closest%.Diff_cpi_currevent_index);
    Count_Diff_cpi_diy_index := COUNT(GROUP,%Closest%.Diff_cpi_diy_index);
    Count_Diff_cpi_donor_index := COUNT(GROUP,%Closest%.Diff_cpi_donor_index);
    Count_Diff_cpi_ego_index := COUNT(GROUP,%Closest%.Diff_cpi_ego_index);
    Count_Diff_cpi_electronics_index := COUNT(GROUP,%Closest%.Diff_cpi_electronics_index);
    Count_Diff_cpi_equestrian_index := COUNT(GROUP,%Closest%.Diff_cpi_equestrian_index);
    Count_Diff_cpi_family_index := COUNT(GROUP,%Closest%.Diff_cpi_family_index);
    Count_Diff_cpi_family_teen_index := COUNT(GROUP,%Closest%.Diff_cpi_family_teen_index);
    Count_Diff_cpi_family_young_index := COUNT(GROUP,%Closest%.Diff_cpi_family_young_index);
    Count_Diff_cpi_fiction_index := COUNT(GROUP,%Closest%.Diff_cpi_fiction_index);
    Count_Diff_cpi_gambling_index := COUNT(GROUP,%Closest%.Diff_cpi_gambling_index);
    Count_Diff_cpi_games_index := COUNT(GROUP,%Closest%.Diff_cpi_games_index);
    Count_Diff_cpi_gardening_index := COUNT(GROUP,%Closest%.Diff_cpi_gardening_index);
    Count_Diff_cpi_gay_index := COUNT(GROUP,%Closest%.Diff_cpi_gay_index);
    Count_Diff_cpi_giftgivr_index := COUNT(GROUP,%Closest%.Diff_cpi_giftgivr_index);
    Count_Diff_cpi_gourmet_index := COUNT(GROUP,%Closest%.Diff_cpi_gourmet_index);
    Count_Diff_cpi_grandparents_index := COUNT(GROUP,%Closest%.Diff_cpi_grandparents_index);
    Count_Diff_cpi_health_index := COUNT(GROUP,%Closest%.Diff_cpi_health_index);
    Count_Diff_cpi_health_diet_index := COUNT(GROUP,%Closest%.Diff_cpi_health_diet_index);
    Count_Diff_cpi_health_fitness_index := COUNT(GROUP,%Closest%.Diff_cpi_health_fitness_index);
    Count_Diff_cpi_hightech_index := COUNT(GROUP,%Closest%.Diff_cpi_hightech_index);
    Count_Diff_cpi_hispanic_index := COUNT(GROUP,%Closest%.Diff_cpi_hispanic_index);
    Count_Diff_cpi_history_index := COUNT(GROUP,%Closest%.Diff_cpi_history_index);
    Count_Diff_cpi_history_american_index := COUNT(GROUP,%Closest%.Diff_cpi_history_american_index);
    Count_Diff_cpi_hobbies_index := COUNT(GROUP,%Closest%.Diff_cpi_hobbies_index);
    Count_Diff_cpi_homedecr_index := COUNT(GROUP,%Closest%.Diff_cpi_homedecr_index);
    Count_Diff_cpi_homeliv_index := COUNT(GROUP,%Closest%.Diff_cpi_homeliv_index);
    Count_Diff_cpi_humor_index := COUNT(GROUP,%Closest%.Diff_cpi_humor_index);
    Count_Diff_cpi_inspiration_index := COUNT(GROUP,%Closest%.Diff_cpi_inspiration_index);
    Count_Diff_cpi_internet_index := COUNT(GROUP,%Closest%.Diff_cpi_internet_index);
    Count_Diff_cpi_internet_access_index := COUNT(GROUP,%Closest%.Diff_cpi_internet_access_index);
    Count_Diff_cpi_internet_buy_index := COUNT(GROUP,%Closest%.Diff_cpi_internet_buy_index);
    Count_Diff_cpi_liberal_index := COUNT(GROUP,%Closest%.Diff_cpi_liberal_index);
    Count_Diff_cpi_moneymaking_index := COUNT(GROUP,%Closest%.Diff_cpi_moneymaking_index);
    Count_Diff_cpi_motorcycles_index := COUNT(GROUP,%Closest%.Diff_cpi_motorcycles_index);
    Count_Diff_cpi_music_index := COUNT(GROUP,%Closest%.Diff_cpi_music_index);
    Count_Diff_cpi_nonfiction_index := COUNT(GROUP,%Closest%.Diff_cpi_nonfiction_index);
    Count_Diff_cpi_ocean_index := COUNT(GROUP,%Closest%.Diff_cpi_ocean_index);
    Count_Diff_cpi_outdoors_index := COUNT(GROUP,%Closest%.Diff_cpi_outdoors_index);
    Count_Diff_cpi_outdoors_boatsail_index := COUNT(GROUP,%Closest%.Diff_cpi_outdoors_boatsail_index);
    Count_Diff_cpi_outdoors_camp_index := COUNT(GROUP,%Closest%.Diff_cpi_outdoors_camp_index);
    Count_Diff_cpi_outdoors_fishing_index := COUNT(GROUP,%Closest%.Diff_cpi_outdoors_fishing_index);
    Count_Diff_cpi_outdoors_huntfish_index := COUNT(GROUP,%Closest%.Diff_cpi_outdoors_huntfish_index);
    Count_Diff_cpi_outdoors_hunting_index := COUNT(GROUP,%Closest%.Diff_cpi_outdoors_hunting_index);
    Count_Diff_cpi_pets_index := COUNT(GROUP,%Closest%.Diff_cpi_pets_index);
    Count_Diff_cpi_pets_cats_index := COUNT(GROUP,%Closest%.Diff_cpi_pets_cats_index);
    Count_Diff_cpi_pets_dogs_index := COUNT(GROUP,%Closest%.Diff_cpi_pets_dogs_index);
    Count_Diff_cpi_pfin_index := COUNT(GROUP,%Closest%.Diff_cpi_pfin_index);
    Count_Diff_cpi_photog_index := COUNT(GROUP,%Closest%.Diff_cpi_photog_index);
    Count_Diff_cpi_photoproc_index := COUNT(GROUP,%Closest%.Diff_cpi_photoproc_index);
    Count_Diff_cpi_publish_index := COUNT(GROUP,%Closest%.Diff_cpi_publish_index);
    Count_Diff_cpi_publish_books_index := COUNT(GROUP,%Closest%.Diff_cpi_publish_books_index);
    Count_Diff_cpi_publish_mags_index := COUNT(GROUP,%Closest%.Diff_cpi_publish_mags_index);
    Count_Diff_cpi_rural_index := COUNT(GROUP,%Closest%.Diff_cpi_rural_index);
    Count_Diff_cpi_science_index := COUNT(GROUP,%Closest%.Diff_cpi_science_index);
    Count_Diff_cpi_scifi_index := COUNT(GROUP,%Closest%.Diff_cpi_scifi_index);
    Count_Diff_cpi_seniors_index := COUNT(GROUP,%Closest%.Diff_cpi_seniors_index);
    Count_Diff_cpi_sports_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_index);
    Count_Diff_cpi_sports_baseball_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_baseball_index);
    Count_Diff_cpi_sports_basketball_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_basketball_index);
    Count_Diff_cpi_sports_biking_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_biking_index);
    Count_Diff_cpi_sports_football_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_football_index);
    Count_Diff_cpi_sports_golf_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_golf_index);
    Count_Diff_cpi_sports_hockey_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_hockey_index);
    Count_Diff_cpi_sports_running_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_running_index);
    Count_Diff_cpi_sports_ski_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_ski_index);
    Count_Diff_cpi_sports_soccer_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_soccer_index);
    Count_Diff_cpi_sports_swimming_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_swimming_index);
    Count_Diff_cpi_sports_tennis_index := COUNT(GROUP,%Closest%.Diff_cpi_sports_tennis_index);
    Count_Diff_cpi_stationery_index := COUNT(GROUP,%Closest%.Diff_cpi_stationery_index);
    Count_Diff_cpi_sweeps_index := COUNT(GROUP,%Closest%.Diff_cpi_sweeps_index);
    Count_Diff_cpi_tobacco_index := COUNT(GROUP,%Closest%.Diff_cpi_tobacco_index);
    Count_Diff_cpi_travel_index := COUNT(GROUP,%Closest%.Diff_cpi_travel_index);
    Count_Diff_cpi_travel_cruise_index := COUNT(GROUP,%Closest%.Diff_cpi_travel_cruise_index);
    Count_Diff_cpi_travel_rv_index := COUNT(GROUP,%Closest%.Diff_cpi_travel_rv_index);
    Count_Diff_cpi_travel_us_index := COUNT(GROUP,%Closest%.Diff_cpi_travel_us_index);
    Count_Diff_cpi_tvmovies_index := COUNT(GROUP,%Closest%.Diff_cpi_tvmovies_index);
    Count_Diff_cpi_wildlife_index := COUNT(GROUP,%Closest%.Diff_cpi_wildlife_index);
    Count_Diff_cpi_woman_index := COUNT(GROUP,%Closest%.Diff_cpi_woman_index);
    Count_Diff_totdlr_index := COUNT(GROUP,%Closest%.Diff_totdlr_index);
    Count_Diff_cpi_totdlr := COUNT(GROUP,%Closest%.Diff_cpi_totdlr);
    Count_Diff_cpi_totords := COUNT(GROUP,%Closest%.Diff_cpi_totords);
    Count_Diff_cpi_lastdlr := COUNT(GROUP,%Closest%.Diff_cpi_lastdlr);
    Count_Diff_pkcatg := COUNT(GROUP,%Closest%.Diff_pkcatg);
    Count_Diff_pkpubs := COUNT(GROUP,%Closest%.Diff_pkpubs);
    Count_Diff_pkcont := COUNT(GROUP,%Closest%.Diff_pkcont);
    Count_Diff_pkca01 := COUNT(GROUP,%Closest%.Diff_pkca01);
    Count_Diff_pkca03 := COUNT(GROUP,%Closest%.Diff_pkca03);
    Count_Diff_pkca04 := COUNT(GROUP,%Closest%.Diff_pkca04);
    Count_Diff_pkca05 := COUNT(GROUP,%Closest%.Diff_pkca05);
    Count_Diff_pkca06 := COUNT(GROUP,%Closest%.Diff_pkca06);
    Count_Diff_pkca07 := COUNT(GROUP,%Closest%.Diff_pkca07);
    Count_Diff_pkca08 := COUNT(GROUP,%Closest%.Diff_pkca08);
    Count_Diff_pkca09 := COUNT(GROUP,%Closest%.Diff_pkca09);
    Count_Diff_pkca10 := COUNT(GROUP,%Closest%.Diff_pkca10);
    Count_Diff_pkca11 := COUNT(GROUP,%Closest%.Diff_pkca11);
    Count_Diff_pkca12 := COUNT(GROUP,%Closest%.Diff_pkca12);
    Count_Diff_pkca13 := COUNT(GROUP,%Closest%.Diff_pkca13);
    Count_Diff_pkca14 := COUNT(GROUP,%Closest%.Diff_pkca14);
    Count_Diff_pkca15 := COUNT(GROUP,%Closest%.Diff_pkca15);
    Count_Diff_pkca16 := COUNT(GROUP,%Closest%.Diff_pkca16);
    Count_Diff_pkca17 := COUNT(GROUP,%Closest%.Diff_pkca17);
    Count_Diff_pkca18 := COUNT(GROUP,%Closest%.Diff_pkca18);
    Count_Diff_pkca20 := COUNT(GROUP,%Closest%.Diff_pkca20);
    Count_Diff_pkca21 := COUNT(GROUP,%Closest%.Diff_pkca21);
    Count_Diff_pkca22 := COUNT(GROUP,%Closest%.Diff_pkca22);
    Count_Diff_pkca23 := COUNT(GROUP,%Closest%.Diff_pkca23);
    Count_Diff_pkca24 := COUNT(GROUP,%Closest%.Diff_pkca24);
    Count_Diff_pkca25 := COUNT(GROUP,%Closest%.Diff_pkca25);
    Count_Diff_pkca26 := COUNT(GROUP,%Closest%.Diff_pkca26);
    Count_Diff_pkca28 := COUNT(GROUP,%Closest%.Diff_pkca28);
    Count_Diff_pkca29 := COUNT(GROUP,%Closest%.Diff_pkca29);
    Count_Diff_pkca30 := COUNT(GROUP,%Closest%.Diff_pkca30);
    Count_Diff_pkca31 := COUNT(GROUP,%Closest%.Diff_pkca31);
    Count_Diff_pkca32 := COUNT(GROUP,%Closest%.Diff_pkca32);
    Count_Diff_pkca33 := COUNT(GROUP,%Closest%.Diff_pkca33);
    Count_Diff_pkca34 := COUNT(GROUP,%Closest%.Diff_pkca34);
    Count_Diff_pkca35 := COUNT(GROUP,%Closest%.Diff_pkca35);
    Count_Diff_pkca36 := COUNT(GROUP,%Closest%.Diff_pkca36);
    Count_Diff_pkca37 := COUNT(GROUP,%Closest%.Diff_pkca37);
    Count_Diff_pkca39 := COUNT(GROUP,%Closest%.Diff_pkca39);
    Count_Diff_pkca40 := COUNT(GROUP,%Closest%.Diff_pkca40);
    Count_Diff_pkca41 := COUNT(GROUP,%Closest%.Diff_pkca41);
    Count_Diff_pkca42 := COUNT(GROUP,%Closest%.Diff_pkca42);
    Count_Diff_pkca54 := COUNT(GROUP,%Closest%.Diff_pkca54);
    Count_Diff_pkca61 := COUNT(GROUP,%Closest%.Diff_pkca61);
    Count_Diff_pkca62 := COUNT(GROUP,%Closest%.Diff_pkca62);
    Count_Diff_pkca64 := COUNT(GROUP,%Closest%.Diff_pkca64);
    Count_Diff_pkpu01 := COUNT(GROUP,%Closest%.Diff_pkpu01);
    Count_Diff_pkpu02 := COUNT(GROUP,%Closest%.Diff_pkpu02);
    Count_Diff_pkpu03 := COUNT(GROUP,%Closest%.Diff_pkpu03);
    Count_Diff_pkpu04 := COUNT(GROUP,%Closest%.Diff_pkpu04);
    Count_Diff_pkpu05 := COUNT(GROUP,%Closest%.Diff_pkpu05);
    Count_Diff_pkpu06 := COUNT(GROUP,%Closest%.Diff_pkpu06);
    Count_Diff_pkpu07 := COUNT(GROUP,%Closest%.Diff_pkpu07);
    Count_Diff_pkpu08 := COUNT(GROUP,%Closest%.Diff_pkpu08);
    Count_Diff_pkpu09 := COUNT(GROUP,%Closest%.Diff_pkpu09);
    Count_Diff_pkpu10 := COUNT(GROUP,%Closest%.Diff_pkpu10);
    Count_Diff_pkpu11 := COUNT(GROUP,%Closest%.Diff_pkpu11);
    Count_Diff_pkpu12 := COUNT(GROUP,%Closest%.Diff_pkpu12);
    Count_Diff_pkpu13 := COUNT(GROUP,%Closest%.Diff_pkpu13);
    Count_Diff_pkpu14 := COUNT(GROUP,%Closest%.Diff_pkpu14);
    Count_Diff_pkpu15 := COUNT(GROUP,%Closest%.Diff_pkpu15);
    Count_Diff_pkpu16 := COUNT(GROUP,%Closest%.Diff_pkpu16);
    Count_Diff_pkpu17 := COUNT(GROUP,%Closest%.Diff_pkpu17);
    Count_Diff_pkpu18 := COUNT(GROUP,%Closest%.Diff_pkpu18);
    Count_Diff_pkpu19 := COUNT(GROUP,%Closest%.Diff_pkpu19);
    Count_Diff_pkpu20 := COUNT(GROUP,%Closest%.Diff_pkpu20);
    Count_Diff_pkpu23 := COUNT(GROUP,%Closest%.Diff_pkpu23);
    Count_Diff_pkpu25 := COUNT(GROUP,%Closest%.Diff_pkpu25);
    Count_Diff_pkpu27 := COUNT(GROUP,%Closest%.Diff_pkpu27);
    Count_Diff_pkpu28 := COUNT(GROUP,%Closest%.Diff_pkpu28);
    Count_Diff_pkpu29 := COUNT(GROUP,%Closest%.Diff_pkpu29);
    Count_Diff_pkpu30 := COUNT(GROUP,%Closest%.Diff_pkpu30);
    Count_Diff_pkpu31 := COUNT(GROUP,%Closest%.Diff_pkpu31);
    Count_Diff_pkpu32 := COUNT(GROUP,%Closest%.Diff_pkpu32);
    Count_Diff_pkpu33 := COUNT(GROUP,%Closest%.Diff_pkpu33);
    Count_Diff_pkpu34 := COUNT(GROUP,%Closest%.Diff_pkpu34);
    Count_Diff_pkpu35 := COUNT(GROUP,%Closest%.Diff_pkpu35);
    Count_Diff_pkpu38 := COUNT(GROUP,%Closest%.Diff_pkpu38);
    Count_Diff_pkpu41 := COUNT(GROUP,%Closest%.Diff_pkpu41);
    Count_Diff_pkpu42 := COUNT(GROUP,%Closest%.Diff_pkpu42);
    Count_Diff_pkpu45 := COUNT(GROUP,%Closest%.Diff_pkpu45);
    Count_Diff_pkpu46 := COUNT(GROUP,%Closest%.Diff_pkpu46);
    Count_Diff_pkpu47 := COUNT(GROUP,%Closest%.Diff_pkpu47);
    Count_Diff_pkpu48 := COUNT(GROUP,%Closest%.Diff_pkpu48);
    Count_Diff_pkpu49 := COUNT(GROUP,%Closest%.Diff_pkpu49);
    Count_Diff_pkpu50 := COUNT(GROUP,%Closest%.Diff_pkpu50);
    Count_Diff_pkpu51 := COUNT(GROUP,%Closest%.Diff_pkpu51);
    Count_Diff_pkpu52 := COUNT(GROUP,%Closest%.Diff_pkpu52);
    Count_Diff_pkpu53 := COUNT(GROUP,%Closest%.Diff_pkpu53);
    Count_Diff_pkpu54 := COUNT(GROUP,%Closest%.Diff_pkpu54);
    Count_Diff_pkpu55 := COUNT(GROUP,%Closest%.Diff_pkpu55);
    Count_Diff_pkpu56 := COUNT(GROUP,%Closest%.Diff_pkpu56);
    Count_Diff_pkpu57 := COUNT(GROUP,%Closest%.Diff_pkpu57);
    Count_Diff_pkpu60 := COUNT(GROUP,%Closest%.Diff_pkpu60);
    Count_Diff_pkpu61 := COUNT(GROUP,%Closest%.Diff_pkpu61);
    Count_Diff_pkpu62 := COUNT(GROUP,%Closest%.Diff_pkpu62);
    Count_Diff_pkpu63 := COUNT(GROUP,%Closest%.Diff_pkpu63);
    Count_Diff_pkpu64 := COUNT(GROUP,%Closest%.Diff_pkpu64);
    Count_Diff_pkpu65 := COUNT(GROUP,%Closest%.Diff_pkpu65);
    Count_Diff_pkpu66 := COUNT(GROUP,%Closest%.Diff_pkpu66);
    Count_Diff_pkpu67 := COUNT(GROUP,%Closest%.Diff_pkpu67);
    Count_Diff_pkpu68 := COUNT(GROUP,%Closest%.Diff_pkpu68);
    Count_Diff_pkpu69 := COUNT(GROUP,%Closest%.Diff_pkpu69);
    Count_Diff_pkpu70 := COUNT(GROUP,%Closest%.Diff_pkpu70);
    Count_Diff_censpct_water := COUNT(GROUP,%Closest%.Diff_censpct_water);
    Count_Diff_cens_pop_density := COUNT(GROUP,%Closest%.Diff_cens_pop_density);
    Count_Diff_cens_hu_density := COUNT(GROUP,%Closest%.Diff_cens_hu_density);
    Count_Diff_censpct_pop_white := COUNT(GROUP,%Closest%.Diff_censpct_pop_white);
    Count_Diff_censpct_pop_black := COUNT(GROUP,%Closest%.Diff_censpct_pop_black);
    Count_Diff_censpct_pop_amerind := COUNT(GROUP,%Closest%.Diff_censpct_pop_amerind);
    Count_Diff_censpct_pop_asian := COUNT(GROUP,%Closest%.Diff_censpct_pop_asian);
    Count_Diff_censpct_pop_pacisl := COUNT(GROUP,%Closest%.Diff_censpct_pop_pacisl);
    Count_Diff_censpct_pop_othrace := COUNT(GROUP,%Closest%.Diff_censpct_pop_othrace);
    Count_Diff_censpct_pop_multirace := COUNT(GROUP,%Closest%.Diff_censpct_pop_multirace);
    Count_Diff_censpct_pop_hispanic := COUNT(GROUP,%Closest%.Diff_censpct_pop_hispanic);
    Count_Diff_censpct_pop_agelt18 := COUNT(GROUP,%Closest%.Diff_censpct_pop_agelt18);
    Count_Diff_censpct_pop_males := COUNT(GROUP,%Closest%.Diff_censpct_pop_males);
    Count_Diff_censpct_adult_age1824 := COUNT(GROUP,%Closest%.Diff_censpct_adult_age1824);
    Count_Diff_censpct_adult_age2534 := COUNT(GROUP,%Closest%.Diff_censpct_adult_age2534);
    Count_Diff_censpct_adult_age3544 := COUNT(GROUP,%Closest%.Diff_censpct_adult_age3544);
    Count_Diff_censpct_adult_age4554 := COUNT(GROUP,%Closest%.Diff_censpct_adult_age4554);
    Count_Diff_censpct_adult_age5564 := COUNT(GROUP,%Closest%.Diff_censpct_adult_age5564);
    Count_Diff_censpct_adult_agege65 := COUNT(GROUP,%Closest%.Diff_censpct_adult_agege65);
    Count_Diff_cens_pop_medage := COUNT(GROUP,%Closest%.Diff_cens_pop_medage);
    Count_Diff_cens_hh_avgsize := COUNT(GROUP,%Closest%.Diff_cens_hh_avgsize);
    Count_Diff_censpct_hh_family := COUNT(GROUP,%Closest%.Diff_censpct_hh_family);
    Count_Diff_censpct_hh_family_husbwife := COUNT(GROUP,%Closest%.Diff_censpct_hh_family_husbwife);
    Count_Diff_censpct_hu_occupied := COUNT(GROUP,%Closest%.Diff_censpct_hu_occupied);
    Count_Diff_censpct_hu_owned := COUNT(GROUP,%Closest%.Diff_censpct_hu_owned);
    Count_Diff_censpct_hu_rented := COUNT(GROUP,%Closest%.Diff_censpct_hu_rented);
    Count_Diff_censpct_hu_vacantseasonal := COUNT(GROUP,%Closest%.Diff_censpct_hu_vacantseasonal);
    Count_Diff_zip_medinc := COUNT(GROUP,%Closest%.Diff_zip_medinc);
    Count_Diff_zip_apparel := COUNT(GROUP,%Closest%.Diff_zip_apparel);
    Count_Diff_zip_apparel_women := COUNT(GROUP,%Closest%.Diff_zip_apparel_women);
    Count_Diff_zip_apparel_womfash := COUNT(GROUP,%Closest%.Diff_zip_apparel_womfash);
    Count_Diff_zip_auto := COUNT(GROUP,%Closest%.Diff_zip_auto);
    Count_Diff_zip_beauty := COUNT(GROUP,%Closest%.Diff_zip_beauty);
    Count_Diff_zip_booksmusicmovies := COUNT(GROUP,%Closest%.Diff_zip_booksmusicmovies);
    Count_Diff_zip_business := COUNT(GROUP,%Closest%.Diff_zip_business);
    Count_Diff_zip_catalog := COUNT(GROUP,%Closest%.Diff_zip_catalog);
    Count_Diff_zip_cc := COUNT(GROUP,%Closest%.Diff_zip_cc);
    Count_Diff_zip_collectibles := COUNT(GROUP,%Closest%.Diff_zip_collectibles);
    Count_Diff_zip_computers := COUNT(GROUP,%Closest%.Diff_zip_computers);
    Count_Diff_zip_continuity := COUNT(GROUP,%Closest%.Diff_zip_continuity);
    Count_Diff_zip_cooking := COUNT(GROUP,%Closest%.Diff_zip_cooking);
    Count_Diff_zip_crafts := COUNT(GROUP,%Closest%.Diff_zip_crafts);
    Count_Diff_zip_culturearts := COUNT(GROUP,%Closest%.Diff_zip_culturearts);
    Count_Diff_zip_dm_sold := COUNT(GROUP,%Closest%.Diff_zip_dm_sold);
    Count_Diff_zip_donor := COUNT(GROUP,%Closest%.Diff_zip_donor);
    Count_Diff_zip_family := COUNT(GROUP,%Closest%.Diff_zip_family);
    Count_Diff_zip_gardening := COUNT(GROUP,%Closest%.Diff_zip_gardening);
    Count_Diff_zip_giftgivr := COUNT(GROUP,%Closest%.Diff_zip_giftgivr);
    Count_Diff_zip_gourmet := COUNT(GROUP,%Closest%.Diff_zip_gourmet);
    Count_Diff_zip_health := COUNT(GROUP,%Closest%.Diff_zip_health);
    Count_Diff_zip_health_diet := COUNT(GROUP,%Closest%.Diff_zip_health_diet);
    Count_Diff_zip_health_fitness := COUNT(GROUP,%Closest%.Diff_zip_health_fitness);
    Count_Diff_zip_hobbies := COUNT(GROUP,%Closest%.Diff_zip_hobbies);
    Count_Diff_zip_homedecr := COUNT(GROUP,%Closest%.Diff_zip_homedecr);
    Count_Diff_zip_homeliv := COUNT(GROUP,%Closest%.Diff_zip_homeliv);
    Count_Diff_zip_internet := COUNT(GROUP,%Closest%.Diff_zip_internet);
    Count_Diff_zip_internet_access := COUNT(GROUP,%Closest%.Diff_zip_internet_access);
    Count_Diff_zip_internet_buy := COUNT(GROUP,%Closest%.Diff_zip_internet_buy);
    Count_Diff_zip_music := COUNT(GROUP,%Closest%.Diff_zip_music);
    Count_Diff_zip_outdoors := COUNT(GROUP,%Closest%.Diff_zip_outdoors);
    Count_Diff_zip_pets := COUNT(GROUP,%Closest%.Diff_zip_pets);
    Count_Diff_zip_pfin := COUNT(GROUP,%Closest%.Diff_zip_pfin);
    Count_Diff_zip_publish := COUNT(GROUP,%Closest%.Diff_zip_publish);
    Count_Diff_zip_publish_books := COUNT(GROUP,%Closest%.Diff_zip_publish_books);
    Count_Diff_zip_publish_mags := COUNT(GROUP,%Closest%.Diff_zip_publish_mags);
    Count_Diff_zip_sports := COUNT(GROUP,%Closest%.Diff_zip_sports);
    Count_Diff_zip_sports_biking := COUNT(GROUP,%Closest%.Diff_zip_sports_biking);
    Count_Diff_zip_sports_golf := COUNT(GROUP,%Closest%.Diff_zip_sports_golf);
    Count_Diff_zip_travel := COUNT(GROUP,%Closest%.Diff_zip_travel);
    Count_Diff_zip_travel_us := COUNT(GROUP,%Closest%.Diff_zip_travel_us);
    Count_Diff_zip_tvmovies := COUNT(GROUP,%Closest%.Diff_zip_tvmovies);
    Count_Diff_zip_woman := COUNT(GROUP,%Closest%.Diff_zip_woman);
    Count_Diff_zip_proftech := COUNT(GROUP,%Closest%.Diff_zip_proftech);
    Count_Diff_zip_retired := COUNT(GROUP,%Closest%.Diff_zip_retired);
    Count_Diff_zip_inc100 := COUNT(GROUP,%Closest%.Diff_zip_inc100);
    Count_Diff_zip_inc75 := COUNT(GROUP,%Closest%.Diff_zip_inc75);
    Count_Diff_zip_inc50 := COUNT(GROUP,%Closest%.Diff_zip_inc50);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
