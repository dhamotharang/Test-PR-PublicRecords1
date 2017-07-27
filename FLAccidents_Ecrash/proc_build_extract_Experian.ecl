export proc_build_extract_Experian(string filedate):= function

d := FLAccidents_Ecrash.BaseFile(loss_state_abbr in set_st);

FLAccidents_Ecrash.Layout_Experian_output trecs(d L) := transform
self.date_of_loss  := L.crash_date;
self.report_number := L.case_identifier;
self.report_type   := L.report_code;
self.city_of_loss  := L.crash_city;
self.state_of_loss := L.loss_state_abbr;
self.order_id			 := L.CRU_Order_ID;
self.sequence_nbr	 :='0';
self.vin_status		 :=L.vin_status; //map(L.vin_status != '' => L.vin_status, L.Other_VIN_status) ;
self.tag_number		 := if(L.License_Plate != '', L.License_Plate, L.Other_Unit_License_Plate);;
self.tag_state		 := if(L.Registration_State != '', L.Registration_State, L.Other_Unit_Registration_State);
self.make 				 := if(L.make_description != '',L.make_description,L.make);
self.year 				 := if(L.model_year != '',L.model_year,L.model);
self.model				 := if(L.model_description != '',L.model_description,L.model);
self :=L;
end;

precs := dedup(project(d,trecs(left)),record,all);

return
sequential(
	 output(precs,,'~thor_data400::out::ecrash::'+filedate+'::extract::experian'
												,csv(terminator('\n')
												,separator(','))
												,overwrite)
	,fileservices.Despray('~thor_data400::out::ecrash::'+filedate+'::extract::experian'
												, 'edata12-bld.br.seisint'
												, '/super_credit/ecrash/carfax/ecrash_'+filedate+'_extract_experian.csv')
					);
end;