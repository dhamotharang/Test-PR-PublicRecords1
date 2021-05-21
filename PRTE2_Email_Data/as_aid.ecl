Export as_aid :=project(prte2_Email_Data.files.BOCA_BASE(append_rawaid !=0),
Transform(Layouts.rfinal,
  self.rawaid := left.append_rawaid;
  self.aceaid:=0;
  self.prim_range:=left.clean_address.prim_range;
  self.predir:=left.clean_address.predir;
  self.prim_name:=left.clean_address.prim_name;;
  self.addr_suffix:= left.clean_address.addr_suffix;;
  self.postdir:=left.clean_address.postdir;
  self.unit_desig :=left.clean_address.unit_desig;
  self.sec_range:=left.clean_address.sec_range;
  self.p_city_name:=left.clean_address.p_city_name;
  self.v_city_name:=left.clean_address.v_city_name;
  self.st:=left.clean_address.st;
  self.zip5:=left.clean_address.zip;
  self.zip4:=left.clean_address.zip4;
  self.cart:=left.clean_address.cart;
  self.cr_sort_sz:=left.clean_address.cr_sort_sz;
  self.lot:=left.clean_address.lot;
  self.lot_order:=left.clean_address.lot_order;
  self.dbpc:=left.clean_address.dbpc;
  self.chk_digit:=left.clean_address.chk_digit;
  self.rec_type:=left.clean_address.rec_type;
  self.county:=left.clean_address.county;
  self.geo_lat:=left.clean_address.geo_lat;
  self.geo_long:=left.clean_address.geo_long;
  self.msa:=left.clean_address.msa;
  self.geo_blk:=left.clean_address.geo_blk;
  self.geo_match:=left.clean_address.geo_match;
  self.err_stat:=left.clean_address.err_stat;
 ));

 

