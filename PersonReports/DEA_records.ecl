IMPORT $, iesp, DEAV2_Services, doxie; 

out_rec := iesp.deacontrolledsubstance.t_DEAControlledSubstanceSearch2Record;

EXPORT out_rec DEA_records (
  DATASET(doxie.layout_references) dids,
  $.IParam.dea in_params = MODULE($.IParam.dea) END,
  BOOLEAN IsFCRA = FALSE
) := FUNCTION

	info_rec := iesp.deacontrolledsubstance.t_DEAControlledSubstanceRecord;

	info_rec setInfo(DEAV2_Services.Assorted_Layouts.Layout_Output_Child L) := TRANSFORM
		SELF.SSN := L.Best_SSN;
		SELF.CompanyName := L.Cname;
		SELF.Name := iesp.ECL2ESP.SetName (L.fname, L.mname, L.lname, L.name_suffix, L.title, L.name);
		SELF.Address := iesp.ECL2ESP.SetAddress(
			l.prim_name,l.prim_range,L.predir,L.postdir, L.addr_suffix,L.unit_desig,L.sec_range, 
			l.p_city_name,l.st,l.zip,l.zip4,'');
  	SELF.BusinessType := L.Bussiness_Type;
		SELF.DrugSchedules := L.Drug_Schedules;
		SELF.ExpirationDate := iesp.ECL2ESP.toDate((INTEGER)L.Expiration_Date);
    SELF.HasCriminalConviction := L.hasCriminalConviction;
    SELF.IsSexualOffender := L.isSexualOffender;
    SELF.ExternalKey := '';
	END;

	out_rec toOut(DEAV2_Services.Assorted_Layouts.Layout_Output L) := TRANSFORM
		SELF.AlsoFound := FALSE;
		SELF.registrationNumber := L.Dea_Registration_Number;
		SELF.ControlledSubstancesInfo := PROJECT(L.Children,setInfo(LEFT));
		SELF := [];
	END;

	deaIds := DEAV2_Services.dea_raw.get_deaKeys_from_dids(dids);
  deaRecs := DEAV2_Services.DEAV2_Search_recs(deaIds, in_params.ssn_mask, in_params.application_type);

	RETURN PROJECT(deaRecs,toOut(LEFT));
END;
