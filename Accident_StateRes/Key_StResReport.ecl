IMPORT Accident_Services,doxie,ut;


EXPORT Key_StResReport := INDEX(File_In_Report_Res,
	{ApplicationType},{AccidentState,Allowed,InquiryDataAllowed,Aknowledgement,ResaleAllowed,RestrictedOutputBitmap},
	'~thor_data400::key::accident_state_restrictions::report_' + doxie.Version_SuperKey);
	