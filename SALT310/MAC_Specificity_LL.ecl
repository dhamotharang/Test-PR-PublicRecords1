export MAC_Specificity_LL(infile,infield,cnf,distance,outfile) := MACRO
// Adapted from code stolen from George L'Heureux
  #uniquename(r)
	%r% := record
	infile.infield;
	unsigned cnt := infile.cnf;
	real8 lat := (real)infile.infield[1..10];
	real8 long := (real)infile.infield[11..20];
	end;
	// and table by grid position
	#uniquename(g2)
	%g2% := table(infile,%r%);
	#uniquename(total_in)
	%total_in% := sum(%g2%,cnt);
	
	// do an all-join to get distances between grid centers, limited to a box
#uniquename(temp_georec_pairs)
%temp_georec_pairs% := record
  SALT310.Str20Type infield;
	real lat1;
	real long1;
	unsigned2 dist;
	unsigned cnt;
	unsigned specificity;
end;
	#uniquename(all_join)
	%all_join% := join(%g2%,%g2%,
		(right.lat between (left.lat - distance) and (left.lat + distance)) and
		(right.long between (left.long - distance) and (left.long + distance)),
		transform(%temp_georec_pairs%,
		  self.infield := left.infield;
			self.lat1 := left.lat,
			self.long1 := left.long,
			self.dist := truncate(SALT310.utLL_Dist(left.lat,left.long,right.lat,right.long)+.5),
			self.cnt := right.cnt,
			self.specificity := truncate((log(%total_in% / right.cnt) / log(2)) ) ),all);
	
	#uniquename(rollup_join)
	// roll up any distances that are the same
	%rollup_join% := rollup(sort(distribute(%all_join%,hash(lat1,long1)),lat1,long1,dist,local),transform(%temp_georec_pairs%,
		self.cnt := left.cnt + right.cnt,
		self.specificity := truncate((log(%total_in% / self.cnt) / log(2)) ) ,
		self := left),
		lat1,long1,dist,local);
	
	// now iterate to build up population around centers
	#uniquename(i)
	%i% := iterate(%rollup_join%,transform(%temp_georec_pairs%,
		self.cnt := if(left.lat1 != right.lat1 or left.long1 != right.long1,right.cnt,left.cnt + right.cnt),
		self.specificity := truncate((log(%total_in% / self.cnt) / log(2)) ) ,
		self := right),local);
	#uniquename(ff)
	%ff% := record,maxlength(2048)
	  SALT310.Str20Type infield;
		dataset(SALT310.Layout_LL_Ranges) ranges;
		end;
	// finally, dedup to eliminate all but the last instance of each specificity
	#uniquename(o)
	%o% := project(dedup(%i%,lat1,long1,specificity,right,local),transform(%ff%,self.ranges := dataset([{left.dist,left.specificity}],SALT310.layout_ll_ranges),self.infield := left.infield));
	#uniquename(o2)
	%o2% := rollup( %o%,infield, transform(%ff%,self.ranges := left.ranges+right.ranges,self.infield := left.infield), local );
	outfile := join(infile,%o2%,left.infield=right.infield);
	
endmacro;
