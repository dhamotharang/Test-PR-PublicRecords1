//I used prim_range_derived_weight100 instead of prim_range_weight100 here... ????? don't know whether it is OK and the reason
EXPORT _mj_extra(
   pH
  ,pMatchJoin
  ,pFilterPnames  = 'BIPV2_ProxID.file_filter_Prim_names'
  ,pCnpNames      = 'BIPV2_ProxID.file_cnp_names'
) :=
functionmacro

  //mj0 blocks on prim_name like normal
  //mj1 blocks on cnp_name like normal(add not cnp_name address perfect match)
  //mj2 & 3 like before(cnp_name[1..4] and sec_range  (add not cnp_name address perfect match)
  //mj4 perfect cnp_name, address match
  
  dn01         := pH(~prim_name_derived_isnull AND ~st_isnull);
  dJ1          := join(dn01,pFilterPnames,left.proxid = right.proxid,transform({recordof(left),string28  pname_digits := ''},self := left,self := right),left outer,hash,keep(1));
  dJ2          := join(dJ1 ,pCnpNames    ,left.rcid   = right.rcid  ,transform({recordof(left),string250 cnp_name_raw := ''},self := left,self := right),left outer,hash,keep(1));
  
  dn0_deduped1 := dJ2(cnp_number_weight100 + st_weight100 + prim_range_derived_weight100>=500,~st_isnull); // Use specificity to flag high-dup counts
  dn0_srange1  := dn0_deduped1(sec_range != '');
  
  dn0_deduped2 := dn01(cnp_number_weight100 + prim_range_derived_weight100 + prim_name_derived_weight100 + st_weight100>=500,~prim_name_derived_isnull,~st_isnull); // Use specificity to flag high-dup counts
  dn0_srange2  := dn0_deduped2(sec_range != '');

  dn0_deduped3 := dJ2(cnp_number_weight100 + st_weight100 + v_city_name_weight100 + prim_range_derived_weight100>=500,~v_city_name_isnull ,~st_isnull); // Use specificity to flag high-dup counts
  dn0_deduped4 := dJ2(cnp_number_weight100 + st_weight100 + zip_weight100         + prim_range_derived_weight100>=500,~zip_isnull         ,~st_isnull); // Use specificity to flag high-dup counts

//  dn0_deduped4 := dJ2(cnp_number_weight100 + st_weight100 + v_city_name_weight100 + zip_weight100 + prim_range_derived_weight100>=500); // Use specificity to flag high-dup counts
  
  // dn02         := pH(~prim_name_isnull, ~v_city_name_isnull, ~zip_isnull,cnp_number_weight100 + v_city_name_weight100 + prim_name_weight100>=500);
 

