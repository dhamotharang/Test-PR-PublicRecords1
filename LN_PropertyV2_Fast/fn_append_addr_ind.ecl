import Property, ln_propertyv2, ln_propertyv2_fast;
EXPORT fn_append_addr_ind (dataset(recordof(ln_propertyV2.Layout_DID_Out)) search_prp) := function

	search_in	:= dedup(sort(distribute(search_prp(did<>0 and trim(prim_name)<>''),
													hash(did,prim_range,prim_name)),
										 did,prim_range,prim_name,sec_range,v_city_name,local),
							 did,prim_range,prim_name,sec_range,v_city_name);

	Property.layout_header_append.inrec trans1(search_in L, integer c) := transform
		self.did				:=l.did;
		self.rid				:=c;
		self.prim_range	:=l.prim_range;
		self.prim_name	:=l.prim_name;
		self.sec_range	:=l.sec_range;
		self.city				:=l.v_city_name;
		self.st					:=l.st;
		self						:=l;
	end; 

	ins	:= project(search_in, trans1(left, counter));
	out	:= dedup(sort(distribute(property.append_addr_ind(ins),
										hash(did,prim_range,prim_name)),
							 did,prim_range,prim_name,sec_range,st,city,local),
					did,prim_range,prim_name,sec_range,st,city);
					
	search_dis := sort(distribute(search_prp,
										 hash(did,prim_range,prim_name)),
							  did,prim_range,prim_name,sec_range,st,v_city_name,local);
	
	search_out := join(search_dis,out,
										left.did				= right.did 				and
										left.prim_range	= right.prim_range 	and
										left.prim_name	= right.prim_name 	and
										left.sec_range	= right.sec_range 	and
										left.v_city_name= right.city 				and
										left.st					= right.st,
										transform(ln_propertyV2.Layout_DID_Out,
															self.addr_ind			:=right.addr_ind;
															self.best_addr_ind:=right.best_addr_ind;
															self:=left),
										LEFT OUTER,local);
	return search_out;
	
END;