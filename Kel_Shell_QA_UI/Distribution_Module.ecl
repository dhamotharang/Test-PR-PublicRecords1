EXPORT Distribution_Module := MODULE

EXPORT Dis_Macro(unique_col, infile, op, op2) := MACRO

RulesFile:=Kel_Shell_QA.Rules_file;

// (STD.Str.ToUpperCase(trim(ECLFieldname,left,right))='B2BACTVTLBALARCH1Y')
// DS:=join(fileop(STD.Str.ToUpperCase(trim(fieldname,left,right))='INPUTFIRSTNAMEECHO'),
         // RF(STD.Str.ToUpperCase(trim(eclfieldname,left,right))='INPUTFIRSTNAMEECHO'),
				            // (STD.Str.ToUpperCase(trim(left.fieldname,left,right))='INPUTFIRSTNAMEECHO')= 
                    // (STD.Str.ToUpperCase(trim(right.eclfieldname,left,right))='INPUTFIRSTNAMEECHO'),inner);
	
	DS:=join(Distribute(infile,random()),RulesFile,STD.Str.ToUpperCase(trim(left.fieldname,left,right))= 
                      STD.Str.ToUpperCase(trim(right.eclfieldname,left,right)),inner,lookup);
										
// Checking Distributions for Default vs Valid vs Invalid vs special cases
#uniquename(lay)
%lay% := record
STRING Accountnumber;
// UNSIGNED6 InputLexID; 
STRING Attribute;
STRING Category;
STRING SourceDescription;
STRING Distribution_type;
STRING Attribute_value;
end;

#uniquename(tble)
%tble% := project(DS,transform({%lay%; recordof(DS)- {STRING Category;STRING SourceDescription;}},
                                     self.Accountnumber:=left.#expand(unique_col);
                                     self.Attribute:=left.fieldname;
																		 self.Category:=left.Category;
																		 self.SourceDescription:=left.SourceDescription;
																		 self:=left;		
																		 self:=[];
														  ))(Accountnumber<>'');

		
// Creating BINS for valid ranges
													 
			 #uniquename(Ran)
			 %Ran% :=project(%tble%,transform(%lay%, 
									 self.Distribution_type:='VALUE_RANGE';
									 self.attribute_value :=if(trim(left.OtherOutputRules,left,right) <> 'No BinSize' or trim(left.max,left,right) <> 'No Max',
									                        if(regexfind('[0-9]',TRIM((string)left.field_value,LEFT,RIGHT)) or length(TRIM((string)left.field_value,LEFT,RIGHT))= 0 ,kel_Shell_QA.CreateBins.CreateBins_ranges(left.fieldname,(string)left.field_value,(decimal)left.min,(decimal)left.max,(integer)left.OtherOutputRules,left.DefaultValues),'UNDEFINED'),
																						 'NA');									
/* 									 MAP(left.fieldname in ['AppendedLexIDScore']=> kel_Shell_QA.CreateBins.CreateBins_ranges(left.fieldname,(string)left.field_value,(decimal)left.min,(decimal)left.max,(integer)left.OtherOutputRules,left.DefaultValues),
   																							left.Category not in['Input Echo','Input Clean','Business Input Echo'] => kel_Shell_QA.CreateBins.CreateBins_ranges(left.fieldname,(string)left.field_value,(decimal)left.min,(decimal)left.max,(integer)left.OtherOutputRules,left.DefaultValues),
   																							'NA');
*/
									 self:=left;                                                        
										 ));
            
            														 
 			 #uniquename(Ran2)
   		 %Ran2% :=project(%tble%,transform(%lay%, 
   										 self.Distribution_type:='VALUE_TYPE';
   										 self.attribute_value :=if(trim(left.OtherOutputRules,left,right) <> 'No BinSize' or trim(left.max,left,right) <> 'No Max',
   										 if(regexfind('[0-9]',TRIM((string)left.field_value,LEFT,RIGHT)) or length(TRIM((string)left.field_value,LEFT,RIGHT))= 0 ,
   										 kel_Shell_QA.CreateBins.CreateBins_valid_default(left.fieldname,(string)left.field_value,(decimal)left.min,(decimal)left.max,left.defaultvalues),'UNDEFINED'),
   																					 'NA');
   																					
   										 self:=left;                                                        
   											 ));    
   
       #uniquename(Ran3)
       %Ran3% :=project(%tble%,transform(%lay%, 
                        self.Distribution_type:='VALUE_LENGTH';
            						 self.attribute_value := (string) LENGTH(TRIM((string)left.field_value,LEFT,RIGHT));
         							 self:=left;                                                       
            							 ));				
         								 
      #uniquename(pjt)
      %pjt%:=%Ran%(attribute_value<>'NA') + %Ran2%(attribute_value<>'NA') +  %Ran3% ;


   #uniquename(report_lay)
   %report_lay% :=record
   %pjt%.Attribute;
   %pjt%.Category;
	 %pjt%.SourceDescription;
   %pjt%.Distribution_type;
   %pjt%.attribute_value;
   INTEGER Result_Cnt:=COUNT(GROUP);
   end;
   
   #uniquename(report)
   %report% :=	table(%pjt%,%report_lay%,Attribute,Category,SourceDescription,Distribution_type,attribute_value);	
   
   #uniquename(report_lay2)
   %report_lay2% :=record
   %report%.Attribute;
   %report%.Category;
	 // %pjt%.SourceDescription;
   %report%.Distribution_type;
   DECIMAL10_4 Result_Perc:=SUM(GROUP,%report%.Result_Cnt);
   end;
   
   #uniquename(report2)
   %report2% :=	table(%report%,%report_lay2%,Attribute,Category,Distribution_type);	
   
   #uniquename(report3)
   %report3%:= join(%report%,%report2%,left.Attribute=right.Attribute and
   																		left.Category=right.Category and
   																		left.Distribution_type=right.Distribution_type,
   																		transform({%report_lay%;DECIMAL10_4 Result_Perc},
   																		self.Result_Perc:= (left.Result_Cnt/right.Result_Perc)*100;
   																		self:=left;
   																		self:=right;

                                      ));

