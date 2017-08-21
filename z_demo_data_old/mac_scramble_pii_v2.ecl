/*
Authored By J Sardeshmukh
Version : 1.0
Date    : Aug 22nd, 2008
Status  : Beta
Description : Macro to scramble PII fields for any data set
*/
dummy:= false;
export mac_scramble_pii_v2 (
 param_ds_in, //data set to be scrambled
 param_scrambledfile, // name of scrambled data set
 hasPhone,param_phone,
 hasDL,param_dl ,// DL field name in input ds
 hasDOB,param_dob , //DOB field name
 hasSSN,param_ssn , //SSN field name
 hasDID,param_did ,// DID field name
 hasBDID,param_BDID,
 hasFname,param_fname,
 hasMname,param_mname,
 hasLname,param_lname,
 hasCleanName,param_cleanName, // Clean Name Field
 hasBizName,param_bizName,// Clean Business Name Field
 hasStreet,param_street,
 hasCity,param_city,
 hasState,param_st,
 hasZip5,param_zip5,
 hasZip4,param_zip4,
 hasCleanAddress,param_cleanAddress , //clean Address Field
 fieldsToMark=3,// see note
 /*
 fieldsToMark indicates orig PII fields then need to be marked
 as scrambled; all the fields mentions above , are REPLACED with
 the scrambled values, However there may be orig fields with identifying info.
 For example, while the cleanName fields is replaced there may be fname,lname fields
 that need to be marked as '**scrambled'; If there are more than 10 fields then you
 have to do it with logic outside the macro
 */
 mark_f1 		= 'none'		 ,  // Field name  to be marked as **scrambled;
 mark_f2 		= 'none'		,  // Field to be marked as ** scrambled
 mark_f3 		= 'none'	 ,  // Field name  to be marked as **scrambled;
 mark_f4 		= 'none'			 ,  // Field to be marked as ** scrambled
 mark_f5 		= 'none'				 ,  // Field name  to be marked as **scrambled;
 mark_f6 		= 'none'				 ,  // Field to be marked as ** scrambled
 mark_f7 		= 'none'				 ,  // Field name  to be marked as **scrambled;
 mark_f8 		= 'none'				 ,  // Field to be marked as ** scrambled
 mark_f9 		= 'none'			 ,  // Field name  to be marked as **scrambled;
 mark_f10 	= 'none'				   // Field to marked as ~XXXX
 ):= MACRO
/*
JSardeshmukh:Aug 13;2008

1.sequence and extract to standard 'interface' file
2. scramble interface file
3. Join back replacing 'named fields' with the scrambled values;

*/


#uniquename(file_in)
%file_in%:=param_ds_in;//  Files_Base.GI_Gen_Info;

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
string30 zz_lname := '';  // we leave the first and lastname intact ; there is an issue with Suffix that needs 
string50 zz_street :='';
string30 zz_city   := '';
string5  zz_zip5 :='';
string4  zz_zip4 :='';
//
string10 zz_phone := '';
string8  zz_dob :=''; //ccccmmdd format
string9  zz_ssn :='';
string14 zz_dl_number:= '';
integer8 zz_did := 0;
integer8 zz_bdid := 0;
string10 zz_offender_id := '';
string73 zz_clean_name_in := '';
string73 zz_biz_name_in := '';
string182 zz_clean_address_in := '';
END;

layout_scrambler prep_interface(sequenced_file_in L):= TRANSFORM
self.zz_oseq:=L.oseq;
#if (hasLname)
self.zz_lname := if(l.param_lname<>'', fn_scrambleLastName(L.param_lname),'') ;// macro name here -- added fn call for scramble 
#end

#if (hasCleanName and not hasLname)
self.zz_lname := if(l.param_cleanname[46..65]<>'',fn_scrambleLastName(L.param_cleanName[46..65]),''); // macro name here - added fn call for scramble 
#end

#if (hasStreet and hasCity and hasZip4 and hasZip5) // means we have the others 
self.zz_street      := L.param_Street;
self.zz_city         := L.param_City;
self.zz_zip5         := L.param_zip5;
self.zz_zip4         := L.param_zip4;
#end

#if (hasCleanAddress and not hasStreet)
self.zz_address_city := L.param_cleanAddress[90..114]; // macro names here
self.zz_zip5 := L.param_cleanAddress[117..121]; // macro names here
self.zz_zip4 := L.param_cleanAddress[122..125];// macro names here
#end

