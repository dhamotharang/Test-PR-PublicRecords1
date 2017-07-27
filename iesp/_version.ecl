// this code is (will be) automatically generated

// Every function will implement a particular logic for choosing appropriate version
// Returns the name of the tag for Roxie to fill in depending on a client version
export _version (real client_version = 0.0) := MODULE
  // TODO: remove default from customer version
	export string BankruptcyVersion  := '';
	export string CriminalRecordVersion  := '';
	export string DeaVersion  := '';
	export string DlVersion  := '';
	export string JudgmentLienVersion  := '';
	export string PropertyVersion  := '';
	export string UccVersion  := '';
	export string VehicleVersion  := '';
	export string VoterVersion  := '';

  // those are not for versioning, but rather to include/suppress
	export string EnVersion  := '';
	export string EmailVersion  := '';
	export string ProflicenseVersion  := '';
	export string PhonesPlusVersion  := '';
	export string ProvidersVersion := '';
	export string SanctionsVersion := '';
	export string StateDeathVersion  := '';
END;