//  mj1 := JOIN( dn0_deduped1, dn0_deduped1, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.cnp_name    = RIGHT.cnp_name     AND LEFT.st = RIGHT.st and left.pname_digits    = right.pname_digits                                                                                                  AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull )                                                                AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) /*AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) */ AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),pMatchJoin(project(LEFT,transform(recordof(pH),self := left)) ,project(RIGHT,transform(recordof(pH),self := left)),101),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.cnp_name    = RIGHT.cnp_name     AND LEFT.st = RIGHT.st  and left.pname_digits = right.pname_digits   ,20000),HASH);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
//  mj2 := JOIN( dn0_deduped2, dn0_deduped2, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.prim_name_derived   = RIGHT.prim_name_derived    AND LEFT.st = RIGHT.st AND LEFT.cnp_name[1..4]  = RIGHT.cnp_name[1..4]                                                                                                AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull )                                                                AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) /*AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) */ AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),pMatchJoin(LEFT                                               ,RIGHT                                              ,102),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.prim_name_derived   = RIGHT.prim_name_derived    AND LEFT.st = RIGHT.st AND LEFT.cnp_name[1..4] = RIGHT.cnp_name[1..4],20000),HASH);
//  mj3 := JOIN( dn0_srange2 , dn0_srange2 , LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.prim_name_derived   = RIGHT.prim_name_derived    AND LEFT.st = RIGHT.st AND LEFT.sec_range       = RIGHT.sec_range                                                                                                     AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull )                                                                AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) /*AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) */ AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),pMatchJoin(LEFT                                               ,RIGHT                                              ,103),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.prim_name_derived   = RIGHT.prim_name_derived    AND LEFT.st = RIGHT.st AND LEFT.sec_range      = RIGHT.sec_range     ,20000),HASH);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
//  mj4 := JOIN( dn0_deduped3, dn0_deduped3, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.v_city_name = RIGHT.v_city_name  AND LEFT.st = RIGHT.st and left.pname_digits    = right.pname_digits   AND LEFT.cnp_name_raw[1..4]  = RIGHT.cnp_name_raw[1..4] AND LEFT.cnp_name    != RIGHT.cnp_name AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( ~left.v_city_name_isnull AND ~right.v_city_name_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) /*AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) */ AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),pMatchJoin(project(LEFT,transform(recordof(pH),self := left)) ,project(RIGHT,transform(recordof(pH),self := left)),104),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.v_city_name = RIGHT.v_city_name  AND LEFT.st = RIGHT.st and left.pname_digits = right.pname_digits  AND LEFT.cnp_name_raw[1..4]  = RIGHT.cnp_name_raw[1..4]  ,20000),HASH);
  // mj5 := JOIN( dn0_deduped4, dn0_deduped4, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.zip         = RIGHT.zip          AND LEFT.st = RIGHT.st and left.pname_digits    = right.pname_digits   AND LEFT.cnp_name_raw[1..4]  = RIGHT.cnp_name_raw[1..4] AND LEFT.cnp_name    != RIGHT.cnp_name AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull ) AND ( ~left.zip_isnull         AND ~right.zip_isnull         ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull ) AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),pMatchJoin(project(LEFT,transform(recordof(pH),self := left)) ,project(RIGHT,transform(recordof(pH),self := left)),105),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_range_derived = RIGHT.prim_range_derived AND LEFT.zip         = RIGHT.zip          AND LEFT.st = RIGHT.st and left.pname_digits = right.pname_digits  AND LEFT.cnp_name_raw[1..4]  = RIGHT.cnp_name_raw[1..4]  ,20000),HASH);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  mj6 := JOIN( dn0_deduped2, dn0_deduped2, LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND left.cnp_name = right.cnp_name AND left.company_address = right.company_address                                                                                                                                                                    AND ( ~left.prim_name_derived_isnull AND ~right.prim_name_derived_isnull ) AND ( ~left.st_isnull AND ~right.st_isnull )                                                                AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) /*AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull )*/  AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull )                                                                                               ,pMatchJoin(LEFT                                               ,RIGHT                                              ,106),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND left.cnp_name = right.cnp_name AND left.company_address = right.company_address                                                                   ,20000),HASH);
  // mj7 := JOIN( dn02        , dn02        , LEFT.Proxid > RIGHT.Proxid AND ( LEFT.SALT_Partition = RIGHT.SALT_Partition OR LEFT.SALT_Partition='' OR RIGHT.SALT_Partition = '' ) AND LEFT.cnp_number = RIGHT.cnp_number   AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.prim_range_derived = RIGHT.prim_range_derived and left.zip = right.zip /*AND ( ~left.st_isnull AND ~right.st_isnull )*/ AND ( left.active_duns_number = right.active_duns_number OR left.active_duns_number_isnull OR right.active_duns_number_isnull ) AND ( left.active_enterprise_number = right.active_enterprise_number OR left.active_enterprise_number_isnull OR right.active_enterprise_number_isnull ) AND ( left.active_domestic_corp_key = right.active_domestic_corp_key OR left.active_domestic_corp_key_isnull OR right.active_domestic_corp_key_isnull ) AND ( ~left.cnp_name_isnull AND ~right.cnp_name_isnull ) AND ( ~left.prim_name_isnull AND ~right.prim_name_isnull ) AND ( ~left.company_address_isnull AND ~right.company_address_isnull )AND ~(( left.cnp_name = right.cnp_name ) AND ( left.company_address = right.company_address )),match_join(LEFT,RIGHT,7),HINT(Parallel_Match),ATMOST(LEFT.cnp_number = RIGHT.cnp_number AND LEFT.prim_name = RIGHT.prim_name AND LEFT.st = RIGHT.st AND LEFT.prim_range_derived = RIGHT.prim_range_derived,20000),HASH);

  // last_mjs_t1 := mj6 ;//TEMP HACK TO SPEED UP ITERATIONS
  last_mjs_t1 := /* mj1 + mj2 + mj3 + mj4*/ /*+ mj5 +*/ mj6/* + mj7*/ ;
  
  return last_mjs_t1;
  
endmacro;

// mj0: subgraph: 5688  549,273,247 matches 3H 41M out
// mj1: subgraph: 5658  280,167,521 matches    12M out, cnp_name is not equal
// mj2: subgraph: 5663  317,101,513 matches 1H  4M out
// mj3: subgraph: 5668   68,365,744 matches    47M maybe
// mj4: subgraph: 5673  782,375,929 matches 1H  7M out
// mj5: subgraph: 5678  774,529,345 matches    41M out  //might not be useful--check on full file.


// mj6: subgraph: 5683  466,208,821 matches    12M out

