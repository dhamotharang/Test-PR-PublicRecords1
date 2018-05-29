Import Doxie, ut, std, UPS_Services;

EXPORT fn_CurrentPersonAddressLookup(dataset(UPS_Services.layout_Common)dsPreCurrent) := function 

	dsWithCurrent := join(dsPreCurrent , Doxie.Key_Address, 
											keyed(
											 left.prim_name = right.prim_name and
											 left.prim_range = right.prim_range and
											 left.state = right.st and
											 hash(left.city_name) = right.city_code and
											 left.zip = right.zip and
											 left.sec_range = right.sec_range) and 
											 (std.Metaphone.Primary(left.lname) = right.dph_lname or 
											  left.lname = right.lname )and 
											  (left.fname = right.pfname or 
											   left.fname = right.fname  )
											 ,
											transform
												(UPS_Services.layout_Common,
												 self.Current := if(ut.bit_test(right.lookups,31),'Y',left.Current);
												 self := left ),left outer, keep(1),limit(0));											 

	/* todo :  add a comment about  lookups */
	
return dsWithCurrent;

end;
