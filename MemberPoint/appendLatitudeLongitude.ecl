import Advo;

EXPORT dataset(MemberPoint.Layouts.BestExtended) 
							appendLatitudeLongitude(dataset(MemberPoint.Layouts.BestExtended) bestIn ) := function 

withlatlong := join(bestIn, Advo.Key_Addr1,
                keyed(left.c_best_z5 = right.zip) and
                keyed(left.c_best_prim_range = right.prim_range) and
                keyed(left.c_best_prim_name = right.prim_name) and
                keyed(left.c_best_addr_suffix = right.addr_suffix) and
                keyed(left.c_best_predir = right.predir) and
                keyed(left.c_best_postdir = right.postdir) and
                keyed(left.c_best_sec_range = right.sec_range),
                transform(MemberPoint.Layouts.BestExtended, 
                //self.c_best_county_name           :=right.county_name,''),
                self.c_best_Latitude                    := right.geo_lat, 
                self.c_best_Longitude                   := right.geo_long, 
                self := left),
                left outer,
                keep(1));

return(withlatlong); 
end;
