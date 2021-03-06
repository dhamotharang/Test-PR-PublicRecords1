import doxie_crs, ut, doxie_Raw, header;

doxie.MAC_Header_Field_Declare()

res := doxie_crs.layout_deathfile_records;

wide_subj := Doxie_Raw.death_raw(doxie.Get_Dids(), , dateVal, dppa_purpose, glb_purpose, ssn_mask_value);

wide_RNA := Doxie_Raw.death_raw(doxie.Get_RNA_DIDs, , dateVal, dppa_purpose, glb_purpose, ssn_mask_value, header.constants.CheckRNA);

wide := if (isCRS, sort(wide_subj + wide_RNA,whole record), wide_subj);

export Deathfile_Records := project(wide, res);