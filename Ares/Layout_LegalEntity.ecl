name := record
  string type {xpath('type')};
	string value {xpath('value')};
end;

layout_name := record
	dataset(name) names{xpath('name')};
	string legalEntitySortKey{xpath('legalEntitySortKey')};
end;

date := record
	string established {xpath('established')}:='';
	string chartered {xpath('chartered')}:='';
end;

additionalInfo := record
  string additionalInfo {xpath('additionalInfo')};
end;

meeting := record
	string periodType {xpath('periodType')}:='';
	string period_value {xpath('value')}:='';
end;
summaries_ := record
	string summary {xpath('summary')}:='';
end;

identifier := record
  string transferable{xpath('identifier/@transferable')};
	string fid {xpath('fid')};
  string type {xpath('type')};
	string value {xpath('value')};
	string status {xpath('status')};
end;

action:=record
	string date  {xpath('date')}:='';
	string type  {xpath('type')}:='';
end;

review := record
	string startDate {xpath('startDate')}:='';
	string endDate {xpath('endDate')}:='';
	string status {xpath('status')}:='';
	string uboDeclared {xpath('uboDeclared')}:='';
	dataset(action) actions{xpath('actions/action')};
	string withOnshore {xpath('withOnshore')}:='';
	string withOffshore {xpath('withOffshore')}:='';
	string withProvider {xpath('withProvider')}:='';
	string reviewEditor {xpath('reviewEditor')}:='';
	string currentEditor {xpath('currentEditor')}:='';
	string comment {xpath('comment')}:='';
end;

rating :=record
	string agencyName {xpath('agencyName')}:='';
	string type {xpath('type')}:='';
	string value {xpath('value')}:='';
	string dateApplied {xpath('dateApplied')}:='';
	string dateConfirmed {xpath('dateConfirmed')}:='';
end;

historyEvent := record
	string historyEvent_fid{xpath('historyEvent/@fid')};
	string eventType{xpath('eventType')}:='';
	string eventDate{xpath('eventDate')}:='';
end;

layout_link := record
	string link_href{xpath('link/@href')};
  string link_rel{xpath('link/@rel')};
end;

layout_type := record
	string type_source{xpath('type/@source')}:='';
  string type_value {xpath('type')}:='';
end;

employees := record
	string professional{xpath('professional')}:='';
	string administrative{xpath('administrative')}:='';
end;

layout_trust :=record
	string powersGranted{xpath('powersGranted')}:='';
	string powersFull{xpath('powersFull')}:='';
	string powersUsed{xpath('powersUsed')}:='';
	dataset(employees) employees_{xpath('employees')};
	string minAccountSize{xpath('minAccountSize')}:='';
end;

layout_boardMeetings := record 
	dataset (meeting) boardMeetings {xpath('boardMeetings')};
	dataset (summaries_) summaries {xpath('boardMeetings')};
end;

layout_summary := record
	layout_link countryOfOperations {xpath('countryOfOperations')};	
	string organisationType {xpath('organisationType')};
	string charterType {xpath('charterType')};
	string insuranceType {xpath('insuranceType')};
	string fatcaStatus {xpath('fatcaStatus')};
	string legalEntityType {xpath('legalEntityType')};
	dataset(layout_type) types{xpath('types/type')};
	layout_name names {xpath('names')};
	dataset(date) dates{xpath('dates/date')};
	string numberOfATMs {xpath('numberOfATMs')};
	string numberOfCheckingAccounts {xpath('numberOfCheckingAccounts')};
	string numberOfSavingsAccounts {xpath('numberOfSavingsAccounts')};
	string numberOfGroupBanks {xpath('numberOfGroupBanks')};
	string creditUnionShareDraftFlag {xpath('creditUnionShareDraftFlag')};
	string leadInstitution {xpath('leadInstitution')};
	dataset(additionalInfo) additionalInfos{xpath('additionalInfos/additionalInfo')};	
	layout_trust trust {xpath('trust')};	
	layout_boardMeetings boardMeetings {xpath('boardMeetings')};
	dataset(identifier) identifiers{xpath('identifiers/identifier')};
end;

entity_service :=record
	string category {xpath('category')} :='';
	string detail {xpath('detail')} :='';
	string customDescription {xpath('customDescription')} :='';
end;

layout_location := record
 	layout_link headOffice {xpath('headOffice')};	
  string telecoms {xpath('telecoms')} :='';
end;

virtualPresences := record
	string virtualPresence {xpath('virtualPresence/@rank')};
	string type {xpath('type')};
	string presenceName {xpath('presenceName')};
	string value {xpath('value')};
end;

layout_ownership  := record
	dataset(review) reviews{xpath('reviews/review')};
end;

layout_history := record
	dataset(summaries_) summaries {xpath('summaries')};
	dataset(historyEvent) historyEvents {xpath('historyEven')};
	
end;

EXPORT Layout_LegalEntity := record
	string id {xpath('@id')};
	string fid {xpath('@fid')};
  string tfpid {xpath('@tfpid')};
	layout_summary summary {xpath('summary')};
	dataset(entity_service) services{xpath('services/service')};
	layout_location locations {xpath('locations')};
	dataset(virtualPresences)	virtualPresences {xpath('virtualPresences/virtualPresence')};
	layout_ownership ownership {xpath('ownership')};
	dataset(summaries_) personnel {xpath('personnel/summaries')};
	dataset(rating) creditRatings {xpath('creditRatings/rating')};
	layout_history history {xpath('history')};
	dataset(layout_link) relatedPresences {xpath('relatedPresences/relation')};

end;