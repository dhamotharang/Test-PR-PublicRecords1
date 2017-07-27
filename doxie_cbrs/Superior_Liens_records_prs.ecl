import Liens_Superior;

export Superior_Liens_records_prs := 
MODULE

supl := doxie_cbrs.Superior_Liens_Raw;

liens_superior.Layout_Liens_Superior_LNI tran(supl l) :=
TRANSFORM
	SELF := l;
END;
shared p := PROJECT(supl, tran(LEFT));

export records := p;
export records_count := count(p);

END;
