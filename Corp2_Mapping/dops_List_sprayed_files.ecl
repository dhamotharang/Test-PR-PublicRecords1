import STD,ut;
#workunit('name','Corporate List of Contents of all corp Superfiles to procees in Next Build');
#workunit('priority','high');
#workunit('priority',14);
filedate :=ut.GetDate;
spray_super_ar_old    := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::sprayed::ar'));
spray_super_cont_old  := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::sprayed::cont'));
spray_super_corp_old  := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::sprayed::corp'));
spray_super_event_old := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::sprayed::event'));
spray_super_stock_old := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::sprayed::stock'));


// once back in production ecl, changed used filename to used.
spray_super_ar    := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::mapped::sprayed::ar'))		: independent;
spray_super_main  := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::mapped::sprayed::main')) 	: independent;
spray_super_event := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::mapped::sprayed::event')) : independent;
spray_super_stock := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::mapped::sprayed::stock')) : independent;


new_ly := record
string name;
string date;
string st;
string version;
end;

inSet := ['f','q','l','p','m','t'];

combined_ds_Old :=  spray_super_corp_old; // & spray_super_cont & used_super_event & used_super_stock & used_super_ar;

processed_ds_old := dedup(sort(project(combined_ds_Old,
                          transform(new_ly,
									    self.name := MAP(stringlib.StringFind(left.name, 'lp',1) > 0  => left.name[1..33] + 'p' + left.name[34..(LENGTH(left.name))],
			            		                         stringlib.StringFind(left.name, 'llc',1) > 0  => left.name[1..33] + 'l' + left.name[34..(LENGTH(left.name))],
														 stringlib.StringFind(left.name, 'monthly',1) > 0  => left.name[1..33] + 'm' + left.name[34..(LENGTH(left.name))],
														 stringlib.StringFind(left.name, 'fltm',1) > 0 => left.name[1..33] + 't' + left.name[34..(LENGTH(left.name))],
									                     left.name),										
																 
  					              		self.st := IF(STD.Str.Find(left.name,'fltm',1) > 0, 
									                'FL',
													STD.Str.ToUpperCase(left.name[length(left.name) - 1.. length(left.name)])),			
	 											    ColonPos	:=	stringlib.StringFind(self.name, '::',4);
												    self.date := self.name[26..colonPos-1],
												    self.version := filedate,
												    self := left)),st,date,version),st,date,version);
																			
processed_table_old := SORT(TABLE(processed_ds_old, {processed_ds_old.st, processed_ds_old.date, processed_ds_old.version } ),st,date);

combined_ds_New :=  spray_super_main; // &  used_super_cont & used_super_event & used_super_stock & used_super_ar;

processed_ds_new := dedup(sort(project(combined_ds_New,
                          transform(new_ly,
 						           self.name := MAP(stringlib.StringFind(left.name, 'lp',1) > 0  => left.name[1..33] + 'p' + left.name[34..(LENGTH(left.name))],
     		                            stringlib.StringFind(left.name, 'llc',1) > 0  => left.name[1..33] + 'l' + left.name[34..(LENGTH(left.name))],
									       			      stringlib.StringFind(left.name, 'monthly',1) > 0  => left.name[1..33] + 'm' + left.name[34..(LENGTH(left.name))],
													          stringlib.StringFind(left.name, 'fltm',1) > 0 => left.name[1..33] + 't' + left.name[34..(LENGTH(left.name))],
													          left.name),										
																											 
									self.st := IF(STD.Str.Find(left.name,'fltm',1) > 0, 
									             'FL',
												       STD.Str.ToUpperCase(left.name[length(left.name) - 1.. length(left.name)])),			
										    	     ColonPos	:=	stringlib.StringFind(self.name, '::',4);
									self.date := self.name[26..colonPos-1],
									self.version := filedate,
									self := left)),st,date,version),st,date,version);
																		
processed_table_new := SORT(TABLE(processed_ds_new, {processed_ds_new.st, processed_ds_new.date, processed_ds_new.version } ),st,date);
																	
processed_table	:=	processed_table_new + processed_table_old;
a := SORT(TABLE(processed_table, {processed_table.st, processed_table.date, processed_table.version } ),st,date);

output(a,NAMED('Procesing_using_as_of_' + filedate),all);
