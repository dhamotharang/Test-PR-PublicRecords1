﻿import Email_Data, ut, Data_Services, Header;
//New base layout with scrubbits field appended
	ds_base := dataset('~thor_data400::base::email_data', Email_Data.Layout_Email.Scrubs_bits_base, thor);
	fDeathMaster	:= Header.File_DID_Death_MasterV3_ssa(src = 'D$');
	
//Flag invalid emails
l_temp	:= RECORD
	Layout_Email.base;
	Boolean SkipRec;
	Boolean IsDeath;
END;

pValidEmail	:= PROJECT(ds_base, TRANSFORM(l_temp, SELF.SkipRec := Email_Data.Fn_InvalidEmail(LEFT.clean_email, LEFT.append_domain);
																						 SELF.IsDeath := FALSE;
																						 SELF := LEFT));
																						 
//Determine if record meets DOD filter
l_temp DeathInd(pValidEmail L, 	fDeathMaster R) := TRANSFORM
	tempDeathInd	:= IF(L.DID = (unsigned6)R.DID AND R.DOD8 < '19790101', TRUE,
											IF(L.DID = (unsigned6)R.DID AND R.DOD8 < L.date_first_seen AND R.DOD8 < L.date_vendor_first_reported, TRUE,FALSE));
	SELF.IsDeath	:= tempDeathInd;
	SELF	:= L;
END;

//Only need to check valid records for DOD criteria to see if further filtering is needed
jDeathInd	:= JOIN(SORT(DISTRIBUTE(pValidEmail(SkipRec = FALSE and DID <> 0),HASH(DID)),DID,LOCAL),
									SORT(DISTRIBUTE(fDeathMaster((unsigned6)DID <> 0),HASH(DID)),DID, LOCAL),
									LEFT.DID = (unsigned6)RIGHT.DID,
									DeathInd(LEFT,RIGHT),LEFT OUTER, LOOKUP, LOCAL);
									
//Concat Emails with no DOD and Valid Emails with no DID as those records were filtered from the Dmaster join
ValidEmailAll := jDeathInd(IsDeath = FALSE) + pValidEmail(SkipRec = FALSE and DID = 0);

//Project to layout expected by keybuild
pEmailout	:= PROJECT(ValidEmailAll,Layout_Email.base);

//Project back into previous layout expected by the keybuild	
export File_Email_Base := DEDUP(SORT(pEmailout,clean_email, orig_first_name, orig_last_name),ALL);
