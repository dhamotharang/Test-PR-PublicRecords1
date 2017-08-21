/*
Authored By J Sardeshmukh
Version : 1.0
Date    : Aug 15th, 2008
Status  : Beta
Description : Macro to scramble PII fields for any data set
*/
export mac_scramble_pii (
 param_ds_in, //data set to be scrambled
 scrambled_out, // name of scrambled data set
 param_dl,  // DL field name in input ds
 param_dob, //DOB field name
 param_ssn, //SSN field name
 param_did, // DID field name
 param_cleanName, // Clean Name Field
 param_cleanAddress, //clean Address Field
 mark_f1,  // Field name  to be marked as **scrambled;
 mark_f2,  // Field to be marked as ** scrambled
 mark_f3  // Field to marked as ~XXXX
 ):= MACRO
/*
JSardeshmukh:Aug 13;2008

1.sequence and extract to standard 'interface' file
2. scramble interface file
3. Join back replacing 'named fields' with the scrambled values;

*/

import tx_cleoAIS;
#uniquename(file_in)
%file_in%:=param_ds_in;// tx_cleoAIS.Files_Base.GI_Gen_Info;
sequenced_rec_in:=RECORD
integer5 oseq;
recordof(%file_in%);
END;
sequenced_rec_in seq_in(%file_in% L, integer C):= TRANSFORM
self.oseq:=C;
self:=l;
END;
sequenced_file_in:=PROJECT(%file_in%,seq_in(LEFT,COUNTER));
//output(sequenced_file_in);
//extract common fields and sequence it;
layout_scrambler := RECORD
integer5 zz_oseq;    // we need this to regen the orig file
string30 zz_lname;  // we leave the first and lastname intact ; there is an issue with Suffix that needs 
string30 zz_address_city;
string5  zz_zip5;
string4  zz_zip4;
//
string8  zz_dob; //ccccmmdd format
string9  zz_ssn;
string14 zz_dl_number:= '';
integer8 zz_did := 0;
string10 zz_offender_id := '';
string73 zz_clean_name_in;
string182 zz_clean_address_in;
END;

layout_scrambler prep_interface(sequenced_file_in L):= TRANSFORM
self.zz_oseq:=L.oseq;
self.zz_lname := L.dr_clean_name[46..65]; // macro name here
self.zz_address_city := L.dr_clean_address[90..114]; // macro names here
self.zz_zip5 := L.dr_clean_address[117..121]; // macro names here
self.zz_zip4 := L.dr_clean_address[122..125];// macro names here
self.zz_dob := L.gi_drvr_dob;// macro names here
self.zz_ssn := L.gi_drvr_ssn;
self.zz_dl_number:= L.gi_dl_num;// macro names here
self.zz_did := L.drvr_did;// macro names here
self.zz_offender_id := '';// macro names here
self.zz_clean_name_in:=L.dr_clean_name;
self.zz_clean_address_in:=L.dr_clean_address;
END;

interface_in := project(sequenced_file_in, prep_interface(LEFT));
//Step2 : Now scramble the name
rec_seq := RECORD
integer5 seq;
layout_scrambler;
END;
//
rec_seq hashName(interface_in l):= transform
self.seq := hash(l.zz_lname)%1300;
self:=l;
END;

ds_seq:=sort(PROJECT(interface_in(zz_lname <> ''),hashName(left)),seq);
ds_scramble:=sort(gen_lastNames,seq);
//
rec_seq scrambleName(ds_seq l, ds_scramble r) := TRANSFORM
self.zz_lname := r.lname;
fml:=l.zz_clean_name_in[6..25]+' '+l.zz_clean_name_in[26..44]+' '+r.lname;
self.zz_clean_name_in:=TX_CleoAIS.Fn.cleanName(fml); //l.clean_name_in[1..45]+TRIM(r.%lname%)[1..20]+'  '+l.clean_name_in[68..73]; // replace the scrambled last name
self := l;
END;

ds_scrambled_lastName := JOIN(ds_seq,ds_scramble,left.seq= right.seq,scrambleName(LEFT,RIGHT), LEFT OUTER, LOOKUP);
//Step 3: scramble the CITY,zipCode

rec_seq hashCity(ds_scrambled_lastName l):= transform
self.seq := hash(l.zz_clean_address_in[90..114])%1250;
self :=l;
END;

ds_seq_city:=sort(PROJECT(ds_scrambled_lastName,hashCity(left)),seq);
ds_scramble2:=sort(gen_CityNames,seq);
//
rec_seq scrambleCity(ds_seq_city l, ds_scramble2 r) := TRANSFORM
/*
This will scramble city and the other PII as well 
*/
self.zz_address_city := r.city;
zip:=r.zip_prefix+l.zz_zip5[4..5];
self.zz_zip5:=zip;
self.zz_zip4:=l.zz_clean_address_in[122..125];
st:=l.zz_clean_address_in[115..116];
citystatezip:=r.city+' '+st;// +' '+zip+'-'+l.clean_address_in[122..125];
street:=l.zz_clean_address_in[1..64];
self.zz_clean_address_in:=TX_CleoAIS.Fn.cleanAddress(street,citystatezip);
//scramble the other info now
self.zz_dob:=fn_scramblePII('DOB',l.zz_dob);
self.zz_ssn:=IF(l.zz_ssn[1] <> ' ',fn_scramblePII('SSN',l.zz_ssn),'');
self.zz_did:=IF(l.zz_did <> 0,(integer)fn_scramblePII('DID',(string)l.zz_did),0);
//replace the first letter of DL with gen last name if not in numbers
dl:=fn_scramblePII('DL',l.zz_dl_number);
numbers:=['0','1','2','3','4','5','6','7','8','9'];
self.zz_dl_number:= if(dl[1] in numbers, dl,l.zz_lname[1]+dl[2..length(dl)]);//fn_scramblePII('DL',l.dl_number);
//
self := l;
END;

ds_scramble_city := JOIN(ds_seq_city,ds_scramble2,left.seq= right.seq,scrambleCity(LEFT,RIGHT), LEFT OUTER, LOOKUP);
//step 3 : REPLACE original fields with this INFO NOW
sorted_scramble:=SORT(ds_scramble_city,seq);
sequenced_rec_in replaceFields(sequenced_file_in L, sorted_scramble R):= TRANSFORM
self.param_cleanName:=R.zz_clean_name_in;
self.param_cleanAddress:=R.zz_clean_address_in;
self.param_dob:=R.zz_DOB;
self.param_ssn:=R.zz_SSN;
self.param_dl:=R.zz_DL_number;
self.param_did := R.zz_DID;
//Fields to blank  -- these have to be params
self.mark_f1:= '**** Scrambled ';
self.mark_f2 := '**** Scrambled ';
self.mark_f3 := '~XXXX';
// Other names here?
//
self:=L;

END;

scrambled_out :=JOIN(sequenced_file_in,sorted_scramble,left.oseq=right.zz_oseq,replaceFields(LEFT,RIGHT), LEFT OUTER);


ENDMACRO;