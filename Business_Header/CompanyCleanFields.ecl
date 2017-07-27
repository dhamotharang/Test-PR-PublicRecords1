export CompanyCleanFields(string120 CleanCompanyName, boolean needsCleaning = false) :=
MODULE

shared cn := if(needsCleaning, datalib.companyclean(CleanCompanyName), CleanCompanyName);

export string40 indicative 	:= cn[1..40];
export string40 secondary 	:= cn[41..80];
export string40 furniture 	:= cn[81..120];

END;