#if  (hasDOB)
self.zz_dob := L.param_dob;// macro names here
#end
#if (hasPhone)
self.zz_phone := L.param_phone;// Phone Number
#end
#if  (hasSSN)
self.zz_ssn := L.param_ssn;
#end
#if (hasDL)
self.zz_dl_number:= L.param_dl;// macro names here
#end
#if  (hasDID)
self.zz_did := (integer8) L.param_did;// macro names here
#end
#if  (hasBDID)
self.zz_bdid := (integer8) L.param_bdid;// macro names here
#end
#if (hasCleanName)
 self.zz_clean_name_in:=L.param_cleanName;
#end
#if (hasLname and hasMname and hasFname and not hasCleanName)
 self.zz_clean_name_in:=fn.cleanName(l.param_fname+' '+l.param_mname+' '+l.param_lname);
#end
#if (hasBizName)
self.zz_biz_name_in:=fn_scrambleBizNameV2(L.param_bizName);
#end
#if (hasCleanAddress)
self.zz_clean_address_in:=L.param_cleanAddress;
#end
END;

interface_in := project(sequenced_file_in, prep_interface(LEFT));
//Step2 : Now scramble the name IF it exists
rec_seq := RECORD
integer5 seq :=0;
layout_scrambler;
END;
//
rec_seq genBase(interface_in l, integer c):= transform
self.seq:=c;
self:=l;
END;
sequenced_interface:=PROJECT(interface_in,genBase(left, COUNTER));

#if (false) //(hasCleanName or hasLname)
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
self.zz_clean_name_in:= Fn.cleanName(fml); //l.clean_name_in[1..45]+TRIM(r.%lname%)[1..20]+'  '+l.clean_name_in[68..73]; // replace the scrambled last name
self := l;
END;

ds_scrambled_lastName := JOIN(ds_seq,ds_scramble,left.seq= right.seq,scrambleName(LEFT,RIGHT), LEFT OUTER, LOOKUP);
#else

  // should be original projected interface file if name was not scrambled
ds_scrambled_lastName:= sequenced_interface;
#end

#if (false) // was hasBizName IGNORE THIS AS WE HAVE A NEW FUNCTION
rec_seq hashBizName(ds_scrambled_lastName l):= transform
self.seq := hash(l.zz_biz_name_in)%1300;
self:=l;
END;

ds_seqBiz:=sort(PROJECT(ds_scrambled_lastName(zz_biz_name_in <> ''),hashBizName(left)),seq);
ds_scrambleBiz:=sort(gen_BusinessNames,seq);
//
rec_seq scrambleBizName(ds_seqBiz l, ds_scrambleBiz r) := TRANSFORM
self.zz_biz_name_in := r.biz;
self := l;
END;

ds_scrambled_BizName := JOIN(ds_seqBiz,ds_scrambleBiz,left.seq= right.seq,scrambleBizName(LEFT,RIGHT), LEFT OUTER, LOOKUP);
#else

  // should be original projected interface file if name was not scrambled
ds_scrambled_BizName:= ds_scrambled_lastName;
#end

//Step 3: scramble the CITY,zipCode
#if (hasCleanAddress)
rec_seq hashCity(ds_scrambled_BizName l):= transform
self.seq := hash(l.zz_clean_address_in[90..114])%1250;
self :=l;
END;
#end

#if (hasCity)
rec_seq hashCity(ds_scrambled_BizName l):= transform
self.seq := if(l.zz_city<>'',hash(l.zz_city)%1250,9999);
self :=l;
END;
#end


ds_seq_city:=sort(PROJECT(ds_scrambled_BizName,hashCity(left)),seq);

ds_scramble2:=sort(gen_CityNames,seq);
//
rec_seq scrambleCity(ds_seq_city l, ds_scramble2 r) := TRANSFORM
#if (hasCity and hasZip5)
self.zz_city := r.city;
zip:=r.zip_prefix+l.zz_zip5[4..5];
self.zz_zip5:=fn_scramblePII('zip5',l.zz_zip5);
self.zz_street := fn_genStreetName(l.zz_street);
#end
//
#if (hasCleanAddress and not hasCity)
self.zz_city := r.city;
zip:=r.zip_prefix+l.zz_zip5[4..5];
self.zz_zip5:=fn_scramblePII('zip5',l.zz_zip5);
self.zz_zip4:=l.zz_clean_address_in[122..125];
st:=l.zz_clean_address_in[115..116];
citystatezip:=r.city+' '+st;// +' '+zip+'-'+l.clean_address_in[122..125];
street:=fn_genStreetName(l.zz_clean_address_in[1..64]);
self.zz_clean_address_in:= Fn.cleanAddress(street,citystatezip);
#end
//
self := l;
END;

