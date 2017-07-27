import address_attributes;

export get_Data := MODULE
	EXPORT Sex_Offenders 			(dataset(address_attributes.Layouts.rGeolink) Geolinks_in) := FUNCTION
		//Get Local Sex Offenders in target area
		Address_Attributes.Layouts.rSexOffenders getSexOffendersLocal(Geolinks_in l, Address_Attributes.key_sexoffender_geolink r) := transform
			self := r;			
			self := [];
		end;

		SexOffenders := join(Geolinks_in, Address_Attributes.key_sexoffender_geolink, 
			left.geolink !='' and
			keyed (left.geolink=right.geolink),
			getSexOffendersLocal(left, right), Left Outer, keep(500));
		
		SexOffenders_Target := dedup(sort(SexOffenders(did <> 0), did), did);

		Return SexOffenders_Target;
	END;

	EXPORT Public_Safety 			(dataset(address_attributes.Layouts.rGeolink) Geolinks_in) := FUNCTION
		//Get Local Law Enforcement Centers in target geolink
		Address_Attributes.Layouts.rPublicSafety addLEC(Geolinks_in l, Address_Attributes.key_LawEnforcement_geolink r) := transform
			self.institution := 'Law Enforcement';
			self.name := r.Department_Name;
			self.officers := r.Number_of_Officers;
			self.Pop_Per_Cop :=(string)((integer)r.Population / (integer)r.Number_of_Officers);
			self := r;
			self := [];
		end;

		LEC := join(Geolinks_in, Address_Attributes.key_LawEnforcement_geolink,
			left.geolink !='' and
			left.geolink = right.geolink,
			addLEC(left, right),Left Outer,keep(10));
		
		//Get Local Fire Departments in target geolink
		Address_Attributes.Layouts.rPublicSafety addFD(Geolinks_in l, Address_Attributes.key_FireDepartment_geolink r) := transform
			self.institution := 'Fire Department';
			self.name := r.Fire_Dept_Name;
			self.officers :=(string)((integer)r.active_firefighters_career + (integer)r.active_firefighters_volunteer + (integer)r.active_firefighters_paid_per_call);
			self := r;
			self := [];
		end;

		FD := join(Geolinks_in, Address_Attributes.key_FireDepartment_geolink,
			left.geolink !='' and
			left.geolink = right.geolink,
			addFD(left, right),Left Outer,keep(10));		
			
		Public_Safety := LEC(name <> '') + FD(name <> '');
		
		Return Public_Safety;
	END;

	EXPORT Correctional  			(dataset(address_attributes.Layouts.rGeolink) Geolinks_in) := FUNCTION
		//Get Local Correctional Facilities
		Address_Attributes.Layouts.rCorrectional addCorrectional(Geolinks_in l, Address_Attributes.key_ACA_geolink r) := transform
			self := r;
			self := [];
		end;

		ACA := join(Geolinks_in, Address_Attributes.key_ACA_geolink,
			left.geolink !='' and
			left.geolink = right.geolink,
			addCorrectional(left, right),Left Outer,keep(10));
		
		final_ACA := dedup(sort(ACA, institution),institution);
		
		Return final_ACA;
	END;

	EXPORT Schools 			 			(dataset(address_attributes.Layouts.rGeolink) Geolinks_in) := FUNCTION
		//Get Local Public and Private Schools in target area
		Address_Attributes.Layouts.rSchools addSchoolsLocal(Geolinks_in l, Address_Attributes.key_School_geolink r) := transform
			self := r;
			self := [];
		end;

		Schools := join(Geolinks_in, Address_Attributes.key_School_geolink,
			left.geolink !='' and
			left.geolink = right.geolink,
			addSchoolsLocal(left, right),Left Outer,keep(10));
			
		Return Schools(unitid <> '');
	END;
	
	EXPORT Colleges 		 			(dataset(address_attributes.Layouts.rGeolink) Geolinks_in) := FUNCTION
		//Get local Colleges in target geolink
		Address_Attributes.Layouts.rColleges addColleges(Geolinks_in l, Address_Attributes.key_Colleges_geolink r) := transform
			self := r;
			self := [];
		end;

		Colleges := join(Geolinks_in, Address_Attributes.key_Colleges_geolink,
			left.geolink !='' and
			left.geolink = right.geolink,
			addColleges(left, right),Left Outer,keep(10));
		
		Return Colleges(unitid <> '');
	END;
	EXPORT Neighborhood_Stats (dataset(address_attributes.Layouts.rGeolink) Geolinks_in) := FUNCTION
		//Get Stats from target geolink
		Address_Attributes.Layouts.rNeighborhood_Stats addNeighborhood_Stats(Geolinks_in l, Address_Attributes.key_Neighborhood_Stats_geolink r) := transform
			self := r;
			self := [];
		end;

		Stats := join(Geolinks_in, Address_Attributes.key_Neighborhood_Stats_geolink,
			left.geolink !='' and
			left.geolink = right.geolink,
			addNeighborhood_Stats(left, right),Left Outer,keep(10));
		
		Return Stats;
	END;



END;