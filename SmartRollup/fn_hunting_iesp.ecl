import iesp, doxie_crs, hunting_fishing_services;

export fn_hunting_iesp(dataset(doxie_crs.layout_hunting_records) inrecs) := function

  recs := project(inrecs, transform(hunting_fishing_services.Layouts.raw_rec,
                                    self := left,
                                    self.isDeepDive := false,
                                    self := []));
  outrecs := hunting_fishing_services.Functions.fnHuntFishVal(recs);
  
  
  return project(outrecs,iesp.huntingfishing.t_HuntFishRecord);
end;
