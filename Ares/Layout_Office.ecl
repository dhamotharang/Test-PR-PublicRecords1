layout_name := record
	string type {xpath('type')};
	string value {xpath('value')};
end;
layout_names := record
	string officeSortKey {xpath('officeSortKey')};
	dataset(layout_name) names{xpath('name')};
End;
layout_type := Record
	string type {xpath('./')};
End;
layout_link := Record
	string href{xpath('@href')};
  string rel{xpath('@rel')};
	string sourceHref {xpath('sourceHref')};
End;

layout_place := record
	dataset(layout_link) link {xpath('link')};
end;
layout_telecom := Record
	string fid {xpath('@fid')};
	string rank_ {xpath('@rank')};
	string phoneCountryCode {xpath('phoneCountryCode')};
	string phoneAreaCode {xpath('phoneAreaCode')};
	string phoneNumber {xpath('phoneNumber')};
	string value {xpath('value')};
end;
layout_location := Record
	string primary {xpath('@primary')};
	dataset(layouts.address) address {xpath('address')};
	dataset(layout_telecom) telecom {xpath('telecom')};
End;

layout_summary := record
	dataset(layout_type) types{xpath('types/type')};
	layout_names names{xpath('names')};
	string principalOffice {xpath('principalOffice')};
	string leadLocation {xpath('leadLocation')};
	string foreignOffice {xpath('foreignOffice')};
	layout_link institution {xpath('institution/link')};
	string status {xpath('status')};
	string useInAddress{xpath('useInAddress')};
end;
layout_affected := Record
	string histId {xpath('@histId')};
	string legalTitle {xpath('legalTitle')};
End;
layout_resulting := Record
	string legalTitle {xpath('legalTitle')};
End;
layout_history_event := Record
	string fid {xpath('fid')};
	string eventType {xpath('eventType')};
	string eventTypeCode {xpath('eventType/@code')};
	dataset(layout_affected) affected {xpath('affected')};
	dataset(layout_resulting) resulting {xpath('resulting')};
	 
End;

EXPORT Layout_Office := Record
	string deleted {xpath('@deleted')};
	string fid {xpath('@fid')};
	string id {xpath('@id')};
	string resource{xpath('@resource')};
	string source{xpath('@source')};
	string tfpid {xpath('@tfpid')};
	string tfpuid {xpath('@tfpuid')};
	layout_summary summary{xpath('summary')};
	dataset(layout_location) locations {xpath('locations/location')};
	dataset(layout_history_event) history {xpath('history/historyEvents/historyEvent')};
End;
