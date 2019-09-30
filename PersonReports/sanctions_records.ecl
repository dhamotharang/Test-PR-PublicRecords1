IMPORT $, iesp, doxie,Prof_LicenseV2_Services;

out_rec := iesp.proflicense.t_SanctionRecord;

EXPORT dataset (out_rec) sanctions_records (
  dataset (doxie.layout_references) dids,
  $.IParam.sanctions in_params = module ($.IParam.sanctions) end, //currently, a placeholder
  boolean IsFCRA = false
) := FUNCTION

	ids := Prof_LicenseV2_Services.Prof_Lic_raw.get_sanc_ids_from_dids(dids);
	Sanc_records := doxie.ING_sanctions_report_records(set(ids,sanc_id));
  
	out_rec formatReportRecord (Sanc_records L) := transform
			Self._Type := L.SANC_TYPE;
			Self.ProviderType := L.SANC_PROVTYPE;
			Self.SanctionId := (unsigned) L.SANC_ID;
			Self.SanctionLicenseNumber := L.SANC_LICNBR;
			Self.TIN := L.SANC_TIN;
			Self.Name := iesp.ECL2ESP.SetName (L.Prov_Clean_fname,L.Prov_Clean_mname,L.Prov_Clean_lname,'',''); 
			Self.Address :=  iesp.ECL2ESP.SetAddress (
				l.ProvCo_Address_Clean_prim_name, l.ProvCo_Address_Clean_prim_range, l.ProvCo_Address_Clean_predir,
				l.ProvCo_Address_Clean_postdir, l.ProvCo_Address_Clean_addr_suffix, l.ProvCo_Address_Clean_unit_desig,
				l.ProvCo_Address_Clean_sec_range, l.ProvCo_Address_Clean_p_city_name,
				l.ProvCo_Address_Clean_st, l.ProvCo_Address_Clean_zip, l.ProvCo_Address_Clean_zip4, '');
			Self.Phone := ''; //No phone available.
			Self.DOB := iesp.ECL2ESP.toDate ((integer) L.SANC_DOB);
			Self.UPIN := L.SANC_UPIN;
			Self.SanctionDate := iesp.ECL2ESP.toDate((integer4) L.SANC_SANCDTE_form);
			Self.State := L.SANC_SANCST;
			Self.Reason := L.SANC_REAS;
			Self.Condition := L.SANC_COND;
			Self.Fines := L.SANC_FINES;
			Self.Terms := L.SANC_TERMS;
			Self.UpdateDate := iesp.ECL2ESP.toDate((integer4) L.SANC_UPDTE_form);
			Self.Source := L.sanc_src_desc;
			Self.BoardType := L.sanc_brdtype;
			Self.LostOfLicenseIndicator := L.sanc_unamb_ind; 
			Self.FraudAbuseFlag := L.SANC_FAB;
	end;
	
	return project(Sanc_records, formatReportRecord(left));
	
END;
