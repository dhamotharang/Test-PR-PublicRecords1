import business_header, statistics;
/*
	1) another macro, pass in two fields, and field types, and if field has few values
		get back stats such as:
		a) average unique pField1s per unique address	
		b) top5 pField1s with most address
		c) count pField1s with addresses
		d) if address few values, unique pField1s per unique source values dataset
		e) 
*/
export mac_Two_Fields_Stats(

	 pDataset
	,pDataset_Label
	,pBuild_Subset
	,pVersion				
	,pField1
	,pField1_label	= 'bdid'
	,pField1Type
	,pField2
	,pField2_label	= 'phone'
	,pField2Type
	,pField1Few			= 'false'
	,pField2Few			= 'false'
	,pOutput

) :=
macro

	#uniquename(pField1_pField2_rec_layout							)
	#uniquename(pField1_rec_count 											)
	#uniquename(pField2_rec_count 											)
	#uniquename(pField1_pField2_unique									)
	#uniquename(pField1_cnt_layout											)
	#uniquename(pField2_cnt_layout											)
	#uniquename(pField1_pField2_rec_count								)
	#uniquename(pField2_pField1_rec_count								)
	#uniquename(bh_stat_out															)
	#uniquename(countGroup								 							)
	#uniquename(countUniquepField1s											)
	#uniquename(countUniquepField2s											)
	#uniquename(countUniquepField1sWithAtLeastOnepField2)
	#uniquename(countUniquepField2sWithAtLeastOnepField1)
	#uniquename(AveragepField2sPerpField1      					)
	#uniquename(AveragepField1sPerpField2      					)
	#uniquename(Top10pField1sWithMostpField2s						)
	#uniquename(Top10pField2sWithMostpField1s						)
	#uniquename(Top10Field1sWithMostField2s							)
	#uniquename(Top10Field2sWithMostField1s							)
	#uniquename(PercentUniquepField1sWithpField2s  			)
	#uniquename(PercentUniquepField2sWithpField1s  			)
	#uniquename(returndataset														)
	#uniquename(pField1_filter													)
	#uniquename(pField2_filter													)
	#uniquename(fcountlay																)
	#uniquename(fcountlay2															)
	#uniquename(fcalclay																)
	#uniquename(descriptionstatlay											)
	#uniquename(Top10Field1s														)
	#uniquename(Top10Field2s														)
	#uniquename(Top10pField1sWithMostpField2s_					)
	#uniquename(Top10pField2sWithMostpField1s_					)
	#uniquename(pDataset_slim														)
	#uniquename(countpField1_pField2_unique							)

	%pDataset_slim% 				:= table(pDataset, {pField1,pField2});

	%pField1_pField2_rec_layout% := 
	record
		%pDataset_slim%.pField1;
		%pDataset_slim%.pField2;
	end;


	%fcountlay%						:= Statistics.Layouts.field_count_layout			;
	%descriptionstatlay%	:= Statistics.Layouts.Description_Stat_layout	;
	%fcountlay2%					:= Statistics.Layouts.Description_Stat_layout2;
	%fcalclay%						:= Statistics.Layouts.Calculated_Stat_layout	;

	#if(pField1Type = 'integer')
		%pField1_filter% := %pDataset_slim%.pField1 != 0;
	#elseif(pField1Type = 'string')
		%pField1_filter% := %pDataset_slim%.pField1 != '';
	#elseif(pField1Type = 'boolean')
		%pField1_filter% := %pDataset_slim%.pField1 != false;
	#end
	#if(pField2Type = 'integer')
		%pField2_filter% := %pDataset_slim%.pField2 != 0;
	#elseif(pField2Type = 'string')
		%pField2_filter% := %pDataset_slim%.pField2 != '';
	#elseif(pField2Type = 'boolean')
		%pField2_filter% := %pDataset_slim%.pField2 != false;
	#end
	
	#if(pField1Few = false)
		%pField1_rec_count% 				:= table(%pDataset_slim%(%pField1_filter%), {pField1}, pField1);
	#elseif(pField1Few = true)
		%pField1_rec_count% 				:= table(%pDataset_slim%(%pField1_filter%), {pField1}, pField1	,few);
	#end
	#if(pField2Few = false)
		%pField2_rec_count% 				:= table(%pDataset_slim%(%pField2_filter%), {pField2}, pField2);
	#elseif(pField2Few = true)
		%pField2_rec_count% 				:= table(%pDataset_slim%(%pField2_filter%), {pField2}, pField2	,few);
	#end
	%pField1_pField2_unique%			:= table(%pDataset_slim%(%pField1_filter%, %pField2_filter%), %pField1_pField2_rec_layout%, pField1, pField2);

	%pField1_cnt_layout% := 
	record
		%pField1_pField2_unique%.pField1;
		unsigned8 cnt := count(group);
	end;
	%pField2_cnt_layout% := 
	record
		%pField1_pField2_unique%.pField2;
		unsigned8 cnt := count(group);
	end;

	%pField1_pField2_rec_count%	:= table(%pField1_pField2_unique%, %pField1_cnt_layout%, pField1);
	%pField2_pField1_rec_count%	:= table(%pField1_pField2_unique%, %pField2_cnt_layout%, pField2);


	%bh_stat_out% := Statistics.Layouts.standard_stat_out;
