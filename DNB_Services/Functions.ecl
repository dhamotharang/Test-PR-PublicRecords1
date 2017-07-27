
import ut, Census_Data, dnb, codes, dnb_services, iesp;
export Functions := module

		export params := interface
			export string25 city;
		end;
		
	shared ms(string70 a, string70 b, string70 c) :=
			map(a = '' => b,
					b = '' => a,
					ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b); 
					
		shared streetAddress1Value(string prim_name, string prim_range, string predir, string addr_suffix, string postdir) :=
	            if (prim_name != '',
													trim(prim_range,left,right) + ' ' + trim(predir,left,right) + ' ' +
			                    trim(prim_name,left,right) + ' ' + trim(addr_suffix) + ' ' + 
													trim(postdir,left,right), '');
	       
  shared streetAddress2Value(string city, string st, string zip) := 					
							if (city != '', city + ' ' + trim(st,left,right) + ' ' + trim(zip,left,right), '');
																			
  export stateCityZipValue(string city, string st, string zip) :=
							 if (city != '' OR zip != '', trim(st) + ' ' + city + ' ' + trim(zip), '');
													
	export dnbSearchVal(dataset(dnb_services.Layouts.rawrec) in_recs, params in_mod) := function
		
		Layouts.t_dnbRecordWithPenalty xform(in_recs l) := TRANSFORM
			self.CompanyName := l.business_name,
			self.DunsNumber := l.duns_number,
			self.BusinessId := (string) l.bdid,
			Self.TradeName := l.trade_style,
			self.Phone := l.telephone_number;
			city := trim(ms(l.p_city_name, l.v_city_name, in_mod.city),left,right);
			Self.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix,
												l.unit_desig,l.sec_range, city, l.st, l.zip, l.zip4,l.County_name, '',
												streetAddress1Value(l.prim_name, l.prim_range, l.predir, l.addr_suffix, l.postdir),
												streetAddress2Value(city, l.st, l.zip),
												stateCityZipValue(city, l.st, l.zip));
			
			self.DateLastSeen := iesp.ECL2ESP.toDatestring8(l.date_last_seen),
			self.penalt := l.penalt,
			self.isDeepDive := l.isDeepDive,
			self.BusinessIDs.proxid := l.proxid,
			self.businessIDs.ultid := l.ultid,
			self.businessIDs.orgid := l.orgid,
			self.businessIDs.seleid := l.seleid,
			self.businessIDs.dotid := l.dotid,
			self.BusinessIDs.empid := l.empid,
			self.BusinessIDs.powid := l.powid,
			self.IdValue := '';
		END;
		
		census_data.MAC_Fips2County_Keyed(in_recs, st, county, County_name, temp_add_county);
		filter_search := project(temp_add_county,xform(LEFT));			
	  return(filter_search);         
	end;
	
	

	
end;
