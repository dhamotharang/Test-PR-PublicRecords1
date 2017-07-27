// This macro is used to BDID the source files that are used to create the
// business headers. (Bankruptcy, Corp, UCC, Gong, YellowPages, Whois)
//
// source_type_or_field can be either a souce type like 'U' or the name
// of a field in the input file if the bool_infile_has_source_field is TRUE
//
// bdid_field can be a string10 (bool_bdid_field_is_string10 = TRUE) or
// is an unsigned6 or integer
//
// phone_field and fein_field are optional


EXPORT MAC_Source_Match(infile,outfile,
                        bool_bdid_field_is_string12, bdid_field,
                        bool_infile_has_source_field, source_type_or_field,
                        bool_infile_has_source_group, source_group_field,
                        company_name_field,
                        prim_range_field, prim_name_field, sec_range_field, zip_field,
                        bool_infile_has_phone, phone_field,
                        bool_infile_has_fein, fein_field,
						bool_infile_has_vendor_id = 'false',
						vendor_id_field = 'vendor_id') := MACRO

// Add unique sequence number to input file
#uniquename(infile_seq_layout)
#uniquename(uid)
%infile_seq_layout% := RECORD
  unsigned6 %uid% := 0;
  infile;
END;

#uniquename(infile_init)
#uniquename(infile_init_tra)
%infile_seq_layout% %infile_init_tra%(infile L) := TRANSFORM
SELF := L;
END;

%infile_init% := PROJECT(infile, %infile_init_tra%(LEFT));

#uniquename(infile_seq)
ut.MAC_Sequence_Records(%infile_init%, %uid%, %infile_seq%)

// Project input file to slim layout for matching
#uniquename(infile_match_layout)
%infile_match_layout% := RECORD
  unsigned6 %uid%;
  unsigned6 rcid := 0;
  unsigned6 bdid := 0;
  string2   source;
  qstring34 vendor_id;
  qstring34 source_group;
  qstring120 company_name;
  qstring10 prim_range;
  qstring28 prim_name;
  qstring8  sec_range;
  unsigned3 zip;
  unsigned6 phone;
  unsigned4 fein;
END;

#uniquename(infile_slim_tra)
%infile_match_layout% %infile_slim_tra%(%infile_seq_layout% L) := TRANSFORM
SELF.rcid := 0;
SELF.bdid := 0;
#if(bool_infile_has_source_field)
SELF.source := L.source_type_or_field;
#else
SELF.source := source_type_or_field;
#end
#if(bool_infile_has_vendor_id)
SELF.vendor_id := L.vendor_id_field;
#else
SELF.vendor_id := '';
#end
#if(bool_infile_has_source_group)
SELF.source_group := L.source_group_field;
#else
SELF.source_group := '';
#end
SELF.company_name := (QSTRING120)Stringlib.StringToUpperCase(L.company_name_field);
SELF.prim_range := (QSTRING10)L.prim_range_field;
SELF.prim_name := (QSTRING28)L.prim_name_field;
SELF.sec_range := (QSTRING8)L.sec_range_field;
SELF.zip := (UNSIGNED3)L.zip_field;
#if(bool_infile_has_phone)
SELF.phone := (UNSIGNED6)((UNSIGNED8)L.phone_field);
#else
SELF.phone := 0;
#end
#if(bool_infile_has_fein)
SELF.fein := (UNSIGNED4)L.fein_field;
#else
SELF.fein := 0;
#end
SELF := L;
END;

#uniquename(infile_match)
#uniquename(infile_match_vendor)
#uniquename(infile_match_phone)
#uniquename(infile_match_other)
#uniquename(infile_match_none)

%infile_match% := PROJECT(%infile_seq%, %infile_slim_tra%(LEFT));
%infile_match_vendor% := %infile_match%(bool_infile_has_vendor_id,
                                        source IN Business_Header.Set_Source_Vendor_Id_Unique,
										vendor_id <> '');
%infile_match_phone% := %infile_match%(bool_infile_has_phone,
                                       source IN Business_Header.Set_Source_Phone,
                                       source NOT IN Business_Header.Set_Source_Vendor_Id_Unique,
									   phone <> 0);
%infile_match_other% := %infile_match%(source NOT IN Business_Header.Set_Source_Phone
                                       OR (source IN Business_Header.Set_Source_Phone AND (NOT bool_infile_has_phone or phone = 0)),
                                       source NOT IN Business_Header.Set_Source_Vendor_Id_Unique
									   OR (source IN Business_Header.Set_Source_Vendor_Id_Unique AND (NOT bool_infile_has_vendor_id or vendor_id = '')));
%infile_match_none% := %infile_match%(FALSE);

// Use Basic Match to Business Headers to assign BDID
#uniquename(infile_matched)
#uniquename(infile_matched_vendor)
#uniquename(infile_matched_phone)
#uniquename(infile_matched_other)

// Basic match with vendor
Business_Header.MAC_Basic_Match_Vendor(%infile_match_vendor%,%infile_matched_vendor%, bool_infile_has_source_group)

// Basic match with phone
Business_Header.MAC_Basic_Match_Phone(%infile_match_phone%,%infile_matched_phone%, bool_infile_has_source_group)

// Basic match other
Business_Header.MAC_Basic_Match(%infile_match_other%,%infile_matched_other%, bool_infile_has_source_group)

// Combine matches
/*
%infile_matched% := IF(COUNT(%infile_match_vendor%) <> 0, %infile_matched_vendor%, %infile_match_none%) +
                    IF(COUNT(%infile_matched_phone%) <> 0, %infile_matched_phone%, %infile_match_none%) +
					IF(COUNT(%infile_match_other%) <> 0, %infile_matched_other%, %infile_match_none%);
*/
%infile_matched% := %infile_matched_vendor% + %infile_matched_phone% + %infile_matched_other%;

// Distribute by Unique ID
#uniquename(infile_matched_dist)
%infile_matched_dist% := DISTRIBUTE(%infile_matched%, HASH(%uid%));

#uniquename(infile_matched_dist_sort)
%infile_matched_dist_sort% := SORT(%infile_matched_dist%, %uid%, IF(bdid<>0,0,1), bdid, LOCAL);

// Dedup by unique id
#uniquename(infile_matched_dist_dedup)
%infile_matched_dist_dedup% := DEDUP(%infile_matched_dist_sort%, %uid%, LOCAL);

// Join to sequenced input file to assign BDID
#uniquename(infile_seq_dist)
%infile_seq_dist% := DISTRIBUTE(%infile_seq%, HASH(%uid%));

#uniquename(Assign_BDID)
TYPEOF(infile) %Assign_BDID%(%infile_seq_layout% L, %infile_match_layout% R) := TRANSFORM
#if(bool_bdid_field_is_string12)
SELF.bdid_field := IF(R.bdid <> 0, (STRING12)INTFORMAT(R.bdid, 10, 1), '');
#else
SELF.bdid_field := R.bdid;
#end
SELF := L;
END;

#uniquename(infile_bdid)
%infile_bdid% := JOIN(%infile_seq_dist%,
                      %infile_matched_dist_dedup%,
                      LEFT.%uid% = RIGHT.%uid%,
                      %Assign_BDID%(LEFT, RIGHT),
                      LEFT OUTER,
                      LOCAL);

outfile := %infile_bdid%;

ENDMACRO;