import American_student_list;

export create_american_student_superfiles() := 
macro
#uniquename(CreateSuperBase)
#uniquename(CreateSuperBaseFiles)
#uniquename(CreateSuperIn)
#uniquename(CreateSuperInFiles)
#uniquename(CreateSuperKeyAddr)
#uniquename(CreateSuperKeyAddrFiles)
#uniquename(CreateSuperKeyDID)
#uniquename(CreateSuperKeyDIDFiles)

%CreateSuperBase% := sequential(FileServices.CreateSuperFile(American_student_list.cluster + 'base::american_student_list',false),
																 FileServices.CreateSuperFile(American_student_list.cluster + 'base::american_student_list_Delete',false),
																 FileServices.CreateSuperFile(American_student_list.cluster + 'base::american_student_list_Father',false),
																 FileServices.CreateSuperFile(American_student_list.cluster + 'base::american_student_list_Grandfather',false));																										
																
%CreateSuperBaseFiles% := if (~FileServices.SuperFileExists(American_student_list.cluster + 'base::american_student_list') and
                              ~FileServices.SuperFileExists(American_student_list.cluster + 'base::american_student_list_Delete') and
															~FileServices.SuperFileExists(American_student_list.cluster + 'base::american_student_list_Father') and
															~FileServices.SuperFileExists(American_student_list.cluster + 'base::american_student_list_Grandfather'),
															%CreateSuperBase%,
															output('cannot create base files')); 
															
%CreateSuperIn% := sequential(FileServices.CreateSuperFile(American_student_list.cluster + 'in::american_student_list::delete',false),
															FileServices.CreateSuperFile(American_student_list.cluster + 'in::american_student_list::old',false),
															FileServices.CreateSuperFile(American_student_list.cluster + 'in::american_student_list::superfile',false));
																 																										
																
%CreateSuperInFiles% := if (~FileServices.SuperFileExists(American_student_list.cluster + 'in::american_student_list::delete') and
                            ~FileServices.SuperFileExists(American_student_list.cluster + 'in::american_student_list::old') and
														~FileServices.SuperFileExists(American_student_list.cluster + 'in::american_student_list::superfile'),
														%CreateSuperIn%,
														output('cannot create in files')); 
														
%CreateSuperKeyAddr% := sequential(FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_built',false),
																	 FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_delete',false),
																	 FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_father',false),
																	 FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_grandfather',false),
																	 FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_great_grandfather',false),
																	 FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_prod',false),
																	 FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_address_qa',false));
																 																										
																
%CreateSuperKeyAddrFiles% := if (~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_built') and
																 ~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_delete') and
																 ~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_father') and
																 ~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_grandfather') and
																 ~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_great_grandfather') and
																 ~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_prod') and
																 ~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_address_qa'),
																 %CreateSuperKeyAddr%,
																 output('cannot create key addr files')); 

%CreateSuperKeyDID% := sequential(FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_built',false),
																	FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_delete',false),
																	FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_father',false),
																	FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_grandfather',false),
																	FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_great_grandfather',false),
																	FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_prod',false),
																	FileServices.CreateSuperFile(American_student_list.cluster + 'key::american_student_did_qa',false));
																 																										
																
%CreateSuperKeyDIDFiles% := if (~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_built') and
																~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_delete') and
																~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_father') and
																~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_grandfather') and
																~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_great_grandfather') and
																~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_prod') and
																~FileServices.SuperFileExists(American_student_list.cluster + 'key::american_student_did_qa'),
																%CreateSuperKeyDID%,
																output('cannot create key DID files')); 

#uniquename(do_super_base)
#uniquename(do_super_in)
#uniquename(do_super_key_addr)
#uniquename(do_super_key_did)

%do_super_base% := sequential(output('do super base...'),%CreateSuperBaseFiles%);
%do_super_in% := sequential(output('do super in...'),%CreateSuperInFiles%);
%do_super_key_addr% := sequential(output('do super key addr...'),%CreateSuperKeyAddrFiles%);
%do_super_key_did% := sequential(output('do super key DID...'),%CreateSuperKeyDIDFiles%);

parallel(%do_super_base%
					// ,
				 // %do_super_in%,
				 // %do_super_key_addr%,
				 // %do_super_key_did%
				);

endmacro;