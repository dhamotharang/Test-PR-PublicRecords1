export Generalized_Macro( dInput,  rules_din, summaryresult, detailedresult) := macro

import ut, std, salt23;

#uniquename(din)
%din% := distribute(dinput):independent;

#uniquename(new_lay)
%new_lay% := record
	unsigned seq_num;
	recordof(%din%);
end;

#uniquename(proj_seq)
%proj_seq% := PROJECT(%din%, transform(%new_lay%,self.seq_num := counter;self := left;));

#uniquename(Data_Layout)
%Data_Layout% := record
	unsigned seq_num;
	string100 FieldName;
	SALT23.StrType field_value{maxlength(2000)};
end;
		
loadxml('<xml/>');
// counter used in choose() later on
#declare(field_values) #set(field_values,'counter')
#declare(field_set) #set(field_set,'counter')

// Count of the input data fields
#declare(field_cnt) #set(field_cnt,0)
#exportxml(fields,recordof(%proj_seq%))

#for(fields)
	#for(field)
		#append(field_values,',(string)left.'+%'{@label}'%)
		#set(field_cnt,%field_cnt%+1)
		#append(field_set, ',\''+%'{@label}'%+'\'')
	#end
#end

#if (%field_cnt% = 0)
	return 'No input given';
#end

#if (%field_cnt% > 0)
	// Produce the output, with one row for every field/column.
	#uniquename(d_norm)
	%d_norm%:=
		normalize(%proj_seq%,
							%field_cnt%,
							transform(%Data_Layout%,
								self.seq_num := left.#EXPAND('seq_num'),
								self.FieldName:= choose(%field_set%),
								self.field_value:=choose(#expand(%'field_values'%))
							));

	#uniquename(d_norm1)
	%d_norm1% := %d_norm%(FieldName not in ['seq_num']);
#end

#uniquename(lay1)	
%lay1% := record
	string100 FieldName;
  SALT23.StrType field_value{maxlength(2000)};
	recordof(%proj_seq%);
end;

#uniquename(d_norm2)	
%d_norm2% := JOIN(%d_norm1%, %proj_seq%, 
									left.seq_num = right.seq_num, 
									transform(%lay1%, 
										self.seq_num     := right.seq_num;
										self.fieldname   := left.fieldname;
										self.field_value := left.field_value;
										self             := right;
									));

#uniquename(output_layout)																																									
%output_layout% := record
	string50 rulename;
	recordof(%d_norm2%);
	string unmatchedresult;
end;

%output_layout% Transfrm(%d_norm2% l, rules_Din R) := transform
	self.rulename        := r.rulename;
	self.unmatchedresult := regexreplace((string)r.regexformat,trim((string)l.field_value,left,right),'matched');
	self := l;
end;

#uniquename(join_rs)	
%join_rs% := join(%d_norm2%, rules_din, STD.Str.ToUpperCase(left.fieldname) = STD.Str.ToUpperCase(right.fieldname), Transfrm(left, right), all):independent;

#uniquename(total_count)
%total_count% := count(dinput);

#uniquename(ds_count)
%ds_count% := count(%din%);

#uniquename(recd)	
%recd% := record
	%join_rs%.rulename;
	%join_rs%.fieldname;
	countof := count(group);
	decimal10_4 proportion := (count(group)*100/%ds_count%);
end;

#uniquename(FR_table)	
%FR_table% := table(%join_rs%(unmatchedresult != 'matched' and (std.str.startswith(rulename, 'FR_'))), %recd%, %join_rs%.fieldname, %join_rs%.rulename);

#uniquename(NR_VR_table)
%NR_VR_table% := table(%join_rs%(unmatchedresult = 'matched' and not (std.str.startswith(rulename, 'FR_'))), %recd%, %join_rs%.fieldname, %join_rs%.rulename);

#uniquename(tb)
%tb% := %FR_table% + %NR_VR_table%;

#uniquename(tb1)
%tb1% := JOIN(%tb%, rules_din, 
							STD.Str.ToUpperCase(left.fieldname) = STD.Str.ToUpperCase(right.fieldname) and 
							left.rulename = right.rulename,
							transform(recordof(%tb%),
								self.rulename   := right.rulename;
								self.fieldname  := right.fieldname;
								self.countof    := 0;
								self.proportion := 0.0;
													 ), right only);

#uniquename(final_table)
%final_table% := %tb% + %tb1%;																									 

#uniquename(finalSummaryRec)
%finalSummaryRec% := record
	integer    totalDatasetSize;
	integer    sampleSize;
	decimal8_2 sampleSizePercent;
  string50   ruleName;
	string     ruleType;
	string     ruleMeaning;
	string     fieldName;
	decimal8_2 lowerLimit;
	decimal8_2 upperLimit;
	decimal8_2 matchPercent;
	string     finalConclusion;
end;
 
#uniquename(final_join)
%final_join% := join(rules_din, %final_table%, 
										STD.Str.ToUpperCase(left.fieldname) = STD.Str.ToUpperCase(right.fieldname) and 
										left.rulename = right.rulename, 
										transform(%finalSummaryRec%,
											self.totalDatasetSize  := 0;
											self.sampleSize        := 0;
											self.sampleSizePercent := 0.00;
											self.ruleName          := left.rulename ;
											self.ruleType          := left.rulename[1..2] ;
											self.ruleMeaning       := map(left.rulename[1..2] = 'FR' => 'Not acceptable format',
																										left.rulename[1..2] = 'NR' => 'Output is NULL',
																										left.rulename[1..2] = 'VR' => 'Output is' + left.rulename[STD.Str.Find(left.rulename, '_',2)..length(left.rulename)],
																										'');
											self.fieldName         := STD.Str.ToUpperCase(left.fieldname);
											self.lowerLimit        := left.lowerLimit ;
											self.upperLimit        := left.upperLimit ;
											self.matchPercent      := right.proportion;
											self.finalConclusion   := if(right.proportion < left.lowerlimit or right.proportion > left.upperlimit, 'FAIL', 'PASS');
											self := left;)):independent;


#uniquename(FR_results)	
%FR_results% := %join_rs%(unmatchedresult != 'matched' and (std.str.startswith(rulename, 'FR_') or std.str.startswith(rulename, 'SR_'))) ;

#uniquename(final_lay)	
%final_lay% := record
	recordof(%FR_results%)-[seq_num, unmatchedresult];
end;

#uniquename(final_proj)	
%final_proj% := project(%FR_results%, transform(%final_lay%, self := left;));
	
summaryresult  := %final_join%;
detailedresult := %final_proj%;

endmacro;
