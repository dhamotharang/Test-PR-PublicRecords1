
IMPORT Roxiekeybuild,bankruptcyv3, Banko,bankruptcyv2,lib_fileservices, lib_stringlib, _control,did_add, ut , fcra;

export fUpdateBaseFile(DATASET(Banko.Layout_CategoryEvent) NonMatch , STRING versionB) := function

FCRA_Banko_Additional:= Banko.File_Banko_Base('fcra');
// FCRA_Banko_Additional_EventSortRec := SORT(FCRA_Banko_Additional,CaseKey);
// FCRA_Banko_Additional_EventDist := DISTRIBUTE(FCRA_Banko_Additional_EventSortRec,HASH32(CaseKey));


typeof(Banko.BankoJoinRecord) FilterFCRA_BaseFile_Rec(recordof(Banko.File_Banko_Base('fcra')) L
										,recordof(NonMatch) R) := TRANSFORM
	
	SELF.CatEvent_Description := R.Description;
	SELF.CatEvent_Category := R.Category;
	SELF := L;
END;

FilterFCRA_BaseFile_RecJoin := JOIN(FCRA_Banko_Additional,
					NonMatch,
					LEFT.DRCategoryEventID =  RIGHT.CategoryEventID,
					FilterFCRA_BaseFile_Rec(LEFT,RIGHT),LEFT OUTER,LOOKUP);				


NONFCRA_Banko_Additional:= Banko.File_Banko_Base('nonfcra');
// NONFCRA_Banko_Additional_EventSortRec := SORT(NONFCRA_Banko_Additional,CaseKey);
// NONFCRA_Banko_Additional_EventDist := DISTRIBUTE(NONFCRA_Banko_Additional_EventSortRec,HASH32(CaseKey));
					
typeof(Banko.BankoJoinRecord) Filter_BaseFile_Rec(recordof(Banko.File_Banko_Base('nonfcra')) L
										,recordof(NonMatch) R) := TRANSFORM
	
	SELF.CatEvent_Description := R.Description;
	SELF.CatEvent_Category := R.Category;
	SELF := L;
END;


Filter_BaseFile_RecJoin := JOIN(NONFCRA_Banko_Additional,
					NonMatch,
					LEFT.DRCategoryEventID =  RIGHT.CategoryEventID,
					Filter_BaseFile_Rec(LEFT,RIGHT),LEFT OUTER,LOOKUP);	

// ***************************
// Version-B Base files

Roxiekeybuild.Mac_SF_BuildProcess_V2(
					Filter_BaseFile_RecJoin,
					//'~thor_data400::base::banko::nonfcra','additionalevents',
					  '~thor::base::banko::nonfcra','additionalevents',
					versionB,nonfcrabase);
					
Roxiekeybuild.Mac_SF_BuildProcess_V2(
					FilterFCRA_BaseFile_RecJoin,
					//'~thor_data400::base::banko::fcra','additionalevents',
					  '~thor::base::banko::fcra','additionalevents',
					versionB,fcrabase);

retval := sequential(parallel(nonfcrabase,fcrabase));

return retval;

END;