op:=%report3%;

op2:= join(dedup(%pjt%,Attribute,Category,Distribution_type,attribute_value,KEEP 5),DS,left.Accountnumber=right.#expand(unique_col),transform({%lay%;recordof(ds) - {STRING Category;}},self:=left;self:=right;),left outer);

ENDMACRO;

EXPORT Traditional_Metrics_Macro(unique_col, infile, op) := MACRO

RulesFile:=Kel_Shell_QA.Rules_file;


// DS:=join(fileop(STD.Str.ToUpperCase(trim(fieldname,left,right))='INPUTFIRSTNAMEECHO'),
         // RF(STD.Str.ToUpperCase(trim(eclfieldname,left,right))='INPUTFIRSTNAMEECHO'),
				            // (STD.Str.ToUpperCase(trim(left.fieldname,left,right))='INPUTFIRSTNAMEECHO')= 
                    // (STD.Str.ToUpperCase(trim(right.eclfieldname,left,right))='INPUTFIRSTNAMEECHO'),inner);
	
	DS:=join(Distribute(infile,random()),RulesFile,STD.Str.ToUpperCase(trim(left.fieldname,left,right))= 
                      STD.Str.ToUpperCase(trim(right.eclfieldname,left,right)),inner,lookup);
										
// Checking Distributions for Default vs Valid vs Invalid vs special cases
#uniquename(lay)
%lay% := record
STRING Accountnumber;
// UNSIGNED6 InputLexID; 
STRING Attribute;
STRING Category;
STRING SourceDescription;
STRING Distribution_type;
STRING Attribute_value;
STRING Attribute_range;
end;

#uniquename(tble)
%tble% := project(DS,transform({%lay%; recordof(DS)- {STRING Category;STRING SourceDescription;}},
                                     self.Accountnumber:=left.#expand(unique_col);
                                     self.Attribute:=left.fieldname;
																		 self.Category:=left.Category;
																		 self.SourceDescription:=left.SourceDescription;
																		 self:=left;		
																		 self:=[];
														  ))(Accountnumber<>'');

#uniquename(Ran)
%Ran% :=project(%tble%,transform( {STRING Attribute;STRING Category;STRING SourceDescription;STRING Distribution_type;STRING Attribute_value; string Attribute_range;string val;} , 
               self.Distribution_type:='RANGE';
   						 self.attribute_value :=if(trim(left.OtherOutputRules,left,right) <> 'No BinSize' or trim(left.max,left,right) <> 'No Max',
							       if(regexfind('[0-9]',TRIM((string)left.field_value,LEFT,RIGHT)) or length(TRIM((string)left.field_value,LEFT,RIGHT))= 0 ,
										 kel_Shell_QA.CreateBins.CreateBins_valid_default(left.fieldname,(string)left.field_value,(decimal)left.min,(decimal)left.max,left.defaultvalues),'UNDEFINED'),
																					 'NA');
							 self.Attribute_range:=if(trim(left.OtherOutputRules,left,right) <> 'No BinSize' or trim(left.max,left,right) <> 'No Max',
							       if(regexfind('[0-9]',TRIM((string)left.field_value,LEFT,RIGHT)) or length(TRIM((string)left.field_value,LEFT,RIGHT))= 0 ,
										 kel_Shell_QA.CreateBins.CreateBins_Range(left.fieldname,(string)left.field_value,(decimal)left.min,(decimal)left.max,left.defaultvalues),'UNDEFINED'),
																					 'NA');												 
							 self.val:=(string)left.field_value;										 
							 self:=left;                                                        
   							 ))(attribute_value<>'NA');	

#UNIQUENAME(stat_group)
	%stat_group% := RECORD
											%Ran%.Attribute;
											%Ran%.Category;
											%Ran%.SourceDescription;
											%Ran%.Distribution_type;
											%Ran%.Attribute_value;
											%Ran%.Attribute_range;
											mean 			:= ave(group, (integer) %Ran%.val);
											std_dev   := sqrt(variance(group, (integer) %Ran%.val ));
											max_value := max(group, (integer) %Ran%.val );
											min_value := min(group, (integer) %Ran%.val );
											mid_range :=(max(group, (integer) %Ran%.val ) +  min(group, (integer) %Ran%.val ))/2;
											// median:= %Ran%[ROUNDUP(count(group)/2)].val;
											// median:= ROUNDUP(count(group)/2);
									  END;
			
	#UNIQUENAME(stat_data)
	%stat_data%   := table (%Ran%,%stat_group%, %Ran%.Attribute,%Ran%.Category,%Ran%.Distribution_type,%Ran%.SourceDescription,%Ran%.Attribute_value,%Ran%.Attribute_range);		

 op:=%stat_data%;
 
ENDMACRO;

EXPORT Outliers_Metrics_Macro(unique_col, infile, op) := MACRO

RulesFile:=Kel_Shell_QA.Rules_file;

// DS:=join(fileop(STD.Str.ToUpperCase(trim(fieldname,left,right))='INPUTFIRSTNAMEECHO'),
         // RF(STD.Str.ToUpperCase(trim(eclfieldname,left,right))='INPUTFIRSTNAMEECHO'),
				            // (STD.Str.ToUpperCase(trim(left.fieldname,left,right))='INPUTFIRSTNAMEECHO')= 
                    // (STD.Str.ToUpperCase(trim(right.eclfieldname,left,right))='INPUTFIRSTNAMEECHO'),inner);
	
	DS:=join(Distribute(infile,random()),RulesFile,STD.Str.ToUpperCase(trim(left.fieldname,left,right))= 
                      STD.Str.ToUpperCase(trim(right.eclfieldname,left,right)),inner,lookup);
										
// Checking Distributions for Default vs Valid vs Invalid vs special cases
#uniquename(lay)
%lay% := record
STRING Accountnumber;
// UNSIGNED6 InputLexID; 
STRING Attribute;
STRING Category;
STRING SourceDescription;
STRING Distribution_type;
STRING Result;
end;

#uniquename(tble)
%tble% := project(DS,transform({%lay%; recordof(DS)- {STRING Category;STRING SourceDescription;}},
                                     self.Accountnumber:=left.#expand(unique_col);
                                     self.Attribute:=left.fieldname;
																		 self.Category:=left.Category;
																		 self.SourceDescription:=left.SourceDescription;
																		 self:=left;		
																		 self:=[];
														  ))(Accountnumber<>'' and trim(OtherOutputRules,left,right) <> 'No BinSize' ) ;

// ************  calaculate Outliers  **************			
      #uniquename(set_ds)
			%set_ds%:=SET(%tble%,(real)field_value);
			
			#uniquename(call_getQuartile)
			%call_getQuartile%:=Kel_Shell_QA.getQuartile(%set_ds%);
			
			#uniquename(Interquartile_Range)
			%Interquartile_Range%:= (decimal10_2)%call_getQuartile%[1].Quartile3 - (decimal10_2)%call_getQuartile%[1].Quartile1;
			
			#uniquename(Upper_Bound)
			%Upper_Bound%:= (decimal10_2)%Interquartile_Range% *1.5 + (decimal10_2)%call_getQuartile%[1].Quartile3;
			
			#uniquename(Lower_Bound)
			%Lower_Bound%:=(decimal10_2)%call_getQuartile%[1].Quartile1 - (decimal10_2)%Interquartile_Range% *1.5;
			
			#uniquename(Outliers)
			%Outliers% :=	project(sort(%tble%,(decimal10_2)field_value),transform(%lay%, 	
																					self.Distribution_type:='Outliers';
																					self.Result:= if((real)left.field_value not between %Lower_Bound% and %Upper_Bound%,'PASS','FAIL');
																					self:=left;
																					self:=[];
																				 ));

      op:=%Outliers%;

ENDMACRO;

END;