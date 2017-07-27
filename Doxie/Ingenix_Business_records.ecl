import doxie,doxie_cbrs,ingenix_natlprof, doxie_files, autokey,ut,iesp;

export Ingenix_Business_records(dataset(doxie_cbrs.layout_references) bdids) := MODULE
doxie_cbrs.mac_Selection_Declare();
sanctions 		:= doxie_files.key_sanctions_sancid;
sanc_ids 		:= Ingenix_NatlProf.Key_sanctions_bdid; 
layout_out_recs := iesp.enhancedbizreport.t_EnhancedBizReportSanction;
maxVal 			:= ut.limits.Max_Business_Sanctions;

lookup_sids		:= join(bdids,
						sanc_ids,
						keyed(left.bdid = right.bdid),
						transform(right),
						keep(maxVal));

layout_out_recs get_sanctions(ingenix_natlprof.Key_sanctions_bdid l,doxie_files.key_sanctions_sancid r) := Transform
		self.BusinessId := if(l.bdid != 0,intformat(l.bdid,12,1),'');
		self.SanctionId := l.sanc_id;
		self.UniqueId := if(r.did != '',intformat((unsigned6)r.did,12,1),'');
		self.FilingDetail.BusinessName := r.SANC_BUSNME;
		self.ProviderDetail.Name.First := r.Prov_Clean_fname;
		self.ProviderDetail.Name.Middle := r.Prov_Clean_mname;
		self.ProviderDetail.Name.Last := r.Prov_Clean_lname;
		self.ProviderDetail.Name.Suffix := r.Prov_Clean_name_suffix;
		self.ProviderDetail.Address.Address.StreetNumber := r.ProvCo_Address_Clean_prim_range;
		self.ProviderDetail.Address.Address.StreetPreDirection := r.ProvCo_Address_Clean_predir;
		self.ProviderDetail.Address.Address.StreetName := r.ProvCo_Address_Clean_prim_name;
		self.ProviderDetail.Address.Address.StreetSuffix := r.ProvCo_Address_Clean_addr_suffix;
		self.ProviderDetail.Address.Address.StreetPostDirection := r.ProvCo_Address_Clean_postdir;
		self.ProviderDetail.Address.Address.UnitDesignation := r.ProvCo_Address_Clean_unit_desig;
		self.ProviderDetail.Address.Address.UnitNumber := r.ProvCo_Address_Clean_sec_range;
		self.ProviderDetail.Address.Address.City := r.ProvCo_Address_Clean_p_city_name;
		self.ProviderDetail.Address.Address.State := r.ProvCo_Address_Clean_st;
		self.ProviderDetail.Address.Address.Zip5 := r.ProvCo_Address_Clean_zip;
		self.ProviderDetail.Address.Address.Zip4 := r.ProvCo_Address_Clean_zip4;
		self.ProviderDetail.Address.Location.Latitude := r.ProvCo_Address_Clean_geo_lat;
		self.ProviderDetail.Address.Location.Longitude := r.ProvCo_Address_Clean_geo_long;
		self.FilingDetail.Dob := iesp.ECL2ESP.toDatestring8(r.SANC_DOB);
		self.FilingDetail.TaxIdNumber := r.SANC_TIN;
		self.FilingDetail.UPIN := r.SANC_UPIN;
		self.FilingDetail.ProviderType := r.SANC_PROVTYPE;
		self.FilingDetail.Date := iesp.ECL2ESP.toDatestring8(r.SANC_SANCDTE_form);
		self.FilingDetail.LicenseNumber := r.SANC_LICNBR;
		self.FilingDetail.State := r.SANC_SANCST;
		self.FilingDetail.BoardType := r.SANC_BRDTYPE;   
		self.FilingDetail.SourceDescription := r.SANC_SRC_DESC;
		self.FilingDetail._Type := r.SANC_TYPE;
		self.FilingDetail.Terms := r.SANC_TERMS;
		self.FilingDetail.Reason := r.SANC_REAS;
		self.FilingDetail.Condition := r.SANC_COND;
		self.FilingDetail.Fines := r.SANC_FINES;                       
		self.FilingDetail.Update := iesp.ECL2ESP.toDatestring8(r.SANC_UPDTE_form);
		self.FilingDetail.DateFirstReported := iesp.ECL2ESP.toDatestring8(r.date_first_reported);
		self.FilingDetail.DateLastReported := iesp.ECL2ESP.toDatestring8(r.date_last_reported);
		self.FilingDetail.ReinstateDate := iesp.ECL2ESP.toDatestring8(r.SANC_REINDTE_form);
		self.FilingDetail.FraudAbuseFlag := r.SANC_FAB;
		self.FilingDetail.LossOfLicenseIndicator := r.SANC_UNAMB_IND;
		self.FilingDetail.ProcessDate := iesp.ECL2ESP.toDatestring8(r.process_date);
		self.FilingDetail.DateFirstSeen := iesp.ECL2ESP.toDatestring8(r.date_first_seen);
		self.FilingDetail.DateLastSeen := iesp.ECL2ESP.toDatestring8(r.date_last_seen);
		self:= [];
end;

output_PreSorted := join(lookup_sids,
						sanctions,
						keyed((unsigned6)left.sanc_id = right.l_sancid),
						get_sanctions(left,right),keep(1));  

output_recs := sort(output_PreSorted, (unsigned6) SanctionId);

export records := output_recs;
export records_count := count(records);
END;