#IF (hasCleanAddress or (hasCity and hasZip5 and hasStreet))
ds_scramble_city := JOIN(ds_seq_city,ds_scramble2,left.seq= right.seq,scrambleCity(LEFT,RIGHT), LEFT OUTER, LOOKUP);
//step 3 : REPLACE original fields with this INFO NOW
sorted_scramble:=SORT(ds_scramble_city,seq);
#else
sorted_scramble:=ds_scrambled_BizName;
#end
//
// Last Step Join and replace orginal fields with interface fields
//
sequenced_rec_in replaceFields(sequenced_file_in L, sorted_scramble R):= TRANSFORM
#if (hasCleanName)
self.param_cleanName:=R.zz_clean_name_in;
#end
#if (hasLName)
self.param_lname:=R.zz_lname;
#end
#if (hasBizName)
self.param_BizName:=R.zz_biz_name_in;
#end

#if (hasStreet and hasCity and hasZip4 and hasZip5) // means we have the others 
self.param_street := R.zz_street;
self.param_city :=   R.zz_city;
self.param_zip5 :=   R.zz_zip5;
self.param_zip4 :=   R.zz_zip4;

#end
#if  (hasCleanAddress and hasStreet)
self.param_cleanAddress:=R.zz_clean_address_in;
#end


#if  (hasDOB)
self.param_dob:= (typeof(l.param_dob)) if(R.zz_dob<>'', fn_scramblePII('DOB',R.zz_dob),'');//R.zz_DOB;
#end
#if  (hasSSN)
self.param_ssn:= (typeof(l.param_ssn)) IF(R.zz_ssn[1] <> ' ',fn_scramblePII('SSN',R.zz_ssn),'');//R.zz_SSN;
#end
#if (hasPhone)
self.param_phone := fn_scramblePII('phone',R.zz_phone);
#end
#if  (hasDL)
dl:=fn_scramblePII('DL',R.zz_dl_number);
numbers:=['0','1','2','3','4','5','6','7','8','9'];
self.param_dl:= (typeof(l.param_dl))if(dl[1] in numbers, dl,R.zz_lname[1]+dl[2..length(dl)]);// R.zz_DL_number;
#end
#if  (hasDID)

self.param_did := (typeof(l.param_did)) IF(R.zz_did <> 0,(integer)fn_scramblePII('DID',(string)R.zz_did),0);//R.zz_DID;
#end
#if  (hasBDID)
self.param_bdid := (typeof(l.param_bdid)) IF(R.zz_bdid <> 0,(integer)fn_scramblePII('DID',(string)R.zz_bdid),0);//R.zz_BDID;
#end
//Fields to blanked  -- these have to be params
//More than 10.. or they are not strings .. sorry you have to do it yourself
#if (fieldsToMark > 0)
self.mark_f1:= '**** Scrambled ';
#end
#if (fieldsToMark > 1)
self.mark_f2:= '**** Scrambled ';
#end
#if (fieldsToMark > 2)
self.mark_f3:= '**** Scrambled ';
#end
#if (fieldsToMark > 3)
self.mark_f4:= '**** Scrambled ';
#end
#if (fieldsToMark > 4)
self.mark_f5:= '**** Scrambled ';
#end
#if (fieldsToMark > 5)
self.mark_f6:= '**** Scrambled ';
#end
#if (fieldsToMark > 6)
self.mark_f7:= '**** Scrambled ';
#end
#if (fieldsToMark > 7)
self.mark_f8:= '**** Scrambled ';
#end
#if (fieldsToMark > 8)
self.mark_f9:= '**** Scrambled ';
#end
#if (fieldsToMark > 9)
self.mark_f10:= '**** Scrambled ';
#end

//
self:=L;

END;

param_scrambledFile :=JOIN(sequenced_file_in,sorted_scramble,left.oseq=right.zz_oseq,replaceFields(LEFT,RIGHT), LEFT OUTER);

ENDMACRO;
