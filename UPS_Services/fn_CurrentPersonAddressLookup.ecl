Import Doxie, ut, std, UPS_Services;

EXPORT fn_CurrentPersonAddressLookup(dataset(UPS_Services.layout_Common)dsPreCurrent) := function 
/* The 31st bit of lookups field in Doxie.Key_Address  indicates if the person is a current resident of the address or not*/
	dsWithCurrent := join(dsPreCurrent , Doxie.Key_Address, 
										  keyed(
											 ut.StripOrdinal(left.prim_name) = right.prim_name and
											 left.prim_range = right.prim_range and
											 left.state = right.st and
											 hash(left.city_name) = right.city_code and
											 left.zip = right.zip and
											 left.sec_range = right.sec_range) 
											 AND
											 ( 
											   (
												   left.rollup_key <> 0 and 
													 left.rollup_key_type = UPS_Services.Constants.TAG_ROLLUP_KEY_DID and 
													 left.rollup_key = right.did
													 )
											    OR
											   (
												   (
														 left.lname = right.lname or													   
														 std.Metaphone.Primary(left.lname) = right.dph_lname  
														) 
													  and 
													  (
														  left.fname = right.pfname or 
															left.fname = right.fname  
														 )
													)
												) 
											 ,
											transform
												(UPS_Services.layout_Common,
												 self.Current := if(ut.bit_test(right.lookups,31),'Y',left.Current);
												 self := left ),left outer, keep(1),limit(0));											 

	
return dsWithCurrent;

end;
