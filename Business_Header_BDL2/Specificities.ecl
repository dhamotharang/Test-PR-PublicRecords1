//specificities

import ut,SALT;
export specificities(dataset(Layout_BH_BDL) h) := MODULE

export input_layout := record // project out required fields
  unsigned6 BDL := h.BDL; // using existing id field
  h.RCID;//RIDfield 
  h.GROUP_ID;
  typeof(h.COMPANY_NAME) COMPANY_NAME := Fields.Make_COMPANY_NAME((string)h.COMPANY_NAME ); // Cleans before using
END;
r := input_layout;

h01 := distribute(table(h,r),BDL); // group for the specificity_local function
input_layout do_computes(h01 le) := transform
  self := le;
end;
shared h0 := project(h01,do_computes(left));

export input_file := h0  : persist('temp::Business_header_BDL2::BDL_Specificities_Cache');

  SALT.MAC_Specificity_Local(input_file,GROUP_ID,BDL,GROUP_ID_nulls,Layout_Specificities.GROUP_ID_ChildRec,GROUP_ID_specificity,GROUP_ID_switch,GROUP_ID_values,false);
  o := GROUP_ID_values; // place holder for fuzzy logic
export GROUP_ID_values_persisted := o : persist('temp::values::Business_Header_BDL2::BDL_GROUP_ID');

  SALT.MAC_Specificity_Local(input_file,COMPANY_NAME,BDL,COMPANY_NAME_nulls,Layout_Specificities.COMPANY_NAME_ChildRec,COMPANY_NAME_specificity,COMPANY_NAME_switch,COMPANY_NAME_values,false);
  o := COMPANY_NAME_values; // place holder for fuzzy logic
// This field is a word bag; so create specifcities for the words too
  SALT.Mac_Specificity_Local(input_file,COMPANY_NAME,BDL,COMPANY_NAME_words_nulls,Layout_Specificities.COMPANY_NAME_ChildRec,COMPANY_NAME_words_specificity,COMPANY_NAME_words_switch,COMPANY_NAME_words_values,false,true);
export COMPANY_NAME_values_key := index(COMPANY_NAME_words_values,{COMPANY_NAME},{COMPANY_NAME_words_values},'~thor_data400::key::values::Business_Header_BDL2::BDL_COMPANY_NAME');
  SALT.mac_wordbag_addweights(COMPANY_NAME_values,COMPANY_NAME,COMPANY_NAME_words_values,p);
export COMPANY_NAME_values_persisted := p : persist('temp::values::Business_Header_BDL2::BDL_COMPANY_NAME');

export Specificities := dataset([{0,GROUP_ID_specificity,GROUP_ID_switch,GROUP_ID_nulls,COMPANY_NAME_specificity,COMPANY_NAME_switch,COMPANY_NAME_nulls}],Layout_Specificities.R) : persist('Business_Header_BDL2::BDL::Specificities');
  end;