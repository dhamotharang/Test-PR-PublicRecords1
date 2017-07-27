#warning('Deprecated. Logic moved to doxie.DOC_Search_Events_Records')
import corrections,ut,doxie_files,doxie_raw;

doxie.MAC_Header_Field_Declare()
boolean report_reqd := false : stored('ReportReq');
boolean off_reqd := false : stored('ReturnOffenses'); //moved the 'or's into the raw
boolean par_reqd := false : stored('ReturnParoles');
boolean pt_reqd  := false : stored('ReturnPrisonTerms');
boolean acts_reqd := false : stored('ReturnActivities');
string25	doc_val := '' : stored('DOCNumber');
string60	ofk_val := '' : stored('OffenderKey');

persons := doxie.DOC_Search_People_Local;

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

export doc_search_events_local := outf;