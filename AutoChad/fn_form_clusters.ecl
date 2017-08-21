import header;
export fn_form_clusters(dataset(header.Layout_PairMatch) pairs) := function
  via_rec := record
	  unsigned6 rid;
	  end;
		
  travel_rec := record
	  unsigned6 rid1 := pairs.old_rid;
		unsigned6 rid2 := pairs.new_rid;
		unsigned2 distance := 1;
		boolean new := true;
		string pflag := (string)pairs.pflag;
		dataset(via_rec) via := dataset([],via_rec);
	  end;
		
	pairs0 := table(pairs,travel_rec);	
	
	travel_rec switch(travel_rec ri) := transform
	  self.rid1 := ri.rid2;
		self.rid2 := ri.rid1;
	  self := ri;
	  end;
  all_pairs := pairs0 + project(pairs0,switch(left));
	
	add_step(dataset(travel_rec) p) := function
	  
		travel_rec old_route(travel_rec p) := transform
		  self.new := false;
		  self := p;
		  end;
		
		travel_rec new_route(travel_rec le,travel_rec ri) := transform
		  self.rid1 := le.rid1;
			self.rid2 := ri.rid2;
			self.pflag := le.pflag + ',' + ri.pflag;
			self.distance := le.distance+ri.distance;
			self.new := true;
			self.via := le.via + dataset([{le.rid2}],via_rec) + ri.via;
		  end;
			
	  new_places := join(p,p,left.rid2=right.rid1 and left.rid1<>right.rid2,new_route(left,right));
	  return dedup( sort( project(p,old_route(left)) + new_places, rid1, rid2, distance, new ), rid1, rid2 );
	  end;
	
  return loop( all_pairs, max(rows(left),new)=true, add_step(rows(left)) );
  end;