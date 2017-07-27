import ut;

export lien_is_ok(STRING8 today, STRING8 filing_date) := 
ut.DaysApart(today,filing_date) < ut.DaysInNYears(7);