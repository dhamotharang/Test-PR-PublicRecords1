IMPORT ut,SALT30;
EXPORT Fields := MODULE
// Processing for each FieldType
EXPORT SALT30.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_only_alpha','invalid_weight','invalid_alpha','invalid_alphanumeric','invalid_date','invalid_year','invalid_categorycode','invalid_vin','invalid_titlenum','invalid_ownercode','invalid_state','invalid_zip','invalid_countycode','invalid_vehicletaxcode','invalid_vehiclemake','invalid_source_code','invalid_append_ownernametypeind');
EXPORT FieldTypeNum(SALT30.StrType fn) := CASE(fn,'invalid_only_alpha' => 1,'invalid_weight' => 2,'invalid_alpha' => 3,'invalid_alphanumeric' => 4,'invalid_date' => 5,'invalid_year' => 6,'invalid_categorycode' => 7,'invalid_vin' => 8,'invalid_titlenum' => 9,'invalid_ownercode' => 10,'invalid_state' => 11,'invalid_zip' => 12,'invalid_countycode' => 13,'invalid_vehicletaxcode' => 14,'invalid_vehiclemake' => 15,'invalid_source_code' => 16,'invalid_append_ownernametypeind' => 17,0);
EXPORT MakeFT_invalid_only_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,.'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_only_alpha(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -,.'))));
EXPORT InValidMessageFT_invalid_only_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -,.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_weight(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_weight(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 6 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_weight(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('6,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alpha(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~@&%\'"`$*-_? <>{}[]^=!+,.;:/#()\\|'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' <>{}[]^=!+,.;:/#()\\|',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alpha(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~@&%\'"`$*-_? <>{}[]^=!+,.;:/#()\\|'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~@&%\'"`$*-_? <>{}[]^=!+,.;:/#()\\|'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_alphanumeric(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringtouppercase(s0); // Force to upper case
  s2 := SALT30.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,.'); // Only allow valid symbols
  s3 := SALT30.stringcleanspaces( SALT30.stringsubstituteout(s2,' -,.',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_alphanumeric(SALT30.StrType s) := WHICH(SALT30.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,.'))));
EXPORT InValidMessageFT_invalid_alphanumeric(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotCaps,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 -,.'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_date(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 8 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('8,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_year(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_year(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 4 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('4,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_categorycode(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_categorycode(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['BU','PC','NC','NT','MC','TK','HV','TL','MH','FM','RV','','MP',''],~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_categorycode(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('BU|PC|NC|NT|MC|TK|HV|TL|MH|FM|RV||MP|'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_vin(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_vin(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_vin(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_titlenum(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_titlenum(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))));
EXPORT InValidMessageFT_invalid_titlenum(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_ownercode(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ownercode(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['S','Y','L'],~(LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_ownercode(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('S|Y|L'),SALT30.HygieneErrors.NotLength('1'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_state(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['OH',''],~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('OH|'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_zip(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_zip(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 5 OR LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789 '),SALT30.HygieneErrors.NotLength('5,9'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_countycode(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_countycode(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_countycode(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('0123456789'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_vehicletaxcode(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vehicletaxcode(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['0','2','D',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_vehicletaxcode(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('0|2|D|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_vehiclemake(SALT30.StrType s0) := FUNCTION
  s1 := SALT30.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_vehiclemake(SALT30.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT30.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_vehiclemake(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_source_code(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_code(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['DI',''],~(LENGTH(TRIM(s)) = 2 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('DI|'),SALT30.HygieneErrors.NotLength('2,0'),SALT30.HygieneErrors.Good);
EXPORT MakeFT_invalid_append_ownernametypeind(SALT30.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_append_ownernametypeind(SALT30.StrType s) := WHICH(((SALT30.StrType) s) NOT IN ['B','D','I','P','U',''],~(LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_append_ownernametypeind(UNSIGNED1 wh) := CHOOSE(wh,SALT30.HygieneErrors.NotInEnum('B|D|I|P|U|'),SALT30.HygieneErrors.NotLength('1,0'),SALT30.HygieneErrors.Good);
EXPORT SALT30.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'categorycode','vin','modelyr','titlenum','ownercode','grossweight','ownername','ownerstreetaddress','ownercity','ownerstate','ownerzip','countynumber','vehiclepurchasedt','vehicletaxweight','vehicletaxcode','vehicleunladdenweight','additionalownername','registrationissuedt','vehiclemake','vehicletype','vehicleexpdt','previousplatenum','platenum','processdate','source_code','state_origin','append_ownernametypeind','append_addlownernametypeind');
EXPORT FieldNum(SALT30.StrType fn) := CASE(fn,'categorycode' => 1,'vin' => 2,'modelyr' => 3,'titlenum' => 4,'ownercode' => 5,'grossweight' => 6,'ownername' => 7,'ownerstreetaddress' => 8,'ownercity' => 9,'ownerstate' => 10,'ownerzip' => 11,'countynumber' => 12,'vehiclepurchasedt' => 13,'vehicletaxweight' => 14,'vehicletaxcode' => 15,'vehicleunladdenweight' => 16,'additionalownername' => 17,'registrationissuedt' => 18,'vehiclemake' => 19,'vehicletype' => 20,'vehicleexpdt' => 21,'previousplatenum' => 22,'platenum' => 23,'processdate' => 24,'source_code' => 25,'state_origin' => 26,'append_ownernametypeind' => 27,'append_addlownernametypeind' => 28,0);
//Individual field level validation
EXPORT Make_categorycode(SALT30.StrType s0) := MakeFT_invalid_categorycode(s0);
EXPORT InValid_categorycode(SALT30.StrType s) := InValidFT_invalid_categorycode(s);
EXPORT InValidMessage_categorycode(UNSIGNED1 wh) := InValidMessageFT_invalid_categorycode(wh);
EXPORT Make_vin(SALT30.StrType s0) := MakeFT_invalid_vin(s0);
EXPORT InValid_vin(SALT30.StrType s) := InValidFT_invalid_vin(s);
EXPORT InValidMessage_vin(UNSIGNED1 wh) := InValidMessageFT_invalid_vin(wh);
EXPORT Make_modelyr(SALT30.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_modelyr(SALT30.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_modelyr(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
EXPORT Make_titlenum(SALT30.StrType s0) := MakeFT_invalid_titlenum(s0);
EXPORT InValid_titlenum(SALT30.StrType s) := InValidFT_invalid_titlenum(s);
EXPORT InValidMessage_titlenum(UNSIGNED1 wh) := InValidMessageFT_invalid_titlenum(wh);
EXPORT Make_ownercode(SALT30.StrType s0) := MakeFT_invalid_ownercode(s0);
EXPORT InValid_ownercode(SALT30.StrType s) := InValidFT_invalid_ownercode(s);
EXPORT InValidMessage_ownercode(UNSIGNED1 wh) := InValidMessageFT_invalid_ownercode(wh);
EXPORT Make_grossweight(SALT30.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_grossweight(SALT30.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_grossweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
EXPORT Make_ownername(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_ownername(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_ownername(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_ownerstreetaddress(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_ownerstreetaddress(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_ownerstreetaddress(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_ownercity(SALT30.StrType s0) := MakeFT_invalid_only_alpha(s0);
EXPORT InValid_ownercity(SALT30.StrType s) := InValidFT_invalid_only_alpha(s);
EXPORT InValidMessage_ownercity(UNSIGNED1 wh) := InValidMessageFT_invalid_only_alpha(wh);
EXPORT Make_ownerstate(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_ownerstate(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_ownerstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_ownerzip(SALT30.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_ownerzip(SALT30.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_ownerzip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
EXPORT Make_countynumber(SALT30.StrType s0) := MakeFT_invalid_countycode(s0);
EXPORT InValid_countynumber(SALT30.StrType s) := InValidFT_invalid_countycode(s);
EXPORT InValidMessage_countynumber(UNSIGNED1 wh) := InValidMessageFT_invalid_countycode(wh);
EXPORT Make_vehiclepurchasedt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_vehiclepurchasedt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_vehiclepurchasedt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_vehicletaxweight(SALT30.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_vehicletaxweight(SALT30.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_vehicletaxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
EXPORT Make_vehicletaxcode(SALT30.StrType s0) := MakeFT_invalid_vehicletaxcode(s0);
EXPORT InValid_vehicletaxcode(SALT30.StrType s) := InValidFT_invalid_vehicletaxcode(s);
EXPORT InValidMessage_vehicletaxcode(UNSIGNED1 wh) := InValidMessageFT_invalid_vehicletaxcode(wh);
EXPORT Make_vehicleunladdenweight(SALT30.StrType s0) := MakeFT_invalid_weight(s0);
EXPORT InValid_vehicleunladdenweight(SALT30.StrType s) := InValidFT_invalid_weight(s);
EXPORT InValidMessage_vehicleunladdenweight(UNSIGNED1 wh) := InValidMessageFT_invalid_weight(wh);
EXPORT Make_additionalownername(SALT30.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_additionalownername(SALT30.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_additionalownername(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
EXPORT Make_registrationissuedt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_registrationissuedt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_registrationissuedt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_vehiclemake(SALT30.StrType s0) := MakeFT_invalid_vehiclemake(s0);
EXPORT InValid_vehiclemake(SALT30.StrType s) := InValidFT_invalid_vehiclemake(s);
EXPORT InValidMessage_vehiclemake(UNSIGNED1 wh) := InValidMessageFT_invalid_vehiclemake(wh);
EXPORT Make_vehicletype(SALT30.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_vehicletype(SALT30.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_vehicletype(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_vehicleexpdt(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_vehicleexpdt(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_vehicleexpdt(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_previousplatenum(SALT30.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_previousplatenum(SALT30.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_previousplatenum(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_platenum(SALT30.StrType s0) := MakeFT_invalid_alphanumeric(s0);
EXPORT InValid_platenum(SALT30.StrType s) := InValidFT_invalid_alphanumeric(s);
EXPORT InValidMessage_platenum(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumeric(wh);
EXPORT Make_processdate(SALT30.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_processdate(SALT30.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_processdate(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
EXPORT Make_source_code(SALT30.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_source_code(SALT30.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
EXPORT Make_state_origin(SALT30.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state_origin(SALT30.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
EXPORT Make_append_ownernametypeind(SALT30.StrType s0) := MakeFT_invalid_append_ownernametypeind(s0);
EXPORT InValid_append_ownernametypeind(SALT30.StrType s) := InValidFT_invalid_append_ownernametypeind(s);
EXPORT InValidMessage_append_ownernametypeind(UNSIGNED1 wh) := InValidMessageFT_invalid_append_ownernametypeind(wh);
EXPORT Make_append_addlownernametypeind(SALT30.StrType s0) := MakeFT_invalid_append_ownernametypeind(s0);
EXPORT InValid_append_addlownernametypeind(SALT30.StrType s) := InValidFT_invalid_append_ownernametypeind(s);
EXPORT InValidMessage_append_addlownernametypeind(UNSIGNED1 wh) := InValidMessageFT_invalid_append_ownernametypeind(wh);
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT30,Scrubs_VehicleV2_OH_Direct;
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
    BOOLEAN Diff_categorycode;
    BOOLEAN Diff_vin;
    BOOLEAN Diff_modelyr;
    BOOLEAN Diff_titlenum;
    BOOLEAN Diff_ownercode;
    BOOLEAN Diff_grossweight;
    BOOLEAN Diff_ownername;
    BOOLEAN Diff_ownerstreetaddress;
    BOOLEAN Diff_ownercity;
    BOOLEAN Diff_ownerstate;
    BOOLEAN Diff_ownerzip;
    BOOLEAN Diff_countynumber;
    BOOLEAN Diff_vehiclepurchasedt;
    BOOLEAN Diff_vehicletaxweight;
    BOOLEAN Diff_vehicletaxcode;
    BOOLEAN Diff_vehicleunladdenweight;
    BOOLEAN Diff_additionalownername;
    BOOLEAN Diff_registrationissuedt;
    BOOLEAN Diff_vehiclemake;
    BOOLEAN Diff_vehicletype;
    BOOLEAN Diff_vehicleexpdt;
    BOOLEAN Diff_previousplatenum;
    BOOLEAN Diff_platenum;
    BOOLEAN Diff_processdate;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_state_origin;
    BOOLEAN Diff_append_ownernametypeind;
    BOOLEAN Diff_append_addlownernametypeind;
    SALT30.StrType SourceField {MAXLENGTH(30)};
    UNSIGNED Num_Diffs;
    SALT30.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_categorycode := le.categorycode <> ri.categorycode;
    SELF.Diff_vin := le.vin <> ri.vin;
    SELF.Diff_modelyr := le.modelyr <> ri.modelyr;
    SELF.Diff_titlenum := le.titlenum <> ri.titlenum;
    SELF.Diff_ownercode := le.ownercode <> ri.ownercode;
    SELF.Diff_grossweight := le.grossweight <> ri.grossweight;
    SELF.Diff_ownername := le.ownername <> ri.ownername;
    SELF.Diff_ownerstreetaddress := le.ownerstreetaddress <> ri.ownerstreetaddress;
    SELF.Diff_ownercity := le.ownercity <> ri.ownercity;
    SELF.Diff_ownerstate := le.ownerstate <> ri.ownerstate;
    SELF.Diff_ownerzip := le.ownerzip <> ri.ownerzip;
    SELF.Diff_countynumber := le.countynumber <> ri.countynumber;
    SELF.Diff_vehiclepurchasedt := le.vehiclepurchasedt <> ri.vehiclepurchasedt;
    SELF.Diff_vehicletaxweight := le.vehicletaxweight <> ri.vehicletaxweight;
    SELF.Diff_vehicletaxcode := le.vehicletaxcode <> ri.vehicletaxcode;
    SELF.Diff_vehicleunladdenweight := le.vehicleunladdenweight <> ri.vehicleunladdenweight;
    SELF.Diff_additionalownername := le.additionalownername <> ri.additionalownername;
    SELF.Diff_registrationissuedt := le.registrationissuedt <> ri.registrationissuedt;
    SELF.Diff_vehiclemake := le.vehiclemake <> ri.vehiclemake;
    SELF.Diff_vehicletype := le.vehicletype <> ri.vehicletype;
    SELF.Diff_vehicleexpdt := le.vehicleexpdt <> ri.vehicleexpdt;
    SELF.Diff_previousplatenum := le.previousplatenum <> ri.previousplatenum;
    SELF.Diff_platenum := le.platenum <> ri.platenum;
    SELF.Diff_processdate := le.processdate <> ri.processdate;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_state_origin := le.state_origin <> ri.state_origin;
    SELF.Diff_append_ownernametypeind := le.append_ownernametypeind <> ri.append_ownernametypeind;
    SELF.Diff_append_addlownernametypeind := le.append_addlownernametypeind <> ri.append_addlownernametypeind;
    SELF.Val := (SALT30.StrType)evaluate(le,pivot_exp);
    SELF.SourceField := le.source_code;
    SELF.Num_Diffs := 0+ IF( SELF.Diff_categorycode,1,0)+ IF( SELF.Diff_vin,1,0)+ IF( SELF.Diff_modelyr,1,0)+ IF( SELF.Diff_titlenum,1,0)+ IF( SELF.Diff_ownercode,1,0)+ IF( SELF.Diff_grossweight,1,0)+ IF( SELF.Diff_ownername,1,0)+ IF( SELF.Diff_ownerstreetaddress,1,0)+ IF( SELF.Diff_ownercity,1,0)+ IF( SELF.Diff_ownerstate,1,0)+ IF( SELF.Diff_ownerzip,1,0)+ IF( SELF.Diff_countynumber,1,0)+ IF( SELF.Diff_vehiclepurchasedt,1,0)+ IF( SELF.Diff_vehicletaxweight,1,0)+ IF( SELF.Diff_vehicletaxcode,1,0)+ IF( SELF.Diff_vehicleunladdenweight,1,0)+ IF( SELF.Diff_additionalownername,1,0)+ IF( SELF.Diff_registrationissuedt,1,0)+ IF( SELF.Diff_vehiclemake,1,0)+ IF( SELF.Diff_vehicletype,1,0)+ IF( SELF.Diff_vehicleexpdt,1,0)+ IF( SELF.Diff_previousplatenum,1,0)+ IF( SELF.Diff_platenum,1,0)+ IF( SELF.Diff_processdate,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_state_origin,1,0)+ IF( SELF.Diff_append_ownernametypeind,1,0)+ IF( SELF.Diff_append_addlownernametypeind,1,0);
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
    Count_Diff_categorycode := COUNT(GROUP,%Closest%.Diff_categorycode);
    Count_Diff_vin := COUNT(GROUP,%Closest%.Diff_vin);
    Count_Diff_modelyr := COUNT(GROUP,%Closest%.Diff_modelyr);
    Count_Diff_titlenum := COUNT(GROUP,%Closest%.Diff_titlenum);
    Count_Diff_ownercode := COUNT(GROUP,%Closest%.Diff_ownercode);
    Count_Diff_grossweight := COUNT(GROUP,%Closest%.Diff_grossweight);
    Count_Diff_ownername := COUNT(GROUP,%Closest%.Diff_ownername);
    Count_Diff_ownerstreetaddress := COUNT(GROUP,%Closest%.Diff_ownerstreetaddress);
    Count_Diff_ownercity := COUNT(GROUP,%Closest%.Diff_ownercity);
    Count_Diff_ownerstate := COUNT(GROUP,%Closest%.Diff_ownerstate);
    Count_Diff_ownerzip := COUNT(GROUP,%Closest%.Diff_ownerzip);
    Count_Diff_countynumber := COUNT(GROUP,%Closest%.Diff_countynumber);
    Count_Diff_vehiclepurchasedt := COUNT(GROUP,%Closest%.Diff_vehiclepurchasedt);
    Count_Diff_vehicletaxweight := COUNT(GROUP,%Closest%.Diff_vehicletaxweight);
    Count_Diff_vehicletaxcode := COUNT(GROUP,%Closest%.Diff_vehicletaxcode);
    Count_Diff_vehicleunladdenweight := COUNT(GROUP,%Closest%.Diff_vehicleunladdenweight);
    Count_Diff_additionalownername := COUNT(GROUP,%Closest%.Diff_additionalownername);
    Count_Diff_registrationissuedt := COUNT(GROUP,%Closest%.Diff_registrationissuedt);
    Count_Diff_vehiclemake := COUNT(GROUP,%Closest%.Diff_vehiclemake);
    Count_Diff_vehicletype := COUNT(GROUP,%Closest%.Diff_vehicletype);
    Count_Diff_vehicleexpdt := COUNT(GROUP,%Closest%.Diff_vehicleexpdt);
    Count_Diff_previousplatenum := COUNT(GROUP,%Closest%.Diff_previousplatenum);
    Count_Diff_platenum := COUNT(GROUP,%Closest%.Diff_platenum);
    Count_Diff_processdate := COUNT(GROUP,%Closest%.Diff_processdate);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_state_origin := COUNT(GROUP,%Closest%.Diff_state_origin);
    Count_Diff_append_ownernametypeind := COUNT(GROUP,%Closest%.Diff_append_ownernametypeind);
    Count_Diff_append_addlownernametypeind := COUNT(GROUP,%Closest%.Diff_append_addlownernametypeind);
    %Closest%.SourceField;
  END;
  out_counts := table(%Closest%,%AggRec%,SourceField,few);
ENDMACRO;
END;
