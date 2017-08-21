import Address, watchdog;
inp_ds:=SO_relatives;

bestAddress_ds_orig := watchdog.File_Best;// CHOOSEN(watchdog.File_Best,100000);
bestAddress_ds := distribute(bestAddress_ds_orig,HASH32((unsigned8)bestAddress_ds_orig.did));

layout_inp_ds:= RECORD
unsigned8   so_did := 0;
   string50 	so_name_orig := '';
   string30 	so_lname := '';
   string30 	so_fname := '';
   string20 	so_mname := '';
   string20 	so_name_suffix := '';
   String1      so_name_type :='';
   Address.layout_address_clean_return;
//Relative Relation Fields
unsigned5    relative_did := 0; 
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


layout_inp_ds join_bestSO(inp_ds le, bestAddress_ds ri) := TRANSFORM
//SO Fields
//More SO fields from best
//self.so_phone := ri.phone;
//self.so_ssn := ri.ssn;
//self.so_dob :=ri.dob;
//self.so_title := ri.title;
self.so_fname := ri.fname;
self.so_mname := ri.mname;
self.so_lname := ri.lname;
self.so_name_suffix := ri.name_suffix;
self.prim_range := ri.prim_range;
self.predir := ri.predir;
self.prim_name := ri.prim_name;
self.addr_suffix := ri.suffix;
self.postdir := ri.postdir;
self.unit_desig := ri.unit_desig;
self.sec_range := ri.sec_range;
self.p_city_name := ri.city_name;
self.v_city_name := ri.city_name;
self.st := ri.st;
self.zip5 := ri.zip;
self.zip4 := ri.zip4;
self:=le;
END;


inp_ds_distr:= sort(distribute(inp_ds,hash32((unsigned8) so_did)),so_did,local);
inp_ds_with_best_for_so := JOIN(inp_ds_distr,bestAddress_ds, ((unsigned8)LEFT.so_did = (unsigned8)RIGHT.did), join_bestSO (left,right),LOCAL);

dedup_ds:=dedup(sort(inp_ds_with_best_for_so,so_did,relative_did,LOCAL), left.so_did = right.so_did and left.relative_did = right.relative_did,LOCAL);
sorted_ds:=SORT(dedup_ds,so_did,re_st,LOCAL);
export uniqueSO_relative := sorted_ds;