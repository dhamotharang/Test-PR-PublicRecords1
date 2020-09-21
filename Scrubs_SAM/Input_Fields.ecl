IMPORT SALT311;
IMPORT Scrubs_SAM; // Import modules for FieldTypes attribute definitions
EXPORT Input_Fields := MODULE
 
EXPORT NumFields := 27;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_name','invalid_firstname','invalid_middlename','invalid_lastname','invalid_address_2','invalid_address_3','invalid_address_4','invalid_city','invalid_state','invalid_country','invalid_zipcode','invalid_exclusionprogram','invalid_exclusiontype','invalid_activedate','invalid_terminationdate','invalid_samnumber');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_name' => 2,'invalid_firstname' => 3,'invalid_middlename' => 4,'invalid_lastname' => 5,'invalid_address_2' => 6,'invalid_address_3' => 7,'invalid_address_4' => 8,'invalid_city' => 9,'invalid_state' => 10,'invalid_country' => 11,'invalid_zipcode' => 12,'invalid_exclusionprogram' => 13,'invalid_exclusiontype' => 14,'invalid_activedate' => 15,'invalid_terminationdate' => 16,'invalid_samnumber' => 17,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT311.StrType s,SALT311.StrType firstname,SALT311.StrType lastname) := WHICH(~Scrubs_SAM.Functions.fn_populated_strings(s,firstname,lastname)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_firstname(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_firstname(SALT311.StrType s,SALT311.StrType name,SALT311.StrType lastname) := WHICH(~Scrubs_SAM.Functions.fn_populated_strings(s,name,lastname)>0);
EXPORT InValidMessageFT_invalid_firstname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_middlename(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_middlename(SALT311.StrType s,SALT311.StrType name,SALT311.StrType firstname,SALT311.StrType lastname) := WHICH(~Scrubs_SAM.Functions.fn_populated_strings(s,name,firstname,lastname)>0);
EXPORT InValidMessageFT_invalid_middlename(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lastname(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lastname(SALT311.StrType s,SALT311.StrType name,SALT311.StrType lastname) := WHICH(~Scrubs_SAM.Functions.fn_populated_strings(s,name,lastname)>0);
EXPORT InValidMessageFT_invalid_lastname(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_2(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_2(SALT311.StrType s,SALT311.StrType address_1) := WHICH(~Scrubs_SAM.Functions.fn_str1_depends_str2(s,address_1)>0);
EXPORT InValidMessageFT_invalid_address_2(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_str1_depends_str2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_3(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_3(SALT311.StrType s,SALT311.StrType address_1,SALT311.StrType address_2) := WHICH(~Scrubs_SAM.Functions.fn_str1_depends_str2_str3(s,address_1,address_2)>0);
EXPORT InValidMessageFT_invalid_address_3(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_str1_depends_str2_str3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address_4(SALT311.StrType s,SALT311.StrType address_1,SALT311.StrType address_2,SALT311.StrType address_3) := WHICH(~Scrubs_SAM.Functions.fn_str1_depends_str2_str3_str4(s,address_1,address_2,address_3)>0);
EXPORT InValidMessageFT_invalid_address_4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_str1_depends_str2_str3_str4'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_city(SALT311.StrType s,SALT311.StrType state,SALT311.StrType country,SALT311.StrType zipcode) := WHICH(~Scrubs_SAM.Functions.fn_populated_strings(s,state,country,zipcode)>0);
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s,SALT311.StrType country) := WHICH(~Scrubs_SAM.Functions.fn_Valid_StateAbbrev(s,country)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_Valid_StateAbbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_country(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_country(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_Valid_Country3Abbrev(s)>0);
EXPORT InValidMessageFT_invalid_country(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_Valid_Country3Abbrev'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zipcode(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zipcode(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_verify_zip059(s)>0);
EXPORT InValidMessageFT_invalid_zipcode(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_verify_zip059'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exclusionprogram(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exclusionprogram(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_exclusion_program(s)>0);
EXPORT InValidMessageFT_invalid_exclusionprogram(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_exclusion_program'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exclusiontype(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exclusiontype(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_exclusion_type(s)>0);
EXPORT InValidMessageFT_invalid_exclusiontype(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_exclusion_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_activedate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_activedate(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_Valid_Past_Date(s)>0);
EXPORT InValidMessageFT_invalid_activedate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_Valid_Past_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_terminationdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_terminationdate(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_Valid_General_Date(s)>0);
EXPORT InValidMessageFT_invalid_terminationdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_Valid_General_Date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_samnumber(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_samnumber(SALT311.StrType s) := WHICH(~Scrubs_SAM.Functions.fn_alphanum(s)>0);
EXPORT InValidMessageFT_invalid_samnumber(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_SAM.Functions.fn_alphanum'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'classification','name','prefix','firstname','middlename','lastname','suffix','address_1','address_2','address_3','address_4','city','state','country','zipcode','duns','exclusionprogram','excludingagency','ctcode','exclusiontype','additionalcomments','activedate','terminationdate','recordstatus','crossreference','samnumber','cage');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'classification','name','prefix','firstname','middlename','lastname','suffix','address_1','address_2','address_3','address_4','city','state','country','zipcode','duns','exclusionprogram','excludingagency','ctcode','exclusiontype','additionalcomments','activedate','terminationdate','recordstatus','crossreference','samnumber','cage');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'classification' => 0,'name' => 1,'prefix' => 2,'firstname' => 3,'middlename' => 4,'lastname' => 5,'suffix' => 6,'address_1' => 7,'address_2' => 8,'address_3' => 9,'address_4' => 10,'city' => 11,'state' => 12,'country' => 13,'zipcode' => 14,'duns' => 15,'exclusionprogram' => 16,'excludingagency' => 17,'ctcode' => 18,'exclusiontype' => 19,'additionalcomments' => 20,'activedate' => 21,'terminationdate' => 22,'recordstatus' => 23,'crossreference' => 24,'samnumber' => 25,'cage' => 26,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],[],['CUSTOM'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_classification(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_classification(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_classification(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_name(SALT311.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_name(SALT311.StrType s,SALT311.StrType firstname,SALT311.StrType lastname) := InValidFT_invalid_name(s,firstname,lastname);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_prefix(SALT311.StrType s0) := s0;
EXPORT InValid_prefix(SALT311.StrType s) := 0;
EXPORT InValidMessage_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_firstname(SALT311.StrType s0) := MakeFT_invalid_firstname(s0);
EXPORT InValid_firstname(SALT311.StrType s,SALT311.StrType name,SALT311.StrType lastname) := InValidFT_invalid_firstname(s,name,lastname);
EXPORT InValidMessage_firstname(UNSIGNED1 wh) := InValidMessageFT_invalid_firstname(wh);
 
EXPORT Make_middlename(SALT311.StrType s0) := MakeFT_invalid_middlename(s0);
EXPORT InValid_middlename(SALT311.StrType s,SALT311.StrType name,SALT311.StrType firstname,SALT311.StrType lastname) := InValidFT_invalid_middlename(s,name,firstname,lastname);
EXPORT InValidMessage_middlename(UNSIGNED1 wh) := InValidMessageFT_invalid_middlename(wh);
 
EXPORT Make_lastname(SALT311.StrType s0) := MakeFT_invalid_lastname(s0);
EXPORT InValid_lastname(SALT311.StrType s,SALT311.StrType name,SALT311.StrType lastname) := InValidFT_invalid_lastname(s,name,lastname);
EXPORT InValidMessage_lastname(UNSIGNED1 wh) := InValidMessageFT_invalid_lastname(wh);
 
EXPORT Make_suffix(SALT311.StrType s0) := s0;
EXPORT InValid_suffix(SALT311.StrType s) := 0;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_address_1(SALT311.StrType s0) := s0;
EXPORT InValid_address_1(SALT311.StrType s) := 0;
EXPORT InValidMessage_address_1(UNSIGNED1 wh) := '';
 
EXPORT Make_address_2(SALT311.StrType s0) := MakeFT_invalid_address_2(s0);
EXPORT InValid_address_2(SALT311.StrType s,SALT311.StrType address_1) := InValidFT_invalid_address_2(s,address_1);
EXPORT InValidMessage_address_2(UNSIGNED1 wh) := InValidMessageFT_invalid_address_2(wh);
 
EXPORT Make_address_3(SALT311.StrType s0) := MakeFT_invalid_address_3(s0);
EXPORT InValid_address_3(SALT311.StrType s,SALT311.StrType address_1,SALT311.StrType address_2) := InValidFT_invalid_address_3(s,address_1,address_2);
EXPORT InValidMessage_address_3(UNSIGNED1 wh) := InValidMessageFT_invalid_address_3(wh);
 
EXPORT Make_address_4(SALT311.StrType s0) := MakeFT_invalid_address_4(s0);
EXPORT InValid_address_4(SALT311.StrType s,SALT311.StrType address_1,SALT311.StrType address_2,SALT311.StrType address_3) := InValidFT_invalid_address_4(s,address_1,address_2,address_3);
EXPORT InValidMessage_address_4(UNSIGNED1 wh) := InValidMessageFT_invalid_address_4(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT311.StrType s,SALT311.StrType state,SALT311.StrType country,SALT311.StrType zipcode) := InValidFT_invalid_city(s,state,country,zipcode);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s,SALT311.StrType country) := InValidFT_invalid_state(s,country);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_country(SALT311.StrType s0) := MakeFT_invalid_country(s0);
EXPORT InValid_country(SALT311.StrType s) := InValidFT_invalid_country(s);
EXPORT InValidMessage_country(UNSIGNED1 wh) := InValidMessageFT_invalid_country(wh);
 
EXPORT Make_zipcode(SALT311.StrType s0) := MakeFT_invalid_zipcode(s0);
EXPORT InValid_zipcode(SALT311.StrType s) := InValidFT_invalid_zipcode(s);
EXPORT InValidMessage_zipcode(UNSIGNED1 wh) := InValidMessageFT_invalid_zipcode(wh);
 
EXPORT Make_duns(SALT311.StrType s0) := s0;
EXPORT InValid_duns(SALT311.StrType s) := 0;
EXPORT InValidMessage_duns(UNSIGNED1 wh) := '';
 
EXPORT Make_exclusionprogram(SALT311.StrType s0) := MakeFT_invalid_exclusionprogram(s0);
EXPORT InValid_exclusionprogram(SALT311.StrType s) := InValidFT_invalid_exclusionprogram(s);
EXPORT InValidMessage_exclusionprogram(UNSIGNED1 wh) := InValidMessageFT_invalid_exclusionprogram(wh);
 
EXPORT Make_excludingagency(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_excludingagency(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_excludingagency(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ctcode(SALT311.StrType s0) := s0;
EXPORT InValid_ctcode(SALT311.StrType s) := 0;
EXPORT InValidMessage_ctcode(UNSIGNED1 wh) := '';
 
EXPORT Make_exclusiontype(SALT311.StrType s0) := MakeFT_invalid_exclusiontype(s0);
EXPORT InValid_exclusiontype(SALT311.StrType s) := InValidFT_invalid_exclusiontype(s);
EXPORT InValidMessage_exclusiontype(UNSIGNED1 wh) := InValidMessageFT_invalid_exclusiontype(wh);
 
EXPORT Make_additionalcomments(SALT311.StrType s0) := s0;
EXPORT InValid_additionalcomments(SALT311.StrType s) := 0;
EXPORT InValidMessage_additionalcomments(UNSIGNED1 wh) := '';
 
EXPORT Make_activedate(SALT311.StrType s0) := MakeFT_invalid_activedate(s0);
EXPORT InValid_activedate(SALT311.StrType s) := InValidFT_invalid_activedate(s);
EXPORT InValidMessage_activedate(UNSIGNED1 wh) := InValidMessageFT_invalid_activedate(wh);
 
EXPORT Make_terminationdate(SALT311.StrType s0) := MakeFT_invalid_terminationdate(s0);
EXPORT InValid_terminationdate(SALT311.StrType s) := InValidFT_invalid_terminationdate(s);
EXPORT InValidMessage_terminationdate(UNSIGNED1 wh) := InValidMessageFT_invalid_terminationdate(wh);
 
EXPORT Make_recordstatus(SALT311.StrType s0) := s0;
EXPORT InValid_recordstatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_recordstatus(UNSIGNED1 wh) := '';
 
EXPORT Make_crossreference(SALT311.StrType s0) := s0;
EXPORT InValid_crossreference(SALT311.StrType s) := 0;
EXPORT InValidMessage_crossreference(UNSIGNED1 wh) := '';
 
EXPORT Make_samnumber(SALT311.StrType s0) := MakeFT_invalid_samnumber(s0);
EXPORT InValid_samnumber(SALT311.StrType s) := InValidFT_invalid_samnumber(s);
EXPORT InValidMessage_samnumber(UNSIGNED1 wh) := InValidMessageFT_invalid_samnumber(wh);
 
EXPORT Make_cage(SALT311.StrType s0) := s0;
EXPORT InValid_cage(SALT311.StrType s) := 0;
EXPORT InValidMessage_cage(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_SAM;
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
    BOOLEAN Diff_classification;
    BOOLEAN Diff_name;
    BOOLEAN Diff_prefix;
    BOOLEAN Diff_firstname;
    BOOLEAN Diff_middlename;
    BOOLEAN Diff_lastname;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_address_1;
    BOOLEAN Diff_address_2;
    BOOLEAN Diff_address_3;
    BOOLEAN Diff_address_4;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_country;
    BOOLEAN Diff_zipcode;
    BOOLEAN Diff_duns;
    BOOLEAN Diff_exclusionprogram;
    BOOLEAN Diff_excludingagency;
    BOOLEAN Diff_ctcode;
    BOOLEAN Diff_exclusiontype;
    BOOLEAN Diff_additionalcomments;
    BOOLEAN Diff_activedate;
    BOOLEAN Diff_terminationdate;
    BOOLEAN Diff_recordstatus;
    BOOLEAN Diff_crossreference;
    BOOLEAN Diff_samnumber;
    BOOLEAN Diff_cage;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_classification := le.classification <> ri.classification;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_prefix := le.prefix <> ri.prefix;
    SELF.Diff_firstname := le.firstname <> ri.firstname;
    SELF.Diff_middlename := le.middlename <> ri.middlename;
    SELF.Diff_lastname := le.lastname <> ri.lastname;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_address_1 := le.address_1 <> ri.address_1;
    SELF.Diff_address_2 := le.address_2 <> ri.address_2;
    SELF.Diff_address_3 := le.address_3 <> ri.address_3;
    SELF.Diff_address_4 := le.address_4 <> ri.address_4;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_country := le.country <> ri.country;
    SELF.Diff_zipcode := le.zipcode <> ri.zipcode;
    SELF.Diff_duns := le.duns <> ri.duns;
    SELF.Diff_exclusionprogram := le.exclusionprogram <> ri.exclusionprogram;
    SELF.Diff_excludingagency := le.excludingagency <> ri.excludingagency;
    SELF.Diff_ctcode := le.ctcode <> ri.ctcode;
    SELF.Diff_exclusiontype := le.exclusiontype <> ri.exclusiontype;
    SELF.Diff_additionalcomments := le.additionalcomments <> ri.additionalcomments;
    SELF.Diff_activedate := le.activedate <> ri.activedate;
    SELF.Diff_terminationdate := le.terminationdate <> ri.terminationdate;
    SELF.Diff_recordstatus := le.recordstatus <> ri.recordstatus;
    SELF.Diff_crossreference := le.crossreference <> ri.crossreference;
    SELF.Diff_samnumber := le.samnumber <> ri.samnumber;
    SELF.Diff_cage := le.cage <> ri.cage;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_classification,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_prefix,1,0)+ IF( SELF.Diff_firstname,1,0)+ IF( SELF.Diff_middlename,1,0)+ IF( SELF.Diff_lastname,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_address_1,1,0)+ IF( SELF.Diff_address_2,1,0)+ IF( SELF.Diff_address_3,1,0)+ IF( SELF.Diff_address_4,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_country,1,0)+ IF( SELF.Diff_zipcode,1,0)+ IF( SELF.Diff_duns,1,0)+ IF( SELF.Diff_exclusionprogram,1,0)+ IF( SELF.Diff_excludingagency,1,0)+ IF( SELF.Diff_ctcode,1,0)+ IF( SELF.Diff_exclusiontype,1,0)+ IF( SELF.Diff_additionalcomments,1,0)+ IF( SELF.Diff_activedate,1,0)+ IF( SELF.Diff_terminationdate,1,0)+ IF( SELF.Diff_recordstatus,1,0)+ IF( SELF.Diff_crossreference,1,0)+ IF( SELF.Diff_samnumber,1,0)+ IF( SELF.Diff_cage,1,0);
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
    Count_Diff_classification := COUNT(GROUP,%Closest%.Diff_classification);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_prefix := COUNT(GROUP,%Closest%.Diff_prefix);
    Count_Diff_firstname := COUNT(GROUP,%Closest%.Diff_firstname);
    Count_Diff_middlename := COUNT(GROUP,%Closest%.Diff_middlename);
    Count_Diff_lastname := COUNT(GROUP,%Closest%.Diff_lastname);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_address_1 := COUNT(GROUP,%Closest%.Diff_address_1);
    Count_Diff_address_2 := COUNT(GROUP,%Closest%.Diff_address_2);
    Count_Diff_address_3 := COUNT(GROUP,%Closest%.Diff_address_3);
    Count_Diff_address_4 := COUNT(GROUP,%Closest%.Diff_address_4);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_country := COUNT(GROUP,%Closest%.Diff_country);
    Count_Diff_zipcode := COUNT(GROUP,%Closest%.Diff_zipcode);
    Count_Diff_duns := COUNT(GROUP,%Closest%.Diff_duns);
    Count_Diff_exclusionprogram := COUNT(GROUP,%Closest%.Diff_exclusionprogram);
    Count_Diff_excludingagency := COUNT(GROUP,%Closest%.Diff_excludingagency);
    Count_Diff_ctcode := COUNT(GROUP,%Closest%.Diff_ctcode);
    Count_Diff_exclusiontype := COUNT(GROUP,%Closest%.Diff_exclusiontype);
    Count_Diff_additionalcomments := COUNT(GROUP,%Closest%.Diff_additionalcomments);
    Count_Diff_activedate := COUNT(GROUP,%Closest%.Diff_activedate);
    Count_Diff_terminationdate := COUNT(GROUP,%Closest%.Diff_terminationdate);
    Count_Diff_recordstatus := COUNT(GROUP,%Closest%.Diff_recordstatus);
    Count_Diff_crossreference := COUNT(GROUP,%Closest%.Diff_crossreference);
    Count_Diff_samnumber := COUNT(GROUP,%Closest%.Diff_samnumber);
    Count_Diff_cage := COUNT(GROUP,%Closest%.Diff_cage);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
