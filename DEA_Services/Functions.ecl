
import ut, Census_Data, DEA, codes, DEA_services, iesp;
export Functions := module

		export params := interface
			export string25 city;
		end;
		
	shared ms(string70 a, string70 b, string70 c) :=
			map(a = '' => b,
					b = '' => a,
					ut.StringSimilar(a,c) <= ut.StringSimilar(b,c) => a,b); 
					
		shared streetAddress1Value(string prim_name, string prim_range, string predir, string addr_suffix, string postdir) :=
	            if (prim_name != '', '',
													trim(prim_range,left,right) + ' ' + trim(predir,left,right) + ' ' +
			                    trim(prim_name,left,right) + ' ' + trim(addr_suffix) + ' ' + 
													trim(postdir,left,right));
	       
  shared streetAddress2Value(string city, string st, string zip) := 					
							if (city != '', '', city + ' ' + trim(st,left,right) + ' ' + trim(zip,left,right));
																			
  shared stateCityZipValue(string city, string st, string zip) :=
							 if (city != '' OR zip != '', '', trim(st) + ' ' + city + ' ' + trim(zip));
													
  out_rec := iesp.controlledsubstance.t_DEARecord;
	export out_rec fnDEASearchVal(dataset(DEA_services.Layouts.rawrec) in_recs, params in_mod) := function
		
		out_rec xform(in_recs l) := TRANSFORM
			self.name := iesp.ECL2ESP.setName(l.fname,l.mname,l.lname,l.name_suffix,l.title);
			city := trim(ms(l.p_city_name, l.v_city_name, in_mod.city),left,right);
			Self.Address := iesp.ECL2ESP.setAddress(l.prim_name, l.prim_range, l.predir, l.postdir, l.addr_suffix,
												l.unit_desig,l.sec_range, city, l.st, l.zip, l.zip4,l.County_name, '',
												streetAddress1Value(l.prim_name, l.prim_range, l.predir, l.addr_suffix, l.postdir),
												streetAddress2Value(city, l.st, l.zip),
												stateCityZipValue(city, l.st, l.zip));
			self.RegistrationNumber := l.Dea_Registration_Number,
			self.DrugSchedules := l.Drug_Schedules,
			self.SSN := l.best_ssn,
			self.UniqueId := if ((unsigned6)l.did<>0, (intformat((unsigned6)l.did,12,1)),''),
			self.BusinessType := codes.DEA_REGISTRATION.BUSINESS_ACTIVITY_CODE(l.Business_Activity_code),
			self.CompanyName := l.cname,
			self.ExpirationDate := iesp.ECL2ESP.toDatestring8(l.Expiration_Date) ,
			self._penalty  := l.penalt;
			self.AlsoFound := l.isDeepDive;
			
			END;
		
			 census_data.MAC_Fips2County_Keyed(in_recs, st, county, County_name, temp_add_county);
			 temp_filter_search := project(temp_add_county,xform(LEFT));
 			 filter := dedup(sort(temp_filter_search,record), record);
			
	    return(filter);         
	end;
	
	

	
end;
