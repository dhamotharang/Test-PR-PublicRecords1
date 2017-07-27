vn := Vanity_Companies;
cn := join( company_names, vn, left.company_name=right.company_name, transform(left),hash,left only );

export Company_Names_Only := cn;
