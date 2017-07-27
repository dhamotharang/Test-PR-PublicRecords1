cp(string s) := stringlib.stringtouppercase(s) IN Countries or
                stringlib.stringtouppercase(s) IN Countries_Poss;

export PATTERN Nationality := validate(word opt(' ' word OPT(' ' word)), cp(Matchtext)) opt('\'s');