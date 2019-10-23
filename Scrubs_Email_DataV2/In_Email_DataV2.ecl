IMPORT Email_DataV2;

File_Base := Email_DataV2.Files.Email_Base;

Email_DataV2.Layouts.Scrubs_Layout xform(file_base l) := TRANSFORM
	 SELF.title := l.clean_name.title;
   SELF.fname := l.clean_name.fname;
   SELF.mname	:= l.clean_name.mname;
   SELF.lname	:= l.clean_name.lname;
   SELF.name_suffix := l.clean_name.name_suffix;	
   SELF.name_score := l.clean_name.name_score;	
   SELF.prim_range := l.clean_address.prim_range;
   SELF.predir := l.clean_address.predir;
   SELF.prim_name := l.clean_address.prim_name;
   SELF.addr_suffix := l.clean_address.addr_suffix;
   SELF.postdir := l.clean_address.postdir;
   SELF.unit_desig := l.clean_address.unit_desig;
   SELF.sec_range := l.clean_address.sec_range;
   SELF.p_city_name := l.clean_address.p_city_name;
   SELF.v_city_name := l.clean_address.v_city_name;
   SELF.st := l.clean_address.st;
   SELF.zip := l.clean_address.zip;
   SELF.zip4 := l.clean_address.zip4;
   SELF.cart := l.clean_address.cart;
   SELF.cr_sort_sz := l.clean_address.cr_sort_sz;
   SELF.lot := l.clean_address.lot;
   SELF.lot_order := l.clean_address.lot_order;
   SELF.dbpc := l.clean_address.dbpc;
   SELF.chk_digit := l.clean_address.chk_digit;
   SELF.rec_type := l.clean_address.rec_type;
   SELF.county := l.clean_address.county;
   SELF.geo_lat := l.clean_address.geo_lat;
   SELF.geo_long := l.clean_address.geo_long;
   SELF.msa := l.clean_address.msa;
   SELF.geo_blk := l.clean_address.geo_blk;
   SELF.geo_match := l.clean_address.geo_match;
   SELF.err_stat := l.clean_address.err_stat;
	 SELF := l;
END;

file_base_out := PROJECT(File_Base, xform(left));

EXPORT In_Email_DataV2 := file_base_out;