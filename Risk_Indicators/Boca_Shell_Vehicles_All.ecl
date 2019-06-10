
IMPORT Doxie, Drivers, Riskwise, ut, VehicleV2, VehicleV2_Services, risk_indicators;

EXPORT Boca_Shell_Vehicles_All := MODULE

	// ----------[ Layouts ]----------
	
	// For EXPORT vehicle_records( )...:
	SHARED Layout_Veh_key := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 did;
		STRING30 Vehicle_Key;   // not useful
		STRING15 Iteration_Key; // not useful
		STRING15 Sequence_Key;  // not useful
	END;

	EXPORT Layout_Veh_Info := RECORD
		STRING4  year_make;
		STRING10 make;		
		STRING10 model;
		BOOLEAN  title;
		STRING25 vin;
		STRING2	 orig_state;
		STRING2  source_code;
		BOOLEAN  is_current;
	END;

	SHARED Layout_Veh := RECORD
		Layout_Veh_key;
		Layout_Veh_Info;
	END;

	EXPORT Layout_Vehs := RECORD
		Layout_Veh_key;
		UNSIGNED1 current_count;
		UNSIGNED1 historical_count;
		DATASET(Layout_Veh_Info) Vehicles;
	END;

	// For EXPORT as_Key_BocaShell_Vehicles( )...:
	SHARED Layout_Veh_Info_Key := RECORD
		UNSIGNED2 year_make;
		STRING10 make;		
		STRING10 model;
		BOOLEAN title;
		STRING25 vin;
		string2	orig_state;
		string2 source_code;
	END;

	EXPORT Layout_Veh_Rec := RECORD
		unsigned6	did;
		string30  Vehicle_Key;
		string15  Iteration_Key;
		string15  Sequence_Key;
		UNSIGNED1 current_count;
		UNSIGNED1 historical_count;
		Layout_Veh_Info_Key Vehicle1;
		Layout_Veh_Info_Key Vehicle2;
		Layout_Veh_Info_Key Vehicle3;	
	END;
	
	
	// ----------[ Functions ]----------
	//
	//  o   vehicle_records( )           --general-purpose function returns child dataset of all vehicles for a person
	//  o   as_Key_BocaShell_Vehicles( ) --mimicks the data and layout of VehicleV2.Key_BocaShell_Vehicles
	//  o   as_Boca_Shell_Vehicles( )    --mimicks the data and layout of Risk_Indicators.Boca_Shell_Vehicles
	
	// The following function has the same formal parameters as Risk_Indicators.Boca_Shell_Vehicles, 
	// but it contains logic that corrects problems found in VehicleV2.file_bocashell_vehicles (which
	// is consumed by Boca_Shell_Vehicles), where a 'current' vehicle is determined incorrectly.  
	// The output dataset contains information that will used elsewhere to duplicate the output from 
	// VehicleV2.Key_BocaShell_Vehicles (which is faulty), as well to provide data for other calling 
	// functions potentially.
	EXPORT vehicle_records( GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell_ids) ids, // grouped on seq
	                        UNSIGNED1 dppa, 
	                        BOOLEAN dppa_ok, 
	                        BOOLEAN includeRel,
	                        UNSIGNED1 BSversion ) := 
		FUNCTION
			
			UCase := StringLib.StringToUpperCase;

			// Local layouts...:
			layout_vehicle_key_plus_did := 
				RECORD(VehicleV2_Services.Layout_Vehicle_Key)
					INTEGER seq;
					UNSIGNED6	did;
				END;

			layout_vehicle_key_plus_did xfm1(Risk_Indicators.Layout_Boca_Shell_ids l, VehicleV2.Key_Vehicle_DID r) := TRANSFORM
				SELF.seq           := l.seq; 
				SELF.did           := r.Append_DID;
				SELF.Vehicle_Key   := r.Vehicle_Key;
				SELF.Iteration_Key := r.Iteration_Key;
				SELF.Sequence_Key  := r.Sequence_Key;
				SELF.state_origin  := ''; //needed for dppa stuff
				SELF.is_deep_dive  := false;
			END;

			// 1. Join ids to the did key to get vehicle key information; sort and dedup.
			seq_vehicle_keys := 
				JOIN(
					ids, VehicleV2.Key_Vehicle_DID, 
					KEYED(LEFT.did = RIGHT.Append_DID), 
					xfm1(LEFT, RIGHT)
				);

			vehicle_keys_ddpd := 
				DEDUP(
					SORT(
						seq_vehicle_keys, seq, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin
					),
					seq, Vehicle_Key, Iteration_Key, Sequence_Key, state_origin
				);

			// 2. Transform vehicle keys data to layout needed for vehicle search; sort and group.
			// Note that we have to do a slightly awkward transformation seq --> acctno, since the 
			// formal parameter 'ids' doesn't have an acctno field. But the vehicle search requires 
			// an acctno value to differentiate input records properly.
			in_veh_keys := 
				PROJECT(
					vehicle_keys_ddpd,
					TRANSFORM( VehicleV2_Services.Layout_VKeysWithInput, 
						SELF.acctno := (STRING20)LEFT.seq,
						SELF := LEFT, 
						SELF := []
					)
				);
			
			in_veh_keys_grpd := 
				GROUP( 
					SORT( 
						in_veh_keys, Vehicle_Key, Iteration_Key, Sequence_Key 
					), 
					Vehicle_Key, Iteration_Key, Sequence_Key 
				);

			// 3. Define search module needed for vehicle search.
			in_mod := VehicleV2_Services.IParam.getSearchModule();
			
			// 4. Get vehicle search records.
			VehicleV2_Services.Layouts.Layout_Report_Batch_New // = acctno + VehicleV2_Services.Layout_Report
					vehicles_pre := VehicleV2_Services.Functions.Get_VehicleSearch( in_mod, in_veh_keys_grpd );

			layout_report_w_seq_did := record
				UNSIGNED4 seq;
				UNSIGNED6 did;
				VehicleV2_Services.Layout_Report;
			end;
			
			vehicles := 
				JOIN(
					ids, vehicles_pre,
					LEFT.seq = (INTEGER)RIGHT.acctno,
					TRANSFORM( layout_report_w_seq_did,
						SELF.seq := LEFT.seq,
						SELF.did := LEFT.did,
						SELF := RIGHT
					),
					INNER
				);
			
			// 5. Sort and dedup to obtain the most recent record for each vehicle. It's assumed that
			// iteration_key value (alphanumeric) is sufficient to determine relative recency.
			vehicles_ddpd := 
				dedup( 
					sort( 
						vehicles, seq, vehicle_key, -(unsigned1)is_current, -iteration_key
					), 
					seq, vehicle_key 
				);
			
			// 6. Group by acctno for group-rollup.
			vehicles_grpd := 
				group(
					sort( 
						vehicles_ddpd, seq, -(unsigned1)is_current, -iteration_key 
					), 
					seq 
				);
			
			// Note: In VehicleV2.file_bocashell_vehicles, year_make, make, and model are assigned 
			// values from Best_Model_Year, Best_Make_Code, and Best_Model_Code, respectively. 
			// Turns outthat Best_Model_Code is pretty sparse. In the transform below we're using  
			// slightly different data that should be a bit more useful: le.model_year is just a  
			// year; le.make_desc is not a code--it spells out entirely the make of the vehicle; 
			// and le.vina_vp_series_name is the concatenation of the Model and Series data.
			Layout_Veh xfm2(layout_report_w_seq_did le) := TRANSFORM
				SELF.year_make  := le.model_year;
				SELF.make       := UCase(le.make_desc);		
				SELF.model      := UCase(le.vina_vp_series_name);
				SELF.orig_state := le.state_origin;
				SELF            := le;
				SELF            := [];
			END;

			vehs_denorm := PROJECT(vehicles_grpd(did != 0), xfm2(LEFT));

			// Now rollup individual vehicle records into a child dataset...:
			Layout_Vehs doRollup(Layout_Veh le, DATASET(Layout_Veh) allRows) :=
				TRANSFORM
					SELF.seq              := le.seq;
					SELF.did              := le.did;
					SELF.Vehicle_Key      := le.Vehicle_Key;   // not useful
					SELF.Iteration_Key    := le.Iteration_Key; // not useful
					SELF.Sequence_Key     := le.Sequence_Key;  // not useful
					SELF.current_count    := COUNT( allRows(is_current) );
					SELF.historical_count := COUNT( allRows ); // "if it's current, also ding the historical counter"
					SELF.Vehicles         := PROJECT(allRows, Layout_Veh_Info);
				END;
			
			vehs_rolled := ROLLUP(vehs_denorm, GROUP, doRollup(LEFT,ROWS(LEFT)));
			
			RETURN vehs_rolled;
		END;

	// The function below mimicks the data and layout of VehicleV2.Key_BocaShell_Vehicles, but
	// it benefits from the improved logic found in vehicle_records( ) above. The intention of this 
	// function is to provide backwards-compatibility for those attributes that rely on VehicleV2
	// .Key_BocaShell_Vehicles but want the improved results that vehicle_records( ) provides.
	EXPORT as_Key_BocaShell_Vehicles(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell_ids) ids, // grouped on seq
	                                 UNSIGNED1 dppa, 
	                                 BOOLEAN dppa_ok, 
	                                 BOOLEAN includeRel,
	                                 UNSIGNED1 BSversion) :=
		FUNCTION
			veh_recs := vehicle_records( ids, dppa, dppa_ok, includeRel, BSversion );
			
			Layout_Veh_Rec xfm_to_key_layout(Layout_Vehs le) := TRANSFORM
				SELF.did                  := (UNSIGNED6)le.did;
				SELF.Vehicle_Key          := le.vehicle_key;   
				SELF.Iteration_Key        := le.Iteration_Key; 
				SELF.Sequence_Key         := le.Sequence_Key;  
				SELF.current_count        := le.current_count;
				SELF.historical_count     := le.historical_count;

				SELF.Vehicle1.year_make   := (UNSIGNED2)le.Vehicles[1].year_make;
				SELF.Vehicle1.make        := le.Vehicles[1].make;
				SELF.Vehicle1.model       := le.Vehicles[1].model;
				SELF.Vehicle1.title       := le.Vehicles[1].title;
				SELF.Vehicle1.vin         := le.Vehicles[1].vin;
				SELF.Vehicle1.orig_state  := le.Vehicles[1].orig_state;
				SELF.Vehicle1.source_code := le.Vehicles[1].source_code;

				SELF.Vehicle2.year_make   := (UNSIGNED2)le.Vehicles[2].year_make;
				SELF.Vehicle2.make        := le.Vehicles[2].make;
				SELF.Vehicle2.model       := le.Vehicles[2].model;
				SELF.Vehicle2.title       := le.Vehicles[2].title;
				SELF.Vehicle2.vin         := le.Vehicles[2].vin;
				SELF.Vehicle2.orig_state  := le.Vehicles[2].orig_state;
				SELF.Vehicle2.source_code := le.Vehicles[2].source_code;

				SELF.Vehicle3.year_make   := (UNSIGNED2)le.Vehicles[3].year_make;
				SELF.Vehicle3.make        := le.Vehicles[3].make;
				SELF.Vehicle3.model       := le.Vehicles[3].model;
				SELF.Vehicle3.title       := le.Vehicles[3].title;
				SELF.Vehicle3.vin         := le.Vehicles[3].vin;
				SELF.Vehicle3.orig_state  := le.Vehicles[3].orig_state;
				SELF.Vehicle3.source_code := le.Vehicles[3].source_code;
			END;
			
			ds_Key_BocaShell_Vehicles := PROJECT( veh_recs, xfm_to_key_layout(LEFT) ); 

			RETURN ds_Key_BocaShell_Vehicles;			
		END;

	// The function below mimicks the data and layout of Risk_Indicators.Boca_Shell_Vehicles, but
	// it benefits from the improved logic found in as_Key_BocaShell_Vehicles( ) above. The intention 
	// of this function is to provide backwards-compatibility for those attributes that rely on Risk_
	// Indicators.Boca_Shell_Vehicles but want the improved results that vehicle_records( ) provides.
	EXPORT as_Boca_Shell_Vehicles(GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell_ids) ids, // grouped on seq
	                   UNSIGNED1 dppa, 
	                   BOOLEAN dppa_ok, 
	                   BOOLEAN includeRel,
	                   UNSIGNED1 BSversion) := FUNCTION

		kv := as_Key_BocaShell_Vehicles( ids, dppa, dppa_ok, includeRel, BSversion );

		vehrec := RECORD
			risk_indicators.Layout_Boca_Shell_ids;
			risk_indicators.Layout_Vehicles.Vehicle_Set;
			unsigned1 relative_owned_count;
		END;

		vehrec get_vehicles(ids L, kv R) := transform
			self := L;
			self.vehicle1 := if (drivers.state_dppa_ok(R.vehicle1.orig_state,dppa,R.vehicle1.source_code), R.vehicle1);
			self.vehicle2 := if (drivers.state_dppa_ok(R.vehicle2.orig_state,dppa,R.vehicle2.source_code), r.vehicle2);
			self.vehicle3 := if (drivers.state_dppa_ok(r.vehicle3.orig_state,dppa,R.vehicle3.source_code), r.vehicle3);
			self.relative_owned_count := if(l.isrelat and r.current_count>0, 1, 0);
			self := R;
			self := [];
		end;

		f := if(includeRel and BSversion>1, ids, ids(~isrelat));	// only do the relatives if includeRelatives and bocashell version>1

		outf := join (ungroup(f), KV,
									left.did = right.did and dppa_ok,
									get_vehicles(LEFT,RIGHT), 
						ATMOST(left.did=right.did, Riskwise.max_atmost),keep(100));
					
		vehrec roll_relative_count(vehrec L, vehrec R) := transform
			self.relative_owned_count := l.relative_owned_count + r.relative_owned_count;
			self := l;
		END;
		
		final := ungroup( rollup(group(sort(outf,seq,isrelat, did),seq), left.seq=right.seq, roll_relative_count(LEFT,RIGHT)) );

		out := if(includeRel, final, outf);	// only do the rollup if we are using the relatives

		return out;
	end;

END;
