// Filter out bad states
Bad_State_List := ['OK','SD'];

// Check valid range of filing dates
EXPORT BOOLEAN Check_Valid_State_Filing_Date(STRING2 file_state, STRING8 filing_date) :=
       MAP(file_state IN Bad_State_List OR
             (file_state = 'PA' AND (((INTEGER)(filing_date[1..4])) < 1900 OR
               ((INTEGER)(filing_date[1..6])) > ((INTEGER)((StringLib.GetDateYYYYMMDD())[1..6])))) => FALSE,
           TRUE);