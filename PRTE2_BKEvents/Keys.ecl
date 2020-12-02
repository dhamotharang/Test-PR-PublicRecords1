import doxie;

EXPORT Keys := module

shared BuildFullKeyName(BOOLEAN	isFCRA	=	FALSE)	:=	FUNCTION
	prefix	:=	IF(isFCRA, files.fcra_recs, files.basefile_nonfcra);
	RETURN	prefix;
END;


export courtcode_casenumber(boolean isFCRA = false) := function
KeyRec			:= dedup(project(BuildFullKeyName(isFCRA),transform(layouts.casenumber, self := left, self := [])), all);
RETURN index(KeyRec,
						{court_code,casekey,CaseID},
						{DRCategoryEventID,DocketEntryID,CourtID,district,boca_court
					  ,CaseKey,CaseType,BKCaseNumber,BKCaseNumberURL,ProceedingsCaseNumber
					  ,ProceedingsCaseNumberURL,PacerCaseID,AttachmentURL,EntryNumber
						,EnteredDate,Pacer_EnteredDate,FiledDate,Score,DocketText
						,CatEvent_Description,CatEvent_Category,record_sid
						,global_sid,dt_effective_first,dt_effective_last,delta_ind},
						if(isFCRA, constants.KEY_PREFIX_FCRA, constants.KEY_PREFIX) + doxie.Version_SuperKey + '::courtcode.casenumber.caseId.payload');
												
END;



EXPORT courtcode_fullcasenumber(BOOLEAN	isFCRA	=	FALSE)	:=	FUNCTION

dSlimRec			:=	DEDUP(PROJECT(BuildFullKeyName(isFCRA),Layouts.fullcasenumber), ALL);
RETURN INDEX(dSlimRec, {court_code,BKCaseNumber,CaseID},{dSlimRec},	if(isFCRA, constants.KEY_PREFIX_FCRA, constants.KEY_PREFIX) + doxie.Version_SuperKey + '::courtcode.fullcasenumber.caseId.payload');								
END;																																
																																
																																
END;											