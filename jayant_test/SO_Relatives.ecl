import header, SexOffender ,Address,watchdog;

so_ds_orig := SexOffender.File_Accurint_Search_In; // CHOOSEN(SexOffender.File_Accurint_Search_In,50000);
layout_SO:=SexOffender.Layout_Out_Main;
so_ds := distribute(so_ds_orig,HASH32((unsigned8)so_ds_orig.did));

//
bestAddress_ds_orig := watchdog.File_Best;// CHOOSEN(watchdog.File_Best,100000);
layout_bestaddr := watchdog.Layout_Best;
bestAddress_ds := distribute(bestAddress_ds_orig,HASH32((unsigned8)bestAddress_ds_orig.did));

relatives_ds_orig := header.File_Relatives;// CHOOSEN(header.File_Relatives,200000);
layout_relatives := header.layout_relatives;
relatives_ds1 := distribute(relatives_ds_orig,HASH32((unsigned8)relatives_ds_orig.person1));
relatives_ds2 := distribute(relatives_ds_orig,HASH32((unsigned8)relatives_ds_orig.person2));
/*
export Layout_Relatives := record
  unsigned5 person1;
  unsigned5 person2;
  integer3 recent_cohabit;
  integer3 zip;
  integer2 prim_range;
  boolean  same_lname;
  unsigned2 number_cohabits;
  end;
*/

/*
LOGIC OVERVIEW
==============
1. join so_ds with relatives on person1 , then on person2 to get a relatives DS
2. then join so_relatives best address .. to get a combo set
3. then stats can be run on this persisted ds;
*/

layout_SO_relatives := RECORD
//Sex Offender Fields
unsigned8   so_did := 0;
   string50 	so_name_orig := '';
   string30 	so_lname := '';
   string30 	so_fname := '';
   string20 	so_mname := '';
   string20 	so_name_suffix := '';
   String1      so_name_type :='';
   Address.layout_address_clean_return;
//Relative Relation Fields
unsigned5    relative_did := 0; // both (person1 and person2 matches)
END;

layout_so_relatives join_so_relatives1(so_ds le , relatives_ds1 ri) := TRANSFORM 
self.so_did := (integer)le.did;
self.so_name_orig := le.name_orig;
self.so_lname := le.lname;
self.so_fname := le.fname;
self.so_mname := le.mname;
self.so_name_suffix := le.name_suffix;
self.so_name_type := le.name_type;
self := le;
//Relative Relation Fields
self.relative_did := ri.person2; // both (person1 and person2)
END;

layout_so_relatives join_so_relatives2(so_ds le , relatives_ds2 ri) := TRANSFORM 
self.so_did := (integer)le.did;
self.so_name_orig := le.name_orig;
self.so_lname := le.lname;
self.so_fname := le.fname;
self.so_mname := le.mname;
self.so_name_suffix := le.name_suffix;
self.so_name_type := le.name_type;
self := le;
//Relative Relation Fields
self.relative_did := ri.person1; // both (person1 and person2)
//self.relative_zip := ri.zip;
END;

so_relatives1_ds := JOIN(so_ds,relatives_ds1,((unsigned8)LEFT.did = (unsigned8)RIGHT.person1), join_so_relatives1(left,right), LOCAL);
so_relatives2_ds := JOIN(so_ds,relatives_ds2,((unsigned8)LEFT.did = (unsigned8)RIGHT.person2), join_so_relatives2(left,right), LOCAL);
combo_ds := so_relatives1_ds+so_relatives2_ds;

layout_wAddress := RECORD
layout_so_relatives;
// Relative address from best address
qstring10      re_phone := '';
qstring9       re_ssn := '';
integer4       re_dob := 0;
qstring5       re_title := '';
qstring20      re_fname := '';
qstring20      re_mname := '';
qstring20      re_lname := '';
qstring5       re_name_suffix := '';
qstring10      re_prim_range := '';
string2        re_predir := '';
qstring28      re_prim_name := '';
qstring4       re_suffix := '';
string2        re_postdir := '';
qstring10      re_unit_desig := '';
qstring8       re_sec_range := '';
qstring25      re_city_name := '';
string2        re_st := '';
qstring5       re_zip := '';
qstring4       re_zip4 := '';
unsigned3      re_addr_dt_last_seen := 0;

END;



layout_wAddress join_bestAddr(combo_ds le, bestAddress_ds ri) := TRANSFORM
//SO Fields
self:=le;
//Relative Fields
self.re_phone := ri.phone;
self.re_ssn := ri.ssn;
self.re_dob :=ri.dob;
self.re_title := ri.title;
self.re_fname := ri.fname;
self.re_mname := ri.mname;
self.re_lname := ri.lname;
self.re_name_suffix := ri.name_suffix;
self.re_prim_range := ri.prim_range;
self.re_predir := ri.predir;
self.re_prim_name := ri.prim_name;
self.re_suffix := ri.suffix;
self.re_postdir := ri.postdir;
self.re_unit_desig := ri.unit_desig;
self.re_sec_range := ri.sec_range;
self.re_city_name := ri.city_name;
self.re_st := ri.st;
self.re_zip := ri.zip;
self.re_zip4 := ri.zip4;
self.re_addr_dt_last_seen := ri.addr_dt_last_seen;
END;

combo_ds_distr:= distribute(sort(combo_ds,relative_did,LOCAL),HASH32((unsigned8)relative_did));
combo_ds_bestAddress := JOIN(combo_ds_distr,bestAddress_ds, ((unsigned8)LEFT.relative_did = (unsigned8)RIGHT.did), join_bestAddr(left,right),LOCAL);

export so_relatives := combo_ds_bestAddress:persist('SO_relatives2');