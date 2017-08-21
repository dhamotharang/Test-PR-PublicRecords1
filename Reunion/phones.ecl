IMPORT gong,phonesplus;

dGong:=gong.file_history(current_record_flag='Y' AND did<>0);
dPhonesPlus:=phonesplus.file_phonesplus_base(activeflag='Y' AND confidencescore>=11 AND did<>0);

lPhones:=RECORD
 UNSIGNED6 did;
 STRING10 phone;
 UNSIGNED2 confidencescore;
 STRING1 priority;
END;

dGongFormatted:= PROJECT(dGong,TRANSFORM(lPhones,SELF.phone:=LEFT.phone10;SELF.confidencescore:=0;SELF.priority:='1';SELF:=LEFT;));
dPhonesPlusFormatted:= DEDUP(SORT(DISTRIBUTE(PROJECT(dPhonesPlus,TRANSFORM(lPhones,SELF.phone:=LEFT.cellphone;SELF.priority:='2';SELF:=LEFT;)),HASH(did)),did,-confidencescore,LOCAL),did,LOCAL);

dPhones:=dedup(sort(distribute(dGongFormatted+dPhonesPlusFormatted,hash(did)),did,priority,local),did,         local);

EXPORT phones:=dPhones:PERSIST('~thor::persist::mylife::phone');