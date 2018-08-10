IMPORT Models;

EXPORT Layout_LeadIntegrity_Soap := record
	dataset(Models.layouts.Layout_LeadIntegrity_Batch_In) batch_in;
	integer DPPAPurpose;
	integer GLBPurpose;
	string DataRestrictionMask;
	string DataPermissionMask;
	string ModelName;
	integer Version;
end;