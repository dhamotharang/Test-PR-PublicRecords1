export Keys (indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,
						Address_Key,CityStName_Key,Name_Key,Phone_Key,Phone_Key2,
						SSN_Key,SSN_Key2,StName_Key,Zip_Key,ZipPRLName_key,rep_addr=4, by_lookup=TRUE,favor_lookup_person=0,
            visitor = 'standard.MStandardBuild') :=
MACRO

// If by_lookup is true the lookup field will not be included in the dedup before the index is defined.  
// The favored lookup bit specifies which lookup to prefer for a given set of otherwise identical records.
// The rep addr param specifies which bit to set for the representative address record, that is, the first
// record in a set of records that all share the same address

#uniquename(x)
%x% := 1;
#uniquename(outkey1)
#uniquename(outkey2)
#uniquename(outkey3)
#uniquename(outkey4)
#uniquename(outkey5)
#uniquename(outkey6)
#uniquename(outkey7)

// default: autokey.MAC_Address
visitor.MAC_Address(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,Address_Key ,by_lookup,rep_addr)
						
// default: autokey.MAC_CityStName
visitor.MAC_CityStName(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,CityStName_Key,by_lookup,favor_lookup_person)
						
// default: autokey.MAC_Name
visitor.MAC_Name(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,Name_Key,by_lookup,favor_lookup_person)
						
// default: autokey.MAC_Name
visitor.MAC_Phone(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,Phone_Key)
						
// default: autokey.MAC_Phone2
visitor.MAC_Phone2(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,Phone_Key2,by_lookup,favor_lookup_person)
						
// default: autokey.MAC_SSN
visitor.MAC_SSN(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,SSN_Key)
						
// default: autokey.MAC_SSN2
visitor.MAC_SSN2(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,SSN_Key2,by_lookup,favor_lookup_person)
						
// default: autokey.MAC_StName
visitor.MAC_StName(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,StName_Key,by_lookup,favor_lookup_person)
						
// default: autokey.MAC_Zip
visitor.MAC_Zip(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,Zip_Key,by_lookup,favor_lookup_person)
						
// default: autokey.MAC_ZipPRLName
visitor.MAC_ZipPRLName(indataset,infname,inmname,inlname,
						inssn,
						indob,
						phone,
						inprim_name,inprim_range,inst,incity_name,inzip,insec_range,
						instates,
						inlname1,inlname2,inlname3,
						incity1,incity2,incity3,
						inrel_fname1,inrel_fname2,inrel_fname3,
						inlookups,
						indid,
						inkeyname,ZipPRLName_Key,by_lookup,favor_lookup_person)

ENDMACRO;