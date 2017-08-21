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
import business_header,BIPV2;


EXPORT MAC_Source_Match(

	 infile
	,outfile
	,bool_bdid_field_is_string12
	,bdid_field
	,bool_infile_has_source_field
	,source_type_or_field
	,bool_infile_has_source_group
	,source_group_field
	,company_name_field
	,prim_range_field
	,prim_name_field
	,sec_range_field
	,zip_field
	,bool_infile_has_phone
	,phone_field
	,bool_infile_has_fein
	,fein_field
	,bool_infile_has_vendor_id	= 'false'
	,vendor_id_field						= 'vendor_id'
	,pFileVersion								= '\'prod\''														// default to use prod version of superfiles
	,pUseOtherEnvironment				= business_header._Dataset().IsDataland	// default is to hit prod on dataland, and on prod hit prod.
	,pSetLinkingVersions 				= BIPV2.IDconstants.xlink_versions_default
	,pSRC_RID_field							= BIPV2.IDconstants.SRC_RID_field_default

) := MACRO

import BIPV2,ut;

#uniquename(infile_bdid)
#uniquename(pBHFile)
%pBHFile%	:= Business_Header.Files(pFileVersion,pUseOtherEnvironment).Base.Business_headers.logical;

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


#if(BIPV2.IDconstants.xlink_version_BDID in pSetLinkingVersions)



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

	%infile_match% := distribute(PROJECT(%infile_seq%, %infile_slim_tra%(LEFT)),hash(company_name,source,vendor_id,source_group,prim_range,prim_name,zip));

	//Bug 22751 - jtolbert
	//iterate through input to assign id of matching records
	#uniquename(s_infile)
	#uniquename(new_id_rec)
	#uniquename(new_id)
	#uniquename(with_new_id)
	#uniquename(it_trans)
	#uniquename(it_infile)
	#uniquename(dup_infile)

	//add new id
	%new_id_rec% := record
	 %infile_match%;
	 unsigned6 %new_id%;
	end;

	%with_new_id% := project(%infile_match%,transform(%new_id_rec%,self.%new_id% := left.%uid%,self := left));

	//sort and group by common fields
	%s_infile% := group(sort(%with_new_id%,company_name,source,vendor_id,source_group,prim_range,prim_name,zip,sec_range,phone,fein,local),
															company_name,source,vendor_id,source_group,prim_range,prim_name,zip,sec_range,phone,fein);

	%new_id_rec% %it_trans%(%new_id_rec% l, %new_id_rec% r) := transform
	 self.%new_id% := if(l.%new_id%=0,r.%new_id%,l.%new_id%);
	 self := r;
	end;

	//propagate new_id
	%it_infile% := iterate(%s_infile%,%it_trans%(left,right));
	%dup_infile% := ungroup(dedup(%it_infile%,%new_id%));

	%infile_match_vendor% := %dup_infile%(bool_infile_has_vendor_id,
																					source IN Business_Header.Set_Source_Vendor_Id_Unique,
											vendor_id <> '');
	%infile_match_phone% := %dup_infile%(bool_infile_has_phone,
																				 source IN Business_Header.Set_Source_Phone,
																				 source NOT IN Business_Header.Set_Source_Vendor_Id_Unique,
											 phone <> 0);
	%infile_match_other% := %dup_infile%(source NOT IN Business_Header.Set_Source_Phone
																				 OR (source IN Business_Header.Set_Source_Phone AND (NOT bool_infile_has_phone or phone = 0)),
																				 source NOT IN Business_Header.Set_Source_Vendor_Id_Unique
											 OR (source IN Business_Header.Set_Source_Vendor_Id_Unique AND (NOT bool_infile_has_vendor_id or vendor_id = '')));
	%infile_match_none% := %dup_infile%(FALSE);

	// Use Basic Match to Business Headers to assign BDID
	#uniquename(infile_matched)
	#uniquename(infile_matched_vendor)
	#uniquename(infile_matched_phone)
	#uniquename(infile_matched_other)

	// Basic match with vendor
	Business_Header.MAC_Basic_Match_Vendor(%infile_match_vendor%,%infile_matched_vendor%, bool_infile_has_source_group,pFileVersion,pUseOtherEnvironment)

	// Basic match with phone
	Business_Header.MAC_Basic_Match_Phone(%infile_match_phone%,%infile_matched_phone%, bool_infile_has_source_group,pFileVersion,pUseOtherEnvironment)

	// Basic match other
	Business_Header.MAC_Basic_Match(%infile_match_other%,%infile_matched_other%, bool_infile_has_source_group,pFileVersion,pUseOtherEnvironment)

	// Combine matches
	/*
	%infile_matched% := IF(COUNT(%infile_match_vendor%) <> 0, %infile_matched_vendor%, %infile_match_none%) +
											IF(COUNT(%infile_matched_phone%) <> 0, %infile_matched_phone%, %infile_match_none%) +
						IF(COUNT(%infile_match_other%) <> 0, %infile_matched_other%, %infile_match_none%);
	*/
	%infile_matched% := %infile_matched_vendor% + %infile_matched_phone% + %infile_matched_other%;

	// Distribute by Unique ID
	#uniquename(infile_matched_dist)
	%infile_matched_dist% := DISTRIBUTE(%infile_matched%, HASH(%new_id%));

	#uniquename(infile_matched_dist_sort)
	%infile_matched_dist_sort% := SORT(%infile_matched_dist%, %new_id%, IF(bdid<>0,0,1), bdid, LOCAL);

	// Dedup by unique id
	#uniquename(infile_matched_dist_dedup)
	%infile_matched_dist_dedup% := DEDUP(%infile_matched_dist_sort%, %new_id%, LOCAL);

	//Join new_id to iterated file
	#uniquename(trans_back_id)
	%infile_match_layout% %trans_back_id%(%new_id_rec% l,%infile_matched_dist_dedup% R) := transform
	self.bdid := r.bdid; 
	self := l;
	end;

	#uniquename(with_BDID)
	%with_BDID% := join(distribute(%it_infile%,hash(%new_id%)),%infile_matched_dist_dedup%,left.%new_id%=right.%new_id%,
						%trans_back_id%(left,right),local);

	#uniquename(redist_bdid)
	%redist_bdid% := distribute(%with_bdid%,hash(%uid%));

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

	%infile_bdid% := JOIN(%infile_seq_dist%,
												%redist_bdid%,
												LEFT.%uid% = RIGHT.%uid%,
												%Assign_BDID%(LEFT, RIGHT),
												LEFT OUTER,
												LOCAL);
#else
	%infile_bdid% := %infile_seq%;
#end


#if(BIPV2.IDconstants.xlink_version_BIP in pSetLinkingVersions)
	output('WARNING: Business_Header.MAC_Source_Match does not support BIP.  BIP source matching is done within Business_Header_SS.MAC_Match_Flex');
#end

outfile := %infile_bdid%;




ENDMACRO;