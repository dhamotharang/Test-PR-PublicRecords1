Import Email_Data;

EXPORT File_Email_Base_Scrubs(string version) := FUNCTION

// File_Base := Build_base((integer)version).rollup_with_history_misc;  //removed 8-3 bjd
File_Base := Build_base((integer)version).rollup_with_history;

Email_Data.Layout_Email.Scrubs_Layout xform(file_base l) := transform
	 self.title := l.clean_name.title;
   self.fname := l.clean_name.fname;
   self.mname	:= l.clean_name.mname;
   self.lname	:= l.clean_name.lname;
   self.name_suffix := l.clean_name.name_suffix;	
   self.name_score := l.clean_name.name_score;	
   self.prim_range := l.clean_address.prim_range;
   self.predir := l.clean_address.predir;
   self.prim_name := l.clean_address.prim_name;
   self.addr_suffix := l.clean_address.addr_suffix;
   self.postdir := l.clean_address.postdir;
   self.unit_desig := l.clean_address.unit_desig;
   self.sec_range := l.clean_address.sec_range;
   self.p_city_name := l.clean_address.p_city_name;
   self.v_city_name := l.clean_address.v_city_name;
   self.st := l.clean_address.st;
   self.zip := l.clean_address.zip;
   self.zip4 := l.clean_address.zip4;
   self.cart := l.clean_address.cart;
   self.cr_sort_sz := l.clean_address.cr_sort_sz;
   self.lot := l.clean_address.lot;
   self.lot_order := l.clean_address.lot_order;
   self.dbpc := l.clean_address.dbpc;
   self.chk_digit := l.clean_address.chk_digit;
   self.rec_type := l.clean_address.rec_type;
   self.county := l.clean_address.county;
   self.geo_lat := l.clean_address.geo_lat;
   self.geo_long := l.clean_address.geo_long;
   self.msa := l.clean_address.msa;
   self.geo_blk := l.clean_address.geo_blk;
   self.geo_match := l.clean_address.geo_match;
   self.err_stat := l.clean_address.err_stat;
	 self := l;
end;

Return project(File_Base, xform(left));

end;