IMPORT doxie, doxie_raw;

EXPORT DOC_Search_Events_Records(DATASET(doxie.layout_DOCSearch_Person) persons) := FUNCTION

	doxie.MAC_Header_Field_Declare()
	boolean report_reqd := FALSE : STORED('ReportReq');
	boolean off_reqd := FALSE : STORED('ReturnOffenses'); 
	boolean par_reqd := FALSE : STORED('ReturnParoles');
	boolean pt_reqd  := FALSE : STORED('ReturnPrisonTerms');
	boolean acts_reqd := FALSE : STORED('ReturnActivities');
	string25	doc_val := '' : STORED('DOCNumber');
	string60	ofk_val := '' : STORED('OffenderKey');

	outf := doxie_raw.DOC_Events_Raw(
			persons,
			report_reqd,
			off_reqd,
			par_reqd,
			pt_reqd,
			acts_reqd,
			doc_val,
			ofk_val,
		maxResults_val,
		dateVal,
		dppa_purpose,
		glb_purpose
	);

	RETURN outf;
END;
