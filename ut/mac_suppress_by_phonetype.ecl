//blank the phone field based on state and phone_type

export Mac_suppress_by_phonetype(infile_spt,phone_field_spt,st_field_spt,outfile_spt,file_has_did_field_spt='false',did_field_spt='dummy') := macro

import header,yellowpages,ut;

 //#uniquename(st_set)
 //%st_set% := ['WA',''];

 #uniquename(type_set)
 %type_set% := ['CELL','LNDLN PRTD TO CELL'];
  
 #uniquename(candidates)
 #uniquename(skip_these)
 %candidates% := infile_spt(trim((string)phone_field_spt) not in ['0000000000','9999999999'] and length(trim((string)phone_field_spt))=10);
 %skip_these% := infile_spt(~(trim((string)phone_field_spt) not in ['0000000000','9999999999'] and length(trim((string)phone_field_spt))=10));

 #uniquename(append_phonetype)
 //macro
 yellowpages.NPA_PhoneType_forSuppression(%candidates%,phone_field_spt,phonetype,%append_phonetype%)
 
 #uniquename(candidate_by_did)
 #uniquename(candidate_by_phone)
 
 #if(file_has_did_field_spt)
 %candidate_by_did% := distribute(%append_phonetype%(did_field_spt>0),hash(did_field_spt));
 #else
 %candidate_by_did% := %append_phonetype%;
 #end
 
 %candidate_by_phone% := 
   #if(file_has_did_field_spt)
    %append_phonetype%(did_field_spt=0);
   #else
    %append_phonetype%;
   #end                      
 
 #uniquename(hdr)

 %hdr% :=  Header.file_header_wa;

  #uniquename(t_suppress_by_did)
 #if(file_has_did_field_spt)
 recordof(infile_spt) %t_suppress_by_did%(%candidate_by_did% le, %hdr% ri) := transform
  self.phone_field_spt := if(trim(le.phonetype) in %type_set% and le.did_field_spt=ri.did,(typeof(le.phone_field_spt))'',le.phone_field_spt);
  self                 := le;
 end;
 #end
 
 #uniquename(by_did)
 #if(file_has_did_field_spt)
 %by_did% := join(%candidate_by_did%,%hdr%,left.did_field_spt=right.did,%t_suppress_by_did%(left,right),left outer,local); 
 #end
 
 #uniquename(t_suppress_by_phone)
 recordof(infile_spt) %t_suppress_by_phone%(%candidate_by_phone% le) := transform
  self.phone_field_spt := if(trim(le.phonetype) in %type_set% and (le.st_field_spt='WA' or le.tds_state='WA'),(typeof(le.phone_field_spt))'',le.phone_field_spt);
  self                 := le;
 end;
  #uniquename(named_message1)
 #uniquename(by_phone)
  %named_message1% := 'count_candidates_blanked_by_did_for_phone_suppression';
  %by_phone% := project(%candidate_by_phone%,%t_suppress_by_phone%(left));
 /*
  #if(file_has_did_field_spt)
  #uniquename(named_message2)
  %named_message2% := 'did_not_applied_for_phone_suppression';
  output(count(%candidate_by_did%(phone_field_spt<>''))-count(%by_did%(phone_field_spt<>'')),named(%named_message1%));
  output(%by_did%(phone_field_spt=''),named('candidates_blanked_by_did_for_phone_suppression'),EXTEND);
  #else
  output(%named_message2%);
  #end
 
  #uniquename(named_message3)
  %named_message3% := 'count_candidates_blanked_by_phone_for_phone_suppression';
  output(count(%candidate_by_phone%(phone_field_spt<>''))-count(%by_phone%(phone_field_spt<>'')),named(%named_message3%));
  output(%by_phone%(phone_field_spt=''),named('candidates_blanked_by_phone_for_phone_suppression'),EXTEND);
*/
 #uniquename(concat)
 #if(file_has_did_field_spt)
 %concat% := %by_did% + %by_phone% + %skip_these%;
 #else
 %concat% :=            %by_phone% + %skip_these%;
 #end
 
 outfile_spt := %concat%;
endmacro;