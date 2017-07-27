pF_int := PROJECT(Score_Logs.Files.FCRA_Intermediate, TRANSFORM({STRING source, Score_Logs.Layouts.Input_Intermediate}, 
									SELF.outputxml :=  '<OutResults>' + LEFT.outputxml + '</OutResults>'; 
									SELF := LEFT;
									SELF.source := 'F'));
									
pNF_int := PROJECT(Score_Logs.Files.NonFCRA_Intermediate, TRANSFORM({STRING source, Score_Logs.Layouts.Input_Intermediate}, 
									SELF.outputxml :=  '<OutResults>' + LEFT.outputxml + '</OutResults>'; 
									SELF := LEFT;
									SELF.source := 'NF'));

pALL_int := (pNF_int+pF_int)(length(transaction_id) between 1 and 30 and
															 stringlib.stringfind(outputxml, '<Row><wrapper><Row>', 1) > 0 and
															 stringlib.stringfind(outputxml, '</Row></wrapper></Row>', 1) > 0);
										
p2_int := PROJECT(pALL_int, TRANSFORM(Score_Logs.Layouts.Base_Intermediate_Layout,
											clean(STRING zero) := FUNCTION
															one := stringlib.stringfindreplace(zero, '</Row></wrapper></Row>', '');
															two := stringlib.stringfindreplace(one, '<Row><wrapper><Row>', '');
											RETURN two;
											END;
																				
											Score_Logs.Layouts_OutputXML_Intermediate.rform1 fields2	:= 
																																FROMXML(Score_Logs.Layouts_OutputXML_Intermediate.rform1, clean(left.outputxml));
											
											SELF.outputxml_parsed := fields2;
											SELF.datetime := stringlib.stringfilter(LEFT.datetime, ' 0123456789');
											SELF.product_code := MAP(SELF.datetime[..8] <= '20130506' AND LEFT.product_id BETWEEN '3' AND '8' => '1', 
																							 SELF.datetime[..8] <= '20130506' AND LEFT.product_id NOT BETWEEN '3' AND '8' => '2',
																							 SELF.datetime[..8] <= '20130524' AND LEFT.product_id = '7' => '1', //remove when brent pahl makes his changes to the intermediate logs
																							 LEFT.product_id); 
											SELF := LEFT;
											SELF := []));	
											
EXPORT fn_ParseXML_Intermediate := p2_int;