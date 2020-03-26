import BIPV2;

export Layouts := module

	export contact_linkids := module
		export r1 := {
			unsigned8 rid := 0;
			BIPV2.IDlayouts.l_xlink_ids; 
			BIPV2.Layout_Business_Linking_Full - employee_count_org_raw - revenue_org_raw  - employee_count_local_raw  - revenue_local_raw;
			boolean executive_ind := false;
			integer executive_ind_order := 0;
		};

		export layoutOrigFile := {r1 - rid, unsigned4 global_sid, unsigned8 record_sid};
	end;


end;