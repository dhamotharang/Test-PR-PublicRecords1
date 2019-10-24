EXPORT Append_BIP_IDS := 'todo';

	dJoinAppendBdid	:= tools.mac_Append_BDID (dJoinCompAndCont  // Input Dataset for bdiding
											,'rawfields.Name'  																							// Company Name Field
											,['physical_address.prim_range','mailing_address.prim_range'	] // Set of Prim range fields
											,['physical_address.prim_name' ,'mailing_address.prim_name']    // Set of Prim name fields
											,['physical_address.zip'       ,'mailing_address.zip']          // Set of Zip fields
											,['physical_address.sec_range' ,'mailing_address.sec_range']    // Set of Secondary Range Fields
											,['physical_address.st'        ,'mailing_address.st']           // Set of State Fields
											,['clean_phones.phone'         ,'clean_phones.telex']						// Set of phone fields
											,'rid'																													// Unique Id Field in input dataset. 
											,'bdid'  																												// Bdid Field
											,  																															// Fein Field
											,  																															// Matchset for Bdid macro.
											,  																															// Bdid score field
											,Persistnames().AppendBdidCompanies  														// set this if you would like to persist the output
											,  																															// bdid score threshold
											,  																															// default to use prod version of superfiles
											,	   																														// default is to hit prod from dataland, and on prod hit prod.
											,'BIPV2.IDconstants.xlink_versions_BDID_BIP'   									//
											,'rawfields.url'					 																			// URL
											,'rawfields.e_mail'				 																			// Email
											,['physical_address.p_city_name','mailing_address.p_city_name'] // Set of city names
											,'fname'																												// Contact First Name 
											,'mname'				 																								// Contact Middle Name
											,'lname' 																												// Contact Last Name
											,																																// Contact SSN
											,'source'																												// source from MDR.sourceTools
											,'src_rid' );																										// source_rec_id field
