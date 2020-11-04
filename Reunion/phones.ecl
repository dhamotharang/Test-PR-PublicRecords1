IMPORT gong,phonesplus, D2C;

dGong_all_hist :=gong.file_history(did<>0);
dGong := sort(distribute(dGong_all_hist, hash(did)), did, -current_record_flag, -dt_last_seen, local);

dPhonesPlus:=phonesplus.file_phonesplus_base(activeflag='Y' AND confidencescore>=11 AND did<>0, vendor not in D2C.Constants.PhonesPlusV2RestrictedSources);

lPhones:=RECORD
 UNSIGNED6 did;
 STRING10 phone;
 UNSIGNED2 confidencescore;
 STRING1 priority;
END;

dGongFormatted:= PROJECT(dGong,TRANSFORM(lPhones,SELF.phone:=LEFT.phone10;SELF.confidencescore:=0;SELF.priority:='1';SELF:=LEFT;));
dPhonesPlusFormatted:= DEDUP(SORT(DISTRIBUTE(PROJECT(dPhonesPlus,TRANSFORM(lPhones,SELF.phone:=LEFT.cellphone;SELF.priority:='2';SELF:=LEFT;)),HASH(did)),did,-confidencescore,LOCAL),did,LOCAL);

dPhones:=dedup(sort(distribute(dGongFormatted+dPhonesPlusFormatted,hash(did)),did,priority,local),did,local);

EXPORT phones:=dPhones:PERSIST('~thor::persist::mylife::phone');