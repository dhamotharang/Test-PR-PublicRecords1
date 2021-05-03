// Translate legacy ppc to new ppc codes according to Mapping provided by product
// 1- Join transactions to mapping definition
// 2- Keep new ppc codes if they were already logged
// 3- Translate legacy ppc to new ppc codes for transactions matching all mapping
// 4- Translate legacy ppc to default new ppc codes
// 5- Translate legacy ppc to exception new ppc codes 

export FN_Convert_PPC(dataset(inql_FFD.Layouts.Input_Formatted) pInFile) := Module

ppc					:= 	project(inql_ffd.files().PPC_Mapping, transform(inql_ffd.Layouts.PPC_Mapping,
									 boolean isRiskview			:= regexfind('RiskView',left.FCRA_product);
									 boolean isEquifax 			:= regexfind('Equifax',left.FCRA_product);
									 boolean isGov					:= regexfind('Government',left.FCRA_product);
									 boolean isCollection		:= regexfind('Collection',left.FCRA_product); 
									 boolean isNewCodeBlank := trim(left.New_Code) = '';
									 self.isRiskview				:= isRiskview;
									 self.isEquifax 				:= isEquifax and ~isRiskview;
									 self.isGov							:= isGov and (~isEquifax and ~isRiskview);
									 self.isCollection			:= isCollection and (~isEquifax and ~isRiskview and ~isGov);
									 self.isAny     				:= (~isEquifax and ~isRiskView and ~isGov and ~isCollection);
									 self										:= left;
									 ));

ppcmap			:=	dedup(table(ppc,{isAny,isEquifax,isGov,isCollection,isRiskview,
                                 Legacy_FCRA_Purpose_Code,New_Code}),all);
														 
newppc_set	:=	set(dedup(table(ppc(new_code<>''),{New_Code}),all),New_Code);

input_flagged := project(pinFile,transform(Inql_FFD.Layouts.Input_PPC_Xlated,
                 boolean isNewCode    :=  left.ppc in newppc_set;
								 boolean isRiskView		:=  regexfind('RWS',left.product_code);
                 boolean isEquifax 		:=  regexfind('ConsCredRpt',left.function_name);
								 boolean isGov		 		:= (regexfind('GCOL',left.product_code) or
																					regexfind('GEL',left.product_code));								 ;
								 boolean isCollection	:= (regexfind('FCOL',left.product_code) or 
																					regexfind('TCOL',left.product_code));
								 self.isNewCode  		:= isNewCode;
								 self.isRiskview 		:= isRiskView and ~isNewCode;
								 self.isEquifax  		:= isEquifax and (~isNewCode and ~isRiskView);
								 self.isGov      		:= isGov and (~isNewCode and ~isRiskView and ~isEquifax);
								 self.isCollection 	:= isCollection and (~isNewCode and ~isRiskView and ~isEquifax and ~isGov);
								 self								:= left;
								 ));

input_with_new_code := project(input_flagged(isNewCode),transform(Inql_FFD.Layouts.Input_PPC_Xlated,
                                                                self.newppc:=left.ppc;
                                                                self:=left;));

input_with_mapping := join(input_flagged(~isNewCode),ppcmap,
																left.isEquifax 		= right.isEquifax and 
																left.isRiskView 	= right.isRiskView and
																left.isGov 				= right.isGov and
																left.isCollection = right.isCollection and
																left.ppc 			    = right.Legacy_FCRA_Purpose_Code,
																lookup, left outer);
								
input_mapped_to_new_code := 	project(input_with_mapping(New_Code<>''),
																transform(Inql_FFD.Layouts.Input_PPC_Xlated, 
																					self.newppc := left.New_code, 
																					self:=left;
																));
								
input_mapped_to_new_code_default   := join(input_with_mapping(New_Code=''), ppcmap(isAny), 
																			left.ppc = right.Legacy_FCRA_Purpose_Code,
																			transform(Inql_FFD.Layouts.Input_PPC_Xlated,
																								self.newppc :=if(trim(right.New_Code)<>'',right.New_Code,left.newppc);
																								self:=left;),
																				lookup, left outer);
																				
mapped_input_all      					:= (input_with_new_code + 
                                    input_mapped_to_new_code + 
																		input_mapped_to_new_code_default);

mapped_input_no_exception    		:= mapped_input_all (newppc <> 'No xlated PPC Found');

mapped_input_exception_applied 	:= project(mapped_input_all(newppc = 'No xlated PPC Found'),
																					transform(recordof(mapped_input_all), 
																					self.newppc := if(left.product_code  = 'ACC'  and left.ppc='100','110',
																					               if(left.product_code <> 'RWS'  and left.ppc='164','113',
																												 if(left.product_code  = 'RWS', '0',
																												 if(left.ppc  = '0', '',
																											      left.newppc))));
																					self:=left;
																));

export mapped_input := mapped_input_no_exception + mapped_input_exception_applied;

export xlated_ppc 	:= project(mapped_input (newppc <> 'No xlated PPC Found'), 
                               transform(Inql_FFD.Layouts.Input_Formatted,
																				self.ppc := left.newppc;
																				self     := left;));
  


end;