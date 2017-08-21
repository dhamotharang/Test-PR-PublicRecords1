import risk_indicators, address;

infile := risk_indicators.file_pbsa.raw;

layout_pbsa.base tcleanaddr(infile le) := transform

sCleanAddress := address.cleanaddress182(le.Address, le.City + ' ' + le.State + ' ' + le.zip_code);


      SELF.prim_range  := sCleanAddress[ 1..  10];
      SELF.predir      := sCleanAddress[ 11.. 12];
      SELF.prim_name   := sCleanAddress[ 13.. 40];
      SELF.addr_suffix := sCleanAddress[ 41.. 44];
      SELF.postdir     := sCleanAddress[ 45.. 46];
      SELF.unit_desig  := sCleanAddress[ 47.. 56];
      SELF.sec_range   := sCleanAddress[ 57.. 64];
      SELF.p_city_name := sCleanAddress[ 65.. 89];
      SELF.v_city_name := sCleanAddress[ 90..114];
      SELF.st          := sCleanAddress[115..116];
      SELF.zip         := sCleanAddress[117..121];
      SELF.zip4        := sCleanAddress[122..125];
      SELF.cart        := sCleanAddress[126..129];
      SELF.cr_sort_sz  := sCleanAddress[130..130];
      SELF.lot         := sCleanAddress[131..134];
      SELF.lot_order   := sCleanAddress[135..135];
      SELF.dbpc        := sCleanAddress[136..137];
      SELF.chk_digit   := sCleanAddress[138..138];
      SELF.rec_type    := sCleanAddress[139..140];
      SELF.county      := sCleanAddress[141..145];
      SELF.geo_lat     := sCleanAddress[146..155];
      SELF.geo_long    := sCleanAddress[156..166];
      SELF.msa         := sCleanAddress[167..170];
      SELF.geo_blk     := sCleanAddress[171..177];
      SELF.geo_match   := sCleanAddress[178..178];
      SELF.err_stat    := sCleanAddress[179..182];
      self := le;
end;
clean_pbsa := project(infile,tcleanaddr(left));
export proc_build_pbsa :=  output(clean_pbsa,,'~thor_data200::base::mtcsa_clean', overwrite);