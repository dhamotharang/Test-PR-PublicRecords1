import std;

pF := project(Score_Logs.fn_uncompressXML(Score_Logs.Files.FCRA_Transaction), transform({string source, string filt, Score_Logs.Layouts.Input}, self.outputxml := trim(left.outputxml, left, right), self.inputxml := trim(left.inputxml, left, right), self.source := 'F', self.filt := left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], self := left));//changed
pNF := project(Score_Logs.fn_uncompressXML(Score_Logs.Files.NonFCRA_Transaction), transform({string source, string filt, Score_Logs.Layouts.Input}, self.outputxml := trim(left.outputxml, left, right), self.inputxml := trim(left.inputxml, left, right), self.source := 'NF', self.filt := left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], self := left));//changed

p := (pF + pNF)(filt <> ''
								and length(transaction_id) between 1 and 30
								and input_recordtype in ['XML','B64CMPXML']
								and output_recordtype in ['XML', 'B64CMPXML']
								and datetime <> ''
								);

p_all := project(p,
								transform({string filtA := '', string filtB := '', string filtC, string filtD, string filtE, string outputxml2,
													 string filt1, string filt2, string filt3, string filt4, string filt5, string inputxml2,
								            Score_Logs.Layouts.Input, string source}, 
								  // //error checking//
									self.filt1 := left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)];
									self.filt2 := stringlib.stringfindreplace(left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], '<', '</');

									self.filt3 := stringlib.stringfilterout(self.filt1, '<>');
									self.filt4 := '<Info><Product>' + self.filt3 + '</Product>';
									self.filt5 := '</Info>';						

									self.filtC := stringlib.stringfilterout(self.filt1, '<>');
									self.filtD := '<OutResults><Product>' + self.filt3 + '</Product>';
									self.filtE := '</OutResults>';
									// //done error checking//
									
									inputxmla := regexreplace(left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], left.inputxml, '<Info><Product>' + self.filt3 + '</Product>'); 
									inputxmlb := regexreplace(stringlib.stringfindreplace(left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], '<', '</'), inputxmla, '</Info>');

									inputxmla1 := '<OutResults><Product>' + self.filt3 + '</Product>' + left.outputxml; 
									inputxmlb1 := inputxmla1 + '</OutResults>';
									
									self.inputxml2 := stringlib.stringcleanspaces(regexreplace('<WatchList>ALL</WatchList>',inputxmlb, '<WatchList><All>ALL</All></WatchList>', nocase));
									self.outputxml2 := stringlib.stringcleanspaces(regexreplace('<WatchList>ALL</WatchList>',inputxmlb1, '<WatchList><All>ALL</All></WatchList>', nocase));
									
									self := left));

//allow required SAO transactions in the build								
p_all_filter :=p_all(stringlib.stringtouppercase(filt3) in Score_logs.set_product or trim(customer_id,left,right) = '4');

p2 := PROJECT(p_all_filter, TRANSFORM(Score_Logs.Layouts.Base_Transaction_Layout,

											Score_Logs.Layouts_InputXML.rform1 fields1	:= FROMXML(Score_Logs.Layouts_InputXML.rform1, left.inputxml2
														,trim, ONFAIL(transform(Score_Logs.Layouts_InputXML.rform1,self.product:=failmessage,SELF:=[])));
											self.inputxml_parsed := fields1;
											
											Score_Logs.Layouts_OutputXML.rform1 fields2	:= FROMXML(Score_Logs.Layouts_OutputXML.rform1, left.outputxml2
														,trim, ONFAIL(transform(Score_Logs.Layouts_OutputXML.rform1,self.product:=failmessage,SELF:=[])));
											self.outputxml_parsed := fields2;
											
											self.product := left.filt3;
											self.datetime := stringlib.stringfilter(left.datetime, ' 0123456789');

											self := left;
											self := []));

EXPORT fn_ParseXML := p2;