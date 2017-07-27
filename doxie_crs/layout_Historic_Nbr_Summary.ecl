export layout_Historic_Nbr_Summary := record
	unsigned2    seq;
	qstring10    prim_range;
	qstring28    prim_name;
	qstring8     sec_range;
	unsigned6    did;
	unsigned2	   distance;
	string10	   phone;
  boolean HasCriminalConviction := false;
  boolean IsSexualOffender := false;
  end;