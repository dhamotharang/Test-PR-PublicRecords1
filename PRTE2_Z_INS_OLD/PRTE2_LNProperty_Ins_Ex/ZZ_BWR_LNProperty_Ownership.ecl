//* BWR_LNProperty_Ownership: build the LN_Property Ownership Keys *
IMPORT LN_PropertyV2;
EXPORT string filedate         := '20130506';

EXPORT integer8 ln_propertyv2__maxrecsbyownership := 100;

l_hist := RECORD
   unsigned4 dt_seen;
   string12 ln_fares_id;
   unsigned6 owner_did;
  END;
arecord1 :=
RECORD
  unsigned6 did;
  boolean current;
  unsigned4 dt_first_seen;
  unsigned4 dt_last_seen;
  DATASET(l_hist) hist{maxCount(ln_propertyv2__maxrecsbyownership)};
  string20 fname;
  string20 lname;
  string5 fips_code;
  string45 unformatted_apn;
  string2 orig_state;
  string30 orig_county;
  string250 legal_brief_description;
  unsigned8 rawaid;
  unsigned8 aceaid;
  string10 prim_range;
  string2 predir;
  string28 prim_name;
  string4 suffix;
  string2 postdir;
  string10 unit_desig;
  string8 sec_range;
  string25 p_city_name;
  string25 v_city_name;
  string2 st;
  string5 zip;
  string4 zip4;
  string4 cart;
  string1 cr_sort_sz;
  string4 lot;
  string1 lot_order;
  string2 dbpc;
  string1 chk_digit;
  string2 rec_type;
  string5 county;
  string10 geo_lat;
  string11 geo_long;
  string4 msa;
  string7 geo_blk;
  string1 geo_match;
  unsigned8 __internal_fpos__;
 END;





buildindex(index(dataset([],arecord1),{did,current},{dataset([],arecord1)},'keyname'),'~prte::key::ln_propertyv2::' + filedate + '::ownership.did',update);
#workunit('name','PRCT LNPropertyKeys');
#workunit('priority','high');
f1 := LN_PropertyV2.mod_ownership.file_did(did	=	0);
fn1 := '~prte::key::ln_propertyv2::' + filedate + /*20130422*/ '::ownership_did';
did := index(f1, {did, current}, {f1}, fn1);

f2 := LN_PropertyV2.mod_ownership.file_fipsAPN(fips_code	=	'',unformatted_apn	=	'');
fn2 := '~prte::key::ln_propertyv2::' + filedate + /*20130422*/  '::ownership_fipsAPN';
fipsAPN := index(f2, {fips_code, unformatted_apn}, {f2}, fn2);

f3 := LN_PropertyV2.mod_ownership.file_rawaid(rawaid	=	0);
fn3 := '~prte::key::ln_propertyv2::' + filedate + /*20130422*/ '::ownership_rawaid';
rawaid := index(f3, {rawaid}, {f3}, fn3);

f4 := LN_PropertyV2.mod_ownership.file_addr(prim_range	=	'',predir	=	'',prim_name	=	'',addr_suffix	=	'',postdir	=	'',sec_range	=	'',zip5	=	'');
fn4 := '~prte::key::ln_propertyv2::'+ filedate + /*20130422*/ '::ownership_addr';
addr := index(f4, {prim_range,predir,prim_name,addr_suffix,postdir,sec_range,zip5}, {f4}, fn4);

f5 := LN_PropertyV2.mod_ownership.file_bdid(bdid	=	0);
fn5 := '~prte::key::ln_propertyv2::' + filedate + /*20130422*/ '::ownership_bdid';
bdid := index(f5, {bdid, current}, {f5}, fn5);


parallel(build(did,update),build(bdid,update),build(rawaid,update),build(fipsapn,update),build(addr,update));