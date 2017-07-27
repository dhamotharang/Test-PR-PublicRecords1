export Phone_Match_Score(string phone1, string phone2) := 
map(phone1='' or phone2='' => 255,
    phone1[4..10] = phone2[4..10]=>100,0);