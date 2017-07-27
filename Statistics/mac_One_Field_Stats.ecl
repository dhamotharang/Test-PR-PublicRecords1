import business_header;

export mac_One_Field_Stats(

	 pDataset					//Dataset to do stats on
	,pDataset_Label		//String Label for dataset
	,pBuild_Subset		//build subset, i.e. a specific file in the build
	,pVersion					//String version of dataset
	,pField						//Field name to do stats on(raw, not string)
	,pField_Label			//String Label for above field
	,pFieldType				//'integer', 'string', or 'boolean'
	,pOutput					//output attribute
	,pFieldFew				= 'true'

) :=
macro
	#uniquename(pField_rec_count_layout			)
	#uniquename(bh_stat_out									)
	#uniquename(pField_rec_count						)
	#uniquename(countGroup									)
	#uniquename(countPopulatedpFields				)
	#uniquename(countBlankpFields						)
	#uniquename(countUniquepFields					)
	#uniquename(PercentPopulatedpFields     )
	#uniquename(countAverageRecordsPerpField)
	#uniquename(countMaxRecordsPerpField    )
	#uniquename(countMinRecordsPerpField    )
	#uniquename(Top10pFieldsWithMostRecords	)
	#uniquename(Top10FieldsWithMostRecords	)
	#uniquename(returndataset								)
	#uniquename(fcountlay										)
	#uniquename(fcalclay										)
	#uniquename(NullValue										)
	#uniquename(top10transform							)
	#uniquename(fieldcountlay								)
	#uniquename(tSamples										)
	#uniquename(pDataset_slim								)

	%pDataset_slim%	:= table(pDataset, {pField});

	%pField_rec_count_layout% := 
	record
		%pDataset_slim%.pField;
		unsigned8 cnt		:= count(group);
	end;

	%fcountlay% := Statistics.Layouts.Description_Stat_layout;
	%fcalclay% 	:= Statistics.Layouts.Calculated_Stat_layout;
	%fieldcountlay% := Statistics.Layouts.Field_count_layout;

	%bh_stat_out% := Statistics.Layouts.standard_stat_out;
/*	record
		string								Dataset_Name									;
		string								Version												;
		string								Field_Label										;
		dataset(%fcalclay%)		Calculated_stats							;
		dataset(%fcountlay%)	Top_10_Most_Populous 					;
	end;
*/	
	#if(pFieldType = 'integer')
		%pField_rec_count%						:= table(%pDataset_slim%(pField != 0), %pField_rec_count_layout%, pField);
	#elseif(pFieldType = 'string')
		%pField_rec_count%						:= table(%pDataset_slim%(pField != ''), %pField_rec_count_layout%, pField);
	#elseif(pFieldType = 'boolean')
		%pField_rec_count%						:= table(%pDataset_slim%(pField != false), %pField_rec_count_layout%, pField,few);
	#end

	#if(pFieldFew = false)
		%Top10pFieldsWithMostRecords%	:= sort(%pField_rec_count%, -cnt);
	#elsif(pFieldFew = true)
		%Top10pFieldsWithMostRecords%	:= topn(%pField_rec_count%, 10, -cnt);
	#end

	%fieldcountlay% %top10transform%(recordof(%Top10pFieldsWithMostRecords%) l) :=
	transform
//		self.Field_Label	:= pField_Label;
		self.Field_Value	:=  #if(pFieldType = 'integer')
														(string)l.pField
													#elseif(pFieldType = 'string')
														l.pField
													#elseif(pFieldType = 'boolean')
														if(l.pField, 'true', 'false')
													#end;
		self.cnt					:= l.cnt;

	end;

	%countGroup%								 		:= count(%pDataset_slim%);

	#if(pFieldFew = false)
	%Top10FieldsWithMostRecords%		:= dataset([
																				{'Count of Records per '+pField_Label
																				,pField_Label
																				,project(%Top10pFieldsWithMostRecords%, %top10transform%(left))
																				}
																			], %fcountlay%);
	#elseif(pFieldFew = true)
	%Top10FieldsWithMostRecords%		:= dataset([
																				{'Top 10 Most Populous ' + pField_Label + 's'
																				,pField_Label
																				,project(%Top10pFieldsWithMostRecords%, %top10transform%(left))
																				}
																			], %fcountlay%);
	#end

	#if(pFieldType = 'integer')
		%countPopulatedpFields%        	:= count(%pDataset_slim%(pField != 0));
		%countBlankpFields%            	:= count(%pDataset_slim%(pField = 0));
		%countUniquepFields%           	:= count(table(%pDataset_slim%(pField != 0), {pField}, pField));
		%NullValue%											:= 'Zero';
	#elseif(pFieldType = 'string')
		%countPopulatedpFields%        	:= count(%pDataset_slim%(pField !=''));
		%countBlankpFields%            	:= count(%pDataset_slim%(pField = ''));
		%countUniquepFields%           	:= count(table(%pDataset_slim%(pField != ''), {pField}, pField));
		%NullValue%											:= 'Blank';
	#elseif(pFieldType = 'boolean')
		%countPopulatedpFields%        	:= count(%pDataset_slim%(pField !=false));
		%countBlankpFields%            	:= count(%pDataset_slim%(pField = false));
		%countUniquepFields%           	:= count(table(%pDataset_slim%(pField != false), {pField}, pField));
		%NullValue%											:= 'False';
	#end
	
	udecimal13_4 %PercentPopulatedpFields%      	:= (udecimal13_4)((real8)%countPopulatedpFields% / (real8)%countGroup% * 100	);
	udecimal13_4 %countAverageRecordsPerpField% 	:= (udecimal13_4)((real8)%countPopulatedpFields% / (real8)%countUniquepFields%);
	%countMaxRecordsPerpField%     	:= max(%pField_rec_count%, cnt);                               
	%countMinRecordsPerpField%     	:= min(%pField_rec_count%, cnt);

	%returndataset% := dataset([
		{
		 pDataset_Label
		,pVersion			
		,pBuild_Subset
		,pField_Label
		,''
		,[
			 {'count Records'																									,(string)%countGroup%								 		}
			,{'count Records with Populated '	+ pField_Label + 's'						,(string)%countPopulatedpFields%        }
			,{'count '								+ %NullValue%+ ' ' + pField_Label + 's'	,(string)%countBlankpFields%            }
			,{'Percentage '						+ pField_Label + ' Population'					,(string)%PercentPopulatedpFields%      }
			,{'count Unique '					+ pField_Label + 's'										,(string)%countUniquepFields%           }
			,{'Average records per ' 	+ pField_Label													,(string)%countAverageRecordsPerpField% }
			,{'Max Records per '			+ pField_Label													,(string)%countMaxRecordsPerpField%     }
			,{'Min Records per '			+ pField_Label													,(string)%countMinRecordsPerpField%  		}
   	]
		,%Top10FieldsWithMostRecords%
		}
	], %bh_stat_out%);
	
	pOutput := %returndataset%;

endmacro;