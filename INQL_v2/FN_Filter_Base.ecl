EXPORT FN_Filter_Base (dataset(INQL_v2.Layouts.Common_ThorAdditions) pBase) := function

noBatch_filtered_base 			:= pBase(source <> 'BATCH');

Batch_D2C_filtered_Base     := pBase(source = 'BATCH' and
																			~(bus_intel.industry = 'DIRECT TO CONSUMER' and 
																				search_info.function_description in [
																				'ADDRBEST.BESTADDRESSBATCHSERVICE'
																				,'BATCHSERVICES.AKABATCHSERVICE'
																				,'BATCHSERVICES.DEATHBATCHSERVICE'
																				,'BATCHSERVICES.EMAILBATCHSERVICE'
																				,'BATCHSERVICES.PROPERTYBATCHSERVICE'
																				,'DIDVILLE.DIDBATCHSERVICERAW'
																				,'DIDVILLE.RANBESTINFOBATCHSERVICE'
																				,'PROGRESSIVEPHONE.PROGRESSIVEPHONEWITHFEEDBACKBATCHSERVICE']
																				)	 
																		);

filtered_Base := noBatch_filtered_base + Batch_D2C_filtered_Base;

return filtered_Base;

end;
