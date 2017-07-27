
import ut;

export Raw := module

	export getERODocuments(dataset(ero_services.Layouts.LookupId) ids = dataset([],Layouts.LookupId)) := 
		function

			ds_deceased_recs := fn_getDeceasedRecs(ids);
			
			ds_driversLicense_recs_with_dl_address := 
					fn_getDriversLicenseRecs(ids);
					
			// Add the address retrieved from the Drivers License record to the LookupId layout
			// since the requirements stipulation that the Vehicle and Accident recs must be 
			// match-coded against the DL address as well as others.
			ids_plus_dl_addrs :=
				join(
					ids, ds_driversLicense_recs_with_dl_address,
					left.acctno = right.acctno,
					transform( ero_services.Layouts.LookupId,
						self.dl_addr.prim_range  := right.DL_prim_range,
						self.dl_addr.predir      := right.DL_predir,
						self.dl_addr.prim_name   := right.DL_prim_name,
						self.dl_addr.addr_suffix := right.DL_addr_suffix,
						self.dl_addr.postdir     := right.DL_postdir,
						self.dl_addr.unit_desig  := right.DL_unit_desig,
						self.dl_addr.sec_range   := right.DL_sec_range,
						self.dl_addr.p_city_name := right.DL_p_city_name,
						self.dl_addr.st          := right.DL_st,
						self.dl_addr.z5          := right.DL_z5,
						self                     := left
					)
				, left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT));

			ds_driversLicense_recs := 
					project(ds_driversLicense_recs_with_dl_address, Layouts.driversLicense_out);
			
			ds_vehicle_recs         := fn_getVehicleRecs(ids_plus_dl_addrs);
			ds_accident_recs        := fn_getAccidentRecs(ids_plus_dl_addrs);
			ds_criminalOffense_recs := fn_getCriminalOffenseRecs(ids);
			
			// Perform lego-joins to assemble final output records.
			
			mac_join_condition() := macro // change as needed; will be applied to all joins below. 
				left.acctno = right.acctno
			endmacro;
	
			// Add Deceased records.
			ds_output_having_deceased := 
				join( 
					ids, ds_deceased_recs, 
					mac_join_condition(), 
					transform(ERO_Services.Layouts.BatchOut, self.acctno := left.acctno, self.did := left.did, self := right,self := left,  self := [] ), 
					left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT)
				);

			// Add Drivers License records.
			ds_output_having_driversLicense := 
				join( 
					ds_output_having_deceased, ds_driversLicense_recs, 
					mac_join_condition(), 
					transform( ERO_Services.Layouts.BatchOut,self.acctno := left.acctno, self.did := left.did, self := right, self := left,  self := [] ), 
					left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT)
				);

			// Add Vehicle records.
			ds_output_having_vehicle := 
				join( 
					ds_output_having_driversLicense, ds_vehicle_recs, 
					mac_join_condition(), 
					transform( ERO_Services.Layouts.BatchOut,self.acctno := left.acctno, self.did := left.did, self := right, self := left, self := [] ), 
					left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT)
				);
				
			// Add Accident records.
			ds_output_having_accidents := 
				join( 
					ds_output_having_vehicle, ds_accident_recs, 
					mac_join_condition(), 
					transform( ERO_Services.Layouts.BatchOut, self.acctno := left.acctno, self.did := left.did, self := right,self := left,  self := [] ), 
					left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT)
				);
	
			// Add Criminal Offense records.
			ds_output_having_criminalOffenses := 
				join( 
					ds_output_having_accidents, ds_criminalOffense_recs, 
					mac_join_condition(), 
					transform( ERO_Services.Layouts.BatchOut, self.acctno := left.acctno, self.did := left.did, self := right,self := left,  self := [] ), 
					left outer, limit(ERO_Services.Constants.Limits.MAX_JOIN_LIMIT)
				);
				
			ds_output_results := ds_output_having_criminalOffenses;
			
			 // output(ids,named('ids'));
			 // output(ids_plus_dl_addrs,named('ids_plus_dl_addrs'));
			// output(ds_deceased_recs,named('deceased'));
			// output(ds_driversLicense_recs,named('driversLicense'));
			 // output(ds_vehicle_recs,named('vehicle'));
			// output(ds_accident_recs,named('accident'));
			// output(ds_criminalOffense_recs,named('criminal'));
			
			return ds_output_results;
		end;
		
end;