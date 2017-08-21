IMPORT  PRTE2_LNProperty,PromoteSupers;

EXPORT PROC_BUILD_BASE(String filedate) := FUNCTION

	boca_deed := PROJECT(Files.ln_propertyv2_deed_in, Layouts.layout_deed_mortgage_common_model_base);

	boca_search := PROJECT(Files.ln_propertyv2_search_in(ln_fares_id !='ln_fares_id'), transform(
						layouts.layout_search_building,
						self.dt_last_seen := map(left.dt_last_seen <> 0 => left.dt_last_seen, 
																left.dt_vendor_last_reported <> 0 => left.dt_vendor_last_reported,
																(integer)left.process_date),
						self.dt_first_seen := map(left.dt_first_seen <> 0 => left.dt_first_seen, 
																left.dt_vendor_first_reported <> 0 => left.dt_vendor_first_reported,
																(integer)left.process_date),
						self := left));

	boca_tax := PROJECT(Files.ln_propertyv2_tax_in,
												TRANSFORM(	layouts.layout_property_common_model_base,
												SELF := LEFT
											));

	df_deed := dedup(Files.ln_propertyv2_alpha_deed + boca_deed(ln_fares_id[3..5]!='ALP'), record, all);

	df_search := dedup(Files.ln_propertyv2_alpha_search + boca_search, record, all);

	df_tax := dedup(Files.ln_propertyv2_alpha_tax + boca_tax(ln_fares_id[3..5] != 'ALP'), record, all);

	PromoteSupers.MAC_SF_BuildProcess(df_deed,'~PRTE::BASE::ln_propertyv2::deed', writefile_deed);

	PromoteSupers.MAC_SF_BuildProcess(df_search,'~PRTE::BASE::ln_propertyv2::search', writefile_search);

	PromoteSupers.MAC_SF_BuildProcess(df_tax,'~PRTE::BASE::ln_propertyv2::tax', writefile_tax);

	sequential(writefile_deed,writefile_search,writefile_tax);

	Return 'success';
END;