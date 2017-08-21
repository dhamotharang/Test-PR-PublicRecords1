import drivers, address, ut;

dl_in := sample(drivers.File_Dl,100,1);

layout_dl_prep := record
string182	orig_clean;
string2                        orig_state;
string2						   source_code	:=	'AD';
qstring40                      addr1;  // chgd, 30 to 40, 20030325,New Mexico, TK
qstring20                      city;
qstring2                       state;
qstring5                       zip;
qstring10                      prim_range;
qstring2                       predir;
qstring28                      prim_name;
qstring4                       suffix;
qstring2                       postdir;
qstring10                      unit_desig;
qstring8                       sec_range;
qstring25                      p_city_name;
qstring25                      v_city_name;
qstring2                       st;
qstring5                       zip5;
qstring4                       zip4;
qstring4                       cart;
string1                        cr_sort_sz;
qstring4                       lot;
string1                        lot_order;
string2                        dpbc := '';
string1                        chk_digit;
string2                        rec_type;
string2                        ace_fips_st := '';
qstring3                       county;
qstring10                      geo_lat;
qstring11                      geo_long;
qstring4                       msa := '';
qstring7                       geo_match;
qstring4                       err_stat;
string75   temp_addr2;
end;

layout_dl_prep prep(dl_in le) := transform
string2 v_state := map(le.orig_state='FL' and stringlib.stringfilterout(le.state,'0123456789')='' => 'FL', le.state);
  self.orig_clean := 
  le.prim_range+
  le.predir+
  le.prim_name+
  le.suffix+
  le.postdir+
  le.unit_desig+
  le.sec_range+
  le.p_city_name+
  le.v_city_name+
  le.st+
  le.zip5+
  le.zip4+
  le.cart+
  le.cr_sort_sz+
  le.lot+
  le.lot_order+
  le.dpbc+
  le.chk_digit+
  le.rec_type+
  le.ace_fips_st+
  le.county+
  le.geo_lat+
  le.geo_long+
  le.msa+
  le.geo_blk+
  le.geo_match+
  le.err_stat;
  self.temp_addr2 := address.Addr2FromComponents(le.city,v_state,le.zip);
  self := le;
  end;
  
dl_prep := project(dl_in,prep(left));

address.MAC_Address_Clean(dl_prep,addr1,temp_addr2,true,dl_recleaned)

layout_dl_final := record
string2                        orig_state;
string2						   source_code;
qstring10                      prim_range;
qstring2                       predir;
qstring28                      prim_name;
qstring4                       suffix;
qstring2                       postdir;
qstring10                      unit_desig;
qstring8                       sec_range;
qstring25                      p_city_name;
qstring25                      v_city_name;
qstring2                       st;
qstring5                       zip5;
qstring4                       zip4;
qstring4                       cart;
string1                        cr_sort_sz;
qstring4                       lot;
string1                        lot_order;
string2                        dpbc := '';
string1                        chk_digit;
string2                        rec_type;
//string2                        ace_fips_st := '';
qstring3                       county;
qstring10                      geo_lat;
qstring11                      geo_long;
qstring4                       msa := '';
qstring7                       geo_match;
qstring4                       err_stat;
qstring10                      new_prim_range;
qstring2                       new_predir;
qstring28                      new_prim_name;
qstring4                       new_suffix;
qstring2                       new_postdir;
qstring10                      new_unit_desig;
qstring8                       new_sec_range;
qstring25                      new_p_city_name;
qstring25                      new_v_city_name;
qstring2                       new_st;
qstring5                       new_zip5;
qstring4                       new_zip4;
qstring4                       new_cart;
string1                        new_cr_sort_sz;
qstring4                       new_lot;
string1                        new_lot_order;
string2                        new_dpbc;
string1                        new_chk_digit;
string2                        new_rec_type;
//string2                        new_ace_fips_st;
qstring3                       new_county;
qstring10                      new_geo_lat;
qstring11                      new_geo_long;
qstring4                       new_msa;
qstring7                       new_geo_match;
qstring4                       new_err_stat;
string182					   orig_clean;
string182					   clean;
qstring40                      addr1;  // chgd, 30 to 40, 20030325,New Mexico, TK
qstring20                      city;
qstring2                       state;
qstring5                       zip;
end;

layout_dl_final to_final(dl_recleaned le) := transform
  self.new_prim_range := le.clean[1..10];
  self.new_predir := le.clean[11..12];
  self.new_prim_name := le.clean[13..40];
  self.new_suffix := le.clean[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
  self.new_postdir := le.clean[45..46];
  self.new_unit_desig := le.clean[47..56];
  self.new_sec_range := le.clean[57..64];
  self.new_p_city_name := le.clean[65..89];
  self.new_v_city_name := le.clean[90..114];
  self.new_st := le.clean[115..116];
  self.new_zip5 := le.clean[117..121];
  self.new_zip4 := le.clean[122..125];
  self.new_cart := le.clean[126..129];
  self.new_cr_sort_sz := le.clean[130];
  self.new_lot := le.clean[131..134];
  self.new_lot_order := le.clean[135];
  self.new_dpbc := le.clean[136..137];
  self.new_chk_digit := le.clean[138];
  self.new_rec_type := le.clean[139..140];
  self.new_county := le.clean[141..145];
  self.new_geo_lat := le.clean[146..155];
  self.new_geo_long := le.clean[156..166];
  self.new_msa := le.clean[167..170];
//  self.new_geo_blk := le.clean[171..177];
  self.new_geo_match := le.clean[178];
  self.new_err_stat := le.clean[179..182];
self := le;
end;

dl_final := project(dl_recleaned, to_final(left));

export misc_dl_recleaned := dl_final : persist('misc::misc_dl_recleaned');

/*
s_layout := record
string2 	source_code := s.source_code;
string2 	orig_state := s.orig_state;
integer4    same_in_125_chars :=  AVE(group, IF (s.orig_clean[1..125]=s.clean[1..125],100,0));
end;

s_stat := table(s, s_layout, source_code,orig_state, few);

output(s_stat);
*/

