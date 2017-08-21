export macro_ck_pop_bs(date, adate, fcra) := macro
#workunit('name','Bocashell Tracking Populated Fields');
#option ('hthorMemoryLimit', 1000)

IMPORT Risk_Indicators;

//===================  input file  ======================
infile :=  '~nmontpetit::out::first_inv_'+(string)fcra+'_'+(string)date+'_'+(string)adate;

ds_infile := dataset(infile, risk_indicators.Layout_Boca_Shell_Edina, csv(quote('"'), maxlength(32000)));

layout_res := RECORD
	integer source_verification_tu_count;
	integer bjl_bankrupt;
	integer bjl_liens_recent_unreleased_count;
	integer bjl_liens_historical_unreleased_count;
	integer bjl_liens_recent_released_count;
	integer bjl_liens_historical_released_count;
	integer bjl_criminal_count;
	integer bjl_felony_count;
	integer bjl_foreclosure_flag;
	integer relatives_relative_count;
	integer vehicles_current_count;
	integer vehicles_historical_count;
	integer watercraft_watercraft_count;
	integer student_file_type;
	integer professional_license_professional_license_flag;
	integer address_verification_owned_property_total;
	integer address_verification_sold_property_total;
	integer address_verification_ambiguous_property_total;
end;	
 
layout_res ck_pop(ds_infile le) := TRANSFORM
 	self.source_verification_tu_count                                      := (integer)((integer)le.source_verification.tu_count != 0);
	self.address_verification_owned_property_total                         := (integer)((integer)le.address_verification.owned.property_total != 0);
	self.address_verification_sold_property_total                          := (integer)((integer)le.address_verification.sold.property_total != 0);
	self.address_verification_ambiguous_property_total                     := (integer)((integer)le.address_verification.ambiguous.property_total != 0);
	self.bjl_bankrupt                                                      := (integer)((integer)le.bjl.bankrupt != 0);
	self.bjl_liens_recent_unreleased_count                                 := (integer)((integer)le.bjl.liens_recent_unreleased_count != 0);
	self.bjl_liens_historical_unreleased_count                             := (integer)((integer)le.bjl.liens_historical_unreleased_count != 0);
	self.bjl_liens_recent_released_count                                   := (integer)((integer)le.bjl.liens_recent_released_count != 0);
	self.bjl_liens_historical_released_count                               := (integer)((integer)le.bjl.liens_historical_released_count != 0);
	self.bjl_criminal_count                                                := (integer)((integer)le.bjl.criminal_count != 0);
	self.bjl_felony_count                                                  := (integer)((integer)le.bjl.felony_count != 0);
	self.bjl_foreclosure_flag                                              := (integer)((integer)le.bjl.foreclosure_flag != 0);
	self.relatives_relative_count                                          := (integer)((integer)le.relatives.relative_count != 0);
	self.vehicles_current_count                                            := (integer)((integer)le.vehicles.current_count != 0);
	self.vehicles_historical_count                                         := (integer)((integer)le.vehicles.historical_count != 0);
	self.watercraft_watercraft_count                                       := (integer)((integer)le.watercraft.watercraft_count != 0);
	self.student_file_type                                                 := (integer)(         le.student.file_type != '');
	self.professional_license_professional_license_flag                    := (integer)((integer)le.professional_license.professional_license_flag != 0);
end;

ds_flags := project(ds_infile, ck_pop(LEFT));

total := 											count(ds_flags);
source_verification_tu_count := 					count(ds_flags(source_verification_tu_count = 1));
bjl_bankrupt := 									count(ds_flags(bjl_bankrupt = 1));
bjl_liens_recent_unreleased_count := 				count(ds_flags(bjl_liens_recent_unreleased_count = 1));
bjl_liens_historical_unreleased_count := 			count(ds_flags(bjl_liens_historical_unreleased_count = 1));
bjl_liens_recent_released_count := 					count(ds_flags(bjl_liens_recent_released_count = 1));
bjl_liens_historical_released_count := 				count(ds_flags(bjl_liens_historical_released_count = 1));
bjl_criminal_count := 								count(ds_flags(bjl_criminal_count = 1));
bjl_felony_count := 								count(ds_flags(bjl_felony_count = 1));
bjl_foreclosure_flag := 							count(ds_flags(bjl_foreclosure_flag = 1));
relatives_relative_count := 						count(ds_flags(relatives_relative_count = 1));
vehicles_current_count := 							count(ds_flags(vehicles_current_count = 1));
vehicles_historical_count := 						count(ds_flags(vehicles_historical_count = 1));
watercraft_watercraft_count := 						count(ds_flags(watercraft_watercraft_count = 1));
student_file_type := 								count(ds_flags(student_file_type = 1));
professional_license_professional_license_flag := 	count(ds_flags(professional_license_professional_license_flag = 1));
address_verification_owned_property_total := 		count(ds_flags(address_verification_owned_property_total = 1));
address_verification_sold_property_total := 		count(ds_flags(address_verification_sold_property_total = 1));
address_verification_ambiguous_property_total := 	count(ds_flags(address_verification_ambiguous_property_total = 1));

summary_format := record
	total;
	source_verification_tu_count;
	bjl_bankrupt;
	bjl_liens_recent_unreleased_count;
	bjl_liens_historical_unreleased_count;
	bjl_liens_recent_released_count;
	bjl_liens_historical_released_count;
	bjl_criminal_count;
	bjl_felony_count;
	bjl_foreclosure_flag;
	relatives_relative_count;
	vehicles_current_count;
	vehicles_historical_count;
	watercraft_watercraft_count;
	student_file_type;
	professional_license_professional_license_flag;
	address_verification_owned_property_total;
	address_verification_sold_property_total;
	address_verification_ambiguous_property_total;
end;

summary_res := table(ds_flags, summary_format, total);	
output(summary_res);

endmacro;
