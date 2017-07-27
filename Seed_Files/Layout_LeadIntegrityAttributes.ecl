IMPORT iesp, Models;

EXPORT Layout_LeadIntegrityAttributes := RECORD
	STRING20 dataset_name;
	STRING30 acctNo;
	STRING15 fname;
	STRING20 lname;
	STRING9  zip;
	STRING9  ssn;
	STRING10 hphone;
	unsigned1 attributes_version;
	iesp.issservice.t_InsuranceScoringServiceResponse.Result.LeadIntegrityAttributes;
	Models.Layouts.Layout_LeadIntegrity_attributes_v4 Version4;
END;