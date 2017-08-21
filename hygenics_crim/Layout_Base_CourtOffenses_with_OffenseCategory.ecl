import corrections;

EXPORT Layout_Base_CourtOffenses_with_Offensecategory := record
       
corrections.layout_courtoffenses;
// unsigned8  offense_category; //commented as this field is being added to the keys so it was added to layout_court_offense.
string8    Hyg_classification_code;
string8    Old_ln_Offense_score;
end;