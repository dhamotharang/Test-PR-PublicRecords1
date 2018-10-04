﻿IMPORT Data_Services, Doxie;

//PHPR-173: New Indices for Phone Finder Reporting Query

inFile := project(PhoneFinderReportDelta.File_PhoneFinder.Identities_Main, PhoneFinderReportDelta.Layout_PhoneFinder.Identities_Main-date_file_loaded);

EXPORT Key_Identities	:= index(inFile
																,{transaction_id}
																,{inFile}
																,'~thor_data400::key::phonefinderreportdelta::identities_'+doxie.Version_SuperKey);