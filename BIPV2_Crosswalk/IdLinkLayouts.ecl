import BIPV2;
import DidVille;

appendOutRec := BIPV2.IdAppendLayouts.AppendOutput;

EXPORT IdLinkLayouts := module

	export contactRec := {
		BIPV2.IdAppendLayouts.AppendInput.contact_fname,
		BIPV2.IdAppendLayouts.AppendInput.contact_mname,
		BIPV2.IdAppendLayouts.AppendInput.contact_lname,
		BIPV2.IdAppendLayouts.AppendInput.contact_ssn,
		BIPV2.IdAppendLayouts.AppendInput.contact_did,		
	};

	export businessInput := {	
		BIPV2.IdAppendLayouts.AppendInput - [request_id, contact_fname, contact_mname, contact_lname, contact_ssn, contact_did],
		typeof(BIPV2.IdAppendLayouts.AppendInput.company_name) dba_name,
		contactRec contact1,
		contactRec contact2,
		contactRec contact3,
		contactRec contact4,
		contactRec contact5,
	};

	export consumerInput := {
		DidVille.Layout_Did_InBatch - seq,
		unsigned8 did
	};

	export crosswalkInput := {
		BIPV2.IdAppendLayouts.AppendInput.request_id,
		consumerInput consumer,
		businessInput business,
	};

	shared parentRec := {
		BIPV2.IdLayouts.l_xlink_ids.ultid,
		BIPV2.IdLayouts.l_xlink_ids.orgid,
		BIPV2.IdLayouts.l_xlink_ids.seleid,
		BIPV2.IdLayouts.l_xlink_ids.proxid,
		appendOutRec.company_name,
		appendOutRec.prim_name,
		appendOutRec.prim_range,
		appendOutRec.sec_range,
		typeof(appendOutRec.p_city_name) city,
		typeof(appendOutRec.st) state,
		appendOutRec.zip,
		appendOutRec.company_phone,
	};

	export businessOutput := {
		crosswalkInput.request_id,
		consumerInput.did,
		unsigned did_score,
		typeof(Layouts.ConsumerToBipFinalRec.job_title1) title,
		BIPV2.IdLayouts.l_xlink_ids.ultid,
		BIPV2.IdLayouts.l_xlink_ids.orgid,
		BIPV2.IdLayouts.l_xlink_ids.seleid,
		BIPV2.IdLayouts.l_xlink_ids.proxid,
		BIPV2.IdLayouts.l_xlink_ids.powid,
		appendOutRec.isActive,
		appendOutRec.isDefunct,
		appendOutRec.company_name,
		appendOutRec.company_phone,
		appendOutRec.prim_range,
		appendOutRec.prim_name,
		appendOutRec.sec_range,
		typeof(appendOutRec.p_city_name) city,
		typeof(appendOutRec.st) state,
		appendOutRec.zip,
		typeof(appendOutRec.company_fein) fein,
		typeof(Layouts.ConsumerToBipFinalRec.dt_first_seen) business_first_seen,
		typeof(Layouts.ConsumerToBipFinalRec.dt_last_seen)  business_last_seen,
		typeof(Layouts.ConsumerToBipFinalRec.dt_first_seen_at_business) first_seen_at_business,
		typeof(Layouts.ConsumerToBipFinalRec.dt_last_seen_at_business) last_seen_at_business,
		parentRec parent,
		Layouts.ConsumerToBipFinalRec.sourceInfo,
	};

	export contactOutput := {
		crosswalkInput.request_id,
		BIPV2.IdLayouts.l_xlink_ids,
		consumerInput.did,
		unsigned hhid,
		string job_title1,
		string job_title2,
		string job_title3,
		string title,
		string fname,
		string mname,
		string lname,
		string name_suffix,
		string prim_range,
		string prim_name,
		string sec_range,
		string city,
		string state,
		string zip,
		string phone,
		string ssn,
		string email,
		unsigned dt_address_last_seen,
		unsigned dt_address_first_seen,
		unsigned dt_ln_first_seen,
		unsigned dt_ln_last_seen,
		unsigned dt_first_seen_at_business,
		unsigned dt_last_seen_at_business,
		Layouts.BipToConsumerFinalRec.sourceInfo,
	};

end;