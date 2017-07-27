export proc_build_extract_Carfax(string filedate):= function

d := FLAccidents_Ecrash.BaseFile(loss_state_abbr in FLAccidents_Ecrash.set_st);

FLAccidents_Ecrash.Layout_Carfax_output trecs(d L) := transform
self.date_of_loss    := L.crash_date;
self.report_number	 := L.case_identifier;
self.report_type     := L.report_code[2];
self.city_of_loss    := L.crash_city;
self.state_of_loss   := L.loss_state_abbr;
self.order_id			   := L.CRU_Order_ID;
self.sequence_nbr	   := '0';
self.vin_status		   := L.vin_status; //map(L.vin_status != '' => L.vin_status, L.Other_VIN_status) ;
self.tag_number		   := if(L.License_Plate != '', L.License_Plate, L.Other_Unit_License_Plate);;
self.tag_state		   := if(L.Registration_State != '', L.Registration_State, L.Other_Unit_Registration_State);
self.make 				   := if(L.make_description != '',L.make_description,L.make);
self.year 				   := if(L.model_year != '',L.model_year,L.model);
self.model				   := if(L.model_description != '',L.model_description,L.model);
self.airbags_deploy  := L.AirBags_Deployed_Derived;
self.towed				   := L.Vehicle_Towed_Derived;
self.impact_location := if(L.Damaged_Areas_Derived1 !='','Damaged_Area_1: ' + L.Damaged_Areas_Derived1,'')
												+ if(L.Damaged_Areas_Derived2 !='','Damaged_Area_2: ' + L.Damaged_Areas_Derived2,'');
self :=L;
end;

precs := dedup(project(d,trecs(left)),record,all);


return
sequential(
	 output(precs,,'~thor_data400::out::ecrash::'+filedate+'::extract::carfax'
												,csv(terminator('\n')
												,separator(','))
												,overwrite)
	,fileservices.Despray('~thor_data400::out::ecrash::'+filedate+'::extract::carfax'
												, 'edata12-bld.br.seisint'
												, '/super_credit/ecrash/carfax/ecrash_'+filedate+'_extract_carfax.csv')
					);

end;