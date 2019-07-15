dbasebuilt  := BIPV2_ProxID.files('20130925a_45',true).base.logical;  //this was 1 iteration run on top of a completely fixed input file(no foreign corpkey overlinks)
daggProxid        := tools.mac_AggregateFieldsPerID(dbasebuilt,proxid,['foreign_corp_key','cnp_name','company_name'],false);
dagg_badProxid    := daggProxid(count(foreign_corp_keys) != count(table(foreign_corp_keys,{state := trim(foreign_corp_key,left,right)[1..2]},trim(foreign_corp_key,left,right)[1..2])));
output(dbasebuilt     ,named('dbasebuilt'));
output(daggProxid     ,named('daggProxid'));
output(dagg_badProxid ,named('dagg_badProxid'));
output(count(dbasebuilt     ),named('countdbasebuilt'    ));
output(count(daggProxid     ),named('countdaggProxid'    ));
output(count(dagg_badProxid ),named('countdagg_badProxid'));
//RA stuff
dbase   := BIPV2_ProxID.files('20130905',true).base.logical;
dcorpy  := corp2.files().base.corp.qa;
//find most common RA addresses with cname
dcorpy_filt := dcorpy(
     corp_ra_prim_name           != ''
    ,corp_ra_v_city_name         != ''
    ,corp_ra_sec_range           != ''
    ,corp_ra_state               != ''
    ,corp_ra_zip5                != ''
    ,corp_ra_cname1              != ''
    ,not regexfind('SECRETARY OF STATE',corp_ra_name ,nocase)          
);
//grab top 100 RA addresses
dcorpy_top100RA_addresses := topn(table(dcorpy_filt  ,{string prim_range := corp_ra_prim_range, string prim_name := corp_ra_prim_name, string sec_range := corp_ra_sec_range,string v_city_name := corp_ra_v_city_name,string st := corp_ra_state,string zip := corp_ra_zip5,string company_name := corp_ra_cname1,unsigned8 cnt := count(group)},corp_ra_prim_range,corp_ra_prim_name,corp_ra_sec_range,corp_ra_v_city_name,corp_ra_state,corp_ra_zip5,corp_ra_cname1,merge),100,-cnt);
dBIP_top100_RA_Addresses := join(dbase,dcorpy_top100RA_addresses  ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip and left.company_name != right.company_name,transform(
  recordof(left)
  ,self := left
),lookup): persist('~persist::lbentley::dBIP_top100_RA_Addresses');
dBIP_top100_NotRA_Addresses := join(dbase,dcorpy_top100RA_addresses  ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip and left.company_name != right.company_name,transform(
  recordof(left)
  ,self := left
),lookup,left only): persist('~persist::lbentley::dBIP_top100_NotRA_Addresses');
//now see how many of these have other records with their correct address
dBIP_top100_RA_Addresses_corp := dBIP_top100_RA_Addresses(mdr.sourcetools.sourceisCorpV2(source),vl_id != '');
dget_other_recs := join(dBIP_top100_NotRA_Addresses  ,table(dBIP_top100_RA_Addresses_corp  ,{source,vl_id},source,vl_id,merge)  ,left.source = right.source and left.vl_id = right.vl_id  ,transform(left));
dbaseaggTop100RA_Addresses    := BIPV2_ProxID.AggregateProxidElements(dBIP_top100_RA_Addresses ) : persist('~persist::lbentley::dbaseaggTop100RA_Addresses'     );
dbaseaggTop100NotRA_Addresses := BIPV2_ProxID.AggregateProxidElements(dget_other_recs          ) : persist('~persist::lbentley::dbaseaggTop100NotRA_Addresses'  );
dcheckcnames := project(dbaseaggTop100RA_Addresses ,transform({recordof(left),unsigned8 cnamescore,real8 averagediff,unsigned8 diffscore,dataset(recordof(left.cnp_names)) cnp_namessorted},self := left
,self.cnamescore  := sum(iterate(sort(left.cnp_names(length(trim(cnp_name)) > 4),cnp_name),transform(recordof(left),self.cnt := ut.CompanySimilar100(ut.CleanCompany(left.cnp_name), ut.CleanCompany(right.cnp_name)), self := right)),cnt);
,self.diffscore   := sum(iterate(sort(left.cnp_names(length(trim(cnp_name)) > 4),trim(cnp_name,left,right)),transform(recordof(left),self.cnt := if(trim(left.cnp_name,left,right)[1..4] = trim(right.cnp_name,left,right)[1..4],0,1), self := right)),cnt);
,self.cnp_namessorted   := iterate(sort(left.cnp_names(length(trim(cnp_name)) > 4),trim(cnp_name,left,right)),transform(recordof(left),self.cnt := if(trim(left.cnp_name,left,right)[1..4] = trim(right.cnp_name,left,right)[1..4],0,1), self := right));
,self.averagediff := self.cnamescore / count(left.cnp_names) * 100.0;
));
countdbase                      := count(dbase                      );
countdcorpy                     := count(dcorpy                     );
countdcorpy_filt                := count(dcorpy_filt                );
countdcorpy_top100RA_addresses  := count(dcorpy_top100RA_addresses  );
countdBIP_top100_RA_Addresses   := count(dBIP_top100_RA_Addresses   );
countdbaseaggTop100RA_Addresses := count(dbaseaggTop100RA_Addresses );
countdcheckcnames               := count(dcheckcnames               );
countdBIP_top100_NotRA_Addresses    := count(dBIP_top100_NotRA_Addresses   );
countdBIP_top100_RA_Addresses_corp  := count(dBIP_top100_RA_Addresses_corp );
countdget_other_recs                := count(dget_other_recs               );
countdbaseaggTop100NotRA_Addresses  := count(dbaseaggTop100NotRA_Addresses );
output(countdbase                      ,named('countdbase'                     ));
output(countdcorpy                     ,named('countdcorpy'                    ));
output(countdcorpy_filt                ,named('countdcorpy_filt'               ));
output(countdcorpy_top100RA_addresses  ,named('countdcorpy_top100RA_addresses' ));
output(countdBIP_top100_RA_Addresses   ,named('countdBIP_top100_RA_Addresses'  ));
output(countdbaseaggTop100RA_Addresses ,named('countdbaseaggTop100RA_Addresses'));
output(countdcheckcnames               ,named('countdcheckcnames'              ));
output(countdBIP_top100_NotRA_Addresses   ,named('countdBIP_top100_NotRA_Addresses'                ));
output(countdBIP_top100_RA_Addresses_corp ,named('countdBIP_top100_RA_Addresses_corp'              ));
output(countdget_other_recs               ,named('countdget_other_recs'                            ));
output(countdbaseaggTop100NotRA_Addresses ,named('countdbaseaggTop100NotRA_Addresses'              ));
output(dBIP_top100_NotRA_Addresses   ,named('dBIP_top100_NotRA_Addresses'                ));
output(dBIP_top100_RA_Addresses_corp ,named('dBIP_top100_RA_Addresses_corp'              ));
output(dget_other_recs               ,named('dget_other_recs'                            ));
output(dbaseaggTop100NotRA_Addresses ,named('dbaseaggTop100NotRA_Addresses'              ));
output(dbase                      ,named('dbase'                     ));
output(dcorpy                     ,named('dcorpy'                    ));
output(dcorpy_filt                ,named('dcorpy_filt'               ));
output(dcorpy_top100RA_addresses  ,named('dcorpy_top100RA_addresses' ));
output(dBIP_top100_RA_Addresses   ,named('dBIP_top100_RA_Addresses'  ));
output(dbaseaggTop100RA_Addresses ,named('dbaseaggTop100RA_Addresses'));
output(dcheckcnames               ,named('dcheckcnames'              ));
//output(topn(dcorpy_top100RA_addresses    ,500,-cnt) ,named('dcorpy_top100RA_addresses'));
output(topn(dbaseaggTop100RA_Addresses   ,500,addresss[1].address,company_names[1].company_name)  ,named('dbaseaggTop100RA_AddressesSortAddress'),all);
output(choosen(dbaseaggTop100RA_Addresses,500)  ,named('dbaseaggTop100RA_AddressesMostOverLinked'),all);
output(topn(dbaseaggTop100RA_Addresses   ,50,-count(cnp_names))  ,named('dbaseaggTop100RA_AddressesCompany_name'),all);
output(topn(dbaseaggTop100RA_Addresses(count(foreign_corp_keys) <= 1)   ,50,-count(cnp_names))  ,named('dbaseaggTop100RA_AddressesCompany_name1Fcorpkey'),all);
output(topn(dcheckcnames                ,50,-cnamescore)  ,named('MostDiffCnames'),all);
output(topn(dcheckcnames                ,50,-averagediff)  ,named('MostAverageDiffCnames'),all);
output(topn(dcheckcnames                ,50,-diffscore  )  ,named('MostDiffCnames1_4'),all);
