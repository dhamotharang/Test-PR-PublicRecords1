import UCCD;

p := dataset('~thor_data400::base::ucc_debtor_wexp_deduped_'+ uccd.version_development,{uccd.layout_Moxie_WithExpParty,unsigned8 __filepos { virtual(fileposition)}}, flat);

Layout_WithExpPartyExpanded_Filepos := record
	uccd.layout_Moxie_WithExpPartyExpanded;
    unsigned integer8 __filepos { virtual(fileposition)};
end;

Layout_WithExpPartyExpanded_Filepos tra(p l) := transform
	clean_n := datalib.nameclean(l.p_name);
  self.prim_range  := L.clean_address[1..10];
  self.predir      := L.clean_address[11..12];
  self.prim_name   := L.clean_address[13..40];
  self.addr_suffix := L.clean_address[41..44];
  self.postdir     := L.clean_address[45..46];
  self.unit_desig  := L.clean_address[47..56];
  self.sec_range   := L.clean_address[57..64];
  self.p_city_name := L.clean_address[65..89];
  self.v_city_name := L.clean_address[90..114];
  self.st          := L.clean_address[115..116];
  self.zip         := L.clean_address[117..121];
  self.zip4        := L.clean_address[122..125];
  self.cart        := L.clean_address[126..129];
  self.cr_sort_sz  := L.clean_address[130..130];
  self.lot         := L.clean_address[131..134];
  self.lot_order   := L.clean_address[135..135];
  self.dbpc        := L.clean_address[136..137];
  self.chk_digit   := L.clean_address[138..138];
  self.rec_type    := L.clean_address[139..140];
  self.fips_st     := L.clean_address[141..142];
	self.fips_county := L.clean_address[143..145];
  self.geo_lat     := L.clean_address[146..155];
  self.geo_long    := L.clean_address[156..166];
  self.msa         := L.clean_address[167..170];
  self.geo_blk     := L.clean_address[171..177];
  self.geo_match   := L.clean_address[178..178];
  self.err_stat    := L.clean_address[179..182];
	self.title := clean_n[121..125];
	self.fname := clean_n[1..40];
	self.mname := clean_n[41..80];
	self.lname := clean_n[81..120];
	self.name_suffix := clean_n[131..140];
	self := l;
end;


export File_WithExpDebtor2_Base_Dev := project(p, tra(left));