file_mbs := inquiry_acclogs.file_mbs.file;
file_fido := inquiry_acclogs.file_mbs.fido;

fn_filter_(integer allowflags_) :=              inquiry_acclogs.fnTranslations.is_SubMarketFilter(allowflags_) or
												inquiry_acclogs.fnTranslations.is_IndustryFilter(allowflags_) or
												inquiry_acclogs.fnTranslations.is_VerticalFilter(allowflags_) or
												inquiry_acclogs.fnTranslations.is_Disable_Observation(allowflags_) or
												inquiry_acclogs.fnTranslations.is_Internal(allowflags_) or
												inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allowflags_);
												
												
												
					fido_filter := file_fido(fn_filter_(allowflags));
									fido_no_filter := file_fido(~fn_filter_(allowflags));

												
					mbs_filter := file_mbs(fn_filter_(allowflags));
				

	fido_filter_companyid :=	dedup(sort(distribute(fido_filter(company_id <> ''),hash(company_id)), company_id, product_id, local),company_id, product_id,local);
			mbs_filter_companyid :=	dedup(sort(distribute(mbs_filter(id <>'' and idflag != 'GCID'),hash(id)), id, product_id,  -datelastseen, local),id,product_id, local);
fido_filter_gcid :=	dedup(sort(distribute(fido_filter(gc_id <> ''),hash(gc_id)), gc_id, local),gc_id,local);
fido_no_filter_gcid :=	dedup(sort(distribute(fido_no_filter(gc_id <> ''),hash(gc_id)), gc_id, local),gc_id,local);

			mbs_filter_gcid :=	dedup(sort(distribute(mbs_filter(id <>'' and idflag = 'GCID'),hash(id)), id,  -datelastseen, local),id, local);


count(fido_filter_gcid);
count(mbs_filter_gcid);
mbs_filter_gcid tjoin(mbs_filter_gcid le, fido_filter_gcid ri) := transform

self := le;

end;

fido_mbs_match := join(mbs_filter_gcid,
fido_filter_gcid, left.id = right.gc_id, tjoin(left,right), local);

output(fido_mbs_match);
count(fido_mbs_match);

file_mbs_only := join(mbs_filter_gcid,
fido_filter_gcid, left.id = right.gc_id, tjoin(left,right), left only, local);

output(file_mbs_only);
count(file_mbs_only);

temp_rec := record
file_mbs;
string mbs_company_name_fido;
string vertical_fido;
string submarket_fido;
string internal_fido;
string disable_observation_fido;
string industry_fido;
string translation_fido;

end;


temp_rec tjoin1(file_mbs_only le, fido_no_filter_gcid ri) := transform

self.mbs_company_name_fido := ri.mbs_company_name;
self.industry_fido := ri.industry;
self.translation_fido := ri.translation;
self.vertical_fido := ri.vertical;
self.submarket_fido := ri.sub_market;
self.internal_fido := ri.internal_flag;
self.disable_observation_fido := ri.disable_observation;
self := le;

end;

file_mbs_only_ := join(file_mbs_only,fido_no_filter_gcid, left.id = right.gc_id,tjoin1(left,right), local);
file_mbs_only__:= join(file_mbs_only,fido_no_filter_gcid, left.id = right.gc_id,tjoin1(left,right), left only, local);

output(file_mbs_only_, all);


output(file_mbs_only__(length(id) > 10));
count(file_mbs_only__(length(id) > 10));

output(file_mbs_only__(length(id) <= 10 and product_id in ['1', '2', '5', '7']), all);
count(file_mbs_only__(length(id) <= 10 and product_id in ['1', '2', '5', '7']));





