import STD,Corp2_Mapping, address;
export List_using(string filedate, boolean movefiles) := function

// once back in production ecl, changed used filename to used.
used_super_main  := nothor(fileservices.SuperFileContents ('~thor_data400::in::corp2::mapped::sprayed::main')) 	: independent;

new_ly := record
string name;
string date;
string st;
string version;
end;

inSet := ['f','q','l','p','m','t'];

combined_ds_New :=  used_super_main; 

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
																			
processed_table_new 	:= SORT(TABLE(processed_ds_new, {processed_ds_new.st, processed_ds_new.date, processed_ds_new.version } ),st,date);
															
processed_table	:=	sort(processed_table_new,st,date);

a:=output(processed_table,Named('processed_table'),all);	

output_table :=  SORT(TABLE(processed_table,{processed_table.st, processed_table.date, filedate} ),st,date);

b:=OUTPUT(output_table,,'~thor400::corpsv2::processed_' +filedate,COMPRESSED,Overwrite);

// In order to know what states are being processed in this build downstream, add the list of states to a superfile. We only run NID/AID against those states being processed.
StateFile	:=	output(project(dedup(sort(output_table,st),st),transform(Corp2_Mapping.LayoutsCommon.ProcessedStates, self.state	:=	left.st;)),,'~thor400::corpsv2::processedStates_' +filedate,COMPRESSED,Overwrite);

c:= sequential(	
								FileServices.StartSuperFileTransaction(),
								FileServices.ClearSuperFile('~thor_data400::in::Corp2::StatesProcessed::Super'),
								FileServices.AddSuperFile('~thor_data400::in::Corp2::StatesProcessed::Super', '~thor400::corpsv2::processedStates_' +filedate),				 
								FileServices.FinishSuperFileTransaction()
							);

final_move := if(movefiles = true,
                nothor(fileservices.addsuperfile('~thor_data400::corpv2::processed','~thor400::corpsv2::processed_' +filedate ))
	            );
					
 return 
   sequential(a
							,b
							,statefile
							,c,final_move);
										
end;