/*	
	record
		string										Dataset_Name															;
		string										Version																		;
		string										Field1_label															;
		string										Field2_label															;
		dataset(%fcalclay%)				Calculated_stats													;
		dataset(%descriptionstatlay%)			Top10MostPopulous													;
	end;
*/
	%countGroup%								 								:= count(%pDataset_slim%);
	%countUniquepField1s%												:= count(%pField1_rec_count%);
	%countUniquepField2s%												:= count(%pField2_rec_count%);
	%countUniquepField1sWithAtLeastOnepField2%  := count(%pField1_pField2_rec_count%);
	%countUniquepField2sWithAtLeastOnepField1%  := count(%pField2_pField1_rec_count%);
	%countpField1_pField2_unique%								:= count(%pField1_pField2_unique%);
	
//	%AveragepField2sPerpField1%      						:= (real)%countUniquepField2s% / (real)%countUniquepField1sWithAtLeastOnepField2%;
	//pfield1 = bdid
	//pfield2 = source
	//average bdids per source = unique on bdid and source
	//
//	%AverageSourcesPerBdid%      						:= (real)sum(%bdids_per_source%, cnt) / (real)%countUniquepBdidsWithAtLeastOneSource%;

	udecimal13_4 %AveragepField2sPerpField1%      						:= (udecimal13_4)((real8)sum(%pField1_pField2_rec_count%, cnt) / (real8)%countUniquepField1sWithAtLeastOnepField2%);
	udecimal13_4 %AveragepField1sPerpField2%      						:= (udecimal13_4)((real8)sum(%pField2_pField1_rec_count%, cnt) / (real8)%countUniquepField2sWithAtLeastOnepField1%);

	%Top10pField1sWithMostpField2s%							:= topn(%pField1_pField2_rec_count%, 10, -cnt);
	%Top10pField2sWithMostpField1s%							:= topn(%pField2_pField1_rec_count%, 10, -cnt);
	udecimal13_4 %PercentUniquepField1sWithpField2s%  				:= (udecimal13_4)((real8)%countUniquepField1sWithAtLeastOnepField2% / (real8)%countUniquepField1s%	* 100);
	udecimal13_4 %PercentUniquepField2sWithpField1s%  				:= (udecimal13_4)((real8)%countUniquepField2sWithAtLeastOnepField1% / (real8)%countUniquepField2s%	* 100);
                                                                                                                             
	%Top10pField1sWithMostpField2s_%							:= if(pField1Few = false or %countUniquepField1sWithAtLeastOnepField2% > 2000
																											,topn(%pField1_pField2_rec_count%, 10	, -cnt)
																											,sort(%pField1_pField2_rec_count%			, -cnt)
																										);
																										
	%Top10pField2sWithMostpField1s_%							:= if(pField2Few = false or %countUniquepField2sWithAtLeastOnepField1% > 2000
																											,topn(%pField2_pField1_rec_count%, 10	, -cnt)
																											,sort(%pField2_pField1_rec_count%			, -cnt)
																										); 

