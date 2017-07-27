export get_royalfields(dataset(Layout_PropHistory_Out) input,integer fares_count) := FUNCTION


currentassessmentformat :=RECORD
input.currentassessment;
input.DeedSummary;
input.Transactions;
input.owners.mortgage_fraud_area;
input.reqData.in_fares_unformatted_apn;
input.ReqData.seq;
END;

input_with_royal :=record(layout_PropHistory_Out)
unsigned1 do_royal;
END;

input_with_royal get_royal(input l) :=transform
self :=l;
self.do_royal :=if(fares_count=0,2,(unsigned1)
	(l.currentassessment.fares_unformatted_apn<>'' or
	l.currentassessment.apna_or_pin_number<>''  or
	l.currentassessment.duplicate_apn_multiple_address_id<>''  or
	l.currentassessment.fares_iris_apn<>''  or
	l.currentassessment.legal_subdivision_name<>''  or
	l.currentassessment.county_land_use_code<>''  or
	l.currentassessment.county_land_use_description<>''  or
	l.currentassessment.year_built<>''  or
	l.currentassessment.assessed_land_value<>''  or
	l.currentassessment.assessed_improvement_value<>''  or
	l.currentassessment.assessed_total_value<>''  or
	l.currentassessment.tax_amount<>'' or
	l.currentassessment.market_land_value<>''  or
	l.currentassessment.market_improvement_value<>''  or
	l.currentassessment.market_total_value<>''  or
	l.currentassessment.fares_calculated_total_value<>''  or
	l.currentassessment.tax_year<>''  or
	l.currentassessment.fares_living_square_feet<>''  or
	l.currentassessment.land_square_footage<>''  or
	l.currentassessment.no_of_stories<>''  or
	l.currentassessment.no_of_bedrooms<>''  or
	l.currentassessment.no_of_baths<>''  or
	l.currentassessment.no_of_partial_baths<>''  or
	l.currentassessment.fares_condition<>''  or  
	l.currentassessment.fireplace_indicator<>''  or
	l.currentassessment.pool_code<>''  or
	l.currentassessment.air_conditioning_code<>''  or
	l.currentassessment.ac_code_desc<>''  or
	l.currentassessment.heating_code<>''  or

	l.currentassessment.heating_fuel_type_code<>''  or
	l.currentassessment.fuel_type_desc<>''  or
	l.currentassessment.fares_sewer<>''  or
	l.currentassessment.fares_water<>''  or
	l.currentassessment.fares_frame<>''  or
	l.currentassessment.fares_electric_energy<>''  or
	l.currentassessment.roof_cover_code<>''  or
	l.currentassessment.roof_cover_desc<>''  or
	l.currentassessment.roof_type_code<>''  or
	l.currentassessment.roof_type_desc<>''  or
	l.currentassessment.style_code<>''  or
	l.currentassessment.style_desc<>'' or
	l.currentassessment.legal_brief_description<>'' or	
	l.DeedSummary.TotalDeedTransfers<>0 or
	l.DeedSummary.TotalDeedTransferPeriod<>0 or // months
	l.DeedSummary.VacantLot=TRUE or
	l.DeedSummary.LastDeedTransfer<>0 or  // days since
	l.DeedSummary.PeriodSinceOwnerVacatedProperty<>0 or // ?
	l.DeedSummary.LastSaleDate <>0 or
	exists(l.DeedSummary.warnings) or 
	exists(l.transactions) or
	l.reqData.in_fares_unformatted_apn<>'' or
	exists(l.owners(mortgage_fraud_area =TRUE))));
END;





slim_it :=project(input, get_royal(left));

return slim_it;

END;
