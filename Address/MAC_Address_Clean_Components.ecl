export MAC_Address_Clean_Components(infile,addr1,addr2,clean_misses,outfile) := macro

#uniquename(tfile)

address.MAC_Address_Clean(infile,addr1,addr2,clean_misses,%tfile%)

#uniquename(into)

typeof(infile) %into%(%tfile% le) := transform
  self.prim_range := le.clean[1..10];
  self.predir := le.clean[11..12];
  self.prim_name := le.clean[13..40];
  self.addr_suffix := le.clean[41..44];			// If using USPS Standard Suffixes char suffix[4] is OK.
  self.postdir := le.clean[45..46];
  self.unit_desig := le.clean[47..56];
  self.sec_range := le.clean[57..64];
  self.p_city_name := le.clean[65..89];
  self.v_city_name := le.clean[90..114];
  self.st := le.clean[115..116];
  self.zip5 := le.clean[117..121];
  self.zip4 := le.clean[122..125];
  self.cart := le.clean[126..129];
  self.cr_sort_sz := le.clean[130];
  self.lot := le.clean[131..134];
  self.lot_order := le.clean[135];
  self.dbpc := le.clean[136..137];
  self.chk_digit := le.clean[138];
  self.rec_type := le.clean[139..140];
  self.county := le.clean[141..145];
  self.geo_lat := le.clean[146..155];
  self.geo_long := le.clean[156..166];
  self.msa := le.clean[167..170];
  self.geo_blk := le.clean[171..177];
  self.geo_match := le.clean[178];
  self.err_stat := le.clean[179..182];
  self.clean_errors := CASE(le.clean[179],'E'=>1,' '=>3,'U'=>2,0);
  self := le;
  end;

outfile := project(%tfile%,%into%(left));

endmacro;