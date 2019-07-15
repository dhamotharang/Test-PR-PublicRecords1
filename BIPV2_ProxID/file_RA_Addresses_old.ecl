/*2014-06-24T18:23:18Z (vern_p bentley)
check-in for BIP Sprint 17
*/
import mdr,corp2,BIPV2_Company_Names;
dlatest_iteration := BIPV2_ProxID.files().base.built;
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
//dcorpy_top100RA_addresses := table(dcorpy_filt  ,{string prim_range := corp_ra_prim_range, string prim_name := corp_ra_prim_name, string sec_range := corp_ra_sec_range,string v_city_name := corp_ra_v_city_name,string st := corp_ra_state,string zip := corp_ra_zip5,string company_name := corp_ra_cname1,unsigned8 cnt := count(group)},corp_ra_prim_range,corp_ra_prim_name,corp_ra_sec_range,corp_ra_v_city_name,corp_ra_state,corp_ra_zip5,corp_ra_cname1,merge);

dcorpy_top100RA_addresses  := sort(table(dcorpy_filt  ,{string prim_range := corp_ra_prim_range, string prim_name := corp_ra_prim_name, string sec_range := corp_ra_sec_range,string v_city_name := corp_ra_v_city_name,string st := corp_ra_state,string zip := corp_ra_zip5,string company_name := corp_ra_cname1,unsigned8 cnt := count(group),real8 percent := 0.0,unsigned8 running_total_count := count(group),real8 running_total_percent := 0.0},corp_ra_prim_range,corp_ra_prim_name,corp_ra_sec_range,corp_ra_v_city_name,corp_ra_state,corp_ra_zip5,corp_ra_cname1,merge),-cnt);

totalras := sum(dcorpy_top100RA_addresses,cnt);

dcorpy_topRA_addresses_iter := iterate(dcorpy_top100RA_addresses,transform(recordof(left),self.running_total_count := left.running_total_count + right.running_total_count,self.percent := right.cnt / totalras * 100.0,self.running_total_percent := self.running_total_count / totalras * 100.0,self := right));

//top 80% of RA addresses from corp file
daddunique := choosen(project(dcorpy_topRA_addresses_iter(running_total_percent <= 80.0),transform({unsigned6 rcid,recordof(left)},self.rcid := counter,self := left)),2000); //limit to 2000 addresses
BIPV2_Company_Names.functions.mac_go(daddunique, ds_out, rcid, company_name, false, false);
ddedup    := table(ds_out           (cnp_name != ''),{       prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name},       prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name,merge);
diterslim := table(dlatest_iteration(cnp_name != ''),{proxid,prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name},proxid,prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name,merge);
dBIP_top100_RA_Addresses := join(diterslim,ddedup ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip and left.cnp_name != right.cnp_name,transform(
  {unsigned6 proxid,string250 cname,recordof(right)}
  ,self := left
  ,self.cname := left.cnp_name
),hash);
file_RA_Addresses2  := table(dBIP_top100_RA_Addresses,{proxid,cname},proxid,cname,merge);

/////////////
daddunique2 := choosen(project(dcorpy_topRA_addresses_iter(running_total_percent > 80.0),transform({unsigned6 rcid,recordof(left)},self.rcid := counter,self := left)),400000); //limit to 2K
BIPV2_Company_Names.functions.mac_go(daddunique2, ds_out2, rcid, company_name, false, false);
ddedup2    := table(ds_out2           (cnp_name != ''),{       prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name},       prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name,merge);
diterslim2 := table(dlatest_iteration (cnp_name != ''),{proxid,prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name},proxid,prim_range,prim_name,sec_range,v_city_name,st,zip,cnp_name,merge);
dBIP_top100_RA_Addresses2 := join(diterslim2,ddedup2 ,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip and left.cnp_name != right.cnp_name,transform(
  {unsigned6 proxid,string250 cname,recordof(right)}
  ,self := left
  ,self.cname := left.cnp_name
),hash);

ddedupRA_addrs  := table(dBIP_top100_RA_Addresses2,{prim_range,prim_name,sec_range,v_city_name,st,zip,proxid},prim_range,prim_name,sec_range,v_city_name,st,zip,proxid,merge);
ddedupRA_addrs2 := table(ddedupRA_addrs           ,{prim_range,prim_name,sec_range,v_city_name,st,zip,unsigned8 cnt := count(group)},prim_range,prim_name,sec_range,v_city_name,st,zip,merge);
daddr_gt_250_proxids := choosen(ddedupRA_addrs2(cnt >= 35),50000); //limit to 50K

dmtchback := join(dBIP_top100_RA_Addresses2,daddr_gt_250_proxids,left.prim_range = right.prim_range and left.prim_name = right.prim_name and left.sec_range = right.sec_range and left.v_city_name = right.v_city_name and left.st = right.st and left.zip = right.zip,transform(
  {unsigned6 proxid,string250 cname,recordof(right)}
  ,self := left
//  ,self.cname := left.cnp_name
,self := right
),hash);

file_RA_Addresses3  := table(dmtchback,{proxid,cname},proxid,cname,merge);

export file_RA_Addresses_old  := table(file_RA_Addresses2 + file_RA_Addresses3,{proxid,cname},proxid,cname,merge);
