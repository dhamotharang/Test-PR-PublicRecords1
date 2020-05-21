
Overrides.MAC_read_override_base('Assessment',PropertyAssessmentRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file
// PropertyDeed
Overrides.MAC_read_override_base('Deed',PropertyDeedRecIDs,flag_file_id,,(string)ln_fares_id,,,,false);//no DID, use flag file
// DeedByResidence
Overrides.MAC_read_override_base('Property_Search',PropertySearchRecIDs,flag_file_id,did,(string)persistent_record_id,,,,false);


//OverrideBase := PropertyAssessmentRecIDs + PropertyDeedRecIDs + PropertySearchRecIDs;
OverrideBase := PropertyDeedRecIDs;


//output(table(OverrideBase,{Datagroup,cnt:=count(group)},Datagroup,merge),named('DsLexid_override_base'));

//hit ConsumerDisclosure.FCRADataService to append compliance flags and get orphans candidates 

Overrides.Mac_GetOverrides(OverrideBase, dsout);

dsOut_candidates:=dsOut(IsOverride_ and ~IsOverwritten_);

//output(dsOut_candidates(datagroup in ['DEED','PROPERTY_SEARCH']), all);

LN_PropertyV2.key_deed_fid(true)(ln_fares_id in ['OM0074798063', 'OM0059906283']);

FCRA.Key_Override_Property.deed(ln_fares_id in ['OM0074798063', 'OM0059906283']);
           
fcra.File_flag(flag_file_id in [ '544332',   '544342'] and file_id = 'deed');  