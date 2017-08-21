import data_services;

priors      :=  dataset(data_services.foreign_prod+ 'thor_200::in::crim::HD::county_priors',
								layout_in_priors,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(2000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID' and StateCode in _include_states);
										
priors_cw   :=  dataset(data_services.foreign_prod+'thor_200::in::crim::county_priors_cw',
								layout_in_priors,
								CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(6000)))  (stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');// and StateCode in _include_states);
proj_prior_cw := Project(priors_cw,transform(hygenics_crim.layout_in_priors,self.sourcename := trim(left.sourcename)+'_CW'; self := left;));

export file_in_priors_counties := priors+proj_prior_cw;									