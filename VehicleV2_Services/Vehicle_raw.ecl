/* Attribute deprecated, please use VehicleV2.Raw attribute instead */
import VehicleV2_Services, doxie;

export Vehicle_raw := module


	export get_vehicle_crs_report_by_Veh_key (dataset(Layout_Vehicle_Key) in_veh_keys, string in_ssn_mask_type = '') := function


		sort_keys := sort(in_veh_keys, Vehicle_Key, -Iteration_Key);
		group_keys := group(sort_keys, Vehicle_key, Iteration_key);
		dedup_keys := dedup(group_keys, Vehicle_Key, Iteration_Key,sequence_key);

		in_mod := VehicleV2_Services.IParam.getReportModule();

		vsr := ungroup(VehicleV2_Services.Raw.get_vehicle_report(in_mod, dedup_keys));
	
		rec := record
		vsr;
		unsigned1 priority_num;
		unsigned2 srt_num;
		end;

		srt := sort(vsr, vin,-((unsigned1)is_current),
		-max(registrants,reg_latest_effective_date), -max(registrants,reg_latest_expiration_date),
		-((unsigned) iteration_key),-sequence_key,record);
		
		srt_title_holders := sort(vsr,vin,if(exists(owners),0,1),
		-max(owners,ttl_latest_issue_date),-max(owners,ttl_earliest_issue_date),
		-((unsigned) iteration_key),-sequence_key);

		rec get_num(vsr l,integer C):=transform
			self :=l;
			self.priority_num := 1;
			self.srt_num := C;
		END;
		
		ddp := project(sort(dedup(srt, vin),
		-((unsigned1)is_current),-max(registrants,reg_latest_effective_date), -max(registrants,reg_latest_expiration_date), 
		-((unsigned) iteration_key)),
		get_num(left,counter));

		rec get_num_from_reg(vsr l,rec r):=transform
			self :=l;
			self.priority_num := 2;
			self.srt_num := r.srt_num;
		END;

		title_holders := dedup(srt_title_holders,vin)(exists(owners));
		
		ddp_titles := join(title_holders,ddp(~exists(owners)),left.vin=right.vin, get_num_from_reg(left,right));
		
		return project(sort(ddp + ddp_titles,NonDMVSource,srt_num,priority_num),transform(recordof(vsr),self :=left));

	end;	
	
end;
