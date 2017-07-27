import uccsearch, UCCD;

k1 := buildindex(uccsearch.key_collateral);
k2 := buildindex(uccsearch.key_debtor);
k3 := buildindex(uccsearch.key_events);
k4 := buildindex(uccsearch.key_secured);
k5 := buildindex(uccsearch.key_summary);


export proc_build_report := sequential(k1,k2,k3,k4,k5);




