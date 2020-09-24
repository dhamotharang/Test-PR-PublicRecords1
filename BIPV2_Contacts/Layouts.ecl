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

	export contactTitle := module
		shared contactKeyLayout := contact_linkids.layoutOrigFile;

		export contact_title_layout := {
			unsigned contact_title_rank;
			unsigned2 data_permits;
			contactKeyLayout.contact_did,
			contactKeyLayout.contact_job_title_derived;
			unsigned4 global_sid;
			unsigned8 record_sid;
		};

		export buildRec := {
			BIPV2.IDlayouts.l_xlink_ids2.ultid,
			BIPV2.IDlayouts.l_xlink_ids2.orgid,
			BIPV2.IDlayouts.l_xlink_ids2.seleid,
			BIPV2.IDlayouts.l_xlink_ids2.proxid,
			unsigned4 global_sid,
			unsigned8 record_sid,
			dataset(contact_title_layout) contact_title,
		};

		export linkids := {
			BIPV2.IDlayouts.l_xlink_ids2.ultid,
			BIPV2.IDlayouts.l_xlink_ids2.orgid,
			BIPV2.IDlayouts.l_xlink_ids2.seleid,
			BIPV2.IDlayouts.l_xlink_ids2.proxid,
			buildRec.global_sid,
			buildRec.record_sid,
			BIPV2.IDlayouts.l_xlink_ids2.uniqueId,
			dataset(contact_title_layout) contact_title,
			boolean is_suppressed,
		};

	end;

end;