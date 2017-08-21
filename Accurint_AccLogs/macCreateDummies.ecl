import Inquiry_AccLogs;

export macCreateDummies(infile, outfile) := macro

#uniquename(sample1000)
#uniquename(f)
%sample1000% := project(enth(infile, 1, 100000, 1, local), transform({recordof(infile), unsigned %f%}, self.%f% := 1, self := left));

#uniquename(fUserCds)
#uniquename(user_id)
#uniquename(company_id)
%fUserCds% := dataset(
						[{'1024919','EINGELSGOV',1},
						{'1024919','EINGELSLE',1},
						{'1024919','EINGELSLE',1},
						{'1024919','EINGELSQAGOV',1},
						{'1024919','EINGELSQALE',1},
						{'1024919','MSTEELE1',1},
						{'1024919','MSTEELEGOV',1},
						{'1024919','MSTEELELE',1},
						{'1024919','MSTEELEQAGOV',1},
						{'1024919','MSTEELEQALE',1},
						{'1028669','EINGELSGOV',1},
						{'1028669','EINGELSGOV',1},
						{'1028669','EINGELSGOV',1},
						{'1028669','EINGELSGOV1',1},
						{'1028669','EINGELSGOV2',1},
						{'1028669','EINGELSGOV3',1},
						{'1028669','EINGELSGOV4',1},
						{'1028669','EINGELSLE',1},
						{'1028669','EINGELSLE',1},
						{'1028669','EINGELSQAGOV',1},
						{'1028669','EINGELSQAGOV',1},
						{'1028669','EINGELSQALE',1},
						{'1028669','EINGELSQALE',1},
						{'1028669','MSTEELEGOV',1},
						{'1028669','MSTEELEGOV',1},
						{'1028669','MSTEELEGOV',1},
						{'1028669','MSTEELEGOV1',1},
						{'1028669','MSTEELEGOV2',1},
						{'1028669','MSTEELEGOV3',1},
						{'1028669','MSTEELEGOV4',1},
						{'1028669','MSTEELELE',1},
						{'1028669','MSTEELELE',1},
						{'1028669','MSTEELEQAGOV',1},
						{'1028669','MSTEELEQAGOV',1},
						{'1028669','MSTEELEQALE',1},
						{'1028669','MSTEELEQALE',1},
						{'1031379','EINGELSCHILD',1},
						{'1031379','EINGELSCHILD2',1},
						{'1031379','EINGELSGOV',1},
						{'1031379','EINGELSLE',1},
						{'1031379','EINGELSQAGOV',1},
						{'1031379','EINGELSQALE',1},
						{'1031379','MSTEELECHILD',1},
						{'1031379','MSTEELEGOV',1},
						{'1031379','MSTEELELE',1},
						{'1031379','MSTEELEQAGOV',1},
						{'1031379','MSTEELEQALE',1},
						{'1032317','EINGELSCCP',1},
						{'1032317','EINGELSCCP2',1},
						{'1032317','EINGELSCCP3',1},
						{'1032317','EINGELSGOV',1},
						{'1032317','EINGELSLE',1},
						{'1032317','EINGELSQAGOV',1},
						{'1032317','EINGELSQALE',1},
						{'1032317','MSTEELECCP',1},
						{'1032317','MSTEELECCP2',1},
						{'1032317','MSTEELECCP3',1},
						{'1032317','MSTEELEGOV',1},
						{'1032317','MSTEELELE',1},
						{'1032317','MSTEELEQAGOV',1},
						{'1032317','MSTEELEQALE',1}], {string %company_id%, string %user_id%, unsigned %f%});

#uniquename(jnUsers)
%jnUsers% := dedup(join(%fUserCds%, Inquiry_AccLogs.File_Lookups.user_info,
								stringlib.stringtouppercase(left.%user_id%) = stringlib.stringtouppercase(right.login_id),
								transform({recordof(%fUserCds%), recordof(Inquiry_AccLogs.File_Lookups.user_info) - company_id},
									self.first_name := if(right.first_name = '', left.%user_id%[..1], right.first_name);
									self.last_name := if(right.last_name = '', left.%user_id%[2..7], right.last_name);
									self.status := 'A';
									self := left,
									self := right),
								left outer), record, all);


#uniquename(matchSamp)
%matchSamp% := dedup(join(%jnUsers%, %Sample1000%,
											left.%f% = right.%f%,
											transform(recordof(infile),
															self.orig_company_id := left.%company_id%;
															self.orig_user_companyname := 'CASE CONNECT TEST DUMMY RECORD';
															self.orig_loginid := stringlib.stringtouppercase(left.%user_id%);
															self.orig_billing_code := stringlib.stringtouppercase(left.%user_id%);
															self.orig_user_firstname := left.first_name;
															self.orig_user_lastname := left.last_name;
															self.orig_user_status := left.status;
															self.user_id := left.%user_id%;
															self.user_fname := stringlib.stringtouppercase(left.first_name);
															self.user_lname := stringlib.stringtouppercase(left.last_name);
															self.user_title := '';
															self.user_name_append := '';
															self.user_cname := 'CASE CONNECT TEST DUMMY RECORD';
															self := right)), record, all);
																								
outfile := project(%matchSamp%, transform(recordof(infile),
																								self.record_id := counter,
																								self := left)) + infile;
								
							
endmacro;
