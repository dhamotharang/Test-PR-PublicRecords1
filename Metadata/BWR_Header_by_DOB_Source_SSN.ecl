//Header by DOB Robustness by John J. Bulten 20070620 W20070706-120327 W20071210-133649 20080221
//Results were parsed through Excel PivotTable

dDev := distribute(dataset('~thor_data400::base::header_prod',header.Layout_Header,flat),hash(dob,src));

rDev := record
  dDev.src;
  dDev.dob;
  dDev.ssn;
  dDev.prim_name;
  dDev.city_name;
  dDev.valid_SSN;
  dDev.jflag1;
  nCount := count(group);
end;

tDev := table(distributed(dDev/*(st='PR')*/,hash(dob,src)),rDev,src,dob,ssn,prim_name,city_name,valid_SSN,jflag1,all);

//Less than 8-digit DOB by source, validity BCILTU -145303
output(table(distributed(tDev,hash(dob,src))(dob<10000000),{src,0,sum(group,nCount),jflag1},src,jflag1),all);

//8-digit DOB by source, mmdd, validity BCILTU -152150
output(table(distributed(tDev,hash(dob,src))(dob between 10000000 and 99999999),{src,dob%10000,sum(group,nCount),jflag1},src,dob%10000,jflag1),all);

//9-digit DOB by source, mmdd00
output(table(distributed(tDev,hash(dob,src))(dob between 100000000 and 999999999),{src,dob%1000000,sum(group,nCount)},src,dob%1000000),all);

//All by SSN prefix, validity BFGORU -152150
output(table(distributed(tDev,hash(dob,src)),{ssn[1..3],valid_SSN,sum(group,nCount)},ssn[1..3],valid_SSN),all);

//8-digit DOB by source, ccyy -144528
output(table(distributed(tDev,hash(dob,src))(dob between 10000000 and 99999999),{src,dob div 10000,sum(group,nCount)},src,dob div 10000),all);