//,self.Stat_Description	:= 'Top 10 '+pField1_Label+'s With Most '+pField2_Label+ 's';

	#if(pField1Type = 'integer')
		%Top10Field1sWithMostField2s%		:= project(%Top10pField1sWithMostpField2s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= (string)left.pField1;
																				 self.cnt								:= left.cnt;
																			));
	#elseif(pField1Type = 'string')
		%Top10Field1sWithMostField2s%		:= project(%Top10pField1sWithMostpField2s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= left.pField1;
																				 self.cnt								:= left.cnt;
																			));
	#elseif(pField1Type = 'boolean')
		%Top10Field1sWithMostField2s%		:= project(%Top10pField1sWithMostpField2s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= if(left.pField1, 'true', 'false');
																				 self.cnt								:= left.cnt;
																			));
	#end

//,self.Stat_Description	:= 'Top 10 '+pField2_Label+'s With Most '+pField1_Label+ 's';
	#if(pField2Type = 'integer')
		%Top10Field2sWithMostField1s%		:= project(%Top10pField2sWithMostpField1s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= (string)left.pField2;
																				 self.cnt								:= left.cnt;
																			));
	#elseif(pField2Type = 'string')
		%Top10Field2sWithMostField1s%		:= project(%Top10pField2sWithMostpField1s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= left.pField2;
																				 self.cnt								:= left.cnt;
																			));
	#elseif(pField2Type = 'boolean')
		%Top10Field2sWithMostField1s%		:= project(%Top10pField2sWithMostpField1s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= if(left.pField2, 'true', 'false');
																				 self.cnt								:= left.cnt;
																			));
	#end

	#if(pField1Few = false)
	%Top10Field1s%		:= dataset([
																				{'Top 10 '+pField1_Label+'s With Most '+pField2_Label+ 's'
																				,pField1_Label
																				,%Top10Field1sWithMostField2s%
																				}
																			], %descriptionstatlay%);
	#elseif(pField1Few = true)
	%Top10Field1s%		:= dataset([
																				{'Count of '+pField2_Label+'s Per '+pField1_Label
																				,pField1_Label
																				,%Top10Field1sWithMostField2s%
																				}
																			], %descriptionstatlay%);
	#end
	
	#if(pField2Few = false)
	%Top10Field2s%		:= dataset([
																				{'Top 10 '+pField2_Label+'s With Most '+pField1_Label+ 's'
																				,pField2_Label
																				,%Top10Field2sWithMostField1s%
																				}
																			], %descriptionstatlay%);
	#elseif(pField2Few = true)
	%Top10Field2s%		:= dataset([
																				{'Count of '+pField1_Label+'s Per '+pField2_Label
																				,pField2_Label
																				,%Top10Field2sWithMostField1s%
																				}
																			], %descriptionstatlay%);
	#end




	%returndataset% := dataset([
		{
		 pDataset_Label
		,pVersion	
		,pBuild_Subset
		,pField1_label
		,pField2_label
		,[
		 {'count Records'																																				,%countGroup%								 					 			}
		,{'count Unique '				+ pField1_Label + 's'																						,%countUniquepField1s%										  }
		,{'count Unique '				+ pField2_Label + 's'																						,%countUniquepField2s%											} 	
		,{'count Unique '				+ pField1_Label + ', ' + pField2_Label + ' Combos'							,%countpField1_pField2_unique%							} 	
		,{'count Unique '				+ pField1_Label + 's Containing at least one ' + pField2_Label	,%countUniquepField1sWithAtLeastOnepField2% }  	
		,{'count Unique '				+ pField2_Label + 's Containing at least one ' + pField1_Label	,%countUniquepField2sWithAtLeastOnepField1% }  	
		,{'Percentage Unique '	+ pField1_Label + 's Containing at least one ' + pField2_Label	,(string)%PercentUniquepField1sWithpField2s%  			}
		,{'Percentage Unique '	+ pField2_Label + 's Containing at least one ' + pField1_Label	,(string)%PercentUniquepField2sWithpField1s%  			}  	
		,{'Average Count '			+ pField1_Label + 's Per Unique ' + pField2_Label								,(string)%AveragepField1sPerpField2%      					} 
   	,{'Average Count '			+ pField2_Label + 's Per Unique ' + pField1_Label								,(string)%AveragepField2sPerpField1%								}
		]
   	,%Top10Field1s% + %Top10Field2s%
		}
	], %bh_stat_out%);
	
	pOutput := %returndataset%;

endmacro;