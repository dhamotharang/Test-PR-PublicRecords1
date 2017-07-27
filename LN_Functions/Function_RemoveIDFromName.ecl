export Function_RemoveIDFromName(string pStringIn) :=
stringlib.stringfindreplace(
 stringlib.stringfindreplace(
  stringlib.stringfindreplace(
   stringlib.stringfindreplace(
    stringlib.stringfindreplace(
     stringlib.stringfindreplace(
      stringlib.stringfindreplace(
       stringlib.stringfindreplace(
        stringlib.stringfindreplace(
         stringlib.stringfindreplace(
          stringlib.stringfindreplace(
           stringlib.stringfindreplace(
            stringlib.stringfindreplace(
             stringlib.stringfindreplace(
              stringlib.stringfindreplace(
               stringlib.stringfindreplace(
                stringlib.stringfindreplace(
                 stringlib.stringfindreplace(
                  stringlib.stringfindreplace(
                   stringlib.stringfindreplace(
                    stringlib.stringfindreplace(
                     stringlib.stringfindreplace(
                      stringlib.stringfindreplace(
                       stringlib.stringfindreplace(
                        stringlib.stringfindreplace(
                         stringlib.stringfindreplace(
                          stringlib.stringfindreplace(
                           stringlib.stringfindreplace(
                            stringlib.stringfindreplace(
                             stringlib.stringfindreplace(
                              stringlib.stringfindreplace(
                               stringlib.stringfindreplace(
                                stringlib.stringfindreplace(
                                 stringlib.stringfindreplace(
                                  stringlib.stringfindreplace(
                                   stringlib.stringfindreplace(
                                    stringlib.stringfindreplace(
										stringlib.stringtouppercase(pStringIn),
									' (TENANT)',' '),
								   ' (SOLE OWNER)',' '),
								  ' (HER HUSBAND)',' '),
								 ' (COMPANY/CORPORATION)',' '),
								' (WIDOW/WIDOWER)',' '),
							   ' (PARTNERSHIP)',' '),
							  ' (GOVERNMENT)',' '),
							 ' (MINOR/GUARDIAN)',' '),
							' (EXECUTOR)',' '),
						   ' F/K/A',' '),
						  ' D/B/A',' '),
						 ' A/K/A',' '),
						' (MARRIED WOMAN AS HER SOLE AND SEPARATE PROPERTY)',' '),
					   ' (SINGLE OR UNMARRIED WOMAN)',' '),
					  ' (MARRIED MAN AS HIS SOLE AND SEPARATE PROPERTY)',' '),
					 ' (SINGLE OR UNMARRIED MAN)',' '),
					' (HUSBAND AND WIFE)',' '),
				   ' (RIGHT OF SURVIVORSHIP)',' '),
				  ' (TRUST)',' '),
				 ' (JOINT SURVIVORSHIP)',' '),
				' (CONTRACT OWNER)',' '),
			   ' (TRUSTEE/CONSERVATOR)',' '),
			  ' (TENANTS BY ENTIRETY)',' '),
			 ' (TENANTS IN COMMON)',' '),
			' (REVOCABLE TRUST)',' '),
		   ' (LIVING TRUST)',' '),
		  ' (LIFE ESTATE)',' '),
		 ' (JOINT VENTURE)',' '),
		' (JOINT TENANCY)',' '),
	   ' (IRREVOCABLE TRUST)',' '),
	  ' (FAMILY TRUST)',' '),
	 ' ETUX',' '),
	' (ESTATE)',' '),
   ' ETAL',' '),
  ' (COMMUNITY PROPERTY)',' '),
 '; OWNER OCCUPIED',' '),
'OWNER OCCUPIED',' ');
;
/*
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),'; OWNER OCCUPIED',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' OWNER OCCUPIED',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (COMMUNITY PROPERTY)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' ETAL',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (ESTATE)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' ETUX',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (FAMILY TRUST)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (IRREVOCABLE TRUST)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (JOINT TENANCY)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (JOINT VENTURE)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (LIFE ESTATE)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (LIVING TRUST)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (REVOCABLE TRUST)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (TENANTS IN COMMON)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (TENANTS BY ENTIRETY)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (TRUSTEE/CONSERVATOR)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (CONTRACT OWNER)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (JOINT SURVIVORSHIP)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (TRUST)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (RIGHT OF SURVIVORSHIP)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (HUSBAND AND WIFE)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (SINGLE OR UNMARRIED MAN)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (MARRIED MAN AS HIS SOLE AND SEPARATE PROPERTY)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (SINGLE OR UNMARRIED WOMAN)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (MARRIED WOMAN AS HER SOLE AND SEPARATE PROPERTY)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' A/K/A',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' D/B/A',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' F/K/A',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (EXECUTOR)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (MINOR/GUARDIAN)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (GOVERNMENT)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (PARTNERSHIP)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (WIDOW/WIDOWER)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (COMPANY/CORPORATION)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (HER HUSBAND)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (SOLE OWNER)',' ');
stringlib.stringfindreplace(stringlib.stringtouppercase(pString),' (TENANT)',' ');
*/

