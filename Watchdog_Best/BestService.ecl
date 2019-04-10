/*--SOAP--
<message name="BestService">
<part name="did" type="xsd:string"/>
</message>
*/
/*--INFO-- Will show the Best logic as applied to a particular did.*/
EXPORT BestService := MACRO
  IMPORT SALT311,Watchdog_best;
  STRING20 didstr := ''  : STORED('did', FORMAT(SEQUENCE(1)));
  SALT311.UIDType uid := (SALT311.UIDType)didstr;
TheData := PROJECT(LIMIT(Watchdog_best.Keys(Watchdog_best.In_Hdr).InData(did=uid),Watchdog_best.Config.JoinLimit),Watchdog_best.Layout_Hdr);
cm_s := GLOBAL(PROJECT(Watchdog_best.Keys(TheData).Specificities_Key,Watchdog_best.Layout_Specificities.R)[1]);
CM := Watchdog_best.MAC_CreateBest(TheData, cm_s, TRUE);
OUTPUT(CM.BestBy_did_np,NAMED('BestBy_did'));
OUTPUT(CM.BestBy_did_child_np,NAMED('BestBy_did_child'));
OUTPUT(CM.BestBy_did_best_np,NAMED('BestBy_did_best'));
OUTPUT(CM.BestTitle_tab_title,NAMED('Tab_BestTitle_title'));
OUTPUT(CM.BestTitle_method_title,NAMED('Method_BestTitle_title'));
OUTPUT(CM.BestSuffix_tab_name_suffix,NAMED('Tab_BestSuffix_name_suffix'));
OUTPUT(CM.BestSuffix_method_name_suffix,NAMED('Method_BestSuffix_name_suffix'));
OUTPUT(CM.BestSSN_tab_ssnum,NAMED('Tab_BestSSN_ssnum'));
OUTPUT(CM.BestSSN_method_ssnum,NAMED('Method_BestSSN_ssnum'));
OUTPUT(CM.SecondBestSSN_tab_ssnum,NAMED('Tab_SecondBestSSN_ssnum'));
OUTPUT(CM.SecondBestSSN_method_ssnum,NAMED('Method_SecondBestSSN_ssnum'));
OUTPUT(CM.BestPhoneCurrentWithNpa_tab_phone,NAMED('Tab_BestPhoneCurrentWithNpa_phone'));
OUTPUT(CM.BestPhoneCurrentWithNpa_method_phone,NAMED('Method_BestPhoneCurrentWithNpa_phone'));
OUTPUT(CM.BestDOB_tab_dob,NAMED('Tab_BestDOB_dob'));
OUTPUT(CM.BestDOB_method_dob,NAMED('Method_BestDOB_dob'));
OUTPUT(CM.NoDayDOB_tab_dob,NAMED('Tab_NoDayDOB_dob'));
OUTPUT(CM.NoDayDOB_method_dob,NAMED('Method_NoDayDOB_dob'));
OUTPUT(CM.NoMonthDOB_tab_dob,NAMED('Tab_NoMonthDOB_dob'));
OUTPUT(CM.NoMonthDOB_method_dob,NAMED('Method_NoMonthDOB_dob'));
OUTPUT(CM.BestAddress_tab_address,NAMED('Tab_BestAddress_address'));
OUTPUT(CM.BestAddress_method_address,NAMED('Method_BestAddress_address'));
OUTPUT(CM.GongAddressBySeen_tab_address,NAMED('Tab_GongAddressBySeen_address'));
OUTPUT(CM.GongAddressBySeen_method_address,NAMED('Method_GongAddressBySeen_address'));
OUTPUT(CM.BetterAddressBySeen_tab_address,NAMED('Tab_BetterAddressBySeen_address'));
OUTPUT(CM.BetterAddressBySeen_method_address,NAMED('Method_BetterAddressBySeen_address'));
OUTPUT(CM.RecentAddressBySeen_tab_address,NAMED('Tab_RecentAddressBySeen_address'));
OUTPUT(CM.RecentAddressBySeen_method_address,NAMED('Method_RecentAddressBySeen_address'));
OUTPUT(CM.BetterAddressByReported_tab_address,NAMED('Tab_BetterAddressByReported_address'));
OUTPUT(CM.BetterAddressByReported_method_address,NAMED('Method_BetterAddressByReported_address'));
OUTPUT(CM.RecentAddressByReported_tab_address,NAMED('Tab_RecentAddressByReported_address'));
OUTPUT(CM.RecentAddressByReported_method_address,NAMED('Method_RecentAddressByReported_address'));
OUTPUT(CM.CommonestAddress_tab_address,NAMED('Tab_CommonestAddress_address'));
OUTPUT(CM.CommonestAddress_method_address,NAMED('Method_CommonestAddress_address'));
OUTPUT(CM.BestFirstName_tab_fname,NAMED('Tab_BestFirstName_fname'));
OUTPUT(CM.BestFirstName_method_fname,NAMED('Method_BestFirstName_fname'));
OUTPUT(CM.CommonFirstName_tab_fname,NAMED('Tab_CommonFirstName_fname'));
OUTPUT(CM.CommonFirstName_method_fname,NAMED('Method_CommonFirstName_fname'));
OUTPUT(CM.BestMiddleName_tab_mname,NAMED('Tab_BestMiddleName_mname'));
OUTPUT(CM.BestMiddleName_method_mname,NAMED('Method_BestMiddleName_mname'));
OUTPUT(CM.CommonMiddleName_tab_mname,NAMED('Tab_CommonMiddleName_mname'));
OUTPUT(CM.CommonMiddleName_method_mname,NAMED('Method_CommonMiddleName_mname'));
OUTPUT(CM.CommonLastName_tab_lname,NAMED('Tab_CommonLastName_lname'));
OUTPUT(CM.CommonLastName_method_lname,NAMED('Method_CommonLastName_lname'));
ENDMACRO;
