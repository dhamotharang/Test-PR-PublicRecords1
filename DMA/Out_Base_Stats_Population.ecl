import strata;

export Out_Base_Stats_Population(string filedate) := function 

ds := DMA.file_suppressionMPS;

 rSTRATA_DNM := record
  CountGroup              := count(group);
  title                   := sum(group,if(ds.title<>'',1,0));
  fname                   := sum(group,if(ds.fname<>'',1,0));
  mname                   := sum(group,if(ds.mname<>'',1,0));
  lname                   := sum(group,if(ds.lname<>'',1,0));
  name_suffix             := sum(group,if(ds.name_suffix<>'',1,0));
  name_score              := sum(group,if(ds.name_score<>'',1,0));
  prim_range              := sum(group,if(ds.prim_range<>'',1,0));
  predir                  := sum(group,if(ds.predir<>'',1,0));
  prim_name               := sum(group,if(ds.prim_name<>'',1,0));
  addr_suffix             := sum(group,if(ds.addr_suffix<>'',1,0));
  postdir                 := sum(group,if(ds.postdir<>'',1,0));
  unit_desig              := sum(group,if(ds.unit_desig<>'',1,0));
  sec_range               := sum(group,if(ds.sec_range<>'',1,0));
  p_city_name             := sum(group,if(ds.p_city_name<>'',1,0));
  v_city_name             := sum(group,if(ds.v_city_name<>'',1,0));
  DMA.file_suppressionMPS.st;
  zip                     := sum(group,if(ds.zip<>'',1,0));
  zip4                    := sum(group,if(ds.zip4<>'',1,0));
  cart                    := sum(group,if(ds.cart<>'',1,0));
  cr_sort_sz              := sum(group,if(ds.cr_sort_sz<>'',1,0));
  lot                     := sum(group,if(ds.lot<>'',1,0));
  lot_order               := sum(group,if(ds.lot_order<>'',1,0));
  dpbc                    := sum(group,if(ds.dpbc<>'',1,0));
  chk_digit               := sum(group,if(ds.chk_digit<>'',1,0));
  rec_type                := sum(group,if(ds.rec_type<>'',1,0));
  ace_fips_st             := sum(group,if(ds.ace_fips_st<>'',1,0));
  fips_county             := sum(group,if(ds.fips_county<>'',1,0));
  geo_lat                 := sum(group,if(ds.geo_lat<>'',1,0));
  geo_long                := sum(group,if(ds.geo_long<>'',1,0));
  msa                     := sum(group,if(ds.msa<>'',1,0));
  geo_match               := sum(group,if(ds.geo_match<>'',1,0));
  err_stat                := sum(group,if(ds.err_stat<>'',1,0));
  END;
  
  tStats := table(ds,rSTRATA_DNM,st,few);

strata.createXMLStats(tStats,'DNM','data',filedate,'',resultsOut);
return resultsOut;
end;

