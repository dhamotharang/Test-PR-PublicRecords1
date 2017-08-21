IMPORT CMS_AddOn;

EXPORT QA_Records(DATASET(CMS_AddOn.Layouts.Base) pBase = CMS_AddOn.Files().Base.QA) := FUNCTION

	// get new records for QA
	SampleFileAddOn := TOPN(pBase, 200, -dt_vendor_first_reported);

	SampleRecs := OUTPUT(SampleFileAddOn , named('SampleNewAddOnRecordsForQA'));

	RETURN SampleRecs;

END;