/*2007-06-05T22:15:46Z (kevin logemann)
bug 24754 -- passing current_year to DL_Raw
*/
import doxie, doxie_build, Doxie_Raw;

boolean random_value := false : STORED('Randomize');
doxie.MAC_Header_Field_Declare()
doxie.MAC_Selection_Declare()

dids := IF (did_value = '', 
            PROJECT (doxie.get_dids(), doxie.layout_references),
            DATASET ([{did_value}], doxie.layout_references)) (Include_DriversLicenses_val);


outf2 := Doxie_Raw.DL_Raw(dids,
    dateVal,
    dppa_purpose,
    glb_purpose,
		ln_branded_value,
    race_value,
    gender_value,
		0, // current_year, not used.
    find_year_low,
    find_year_high,
    state_value,
    MaxResults_val,
    MaxResultsThisTime_val,
    random_value,
    dl_value,
    ssn_mask_value,
    dl_mask_value);
export dl_Search_local := 

#if(doxie_build.buildstate NOT IN ['PA','PUBLIC'])
dataset([],Layout_DlSearch);
#else
outf2(dppa_ok);
#end