IMPORT Accident_Services,doxie,ut, data_services;

StateRestrictions := DATASET([
	// GOVERNMENT
	{'GOV','AK','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','AL','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','CO','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','CT','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','DC','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','DE','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','FL','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','GA','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','ID','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','IL','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','IN','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','KS','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','MA','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','MD','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','ME','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','MI','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','MO','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','NC','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','ND','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','NE','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','NJ','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','NM','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','OH','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','OR','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','SC','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','SD','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','TN','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','VT','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','WI','Y',FALSE,FALSE,FALSE,0,[]},
	{'GOV','WV','Y',FALSE,FALSE,FALSE,0,[]},
	// LAW ENFORCEMENT
	{'LE','AK','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','AL','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','AR','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','CO','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','CT','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','DC','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','DE','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','FL','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','GA','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','HI','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','ID','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','IL','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','IN','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','KS','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','MA','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','MD','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','ME','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','MI','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','MO','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','NC','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','ND','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','NE','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','NJ','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','NM','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','OH','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','OK','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','OR','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','PA','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','SC','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','SD','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','TN','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','UT','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','VT','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','WI','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','WV','Y',FALSE,FALSE,FALSE,0,[]},
	{'LE','WY','Y',FALSE,FALSE,FALSE,0,[]},
	// INSURANCE AND CARRIER ID
	{'INS','AK','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','AL','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','AR','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','AZ','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','CA','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','CO','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','CT','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','DC','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','DE','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','FL','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','GA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','HI','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','IA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','ID','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','IL','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','IN','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','KS','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','KY','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','LA','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','MA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','MD','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','ME','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','MI','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','MN','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','MO','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','MS','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','MT','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','NC','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','ND','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','NE','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','NH','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','NJ','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','NM','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','NV','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','NY','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','OH','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','OK','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','OR','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','PA','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','RI','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','SC','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','SD','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','TN','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','TX','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','UT','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','VA','R',FALSE,FALSE,FALSE,0,[]},
	{'INS','VT','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','WA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','WI','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','WV','Y',FALSE,FALSE,FALSE,0,[]},
	{'INS','WY','Y',FALSE,FALSE,FALSE,0,[]},
	// OLD CARRIER ID DEPRICATE IN NEXT BUILD 
	{'INSCLAIMS','AK','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','AL','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','AR','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','AZ','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','CO','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','CT','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','DC','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','DE','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','FL','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','GA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','IA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','ID','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','IL','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','IN','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','KS','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','MA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','MD','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','ME','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','MI','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','MO','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','MS','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','NC','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','ND','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','NE','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','NJ','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','NM','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','NY','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','OH','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','OK','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','OR','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','RI','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','SC','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','SD','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','TN','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','VT','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','WA','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','WI','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','WV','Y',FALSE,FALSE,FALSE,0,[]},
	{'INSCLAIMS','WY','Y',FALSE,FALSE,FALSE,0,[]}
],Accident_Services.Layouts.AccidentStateRestrictionReportRecord);

EXPORT Key_StResReport := INDEX(StateRestrictions,
	{ApplicationType},{AccidentState,Allowed,InquiryDataAllowed,Aknowledgement,ResaleAllowed,RestrictedOutputBitmap},
	data_services.data_location.prefix() + 'thor_data400::key::accident_state_restrictions::report_' + doxie.Version_SuperKey);
	