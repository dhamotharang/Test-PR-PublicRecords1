import Prof_LicenseV2_Services,doxie,doxie_files,ingenix_natlprof;

doxie.MAC_Header_Field_Declare()

export Sanc_raw(
    dataset(Doxie.layout_references) dids = doxie_raw.ds_EmptyDIDs,
		dataset(prof_licensev2_services.Layout_Search_Ids_Sanc) Sanc_Ids = dataset([], prof_licensev2_services.Layout_Search_Ids_Sanc),
    unsigned3 dateVal = 0) := FUNCTION



d := if(exists(dids), Prof_LicenseV2_Services.Prof_Lic_raw.get_sanc_ids_from_dids(dids));

sanctions_ids :=d + Sanc_Ids;


sanctions_id_key := doxie_files.key_sanctions_sancid;

//get sanctions record				
out_rec := doxie.ingenix_sanctions_module.layout_ingenix_sanctions_report;
  
out_rec slim_out(sanctions_id_key r) := transform
	self.npi := '',
	self.NPITierTypeID := 0,
	self := r;
end;  

out_rec add_npi({out_rec,string providerID} l, ingenix_natlprof.key_NPI_ProviderId r) := transform
	self.NPI := r.NPI;
	self.NPITierTypeID := (unsigned2)r.NPITierTypeID;
	self := l;
end;

out_final0 := join(sanctions_ids, sanctions_id_key,
                  left.sanc_id = right.l_sancid,
                  slim_out(right));  

out_final1 := join(out_final0, Ingenix_NatlProf.key_ProviderID_UPIN,
									left.sanc_upin = right.l_upin,
									transform({out_rec,string providerID},
										self.providerid := right.providerid,
										self := left),
									left outer,
									keep(1));

out_final := join(out_final1, Ingenix_NatlProf.key_NPI_providerid,
									(unsigned)left.providerid = right.l_providerId,
									add_npi(left,right),
									left outer,
									keep(1));
			   
out_final_srt := sort(out_final, (unsigned6)SANC_ID);		


return out_final_srt(dateVal = 0 OR (unsigned3)(SANC_SANCDTE_form[1..6]) <= dateVal);

END;