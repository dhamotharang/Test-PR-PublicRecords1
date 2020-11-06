// =====================================================================
// ROXIE QUERY
// -----------
// For the complete list of input parameters please check published WU.
// Look at the history of this attribute for the old SOAP info.
// =====================================================================
/*--INFO-- <p>Search service for Mexican professional licenses.</p>*/
import iesp;

// ***************************************************************************************
// *** DEPRECATED: This service has been replaced by MX_Services.ProfessionSearchService.
// ***		Note: keeping this version for backward compatibility.
// ***************************************************************************************
export ProfLicenseSearchService := MACRO
	#onwarning(4207, ignore);

	ds_in_v1 	:= DATASET ([], iesp.internationalproflicense.t_InternationalProfessionalLicenseSearchRequest) : STORED('InternationalProfessionalLicenseSearchRequest', FEW);
	ds_in			:= project(ds_in_v1, iesp.internationalprofcert.t_InternationalProfCertificationSearchRequest);
	first_row := ds_in[1] : INDEPENDENT;
	iesp.ECL2ESP.SetInputBaseRequest(first_row);
	iesp.ECL2ESP.Marshall.Mac_Set(first_row.options);
	MX_Services.IParam.SetInputProfessionSearchBy(first_row.searchBy);
	MX_Services.IParam.SetInputProfessionSearchOptions(first_row.options);
	in_mod 			:= MX_Services.Functions.getProfessionSearchModule(first_row);
	recs 				:= MX_Services.SearchRecords.Profession.records(in_mod);

	// need to project to v1 output layout.
	recs_final := project(choosen(recs, MX_Services.Constants.Limits.MAX_RESULTS),
										 transform(iesp.internationalproflicense.t_InternationalProfessionalLicenseRecord,
												_akas			:= choosen(left.akas, iesp.constants.INTERNATIONALPROFLICENSE_MAX_COUNT_AKAS);
												_licenses	:= choosen(left.certifications,iesp.constants.INTERNATIONALPROFLICENSE_MAX_COUNT_LICENSES);
												self.UniqueId := left.entity_id,
												self._penalty	:= left._penalty,
												self.Gender 	:= left.gender,
												self.FullName := left.fullname,
												self.Akas 		:= project(_akas, iesp.internationaldocket.t_InternationalName),
												self.Licenses := project(_licenses, iesp.internationalproflicense.t_InternationalProfessionalLicense)
											));

	iesp.ECL2ESP.Marshall.MAC_Marshall_Results(recs_final,Results,iesp.internationalproflicense.t_InternationalProfessionalLicenseSearchResponse);
	output(Results, named('results'));

ENDMACRO;
