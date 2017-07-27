import Address_file, ADVO;

rec := fedex_services.Layouts.out;

export fn_CheckAddrType (
	dataset(rec) l):= 
FUNCTION

	typekey := Advo.Key_Addr1; //zip, prim_range, prim_name, addr_suffix, predir, postdir, sec_range
	j := 
		join(
			l,
			typekey,
			keyed(left.zip5 = right.zip) and 
			keyed(left.prim_range = right.prim_Range) and
			keyed(left.prim_name = right.prim_name) and 
			keyed(left.addr_suffix = right.addr_suffix) and
			keyed(left.predir = right.predir) and
			keyed(left.postdir = right.postdir) and
			keyed(left.sec_range = right.sec_range),
//			keyed(left.v_city_name = right.v_city_name) and
//			keyed(left.st = right.st) and
			transform(
				rec,
					self.unit_desig := if(length(trim(left.sec_range))=0 and length(trim(left.unit_desig))>0,'',left.unit_desig),  // if there is not sec range and the unit desig has something blank it out
					self.address_type := 
							map(left.internal_src = fedex_services.Contants.internal_src_fedexNoHit 		
																							=> left.address_type,
									right.Residential_or_Business_Ind = 'A'		=> Fedex_Services.Contants.str_Residential,
									right.Residential_or_Business_Ind = 'B'		=> Fedex_Services.Contants.str_Business,			
									left.address_type),
					self.address_college_ind := if(right.College_Indicator ='Y', true, false),
					self.address_mail_drop_ind := map(right.Drop_Indicator ='C' => true,
																						right.Drop_Indicator ='Y' => true,
																						false),
					self.address_location_type := right.Record_Type_Code,
					self.address_dwelling_type := map(right.Address_Type = '1' => 'SFD',
																			 		  right.Address_Type = '2' => 'MFD',
																						''),
					self := left
			),
			left outer,
			keep(1)
		);
							
	return j;	
		
END;