/*2014-08-26T20:45:40Z (Donald Lingle)

*/
import AutoStandardI, topbusiness_services,Ingenix_NatlProf, doxie_files, BIPV2, iesp;

EXPORT SanctionSection := MODULE
// use this attr to reference how to create section coding
// : doxie.Ingenix_Business_records

export fn_fullView (
	dataset(topBusiness_services.SanctionSection_Layouts.rec_input) ds_in_data,
	TopBusiness_Services.layouts.rec_input_options in_options,
	AutoStandardI.DataRestrictionI.params in_mod
	) := function	  
 
 FETCH_LEVEL := in_options.BusinessReportFetchLevel;
 
 sanctionRawRecs := Ingenix_NatlProf.Key_Sanctions_LinkIds.keyfetch(
											project(ds_in_data, TRANSFORM(BIPV2.IDlayouts.l_xlink_ids,
											self := left, self := []))
										, FETCH_LEVEL);
 
TopBusiness_Services.SanctionSection_Layouts.rec_Sanction_recordWLinkids
                get_sanctions(sanctionRawRecs l,doxie_files.key_sanctions_sancid r) := TRANSFORM
		self.ultid := l.ultid;
		self.orgid := l.orgid;
		self.seleid := l.seleid;
		self.proxid := l.proxid;
		self.empid := l.empid;
		self.powid := l.powid;
		self.Dotid := l.dotid;		
		self.SanctionId := l.sanc_id;
		self.UniqueId := if(r.did != '',intformat((unsigned6)r.did,12,1),'');
		self.FilingDetail.BusinessName := r.SANC_BUSNME;
		self.ProviderDetail.Name.First := r.Prov_Clean_fname;
		self.ProviderDetail.Name.Middle := r.Prov_Clean_mname;
		self.ProviderDetail.Name.Last := r.Prov_Clean_lname;
		self.ProviderDetail.Name.Suffix := r.Prov_Clean_name_suffix;
		self.ProviderDetail.Name.Full := '';
		self.ProviderDetail.Name.prefix := '';
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
		self.ProviderDetail.Address.Address.StreetAddress1 := '';
		self.ProviderDetail.Address.Address.StreetAddress2 := '';
		self.ProviderDetail.Address.Address.county := '';
		self.ProviderDetail.Address.Address.postalCode := '';
		self.ProviderDetail.Address.Address.statecityzip := '';	
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
		self := [];
end;

output_PreSorted := join(sanctionRawRecs,
						doxie_files.key_sanctions_sancid,
						keyed((unsigned6)left.sanc_id = right.l_sancid),
						get_sanctions(left,right),keep(1));  
           
ds_all_grouped := group(sort(output_PreSorted, #expand(BIPV2.IDmacros.mac_ListTop3Linkids())),
                        #expand(BIPV2.IDmacros.mac_ListTop3Linkids()));
                          

   TopBusiness_Services.SanctionSection_layouts.rec_linkids_plus_SanctionRecord   sanction_rollup_rptdetail(
																TopBusiness_Services.SanctionSection_layouts.rec_Sanction_recordWLinkids l,
																dataset(TopBusiness_Services.SanctionSection_layouts.rec_Sanction_recordWLinkids) allrows) := transform
					 
					   self.Sanctions := project(choosen(allrows, iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_SANCTION_RECORDS),transform(iesp.TopbusinessReport.t_TopBusinessSanctionRecord,
						                          self := left));
			          	                												
								self.acctno := '';
								self := l; // this covers ultid, orgid, seleid etc...
                self := [];
						end;														
													
   ds_all_rptdetail_rolled := rollup(ds_all_grouped,
																     group,
																     Sanction_rollup_rptdetail(left,rows(left)));													

	results := join(ds_in_data, ds_all_rptdetail_rolled,
	                                     left.ultid = right.ultid AND
																			 left.orgid = right.orgid AND
																			 left.seleid = right.seleid,
																			
																			 transform(TopBusiness_Services.SanctionSection_layouts.rec_final,
                                         self.acctno := left.acctno;
																				 self := right), 
																				left outer);
		 
 return results;

end; // function
end; // module