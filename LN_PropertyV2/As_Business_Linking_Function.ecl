IMPORT Address, ut, Business_Header;
/////////////////////////////////////////////////////////////////////////////////////////
// -- As_Business_Linking_Function
// -- Parameters:
// -- 	bhdr_data:		input dataset for business headers already mapped into the 
// --					layout_business_header layout
// -- 	use_filter:		filter created for the LN property file to remove the many
// --					non businesses(family, trusts, estates, wills, etc)
// -- 	fix_company_nam:	Fixes records with DBA and/or Lessor/Lessee in the name
/////////////////////////////////////////////////////////////////////////////////////////
EXPORT As_Business_Linking_Function(
       DATASET(Business_Header.Layout_Business_Linking.Company_) blnk_data, 
	  BOOLEAN use_filter       = TRUE, 
	  BOOLEAN fix_company_name = TRUE
	  ) := FUNCTION

numset := ['0','1','2','3','4','5','6','7','8','9'];
bl_layout := Business_Header.Layout_Business_Linking.Company_;

/////////////////////////////////////////////////////////////////////////////////////////
// -- RemoveEnd Function
// -- Code to remove garbage from end of line
/////////////////////////////////////////////////////////////////////////////////////////
STRING RemoveEnd(STRING s) := FUNCTION
	STRING rs := TRIM(Stringlib.StringReverse(s));
	STRING lw := Stringlib.StringReverse(TRIM(rs[1..(Stringlib.StringFind(rs, ' ', 1) - 1)]));
	STRING ts := TRIM(Stringlib.StringReverse(TRIM(rs[(Stringlib.StringFind(rs, ' ', 1)+1)..])));

	STRING res2 := IF(((lw[1] = '(' AND lw[length(TRIM(lw))] = ')') OR
                  (lw[1] IN numset AND lw[length(TRIM(lw))] IN numset) OR
		Stringlib.StringFilterOut(lw, '0123456789!@#$%^&*()_-=+{}|<>?,.') = '') AND lw[1] <> '#', 
                 ts, s);
	STRING res := IF(stringlib.stringfind(res2, '#',1) != 0, res2, REGEXREPLACE('[0-9 !@#$%^&*()_=+{}|<>?,.-]+$',res2,''));
     
	RETURN res;
END;

alphaset := ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q',
			 'R','S','T','U','V','W','X','Y','Z'];

/////////////////////////////////////////////////////////////////////////////////////////
// -- fixlessor Function
// -- Take out LESSEE, LESSOR, LSE, LSR from the string
/////////////////////////////////////////////////////////////////////////////////////////
STRING fixlessor(STRING s) := FUNCTION

	INTEGER slength := LENGTH(s);
	/////////////////////////////////////////////////////////////////////////////////////////
	// -- Find strings 'LSR', 'LESSOR', 'LSE', 'LESSEE' in string
	// -- and make sure they are not part of a larger word
	/////////////////////////////////////////////////////////////////////////////////////////
	INTEGER lsrmatchindex := stringlib.stringfind(s,'LSR',1);
	BOOLEAN lsrbyitself   := MAP(lsrmatchindex > 1 AND lsrmatchindex < slength AND s[lsrmatchindex - 1] NOT IN alphaset AND s[lsrmatchindex + 3] NOT IN alphaset => TRUE,
		                       lsrmatchindex = 1 AND s[lsrmatchindex + 3] NOT IN alphaset => TRUE, FALSE);
		
	INTEGER lessormatchindex := stringlib.stringfind(s,'LESSOR',1);
	BOOLEAN lessorbyitself   := MAP(lessormatchindex > 1  AND lessormatchindex < slength AND s[lessormatchindex - 1] NOT IN alphaset AND s[lessormatchindex + 6] NOT IN alphaset => TRUE,
		                          lessormatchindex = 1 AND s[lessormatchindex + 6] NOT IN alphaset => TRUE, FALSE);

	INTEGER lsematchindex := stringlib.stringfind(s,'LSE',1);
	BOOLEAN lsebyitself   := MAP(lsematchindex > 1 AND lsematchindex < slength AND s[lsematchindex - 1] NOT IN alphaset AND s[lsematchindex + 3] NOT IN alphaset => TRUE,
		                       lsematchindex = 1 AND s[lsematchindex + 3] NOT IN alphaset => TRUE, FALSE);
		
	INTEGER lesseematchindex  := stringlib.stringfind(s,'LESSEE',1);
	BOOLEAN lessebyitself   	:= MAP(lesseematchindex > 1 AND lesseematchindex < slength AND s[lesseematchindex - 1] NOT IN alphaset AND s[lesseematchindex + 6] NOT IN alphaset => TRUE,
		                           lesseematchindex = 1 AND s[lesseematchindex + 6] NOT IN alphaset => TRUE, FALSE);

	/////////////////////////////////////////////////////////////////////////////////////////
	// -- If both LSE, LSR or LESSOR, LESSEE are in the string, blank it out(needs improvement)
	// -- else, remove the LSE, LSR or LESSOR, LESSEE from the string
	/////////////////////////////////////////////////////////////////////////////////////////
	STRING res := MAP(lsrmatchindex = 0 AND lessormatchindex = 0 AND lsematchindex = 0 AND lesseematchindex = 0 => s,
		lsrmatchindex > 0 AND lsrbyitself AND lsematchindex > 0 AND lsebyitself => '',
		lessormatchindex > 0 AND lessorbyitself AND lesseematchindex > 0 AND lessebyitself => '',

		lsrmatchindex > 0 AND lsrbyitself       => IF(lsrmatchindex = 1, 	s[5.. ], s[1..(lsrmatchindex - 1)]),
		lessormatchindex > 0 AND lessorbyitself => IF(lessormatchindex = 1, s[8.. ], s[1..(lessormatchindex - 1)]),
		lsematchindex > 0 AND lsebyitself       => IF(lsematchindex = 1, 	s[5.. ], s[1..(lsematchindex - 1)]),
		lesseematchindex > 0 AND lessebyitself  => IF(lesseematchindex = 1, s[8.. ], s[1..(lesseematchindex - 1)]), s);

	RETURN res;
