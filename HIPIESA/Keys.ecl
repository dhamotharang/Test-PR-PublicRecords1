IMPORT HIPIESa;
EXPORT Keys(HIPIESA.Options.ISearchParams inOptions) := MODULE
	//GCID::JOBID
	//sa::key::providerid::8291831::2017092203
	//sa::key::firstname::8291831::2017092203
	//sa::key::lastname::8291831::2017092203
	//sa::key::npi::8291831::2017092203
	//sa::key::payload::8291831::2017092203


 FacilityNameIndexFile := '~sa::key::facilityname::' + inOptions.GcId + '::' + inOptions.JobId;
 FacilityNameDs := DATASET('', HIPIESa.Layouts.FacilityNameLayout, THOR);
 EXPORT FacilityNameIndex := INDEX(FacilityNameDs, {(string120) companyname}, {FacilityNameDs}, FacilityNameIndexFile);

 ProviderLastNameIndexFile := '~sa::key::lastname::' + inOptions.GcId + '::' + inOptions.JobId;
 ProviderLastNameDs := DATASET('', HIPIESa.Layouts.ProviderLastNameLayout, THOR);
 EXPORT ProviderLastNameIndex := INDEX(ProviderLastNameDs, {(string20) lastname}, {ProviderLastNameDs}, ProviderLastNameIndexFile);

 ProviderFirstNameIndexFile := '~sa::key::firstname::' + inOptions.GcId + '::' + inOptions.JobId;
 ProviderFirstNameDs := DATASET('', HIPIESa.Layouts.ProviderFirstNameLayout, THOR);
 EXPORT ProviderFirstNameIndex := INDEX(ProviderFirstNameDs, {(string20) firstname}, {ProviderFirstNameDs}, ProviderFirstNameIndexFile);

 ProviderNpiIndexFile := '~sa::key::npi::' + inOptions.GcId + '::' + inOptions.JobId;
 ProviderNpiDs := DATASET('', HIPIESa.Layouts.ProviderNpiLayout, THOR);
 EXPORT ProviderNpiIndex := INDEX(ProviderNpiDs, {(string10) providernpi}, {ProviderNpiDs}, ProviderNpiIndexFile);

 ProviderKeyIndexFile := '~sa::key::providerid::' + inOptions.GcId + '::' + inOptions.JobId;
 ProviderKeyDs := DATASET('', HIPIESa.Layouts.ProviderKeyLayout, THOR);
 EXPORT ProviderKeyIndex := INDEX(ProviderKeyDs, {(string50) providerkey}, {ProviderKeyDs}, ProviderKeyIndexFile);

 PayloadIndexFile := '~sa::key::payload::' + inOptions.GcId + '::' + inOptions.JobId;
 PayloadDs := DATASET('', HIPIESa.Layouts.PayloadLayout, THOR);
 EXPORT PayloadIndex := INDEX(PayloadDs, {(unsigned8) recordid}, {PayloadDs}, PayloadIndexFile);

END;