export CleanCompany(string s) := trim(datalib.companyclean(s)[1..40])+' '+datalib.companyclean(s)[41..80];
