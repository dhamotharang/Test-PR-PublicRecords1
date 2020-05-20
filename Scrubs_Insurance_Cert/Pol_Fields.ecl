IMPORT SALT311;
EXPORT Pol_Fields := MODULE
 
EXPORT NumFields := 33;
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'lnpolicyid','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'lnpolicyid','lninscertrecordid','dartid','insuranceprovider','policynumber','coveragestartdate','coverageexpirationdate','coveragewrapup','policystatus','insuranceprovideraddressline','insuranceprovideraddressline2','insuranceprovidercity','insuranceproviderstate','insuranceproviderzip','insuranceproviderzip4','insuranceproviderphone','insuranceproviderfax','coveragereinstatedate','coveragecancellationdate','coveragewrapupdate','businessnameduringcoverage','addresslineduringcoverage','addressline2duringcoverage','cityduringcoverage','stateduringcoverage','zipduringcoverage','zip4duringcoverage','numberofemployeesduringcoverage','insuranceprovidercontactdept','insurancetype','coverageposteddate','coverageamountfrom','coverageamountto');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'lnpolicyid' => 0,'lninscertrecordid' => 1,'dartid' => 2,'insuranceprovider' => 3,'policynumber' => 4,'coveragestartdate' => 5,'coverageexpirationdate' => 6,'coveragewrapup' => 7,'policystatus' => 8,'insuranceprovideraddressline' => 9,'insuranceprovideraddressline2' => 10,'insuranceprovidercity' => 11,'insuranceproviderstate' => 12,'insuranceproviderzip' => 13,'insuranceproviderzip4' => 14,'insuranceproviderphone' => 15,'insuranceproviderfax' => 16,'coveragereinstatedate' => 17,'coveragecancellationdate' => 18,'coveragewrapupdate' => 19,'businessnameduringcoverage' => 20,'addresslineduringcoverage' => 21,'addressline2duringcoverage' => 22,'cityduringcoverage' => 23,'stateduringcoverage' => 24,'zipduringcoverage' => 25,'zip4duringcoverage' => 26,'numberofemployeesduringcoverage' => 27,'insuranceprovidercontactdept' => 28,'insurancetype' => 29,'coverageposteddate' => 30,'coverageamountfrom' => 31,'coverageamountto' => 32,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_lnpolicyid(SALT311.StrType s0) := s0;
EXPORT InValid_lnpolicyid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lnpolicyid(UNSIGNED1 wh) := '';
 
EXPORT Make_lninscertrecordid(SALT311.StrType s0) := s0;
EXPORT InValid_lninscertrecordid(SALT311.StrType s) := 0;
EXPORT InValidMessage_lninscertrecordid(UNSIGNED1 wh) := '';
 
