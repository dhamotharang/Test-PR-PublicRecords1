EXPORT files := MODULE
	IMPORT Data_Services;
  // The "individual" file contains one row for each matching item in the
	// "email" file regardless of whether it's a duplicate or not, so we have
	// a file reference for both the original individual file as well as a
	// deduped version
	EXPORT file_Acquireweb_Email_Individuals	:=	DATASET('~thor::in::acquireweb::individuals', layouts.layout_Acquireweb_Email_Individuals, CSV(HEADING(1),terminator('\n'),separator('|'),quote('')));
  EXPORT file_acquireweb_email_ind_dedup    :=  DISTRIBUTE(DEDUP(SORT(file_Acquireweb_Email_Individuals,RECORD)),HASH32(awid_ind)) : PERSIST('~thor::persist::acquireweb::ind_in');
	EXPORT file_Acquireweb_Email_Emails				:=	DATASET('~thor::in::acquireweb::emails', layouts.layout_Acquireweb_Email_Emails, CSV(HEADING(1),terminator('\n'),separator('|'),quote('')));
	EXPORT file_Acquireweb_Base               :=  DATASET('~thor_data200::base::acquireweb',layouts.layout_Acquireweb_Base,thor);
	
END;