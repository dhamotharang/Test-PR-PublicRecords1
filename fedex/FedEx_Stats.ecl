import strata;

export FedEx_Stats(string filedate) := function 

ds := fedex.file_fedex_base;

rFedEx_Stats := record	 
	 CountGroup                                        := count(group); 			
		file_date																							:= sum(group,if(ds.file_date<>'',1,0));
		record_id																						:= sum(group,if(ds.record_id<>'',1,0));
		record_type																				:= sum(group,if(ds.record_type<>'',1,0));
		first_name																					:= sum(group,if(ds.first_name<>'',1,0));
		middle_initial																			:= sum(group,if(ds.middle_initial<>'',1,0));
		last_name																						:= sum(group,if(ds.last_name<>'',1,0));
		full_name																						:= sum(group,if(ds.full_name<>'',1,0));
		company_name																  := sum(group,if(ds.company_name<>'',1,0));
		address_line1																			:= sum(group,if(ds.address_line1<>'',1,0));
		address_line2																			:= sum(group,if(ds.address_line2<>'',1,0));
		city																											:= sum(group,if(ds.city<>'',1,0));
		state																										:= ds.state;
		zip																											:= sum(group,if(ds.zip<>'',1,0));
		country																							  := sum(group,if(ds.country<>'',1,0));
		phone																									:= sum(group,if(ds.phone<>'',1,0));
 END;
 
 
 tStats := table(ds,rFedEx_Stats,state,few);

strata.createXMLStats(tStats,'fedex','data',filedate,'',resultsOut);
return resultsOut;
end;