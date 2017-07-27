import doxie,LN_PropertyV2;

dAssess	:=	distribute(	LN_PropertyV2.File_Assessment(tax_year	!=	'',assessed_total_value	!=	'',tax_amount	!=	''),
												hash(ln_fares_id)
											);
dSearch	:=	distribute(	LN_PropertyV2.File_Search_DID(source_code[2]	=	'P',zip	!=	''),
												hash(ln_fares_id)
											);

rAssesSlim_layout	:=
record
	dSearch.zip;
	dAssess.tax_year;
	integer	assessed_total_value;
	integer	tax_amount;
end;

rAssesSlim_layout	tPropZip(dAssess	le,dSearch	ri)	:=
transform
	self.zip									:=	ri.zip;
	self.tax_year							:=	le.tax_year;
	self.assessed_total_value	:=	(integer)	le.assessed_total_value;
	self.tax_amount						:=	(integer)	le.tax_amount;
end;

res	:=	join(	dAssess,
							dSearch,
							left.ln_fares_id	=	right.ln_fares_id,
							tPropZip(left,right),
							keep(1),
							local
						);
	
res2	:=	res(tax_year	<>	'', zip	<>	'',assessed_total_value	<>	0,tax_amount	<>	0);

rOut_layout	:=
record
	res2.zip;
	res2.tax_year;
	integer8	avg_tax		:=	ave(group,res2.tax_amount);
	integer8	avg_value	:=	ave(group,res2.assessed_total_value);
end;

final	:=	table(res2,rOut_layout,res2.zip,res2.tax_year);

export key_tax_summary := index(final,{final},'~thor_data400::key::ln_propertyv2::'	+	doxie.Version_SuperKey	+	'::tax_summary');