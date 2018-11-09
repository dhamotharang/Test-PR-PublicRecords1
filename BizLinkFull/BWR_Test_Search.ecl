#workunit('name',BizLinkFull.MEOW_Service_name)
dRawData:=project(ENTH(dedup(BIPV2_Testing.files.xlink(src = 'INQ'), all),3000), transform({BIPV2_Testing.files.xlink, unsigned4 zip_radius, string2 st}, self := left, self.zip_radius := 15, self.st := left.company_state));
dInputFormalized:=BizLinkFull._Search.macFormalize(dRawData) : persist('~thor_data400::cemtemp::dInputFormalized');
BizLinkFull.MAC_MEOW_Biz_Online(dInputFormalized,uniqueid,parent_proxid,ultimate_proxid,has_lgid,empid,powid,source,source_record_id,company_name,company_name_prefix,cnp_name,
cnp_number,cnp_btype,cnp_lowv,company_phone,company_phone_3,company_phone_3_ex,company_phone_7,company_fein,company_sic_code1,prim_range,prim_name,sec_range,city,city_clean,st,zip_cases,company_url,
isContact,contact_did,title,fname,fname_preferred,mname,lname,name_suffix,contact_ssn,contact_email,sele_flag,org_flag,ult_flag,CONTACTNAME,STREETADDRESS,dAppended,outStats);
output(dRawData, named('dRawData'));
output(dInputFormalized, named('dInputFormalized'));
output(dAppended, named('dAppended'));
output(choosen(dAppended, 10), named('dAppended_10'));
// output(outStats);
c := count(dRawData);
is_hit := exists(dAppended.results(keys_failed = 0));
is_lafn := exists(dAppended.results(keys_failed <> 0)) and not is_hit;
is_error := dAppended.errorcode <> '';
is_miss := not exists(dAppended.results) and not is_error;
hits := dAppended(is_hit);
lafn := dAppended(is_lafn);
eror := dAppended(is_error);
miss := dAppended(is_miss);
rec_slim := record
  {dAppended} - [results_ultid, results_orgid, results_seleid];
end;
rec_super_slim := record
  {dAppended} - [results, results_ultid, results_orgid, results_seleid];
end;
mac(t) := macro
  #uniquename(pct)
  #uniquename(srtd)
  real %pct% := 100 * count(t) / c;
  %srtd% := sort(t, uniqueid);
  output(%pct%, named('pct_'+#text(t)));
  output(%srtd%, named('srtd_'+#text(t)));
  output(project(%srtd%, rec_slim), named('srtd_slim_'+#text(t)));
  output(project(%srtd%, rec_super_slim), named('srtd_super_slim_'+#text(t)));
  output(sort(table(t, {t.keys_tried, BizLinkFull.Process_Biz_Layouts.keysusedtotext(t.keys_tried), cnt := count(group)}, keys_tried), -cnt),     named('keys_tried_'+#text(t)));
  output(sort(table(t, {t.results[1].keys_failed, BizLinkFull.Process_Biz_Layouts.keysusedtotext(t.results[1].keys_failed), cnt := count(group)}, t.results[1].keys_failed), -cnt),named('keys_failed_resultrow1_'+#text(t)));
  output(sort(table(t, {t.results[1].keys_used, BizLinkFull.Process_Biz_Layouts.keysusedtotext(t.results[1].keys_used), cnt := count(group)}, t.results[1].keys_used), -cnt),named('keys_used_resultrow1_'+#text(t)));
endmacro;
mac(hits)
mac(lafn)
mac(eror)
mac(miss)
