EXPORT boolean fn_cname(string s) := length(trim(s))>2;
//EXPORT boolean fn_cname(string s) := length(trim(regexreplace('\\[|\\]|/|\\.|,|\\+|!|=|\\"|\\^|<|>|\\{|\\}',s,' '),LEFT, RIGHT))>2;