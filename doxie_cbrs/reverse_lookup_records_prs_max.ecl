IMPORT doxie,doxie_cbrs;
doxie_cbrs.mac_Selection_Declare()
EXPORT reverse_lookup_records_prs_max(DATASET(doxie_cbrs.layout_references) bdids,
                                      doxie.IDataAccess mod_access
                                     ) := FUNCTION
                                     
r := doxie_cbrs.reverse_lookup_records_prs(bdids,mod_access,Include_ReversePhone_val,Max_ReverseLookup_val)(Return_ReversePhone_val AND NOT past_max);

//gonna lop it off for exactly max
r lop(r l) := TRANSFORM
	overshot := l.cumulative_count - max_reverselookup_val;
	SELF.listed_name_children := 
		IF(overshot < 0, 
			 l.listed_name_children,
			 CHOOSEN(l.listed_name_children, COUNT(l.listed_name_children) - overshot));
	SELF := l;
END;

RETURN PROJECT(r, lop(LEFT));
END;