EXPORT Make_dartid(SALT311.StrType s0) := s0;
EXPORT InValid_dartid(SALT311.StrType s) := 0;
EXPORT InValidMessage_dartid(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceprovider(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceprovider(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceprovider(UNSIGNED1 wh) := '';
 
EXPORT Make_policynumber(SALT311.StrType s0) := s0;
EXPORT InValid_policynumber(SALT311.StrType s) := 0;
EXPORT InValidMessage_policynumber(UNSIGNED1 wh) := '';
 
EXPORT Make_coveragestartdate(SALT311.StrType s0) := s0;
EXPORT InValid_coveragestartdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_coveragestartdate(UNSIGNED1 wh) := '';
 
EXPORT Make_coverageexpirationdate(SALT311.StrType s0) := s0;
EXPORT InValid_coverageexpirationdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_coverageexpirationdate(UNSIGNED1 wh) := '';
 
EXPORT Make_coveragewrapup(SALT311.StrType s0) := s0;
EXPORT InValid_coveragewrapup(SALT311.StrType s) := 0;
EXPORT InValidMessage_coveragewrapup(UNSIGNED1 wh) := '';
 
EXPORT Make_policystatus(SALT311.StrType s0) := s0;
EXPORT InValid_policystatus(SALT311.StrType s) := 0;
EXPORT InValidMessage_policystatus(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceprovideraddressline(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceprovideraddressline(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceprovideraddressline(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceprovideraddressline2(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceprovideraddressline2(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceprovideraddressline2(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceprovidercity(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceprovidercity(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceprovidercity(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceproviderstate(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceproviderstate(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceproviderstate(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceproviderzip(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceproviderzip(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceproviderzip(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceproviderzip4(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceproviderzip4(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceproviderzip4(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceproviderphone(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceproviderphone(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceproviderphone(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceproviderfax(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceproviderfax(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceproviderfax(UNSIGNED1 wh) := '';
 
EXPORT Make_coveragereinstatedate(SALT311.StrType s0) := s0;
EXPORT InValid_coveragereinstatedate(SALT311.StrType s) := 0;
EXPORT InValidMessage_coveragereinstatedate(UNSIGNED1 wh) := '';
 
EXPORT Make_coveragecancellationdate(SALT311.StrType s0) := s0;
EXPORT InValid_coveragecancellationdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_coveragecancellationdate(UNSIGNED1 wh) := '';
 
EXPORT Make_coveragewrapupdate(SALT311.StrType s0) := s0;
EXPORT InValid_coveragewrapupdate(SALT311.StrType s) := 0;
EXPORT InValidMessage_coveragewrapupdate(UNSIGNED1 wh) := '';
 
EXPORT Make_businessnameduringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_businessnameduringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_businessnameduringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_addresslineduringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_addresslineduringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_addresslineduringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_addressline2duringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_addressline2duringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_addressline2duringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_cityduringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_cityduringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_cityduringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_stateduringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_stateduringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_stateduringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_zipduringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_zipduringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_zipduringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4duringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_zip4duringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_zip4duringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_numberofemployeesduringcoverage(SALT311.StrType s0) := s0;
EXPORT InValid_numberofemployeesduringcoverage(SALT311.StrType s) := 0;
EXPORT InValidMessage_numberofemployeesduringcoverage(UNSIGNED1 wh) := '';
 
EXPORT Make_insuranceprovidercontactdept(SALT311.StrType s0) := s0;
EXPORT InValid_insuranceprovidercontactdept(SALT311.StrType s) := 0;
EXPORT InValidMessage_insuranceprovidercontactdept(UNSIGNED1 wh) := '';
 
EXPORT Make_insurancetype(SALT311.StrType s0) := s0;
EXPORT InValid_insurancetype(SALT311.StrType s) := 0;
EXPORT InValidMessage_insurancetype(UNSIGNED1 wh) := '';
 
EXPORT Make_coverageposteddate(SALT311.StrType s0) := s0;
EXPORT InValid_coverageposteddate(SALT311.StrType s) := 0;
EXPORT InValidMessage_coverageposteddate(UNSIGNED1 wh) := '';
 
EXPORT Make_coverageamountfrom(SALT311.StrType s0) := s0;
EXPORT InValid_coverageamountfrom(SALT311.StrType s) := 0;
EXPORT InValidMessage_coverageamountfrom(UNSIGNED1 wh) := '';
 
EXPORT Make_coverageamountto(SALT311.StrType s0) := s0;
EXPORT InValid_coverageamountto(SALT311.StrType s) := 0;
EXPORT InValidMessage_coverageamountto(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Insurance_Cert;
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
    BOOLEAN Diff_lnpolicyid;
    BOOLEAN Diff_lninscertrecordid;
    BOOLEAN Diff_dartid;
    BOOLEAN Diff_insuranceprovider;
    BOOLEAN Diff_policynumber;
    BOOLEAN Diff_coveragestartdate;
    BOOLEAN Diff_coverageexpirationdate;
    BOOLEAN Diff_coveragewrapup;
    BOOLEAN Diff_policystatus;
    BOOLEAN Diff_insuranceprovideraddressline;
    BOOLEAN Diff_insuranceprovideraddressline2;
    BOOLEAN Diff_insuranceprovidercity;
    BOOLEAN Diff_insuranceproviderstate;
    BOOLEAN Diff_insuranceproviderzip;
    BOOLEAN Diff_insuranceproviderzip4;
    BOOLEAN Diff_insuranceproviderphone;
    BOOLEAN Diff_insuranceproviderfax;
    BOOLEAN Diff_coveragereinstatedate;
    BOOLEAN Diff_coveragecancellationdate;
    BOOLEAN Diff_coveragewrapupdate;
    BOOLEAN Diff_businessnameduringcoverage;
    BOOLEAN Diff_addresslineduringcoverage;
    BOOLEAN Diff_addressline2duringcoverage;
    BOOLEAN Diff_cityduringcoverage;
    BOOLEAN Diff_stateduringcoverage;
    BOOLEAN Diff_zipduringcoverage;
    BOOLEAN Diff_zip4duringcoverage;
    BOOLEAN Diff_numberofemployeesduringcoverage;
    BOOLEAN Diff_insuranceprovidercontactdept;
    BOOLEAN Diff_insurancetype;
    BOOLEAN Diff_coverageposteddate;
    BOOLEAN Diff_coverageamountfrom;
    BOOLEAN Diff_coverageamountto;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_lnpolicyid := le.lnpolicyid <> ri.lnpolicyid;
    SELF.Diff_lninscertrecordid := le.lninscertrecordid <> ri.lninscertrecordid;
    SELF.Diff_dartid := le.dartid <> ri.dartid;
    SELF.Diff_insuranceprovider := le.insuranceprovider <> ri.insuranceprovider;
    SELF.Diff_policynumber := le.policynumber <> ri.policynumber;
    SELF.Diff_coveragestartdate := le.coveragestartdate <> ri.coveragestartdate;
    SELF.Diff_coverageexpirationdate := le.coverageexpirationdate <> ri.coverageexpirationdate;
    SELF.Diff_coveragewrapup := le.coveragewrapup <> ri.coveragewrapup;
    SELF.Diff_policystatus := le.policystatus <> ri.policystatus;
    SELF.Diff_insuranceprovideraddressline := le.insuranceprovideraddressline <> ri.insuranceprovideraddressline;
    SELF.Diff_insuranceprovideraddressline2 := le.insuranceprovideraddressline2 <> ri.insuranceprovideraddressline2;
    SELF.Diff_insuranceprovidercity := le.insuranceprovidercity <> ri.insuranceprovidercity;
    SELF.Diff_insuranceproviderstate := le.insuranceproviderstate <> ri.insuranceproviderstate;
    SELF.Diff_insuranceproviderzip := le.insuranceproviderzip <> ri.insuranceproviderzip;
    SELF.Diff_insuranceproviderzip4 := le.insuranceproviderzip4 <> ri.insuranceproviderzip4;
    SELF.Diff_insuranceproviderphone := le.insuranceproviderphone <> ri.insuranceproviderphone;
    SELF.Diff_insuranceproviderfax := le.insuranceproviderfax <> ri.insuranceproviderfax;
    SELF.Diff_coveragereinstatedate := le.coveragereinstatedate <> ri.coveragereinstatedate;
    SELF.Diff_coveragecancellationdate := le.coveragecancellationdate <> ri.coveragecancellationdate;
    SELF.Diff_coveragewrapupdate := le.coveragewrapupdate <> ri.coveragewrapupdate;
    SELF.Diff_businessnameduringcoverage := le.businessnameduringcoverage <> ri.businessnameduringcoverage;
    SELF.Diff_addresslineduringcoverage := le.addresslineduringcoverage <> ri.addresslineduringcoverage;
    SELF.Diff_addressline2duringcoverage := le.addressline2duringcoverage <> ri.addressline2duringcoverage;
    SELF.Diff_cityduringcoverage := le.cityduringcoverage <> ri.cityduringcoverage;
    SELF.Diff_stateduringcoverage := le.stateduringcoverage <> ri.stateduringcoverage;
    SELF.Diff_zipduringcoverage := le.zipduringcoverage <> ri.zipduringcoverage;
    SELF.Diff_zip4duringcoverage := le.zip4duringcoverage <> ri.zip4duringcoverage;
    SELF.Diff_numberofemployeesduringcoverage := le.numberofemployeesduringcoverage <> ri.numberofemployeesduringcoverage;
    SELF.Diff_insuranceprovidercontactdept := le.insuranceprovidercontactdept <> ri.insuranceprovidercontactdept;
    SELF.Diff_insurancetype := le.insurancetype <> ri.insurancetype;
    SELF.Diff_coverageposteddate := le.coverageposteddate <> ri.coverageposteddate;
    SELF.Diff_coverageamountfrom := le.coverageamountfrom <> ri.coverageamountfrom;
    SELF.Diff_coverageamountto := le.coverageamountto <> ri.coverageamountto;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_lnpolicyid,1,0)+ IF( SELF.Diff_lninscertrecordid,1,0)+ IF( SELF.Diff_dartid,1,0)+ IF( SELF.Diff_insuranceprovider,1,0)+ IF( SELF.Diff_policynumber,1,0)+ IF( SELF.Diff_coveragestartdate,1,0)+ IF( SELF.Diff_coverageexpirationdate,1,0)+ IF( SELF.Diff_coveragewrapup,1,0)+ IF( SELF.Diff_policystatus,1,0)+ IF( SELF.Diff_insuranceprovideraddressline,1,0)+ IF( SELF.Diff_insuranceprovideraddressline2,1,0)+ IF( SELF.Diff_insuranceprovidercity,1,0)+ IF( SELF.Diff_insuranceproviderstate,1,0)+ IF( SELF.Diff_insuranceproviderzip,1,0)+ IF( SELF.Diff_insuranceproviderzip4,1,0)+ IF( SELF.Diff_insuranceproviderphone,1,0)+ IF( SELF.Diff_insuranceproviderfax,1,0)+ IF( SELF.Diff_coveragereinstatedate,1,0)+ IF( SELF.Diff_coveragecancellationdate,1,0)+ IF( SELF.Diff_coveragewrapupdate,1,0)+ IF( SELF.Diff_businessnameduringcoverage,1,0)+ IF( SELF.Diff_addresslineduringcoverage,1,0)+ IF( SELF.Diff_addressline2duringcoverage,1,0)+ IF( SELF.Diff_cityduringcoverage,1,0)+ IF( SELF.Diff_stateduringcoverage,1,0)+ IF( SELF.Diff_zipduringcoverage,1,0)+ IF( SELF.Diff_zip4duringcoverage,1,0)+ IF( SELF.Diff_numberofemployeesduringcoverage,1,0)+ IF( SELF.Diff_insuranceprovidercontactdept,1,0)+ IF( SELF.Diff_insurancetype,1,0)+ IF( SELF.Diff_coverageposteddate,1,0)+ IF( SELF.Diff_coverageamountfrom,1,0)+ IF( SELF.Diff_coverageamountto,1,0);
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
    Count_Diff_lnpolicyid := COUNT(GROUP,%Closest%.Diff_lnpolicyid);
    Count_Diff_lninscertrecordid := COUNT(GROUP,%Closest%.Diff_lninscertrecordid);
    Count_Diff_dartid := COUNT(GROUP,%Closest%.Diff_dartid);
    Count_Diff_insuranceprovider := COUNT(GROUP,%Closest%.Diff_insuranceprovider);
    Count_Diff_policynumber := COUNT(GROUP,%Closest%.Diff_policynumber);
    Count_Diff_coveragestartdate := COUNT(GROUP,%Closest%.Diff_coveragestartdate);
    Count_Diff_coverageexpirationdate := COUNT(GROUP,%Closest%.Diff_coverageexpirationdate);
    Count_Diff_coveragewrapup := COUNT(GROUP,%Closest%.Diff_coveragewrapup);
    Count_Diff_policystatus := COUNT(GROUP,%Closest%.Diff_policystatus);
    Count_Diff_insuranceprovideraddressline := COUNT(GROUP,%Closest%.Diff_insuranceprovideraddressline);
    Count_Diff_insuranceprovideraddressline2 := COUNT(GROUP,%Closest%.Diff_insuranceprovideraddressline2);
    Count_Diff_insuranceprovidercity := COUNT(GROUP,%Closest%.Diff_insuranceprovidercity);
    Count_Diff_insuranceproviderstate := COUNT(GROUP,%Closest%.Diff_insuranceproviderstate);
    Count_Diff_insuranceproviderzip := COUNT(GROUP,%Closest%.Diff_insuranceproviderzip);
    Count_Diff_insuranceproviderzip4 := COUNT(GROUP,%Closest%.Diff_insuranceproviderzip4);
    Count_Diff_insuranceproviderphone := COUNT(GROUP,%Closest%.Diff_insuranceproviderphone);
    Count_Diff_insuranceproviderfax := COUNT(GROUP,%Closest%.Diff_insuranceproviderfax);
    Count_Diff_coveragereinstatedate := COUNT(GROUP,%Closest%.Diff_coveragereinstatedate);
    Count_Diff_coveragecancellationdate := COUNT(GROUP,%Closest%.Diff_coveragecancellationdate);
    Count_Diff_coveragewrapupdate := COUNT(GROUP,%Closest%.Diff_coveragewrapupdate);
    Count_Diff_businessnameduringcoverage := COUNT(GROUP,%Closest%.Diff_businessnameduringcoverage);
    Count_Diff_addresslineduringcoverage := COUNT(GROUP,%Closest%.Diff_addresslineduringcoverage);
    Count_Diff_addressline2duringcoverage := COUNT(GROUP,%Closest%.Diff_addressline2duringcoverage);
    Count_Diff_cityduringcoverage := COUNT(GROUP,%Closest%.Diff_cityduringcoverage);
    Count_Diff_stateduringcoverage := COUNT(GROUP,%Closest%.Diff_stateduringcoverage);
    Count_Diff_zipduringcoverage := COUNT(GROUP,%Closest%.Diff_zipduringcoverage);
    Count_Diff_zip4duringcoverage := COUNT(GROUP,%Closest%.Diff_zip4duringcoverage);
    Count_Diff_numberofemployeesduringcoverage := COUNT(GROUP,%Closest%.Diff_numberofemployeesduringcoverage);
    Count_Diff_insuranceprovidercontactdept := COUNT(GROUP,%Closest%.Diff_insuranceprovidercontactdept);
    Count_Diff_insurancetype := COUNT(GROUP,%Closest%.Diff_insurancetype);
    Count_Diff_coverageposteddate := COUNT(GROUP,%Closest%.Diff_coverageposteddate);
    Count_Diff_coverageamountfrom := COUNT(GROUP,%Closest%.Diff_coverageamountfrom);
    Count_Diff_coverageamountto := COUNT(GROUP,%Closest%.Diff_coverageamountto);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
