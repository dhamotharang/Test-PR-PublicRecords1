Import Data_Services, ln_property,doxie, ut,fcra, BIPV2,LN_PropertyV2;

export key_search_fid(boolean IsFCRA = false, boolean isFast = false) := function

keyPrefix			:= if(isFast,'property_fast','ln_propertyv2');

KeyName 			:= 'thor_data400::key::'+keyPrefix+'::';
KeyName_fcra  := 'thor_data400::key::'+keyPrefix+'::fcra::';

//Appeend Linkids to existing key layout
file_search_bld_Bip0	:= LN_PropertyV2_Fast.file_search_building_Bip(LN_PropertyV2.File_Search_DID,false);
file_search_bld_Bip1	:= LN_PropertyV2_Fast.file_search_building_Bip(LN_PropertyV2_Fast.Files.basedelta.search_prp,true);
file_search_bld_Bip2	:= if(isFast,file_search_bld_Bip1,file_search_bld_Bip0);

file_search_bld0	:= LN_PropertyV2_Fast.CleanSearch(false);
file_search_bld1	:= LN_PropertyV2_Fast.CleanSearch(true, true);
file_search_bld	:= if(isFast,file_search_bld1,file_search_bld0);


file_deed				:= if(isFast,LN_PropertyV2_Fast.Files.base.deed_mortg,LN_PropertyV2.File_Deed);
file_assessment	:= if(isFast,LN_PropertyV2_Fast.Files.base.assessment,LN_PropertyV2.File_Assessment);


file_search_bld_Bip := project(file_search_bld_Bip2, {recordof(file_search_bld_Bip2),  unsigned8 persistent_record_id := 0}); 
//appends persistent_record_id field as in LN_PropertyV2.file_search_building
append_puid_  := ln_propertyV2.fn_append_puid(file_search_bld_Bip);

append_puid := project(append_puid_, {LN_PropertyV2.layout_search_building_orig, BIPV2.IDlayouts.l_xlink_ids, 
string2		ln_party_status,
string6		ln_percentage_ownership,
string2		ln_entity_type,
string8		ln_estate_trust_date,
string1		ln_goverment_type,
integer2	xadl2_weight,
string2 	Addr_ind,
string1 	Best_addr_ind,
unsigned6 addr_tx_id,
string1   best_addr_tx_id,
unsigned8	Location_id,
string1   best_locid});

//filtering by [ln_fares_id[1] != 'R'] produces FCRA compliant data
in_file := DISTRIBUTE(append_puid(ln_fares_id <> ''), HASH(ln_fares_id));
d:= in_file(ln_fares_id[1] != 'R');

d patch_deed_dates(d le, file_deed ri) :=
TRANSFORM
  patch_date := ri.recording_date;
  SELF.process_date := IF((unsigned)patch_date=0,le.process_date,patch_date);
  SELF := le;
END;
deed_check := JOIN(d(ln_fares_id[2]<>'A'), DISTRIBUTE(file_deed(ln_fares_id[1] != 'R'),HASH(ln_fares_id)),
                   LEFT.ln_fares_id=RIGHT.ln_fares_id, patch_deed_dates(LEFT,RIGHT),KEEP(1),LOCAL);

d patch_assess_dates(d le, file_assessment ri) :=
TRANSFORM
  patch_date := IF(ri.recording_date != '', ri.recording_date, ri.sale_date);
  SELF.process_date := IF((unsigned)patch_date=0,le.process_date,patch_date);
  SELF := le;
END;
assessment_check := JOIN(d(ln_fares_id[2]='A'), DISTRIBUTE(file_assessment(ln_fares_id[1] != 'R'),HASH(ln_fares_id)), 
                         LEFT.ln_fares_id=RIGHT.ln_fares_id, patch_assess_dates(LEFT,RIGHT),KEEP(1),LOCAL);

all_check := deed_check+assessment_check;

base_file0 := if(IsFCRA, all_check, in_file);
LN_PropertyV2_Fast.FCRA_compliance_MAC(isFCRA,base_file0,file_out);
base_file := file_out;

key_name := Constants.keyServerPointer+ if(isFCRA, KeyName_fcra, KeyName) + doxie.Version_SuperKey + '::search.fid';
									
return_file		:= INDEX(base_file,{ln_fares_id, which_orig, source_code_2 := source_code[2], source_code_1 := source_code[1]},
											{base_file},
											key_name);
													
return(return_file); 		

END;