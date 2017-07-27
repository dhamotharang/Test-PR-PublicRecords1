/***
 ** Function to filter/transform Watercraft Services dataset into desired format.
 ** Filter watercraft longer than a certain length.
 ***/

import WatercraftV2_Services, iesp;
in_rec  := WatercraftV2_Services.Layouts.report_out;
out_rec := iesp.identitymanagementreport.t_IdmWaterCraftRecord;

export out_rec format_watercraft(dataset(in_rec) d_watercraft) := 
FUNCTION
			
			// #Step-1 Rollup according to watercraftkey
			in_rec rollupbykey(in_rec L,in_rec R) := TRANSFORM
				SELF.hull_number := IF(L.hull_number <> '',L.hull_number,R.hull_number);
				SELF := L;
			END;
			sorted_watercraft := SORT(d_watercraft, watercraft_key, -date_last_seen);
			rolledup_recs			:= ROLLUP(sorted_watercraft,LEFT.watercraft_key=RIGHT.watercraft_key,rollupbykey(LEFT,RIGHT));
			
			// #Step-2 Rollup for hull number + state combination
			in_rec rollupbyhullst(in_rec L, in_rec R) := TRANSFORM
				SELF := L; // we can add more fields to this transform later on
			end; 
			
			sorted_again := SORT(rolledup_recs,hull_number,title_state,-date_last_seen);
			int_recs := ROLLUP(rolledup_recs(hull_number <> ''), LEFT.hull_number = RIGHT.hull_number and LEFT.title_state = RIGHT.title_state,
																							rollupbyhullst(left, right));
			//#Step-3 transform the output into iesdl layout
			out_rec toOut(WatercraftV2_Services.Layouts.report_out L) := Transform
						Self.Watercraft.WatercraftKey := L.watercraft_key;
						Self.Watercraft.Description.HullNumber := L.hull_number;
						Self.Watercraft.Description.VesselType := L.vehicle_type_description;
						Self.Watercraft.Description.HullType := L.hull_type_description;
						Self.Watercraft.Description.ModelYear := (integer4) L.model_year; 
						Self.Watercraft.Description.VesselName := L.name_of_vessel;
						Self.Watercraft.Description.Make := L.watercraft_make_description;
						Self.Watercraft.Description.Model := L.watercraft_model_description;
						Self.Watercraft.Description.Length := L.watercraft_length;
						Self.Watercraft.Title.IssueDate := iesp.ECL2ESP.toDate((integer4) L.title_issue_date);
						Self.Watercraft.Title.State := L.title_state;
						Self.Watercraft.PurchaseDate := iesp.ECL2ESP.toDate((integer) L.purchase_date);
						// filter out aircraft carriers and the like
						Self.Watercraft.Filtered := (integer)L.watercraft_length > IdentityManagement_Services.Constants.MaxWatercraftLen;
						Self.Watercraft.DateLastSeen := iesp.ECL2ESP.toDate((INTEGER)L.date_last_seen);

			end;
			watercrafts_recs := SORT(project(int_recs, toOut(left)),-Watercraft.DateLastSeen);

			/*******
			// DEBUG
			OUTPUT(watercrafts_recs, NAMED('watercrafts_recs'));
			*******/
			
			RETURN watercrafts_recs;
		
END;