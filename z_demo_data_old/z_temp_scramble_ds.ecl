/*
JSardeshmukh:Aug 13;2008
This is the skeleton to be used to generate a macro to scramble
ANY dataset for 'obfuscating' Personal Info; For test purposes!
Logic Overview;
1.sequence and extract standard 'interface' file
2. scramble interface file
3. Join back replacing 'named fields' with the scrambled values;

*/

import tx_cleoAIS;
file_in:=tx_cleoAIS.Files_Base.GI_Gen_Info;
sequenced_rec_in:=RECORD
integer5 oseq;
recordof(file_in);
END;
sequenced_rec_in seq_in(file_in L, integer C):= TRANSFORM
self.oseq:=C;
self:=l;
END;
sequenced_file_in:=PROJECT(file_in,seq_in(LEFT,COUNTER));
output(sequenced_file_in);
//extract common fields and sequence it;
layout_scrambler := RECORD
integer5 oseq;    // we need this to regen the orig file
string30 lname;  // we leave the first and lastname intact ; there is an issue with Suffix that needs 
string30 address_city;
string5  zip5;
string4  zip4;
//
string8  dob; //ccccmmdd format
string9  ssn;
string14 dl_number:= '';
integer8 did := 0;
string10 offender_id := '';
string73 clean_name_in;
string182 clean_address_in;
END;

layout_scrambler prep_interface(sequenced_file_in L):= TRANSFORM
self.lname := L.dr_clean_name[46..65]; // macro name here
self.address_city := L.dr_clean_address[90..114]; // macro names here
self.zip5 := L.dr_clean_address[117..121]; // macro names here
self.zip4 := L.dr_clean_address[122..125];// macro names here
self.dob := L.gi_drvr_dob;// macro names here
self.ssn := L.gi_drvr_ssn;
self.dl_number:= L.gi_dl_num;// macro names here
self.did := L.drvr_did;// macro names here
self.offender_id := '';// macro names here
self.clean_name_in:=L.dr_clean_name;
self.clean_address_in:=L.dr_clean_address;
self:=l;
END;

interface_in := project(sequenced_file_in, prep_interface(LEFT));
//Step2 : Now scramble the name
rec_seq := RECORD
integer5 seq;
layout_scrambler;
END;
//
rec_seq hashName(interface_in l):= transform
self.seq := hash(l.lname)%1300;
self:=l;
END;

ds_seq:=sort(PROJECT(interface_in(lname <> ''),hashName(left)),seq);
ds_scramble:=sort(gen_lastNames,seq);
//
rec_seq scrambleName(ds_seq l, ds_scramble r) := TRANSFORM
self.lname := r.lname;
fml:=l.clean_name_in[6..25]+' '+l.clean_name_in[26..44]+' '+r.lname;
self.clean_name_in:=TX_CleoAIS.Fn.cleanName(fml); //l.clean_name_in[1..45]+TRIM(r.lname)[1..20]+'  '+l.clean_name_in[68..73]; // replace the scrambled last name
self := l;
END;

ds_scrambled_lastName := JOIN(ds_seq,ds_scramble,left.seq= right.seq,scrambleName(LEFT,RIGHT), LEFT OUTER, LOOKUP);
//Step 3: scramble the CITY,zipCode

rec_seq hashCity(ds_scrambled_lastName l):= transform
self.seq := hash(l.clean_address_in[90..114])%1250;
self :=l;
END;

ds_seq_city:=sort(PROJECT(ds_scrambled_lastName,hashCity(left)),seq);
ds_scramble2:=sort(gen_CityNames,seq);
//
rec_seq scrambleCity(ds_seq_city l, ds_scramble2 r) := TRANSFORM
/*
This will scramble city and the other PII as well 
*/
self.address_city := r.city;
zip:=r.zip_prefix+l.zip5[4..5];
self.zip5:=zip;
self.zip4:=l.clean_address_in[122..125];
st:=l.clean_address_in[115..116];
citystatezip:=r.city+' '+st;// +' '+zip+'-'+l.clean_address_in[122..125];
street:=l.clean_address_in[1..64];
self.clean_address_in:=TX_CleoAIS.Fn.cleanAddress(street,citystatezip);
//scramble the other info now
self.dob:=fn_scramblePII('DOB',l.dob);
self.ssn:=IF(l.ssn[1] <> ' ',fn_scramblePII('SSN',l.ssn),'');
self.did:=IF(l.did <> 0,(integer)fn_scramblePII('DID',(string)l.did),0);
//replace the first letter of DL with gen last name if not in numbers
dl:=fn_scramblePII('DL',l.dl_number);
numbers:=['0','1','2','3','4','5','6','7','8','9'];
self.dl_number:= if(dl[1] in numbers, dl,l.lname[1]+dl[2..length(dl)]);//fn_scramblePII('DL',l.dl_number);
//
self := l;
END;

ds_scramble_city := JOIN(ds_seq_city,ds_scramble2,left.seq= right.seq,scrambleCity(LEFT,RIGHT), LEFT OUTER, LOOKUP);
//step 3 : REPLACE original fields with this INFO NOW
sorted_scramble:=SORT(ds_scramble_city,oseq);
sequenced_rec_in replaceFields(sequenced_file_in L, sorted_scramble R):= TRANSFORM
self.dr_clean_name:=R.zz_clean_name_in;
self.dr_clean_address:=R.zz_clean_address_in;
self.gi_drvr_dob:=R.zz_DOB;
self.gi_drvr_ssn:=R.zz_SSN;
self.gi_dl_num:=R.zz_DL_number;
self.drvr_did := R.zz_DID;
//Fields to blank  -- these have to be params
self.gi_drvr_lname:= '**** Scrambled ';
self.gi_drvr_city := '**** Scrambled ';
self.gi_drvr_zipcode := '~XXXX';
// Other names here?
//
self:=L;

END;

export _temp_scramble_ds :=JOIN(sequenced_file_in,sorted_scramble,left.oseq=right.oseq,replaceFields(LEFT,RIGHT), LEFT OUTER);
