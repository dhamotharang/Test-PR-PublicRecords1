import SALT39;
export Fn_LL_DistanceScore(StrType l,dataset(layout_ll_ranges) ld, StrType r,dataset(layout_ll_ranges) rd,unsigned2 distance) := function
  llat := (real8)l[1..10];
  rlat := (real8)r[1..10];
  llong := (real8)l[11..20];
  rlong := (real8)r[11..20];
	d := truncate(SALT39.utLL_Dist(llat,llong,rlat,rlong)+.5);
	lsr := ld(distance>=d)[1].specificity;
	rsr := rd(distance>=d)[1].specificity;
	sc := truncate(50*(lsr+rsr));
	return IF( llat < rlat-distance OR llat > rlat+distance OR llong < rlong-distance OR llong > rlong+distance,0, sc );
  end;
