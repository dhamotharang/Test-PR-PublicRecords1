import std;

pF := project(Score_Logs.Files.FCRA_Transaction, transform({string source, string filt, Score_Logs.Layouts.Input}, self.outputxml := trim(left.outputxml, left, right), self.inputxml := trim(left.inputxml, left, right), self.source := 'F', self.filt := left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], self := left));//changed
pNF := project(Score_Logs.Files.NonFCRA_Transaction, transform({string source, string filt, Score_Logs.Layouts.Input}, self.outputxml := trim(left.outputxml, left, right), self.inputxml := trim(left.inputxml, left, right), self.source := 'NF', self.filt := left.inputxml[1..stringlib.stringfind(left.inputxml, '>', 1)], self := left));//changed

p0 := (pF + pNF)(filt <> '' and length(transaction_id) between 1 and 30 and input_recordtype = 'XML' and output_recordtype = 'XML' and datetime <> ''
			and	STD.Str.FindCount(inputxml,'<') = STD.Str.FindCount(inputxml,'>')
			and STD.Str.FindCount(inputxml,'>') = STD.Str.FindCount(inputxml,'</')*2 + STD.Str.FindCount(inputxml,'/>')
			and STD.Str.FindCount(outputxml,'<') = STD.Str.FindCount(outputxml,'>')
			and STD.Str.FindCount(outputxml,'>') = STD.Str.FindCount(outputxml,'</')*2 + STD.Str.FindCount(outputxml,'/>')
			);

PATTERN BadTag := PATTERN('(<.* [^<>=\']+>)');
p1:=PARSE(p0,inputxml,BadTag,{boolean do_not_use_input := MATCHTEXT(BadTag),p0},NOT MATCHED);
p:=PARSE(p1,outputxml,BadTag,{boolean do_not_use_output := MATCHTEXT(BadTag),p1},NOT MATCHED);

p_all := project(p(not do_not_use_input and not do_not_use_output),
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

p2 := PROJECT(p_all, TRANSFORM(Score_Logs.Layouts.Base_Transaction_Layout,

											Score_Logs.Layouts_InputXML.rform1 fields1	:= FROMXML(Score_Logs.Layouts_InputXML.rform1, left.inputxml2);
											self.inputxml_parsed := fields1;
											
											Score_Logs.Layouts_OutputXML.rform1 fields2	:= FROMXML(Score_Logs.Layouts_OutputXML.rform1, left.outputxml2);
											self.outputxml_parsed := fields2;
											
											self.product := left.filt3;
											self.datetime := stringlib.stringfilter(left.datetime, ' 0123456789');

											self := left;
											self := []));

EXPORT fn_ParseXML := p2;