import business_header, statistics;

export mac_Two_Fields_Stats(

	 pDataset										// -- Dataset to do stats on
	,pDataset_Label             // -- String Label for dataset
	,pBuild_Subset              // -- build subset string, i.e. a specific file in the build
	,pVersion				            // -- String version date of dataset
	,pField1                    // -- Field1 name to do stats on(raw, not string)
	,pField1_label	= 'bdid'    // -- String Label for above field
	,pField1Type                // -- 'integer', 'string', 'boolean' or 'string0'(string converted from integer)					
	,pField2                    // -- Field2 name to do stats on(raw, not string)																
	,pField2_label	= 'phone'   // -- String Label for above field
	,pField2Type                // -- 'integer', 'string', 'boolean' or 'string0'(string converted from integer)
	,pField1Few			= 'false'   // -- Does Field1 have few values(would you use ",few" in a table?)
	,pField2Few			= 'false'		// -- Does Field2 have few values(would you use ",few" in a table?)
	,pOutput										// -- output attribute
	,pHasBigSkew		= 'false'		// -- Is either field heavily skewed(has some values that occur way more frequently than other values)

) :=
macro

	#uniquename(pField1_pField2_rec_layout							)
	#uniquename(pField1_rec_count 											)
	#uniquename(pField1_rec_count_prep		 							)
	#uniquename(pField2_rec_count 											)
	#uniquename(pField2_rec_count_prep		 							)
	#uniquename(pField1_pField2_prep										)
	#uniquename(pField1_pField2_unique									)
	#uniquename(pField1_cnt_layout											)
	#uniquename(pField2_cnt_layout											)
	#uniquename(pField1_pField2_cnt											)
	#uniquename(pField1_pField2_prep2										)
	#uniquename(pField1_pField2_rec_count								)
	#uniquename(pField2_pField1_cnt											)
	#uniquename(pField2_pField1_prep2										)
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

	// -- Layouts
	%fcountlay%						:= Statistics.Layouts.field_count_layout			;
	%descriptionstatlay%	:= Statistics.Layouts.Description_Stat_layout	;
	%fcalclay%						:= Statistics.Layouts.Calculated_Stat_layout	;

	// -- Filters
	#if(pField1Type = 'integer')
		%pField1_filter% := %pDataset_slim%.pField1 != 0;
	#elseif(pField1Type = 'string')
		%pField1_filter% := %pDataset_slim%.pField1 != '';
	#elseif(pField1Type = 'string0')
		%pField1_filter% := %pDataset_slim%.pField1 != '' and (unsigned8)trim(%pDataset_slim%.pField1) != 0;
	#elseif(pField1Type = 'boolean')
		%pField1_filter% := %pDataset_slim%.pField1 != false;
	#end
	#if(pField2Type = 'integer')
		%pField2_filter% := %pDataset_slim%.pField2 != 0;
	#elseif(pField2Type = 'string')
		%pField2_filter% := %pDataset_slim%.pField2 != '';
	#elseif(pField2Type = 'string0')
		%pField2_filter% := %pDataset_slim%.pField2 != '' and (unsigned8)trim(%pDataset_slim%.pField2) != 0;
	#elseif(pField2Type = 'boolean')
		%pField2_filter% := %pDataset_slim%.pField2 != false;
	#end
	
	// -- Unique on Field1
	#if(pHasBigSkew = false or pField1Type = 'boolean')
		#if(pField1Few = true or pField1Type = 'boolean')
			%pField1_rec_count% 				:= table(%pDataset_slim%(%pField1_filter%), {pField1}, pField1	,few);
		#else
			%pField1_rec_count% 				:= table(%pDataset_slim%(%pField1_filter%), {pField1}, pField1  ,merge);
		#end
	#else
		%pField1_rec_count_prep%	:= table(distribute(%pDataset_slim%(%pField1_filter%)	,random()				), {pfield1}, pfield1,local);
		%pField1_rec_count%				:= table(distribute(%pField1_rec_count_prep%					,hash64(pfield1)), {pfield1}, pfield1,local);
	#end
	
	// -- Unique on Field2
	#if(pHasBigSkew = false or pField2Type = 'boolean')
		#if(pField2Few = true or pField2Type = 'boolean')
			%pField2_rec_count% 				:= table(%pDataset_slim%(%pField2_filter%), {pField2}, pField2	,few);
		#else
			%pField2_rec_count% 				:= table(%pDataset_slim%(%pField2_filter%), {pField2}, pField2  ,merge);
		#end
	#else
		%pField2_rec_count_prep%	:= table(distribute(%pDataset_slim%(%pField2_filter%)	,random()				), {pfield2}, pfield2,local);
		%pField2_rec_count%				:= table(distribute(%pField2_rec_count_prep%					,hash64(pfield2)), {pfield2}, pfield2,local);
	#end
	
	// -- Unique on Field1,Field2
	#if(pHasBigSkew = false)
		#if(pField2Few = true and pField1Few = true)
			%pField1_pField2_unique%	:= table(%pDataset_slim%(%pField1_filter%, %pField2_filter%), %pField1_pField2_rec_layout%, pField1, pField2,few);
		#else
			%pField1_pField2_unique%	:= table(%pDataset_slim%(%pField1_filter%, %pField2_filter%), %pField1_pField2_rec_layout%, pField1, pField2,merge);
		#end
	#else
		%pField1_pField2_prep%		:= table(distribute(%pDataset_slim%(%pField1_filter%, %pField2_filter%)	,random(								))	,{pField1, pField2}, pField1, pField2,local);
		%pField1_pField2_unique%	:= table(distribute(%pField1_pField2_prep%															,hash64(pField1, pField2))	,{pField1, pField2}, pField1, pField2,local);
	#end

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

	#if(pHasBigSkew = false)
		%pField1_pField2_rec_count%	:= table(%pField1_pField2_unique%, %pField1_cnt_layout%, pField1,merge);
		%pField2_pField1_rec_count%	:= table(%pField1_pField2_unique%, %pField2_cnt_layout%, pField2,merge);
	#else

		%pField1_pField2_cnt%				:= table(%pField1_pField2_unique%, {pField1, unsigned8 cnt := 1});
		%pField1_pField2_prep2%			:= table(distribute(%pField1_pField2_cnt%		,random()				), {pfield1,unsigned8 cnt := sum(group, cnt)}, pfield1,local);
		%pField1_pField2_rec_count%	:= table(distribute(%pField1_pField2_prep2%	,hash64(pfield1)), {pfield1,unsigned8 cnt := sum(group, cnt)}, pfield1,local);

		%pField2_pField1_cnt%				:= table(%pField1_pField2_unique%, {pField2, unsigned8 cnt := 1});
		%pField2_pField1_prep2%			:= table(distribute(%pField2_pField1_cnt%		,random()				), {pfield2,unsigned8 cnt := sum(group, cnt)}, pfield2,local);
		%pField2_pField1_rec_count%	:= table(distribute(%pField2_pField1_prep2%	,hash64(pfield2)), {pfield2,unsigned8 cnt := sum(group, cnt)}, pfield2,local);

	#end

	%bh_stat_out% := Statistics.Layouts.standard_stat_out;


	// -- Counts
	%countGroup%								 								:= count(%pDataset_slim%);
	%countUniquepField1s%												:= count(%pField1_rec_count%);
	%countUniquepField2s%												:= count(%pField2_rec_count%);
	%countUniquepField1sWithAtLeastOnepField2%  := count(%pField1_pField2_rec_count%);
	%countUniquepField2sWithAtLeastOnepField1%  := count(%pField2_pField1_rec_count%);
	%countpField1_pField2_unique%								:= count(%pField1_pField2_unique%);
	
	// -- Averages
	udecimal13_4 %AveragepField2sPerpField1%      						:= (udecimal13_4)((real8)sum(%pField1_pField2_rec_count%, cnt) / (real8)%countUniquepField1sWithAtLeastOnepField2%);
	udecimal13_4 %AveragepField1sPerpField2%      						:= (udecimal13_4)((real8)sum(%pField2_pField1_rec_count%, cnt) / (real8)%countUniquepField2sWithAtLeastOnepField1%);

	// -- Samples
	%Top10pField1sWithMostpField2s%							:= topn(%pField1_pField2_rec_count%, 10, -cnt);
	%Top10pField2sWithMostpField1s%							:= topn(%pField2_pField1_rec_count%, 10, -cnt);

	// -- Percents
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


	#if(pField1Type = 'integer')
		%Top10Field1sWithMostField2s%		:= project(%Top10pField1sWithMostpField2s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= (string)left.pField1;
																				 self.cnt								:= left.cnt;
																			));
	#elseif(pField1Type = 'string' or pField1Type = 'string0')
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

	#if(pField2Type = 'integer')
		%Top10Field2sWithMostField1s%		:= project(%Top10pField2sWithMostpField1s_%, transform(%fcountlay%
																				 ,self.Field_Value				:= (string)left.pField2;
																				 self.cnt								:= left.cnt;
																			));
	#elseif(pField2Type = 'string' or pField2Type = 'string0')
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