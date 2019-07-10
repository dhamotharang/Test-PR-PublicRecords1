IMPORT BIPV2, Business_Risk_BIP, Doxie, Prof_LicenseV2;

EXPORT PD_ProfLic(DATASET(Business_Risk_BIP.Layouts.Shell) LinkIDsFound,
  DATASET(BIPV2.IDlayouts.l_xlink_ids2) kFetchLinkIDs,
  STRING1 kFetchLinkSearchLevel,
  SET OF STRING2 AllowedSourcesSet,
  Doxie.IDataAccess mod_access) := FUNCTION

	// ---------------- Professional License Records ------------------

	SetLinkSearchLevelInteger(STRING1 kFetchLinkSearchLevel) :=
     CASE(kFetchLinkSearchLevel,
        Business_Risk_BIP.Constants.FetchPowID	=> Business_Risk_BIP.Constants.LinkSearch.PowID,
        Business_Risk_BIP.Constants.FetchProxID	=> Business_Risk_BIP.Constants.LinkSearch.ProxID,
        Business_Risk_BIP.Constants.FetchSeleID	=> Business_Risk_BIP.Constants.LinkSearch.SeleID,
        Business_Risk_BIP.Constants.FetchOrgID	=> Business_Risk_BIP.Constants.LinkSearch.OrgID,
        Business_Risk_BIP.Constants.FetchUltID	=> Business_Risk_BIP.Constants.LinkSearch.UltID,
        Business_Risk_BIP.Constants.LinkSearch.SeleID); // Defaulting to SeleID per Heather


	ProfLicRaw := Prof_LicenseV2.Key_Proflic_LinkIDs.KeyFetch(kFetchLinkIDs, mod_access,
																						 (STRING1)kFetchLinkSearchLevel,
																							0 /*ScoreThreshold --> 0 = Give me everything*/ );

	// Add back our Seq numbers
	Business_Risk_BIP.Common.AppendSeq(ProfLicRaw, LinkIDsFound, ProfLicSeq, SetLinkSearchLevelInteger(kFetchLinkSearchLevel));

	// Filter out records after our history date
	ProfLicRecords := Business_Risk_BIP.Common.FilterRecords(ProfLicSeq, date_first_seen, (UNSIGNED)Business_Risk_BIP.Constants.MissingDate, Business_Risk_BIP.Constants.Src_Prolic, AllowedSourcesSet);

	RETURN ProfLicRecords;

END;