Import Data_Services, doxie;

d_base := distribute(marriage_divorce_v2.file_mar_div_base,hash(record_id));
d_srch := marriage_divorce_v2.file_mar_div_search;

r_slim_srch := record
 d_srch.record_id;
 d_srch.st;
end;

r_slim_srch t_slim_srch(d_srch le) := transform
 self := le;
end;

p_slim_srch := distribute(dedup(project(d_srch(st<>''),t_slim_srch(left)),record),hash(record_id));

r0 := record
 d_base;
 p_slim_srch.st;
end;

r0 t_get_per_st(d_base le, p_slim_srch ri) := transform
 self := le;
 self := ri;
end;

j1 := join(d_base,p_slim_srch,
           left.record_id=right.record_id,
		   t_get_per_st(left,right),
		   local
		  );

r1 := record
 unsigned6 record_id;
 string1   filing_type;
 string15  filing_subtype;
 string2   state_origin;
 string25  filing_number;
 string35  county;
end;

r1 t_norm(j1 le, integer c) := transform
 self.state_origin  := choose(c,le.state_origin,le.st,
                                le.state_origin,le.st
						     );
 self.filing_number := choose(c,le.marriage_filing_number,le.divorce_filing_number,
                                le.divorce_filing_number,le.marriage_filing_number
							 );
 self.county        := choose(c,le.marriage_county,le.divorce_county,
                                le.divorce_county,le.marriage_county);
 self               := le;
end;

p_norm := normalize(j1,4,t_norm(left,counter))(filing_number<>'');

r1 t_unformat(r1 le) := transform
 self.filing_number := stringlib.stringfilter(stringlib.stringtouppercase(le.filing_number),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
 self               := le;
end;

p_unformat := dedup(sort(project(p_norm,t_unformat(left)),record),record);

p_unformat_no_blanks := p_unformat(trim(filing_number) <> '');

export key_mar_div_filing_nbr :=
index(p_unformat_no_blanks,
      {filing_number,filing_type,filing_subtype,state_origin,county},{record_id},
      Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::mar_div::'+doxie.Version_SuperKey+'::filing_nbr'
	 );