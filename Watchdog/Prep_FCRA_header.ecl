IMPORT fcra, header, doxie_build, header_quick, ADVO, mdr,risk_indicators;

todays_date := (string)risk_indicators.iid_constants.todaydate;

headerprod_building := doxie_build.file_FCRA_header_building(did!=0 AND ~risk_indicators.iid_constants.filtered_source(src, st));
hf := PROJECT(headerprod_building(dt_last_seen<>0),TRANSFORM(Header.Layout_Header, SELF := LEFT));

base_hf_uncorrected := hf(~fcra.Restricted_Header_Src(src, vendor_id[1]) AND
													((src='BA' AND FCRA.bankrupt_is_ok(todays_date,(string)dt_first_seen)) OR
														(src='L2' AND FCRA.lien_is_ok(todays_date,(string)dt_first_seen)) OR src NOT IN ['BA','L2']));

/* ****************************************************
 *                  Apply Corrections                 *
 ****************************************************** */
base_hf_corrected := Risk_Indicators.Header_Corrections_Function(base_hf_uncorrected) : persist('persist::watchdog_prep_FCRA_header');

export Prep_FCRA_header := base_hf_corrected;