END;

/////////////////////////////////////////////////////////////////////////////////////////
// -- fixdba Function
// -- Remove DBA from the string
/////////////////////////////////////////////////////////////////////////////////////////
STRING fixdba(STRING s) := FUNCTION
	INTEGER dbamatchindex 	:= stringlib.stringfind(s,'DBA',1);
	BOOLEAN dbabyitself   	:= MAP(dbamatchindex > 1 AND s[dbamatchindex - 1] NOT IN alphaset AND s[dbamatchindex + 3] NOT IN alphaset => TRUE,
		                         dbamatchindex = 1 AND s[dbamatchindex + 3] NOT IN alphaset => TRUE, FALSE);
	STRING  res 		      	:= MAP(dbamatchindex = 0 => s,
	                       	dbamatchindex > 0 AND dbabyitself => IF(dbamatchindex = 1, 	s[5.. ], s[1..(dbamatchindex - 1)]), s);
	
	RETURN res;
END;

/////////////////////////////////////////////////////////////////////////////////////////
// -- Company Name filter to filter out most non-businesses
// -- TRUSTS, FAMILY, WILL OF, etc.
// -- name length > 5, zip and prim_name populated, 
/////////////////////////////////////////////////////////////////////////////////////////
// -- figure out if it is a business, person, or both. Recs with NameType = 'B' are business records
// -- other type records are dropped.
Address.Mac_Is_Business(blnk_data,company_name,blnk_data_nameType);

dblAsBusLnkCompanies		:=	IF(use_filter, blnk_data_nameType(nameType = 'B',
																															LENGTH(TRIM(company_name)) >= 5,
																															~((INTEGER)company_address.zip = 0 and company_address.prim_name = ''),
																															stringlib.stringfind(company_name,'00000',1) = 0,
																															stringlib.stringfilterout(company_name,'1234567890-') 	!= '',
																															stringlib.stringfilterout(company_name,'1234567890- ') != 'TU',
																															(stringlib.stringfind(company_name,'TRUST',		 1) =  0 or
																															 stringlib.stringfind(company_name,'BANK',		 1) != 0),
																															stringlib.stringfind(company_name,'FAMILY',		 1) =  0,
																															stringlib.stringfind(company_name,' TSTEE',		 1) =  0,
																															stringlib.stringfind(company_name,'ESTATE OF',	 1) =  0,
																															stringlib.stringfind(company_name,'WILL OF',		 1) =  0,
																															stringlib.stringfind(company_name,'UNKNOWN SPOUSE',1) =  0,
																															stringlib.stringfind(company_name,'NOT AVAILABLE', 1) =  0,
																															stringlib.stringfind(company_name,'NOT AVAIL', 1) =  0),
															 blnk_data_nameType);
								

							
bl_layout fixcompanyname(dblAsBusLnkCompanies L) := TRANSFORM
	SELF.company_name 	:= IF(stringlib.stringfind(L.company_name,'%',1) > 0, 
						fixdba(fixlessor(removeend(l.company_name[1..(stringlib.stringfind(l.company_name,'%',1) - 1)]))),
						fixdba(fixlessor(removeend(l.company_name))));
	SELF 			:= L;
end;


dblAsBusLnkCompanies_fixed := IF(fix_company_name,
                                PROJECT(dblAsBusLnkCompanies, fixcompanyname(LEFT)), PROJECT(dblAsBusLnkCompanies,bl_layout));
								
// dblAsBusLnkCompaniesDedup  := DEDUP(dblAsBusLnkCompanies_fixed(company_name != ''),
                              // company_name,vl_id,company_address.prim_name,company_address.prim_range,ALL);	// we don't really have to dedup as the RIDing technology does that

RETURN dblAsBusLnkCompanies_fixed;

END;