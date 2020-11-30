EXPORT fn_filtPerms(ds_in, permissions_field, mod_access, allowInsurance = FALSE) := FUNCTIONMACRO
 
/*Variables from mod_access*/
local validGLB := mod_access.isValidGLB();														 
local pre_glb_flag := mod_access.isPreGLBRestricted();
local validDPPA := mod_access.isValidDPPA();
local dppa_purpose_value := mod_access.dppa;
local allow_eq := ~mod_access.isEQCHRestricted(); 
local allow_en := ~mod_access.isECHRestricted();
local allow_tu := ~mod_access.isTCHRestricted();
local allow_ut := ~mod_access.isUtility();
local allow_ins := allowInsurance;
local allow_probation_src := mod_access.no_scrub;
local allow_dmv := ~mod_access.suppress_dmv;
local class_marketing := mod_access.isDirectMarketing();
local class_d2c := mod_access.isConsumer();
local class_resellers := mod_access.isResellerAccount();

/*-------------------------*/

local perms := Consumer_Header_Best.Permissions;

local bits_provided := IF(validGLB, perms.all_glb,0) +
											 IF(~pre_glb_flag, perms.bitmap.preglb,0) +
											 IF(validDPPA, perms.all_dppa -
												CASE(dppa_purpose_value, 1 => perms.bitmap.dppa1,
																								 2 => perms.bitmap.dppa2,
																								 3 => perms.bitmap.dppa3,
																								 4 => perms.bitmap.dppa4,
																								 5 => perms.bitmap.dppa5,
																								 6 => perms.bitmap.dppa6,
																								 7 => perms.bitmap.dppa7,
																								 0),0) +
											 IF(allow_eq, perms.bitmap.equifax,0) +
											 IF(allow_en, perms.bitmap.experian,0) +
											 IF(allow_tu, perms.bitmap.transunion,0) +
											 IF(allow_ut, perms.bitmap.utility,0) +
											 IF(allow_ins, perms.bitmap.insurance,0) +
											 perms.bitmap.other_src +
											 IF(allow_probation_src, perms.bitmap.src_probation,0) +
											 IF(allow_dmv, perms.bitmap.dmv_restricted,0) +
											 IF(class_marketing, ~perms.bitmap.marketing,perms.bitmap.marketing) +
											 IF(class_d2c, ~perms.bitmap.d2c,perms.bitmap.d2c) +
											 IF(class_resellers, ~perms.bitmap.resellers,perms.bitmap.resellers);

local bits_provided_ignore := bits_provided & perms.compare_ignore;
local bits_provided_retain := bits_provided & perms.compare_retain;

local output_layout := #IF(#TEXT(permissions_field) = '')
                           {DATASET({unsigned8 permissions}) permissions_ds, recordof(ds_in)};
                       #ELSE
                           recordof(ds_in);
											 #END

local input_dataset := PROJECT(ds_in,TRANSFORM(output_layout, self.permissions_ds := #IF(#TEXT(permissions_field) = '') DATASET([],{unsigned8 permissions}) #ELSE left.permissions_field #END, self:=left));

//Adjust for unique handling of pre-glb
local adjust_bits(unsigned8 bits_in) := FUNCTION
	bits_out := IF(perms.bit_test(bits_in,perms.bitmap.preglb) AND
									(~perms.bit_test(bits_in,perms.all_glb) OR perms.bit_test(bits_provided_ignore,perms.all_glb)),
										bits_in - perms.bitmap.preglb, bits_in);
	RETURN bits_out;
END;	

local filters_applied := input_dataset(
												EXISTS(permissions_ds(
													((adjust_bits(permissions) & perms.compare_ignore) & bits_provided_ignore = (adjust_bits(permissions) & perms.compare_ignore)) 
													AND ((permissions & perms.compare_retain) & bits_provided_retain > 0))));

RETURN filters_applied;

ENDMACRO;