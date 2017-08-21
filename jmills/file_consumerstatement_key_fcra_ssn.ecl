#CONSTANT('DataLocationCC', 'NONAME');  
import consumerstatement;
key_in := consumerstatement.key.fcra.ssn;

layout_out := RECORD
 string9 ssn;
  unsigned8 lexid;
  string20 fname;
  string20 lname;
  varstring cs_text;
  string20 datecreated;
  unsigned8 __internal_fpos__;
 END;
 
 layout_out makelayout (key_in l) := transform
self:=l;
end;


EXPORT file_consumerstatement_key_fcra_ssn := project(key_in,makelayout(left));