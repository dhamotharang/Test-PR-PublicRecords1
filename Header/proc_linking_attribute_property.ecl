IMPORT std,PromoteSupers,data_services;
IMPORT $;

EXPORT proc_linking_attribute_property:= FUNCTION

lc := data_services.Data_location.person_header;
iversion:=regexfind('[0-9]{8,8}',nothor(std.file.SuperFileContents(lc+'thor_data400::in::seqdheadersrc_fat')[1].name),0);

all_prop_attribute_candidates:=$.fn_Linking_Attribute_Property(iversion):persist('~thor_data400::persist::header::linking_attribute::property');

// only ones externally linked
candidates_no_blank_dids:=all_prop_attribute_candidates(did>0):independent;

// take only unique combinations of vid and did
candidates_sorted:=sort(candidates_no_blank_dids,ln_fares_id,did):independent;
candidates_dedupped:=dedup(candidates_sorted,ln_fares_id,did):independent;

// take only those with more than 1 did per vid
candidate_vid_did_count:=table( candidates_dedupped,{ln_fares_id,cnt:=count(group)},ln_fares_id,merge):independent;
vids_with_multiple_dids:=candidate_vid_did_count(cnt>1);

// Take only property data for vid did combinations with multiple non-zero dids
newFile:=join(  distribute(all_prop_attribute_candidates,hash(ln_fares_id))
                ,distribute(vids_with_multiple_dids,hash(ln_fares_id))
                ,LEFT.ln_fares_id=RIGHT.ln_fares_id
                ,transform($.Layout_Linking_Attribute_Property,SELF:=LEFT)
                ,keep(1),local);

PromoteSupers.Mac_SF_BuildProcess(newFile,$.names.linking_attribute_property,bld,2,,true,pVersion:=iversion);

RETURN bld;
END;
