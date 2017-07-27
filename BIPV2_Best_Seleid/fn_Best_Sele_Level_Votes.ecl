EXPORT fn_Best_Sele_Level_Votes (STRING source,INTEGER Dups):=
MAP(source[47] = '1' => 10000 * dups,
    source[46] = '1' => 5000 * dups,
    dups);