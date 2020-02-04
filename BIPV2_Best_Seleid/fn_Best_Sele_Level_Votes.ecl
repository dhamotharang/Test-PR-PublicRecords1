EXPORT fn_Best_Sele_Level_Votes (STRING source,INTEGER Dups):=
MAP(source[47] = '1' => 1 * dups * if(source[49]='1', 1.5, 1.0),
    source[46] = '1' => 10 * dups * if(source[49]='1', 1.5, 1.0),
    dups * if(source[49]='1', 1.5, 1.0));