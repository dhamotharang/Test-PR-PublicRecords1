import corrections;

EXPORT Layout_Base_Offenses_with_OffenseCategory := record

corrections.layout_offense;
// unsigned8  offense_category; //commented as this field is being added to the keys so it was added to layout_offense.
string8    Hyg_classification_code;
string8    Old_ln_Offense_score;
end;