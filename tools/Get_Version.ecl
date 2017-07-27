EXPORT Get_Version(string pversion) := regexreplace('^([[:digit:]]{8}[[:alpha:]]?).*$',pversion,'$1',nocase);
