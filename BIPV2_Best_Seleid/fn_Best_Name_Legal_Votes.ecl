import BIPV2_Best_Proxid;
export fn_Best_Name_Legal_Votes (STRING source,INTEGER Dups) :=
map(source[48] = '1' and source[47] = '1' => 3000* dups,
    source[48] = '1' and source[46] = '1' => 2000* dups,
     source[48] = '1' => 1000 *dups, dups);