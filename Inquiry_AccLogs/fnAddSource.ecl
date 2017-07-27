export fnAddSource(dataset(Inquiry_AccLogs.Layout.Common) infile, string strsource) := function

addsource_layout := record Inquiry_AccLogs.Layout.Common, string source, end;

pr := project(infile, transform(addsource_layout,
																	self.source := strsource,
																	self := left));
																	
return pr;
end;

