Import Healthcare_Cleaners;
EXPORT Functions_Commonized := Module
	Export getCleanNameAddr (dataset(Healthcare_Shared.Layouts.userInputCleanMatch) inRec) := function
		//Web will send in FML or parsed
		//Batch will send in unparsed with FML flag
		getCleanNameFmt := project(inRec,Transform(Healthcare_Cleaners.Layouts.rawNameInput,
																								self.acctno := left.acctno;
																								self.nameFull := left.name_full;
																								// self.isLFM := left.isLFM;
																								self.nameFirst := left.name_first;
																								self.nameMiddle := left.name_middle;
																								self.nameLast := left.name_last;
																								self.nameSuffix := left.name_suffix;
																								self.nameProfessionalSuffix := left.name_prof_suffix;
																								self.namePrefix := left.name_title));
		getCleanName := project(getCleanNameFmt,transform(Healthcare_Shared.Layouts.userInputCleanMatch,
															//if they provided me a parsed last name field don't bother to clean.
															doClean := left.nameFull <> '' or (left.nameFirst <>'' and left.nameLast <> '');
															getClnName:= if(doClean,Healthcare_Cleaners.Functions.doNameClean(left)[1],dataset([],Healthcare_Cleaners.Layouts.cleanNameOutput)[1]);
															self.name_first		:= if(doClean,getClnName.fname,left.nameFirst);
															self.name_middle	:= if(doClean,getClnName.mname,left.nameMiddle);
															self.name_last		:= if(doClean,getClnName.lname,left.nameLast);
															self.name_suffix	:= if(doClean,getClnName.name_suffix,left.nameSuffix);
															self.name_prof_suffix := if(doClean,getClnName.name_prof,left.nameProfessionalSuffix);
															self.name_title 	:= if(doClean,getClnName.name_title,left.namePrefix);
															self.clnName 			:= getClnName;
															self:=left;
															self:=[];));
		inputWithCleanName := join(inRec,getCleanName,left.acctno=right.acctno,
																		transform(Healthcare_Shared.Layouts.userInputCleanMatch,
																					//Store Entire clean and put clean fields in regular input fields
																					goodClean := right.name_first<>'' and right.name_last<>'';//If good clean then use all the clean values
																					self.clnName 			:= right.clnName;
																					self.name_first		:= if(goodClean,right.name_first,left.name_first);
																					self.name_middle	:= if(goodClean,right.name_middle,left.name_middle);
																					self.name_last		:= if(goodClean,right.name_last,left.name_last);
																					self.name_suffix	:= if(goodClean,right.name_suffix,left.name_suffix);
																					self.name_prof_suffix	:= if(right.name_prof_suffix<>'',right.name_prof_suffix,left.name_prof_suffix);
																					self.name_title		:= if(right.name_title<>'',right.name_title,left.name_title);
																					self:=left;
																					self:=[];),left outer,
																					keep(Healthcare_Shared.Constants.BEST_ID), limit(0));
																					
		//Web will send in Address1 and city state and zip or parsed
		//Batch will send in Address1 and address2
		getCleanAddrFmt := project(inputWithCleanName,Transform(Healthcare_Cleaners.Layouts.rawAddressInput,
																								self.acctno := left.acctno;
																								self.addressLine1 := left.AddressLine1;
																								self.addressLine2 := left.AddressLine2;
																								self.prim_range := left.prim_range;
																								self.predir := left.predir;
																								self.prim_name := left.prim_name;
																								self.addr_suffix := left.addr_suffix;
																								self.postdir := left.postdir;
																								self.unit_desig := left.unit_desig;
																								self.sec_range := left.sec_range;
																								self.p_city_name := left.p_city_name;
																								self.st := left.st;
																								self.z5 := left.z5;));
		getCleanAddr := project(getCleanAddrFmt,transform(Healthcare_Shared.Layouts.userInputCleanMatch,
															//if they provided me a parsed street Name field don't bother to clean.
															doClean := left.addressLine1 <> '' or (left.prim_range <>'' and left.prim_name <> '' and ((left.p_city_name<>'' and left.st<>'') or left.z5<>''));
															getClnAddr:= if(doClean,Healthcare_Cleaners.Functions.doAddressClean(left,true,true)[1],dataset([],Healthcare_Cleaners.Layouts.cleanAddressOutput)[1]);
															self.prim_range 		:= if(doClean,getClnAddr.prim_range,left.prim_range);
															self.predir					:= if(doClean,getClnAddr.predir,left.predir);
															self.prim_name			:= if(doClean,getClnAddr.prim_name,left.prim_name);
															self.addr_suffix		:= if(doClean,getClnAddr.addr_suffix,left.addr_suffix);
															self.postdir				:= if(doClean,getClnAddr.postdir,left.postdir);
															self.unit_desig			:= if(doClean,getClnAddr.unit_desig,left.unit_desig);
															self.sec_range			:= if(doClean,getClnAddr.sec_range,left.sec_range);
															self.p_city_name		:= if(doClean,getClnAddr.p_city_name,left.p_city_name);
															self.st							:= if(doClean,getClnAddr.st,left.st);
															self.z5							:= if(doClean,getClnAddr.zip,left.z5);
															self.zip4						:= if(doClean,getClnAddr.zip4,'');
															self.clnAddr 				:= getClnAddr;
															self:=left;
															self:=[];));
		inputWithCleanAddr := join(inputWithCleanName,getCleanAddr,left.acctno=right.acctno,
																		transform(Healthcare_Shared.Layouts.userInputCleanMatch,
																					//Store Entire clean and put clean fields in regular input fields
																					goodClean := right.clnAddr.err_type<>'E';//If good clean then use all the clean values
																					doClean := left.addressLine1 <> '' or (left.prim_range <>'' and left.prim_name <> '' and ((left.p_city_name<>'' and left.st<>'') or left.z5<>''));
																					self.clnAddr 				:= right.clnAddr;
																					self.prim_range 		:= if(goodClean and doClean,right.prim_range,left.prim_range);
																					self.predir					:= if(goodClean and doClean,right.predir,left.predir);
																					self.prim_name			:= if(goodClean and doClean,right.prim_name,left.prim_name);
																					self.addr_suffix		:= if(goodClean and doClean,right.addr_suffix,left.addr_suffix);
																					self.postdir				:= if(goodClean and doClean,right.postdir,left.postdir);
																					self.unit_desig			:= if(goodClean and doClean,right.unit_desig,left.unit_desig);
																					self.sec_range			:= if(goodClean and doClean,right.sec_range,left.sec_range);
																					self.p_city_name		:= if(goodClean and doClean,right.p_city_name,left.p_city_name);
																					self.st							:= if(goodClean and doClean,right.st,left.st);
																					self.z5							:= if(goodClean and doClean,right.z5,left.z5);
																					self.zip4						:= if(goodClean and doClean and right.zip4<>'',right.zip4,Left.zip4);
																					self:=left;
																					self:=[];),left outer,
																					keep(Healthcare_Shared.Constants.BEST_ID), limit(0));

		//Web will send in Address1 and city state and zip or parsed
		//Batch will send in Address1 and address2
		getCleanBillAddrFmt := project(inputWithCleanAddr,Transform(Healthcare_Cleaners.Layouts.rawAddressInput,
																								doClean := left.bill_AddressLine1 <> '' or (left.bill_prim_range <>'' and left.bill_prim_name <> '' and ((left.bill_p_city_name<>'' and left.bill_st<>'') or left.bill_z5<>''));
																								self.acctno := if(doClean,left.acctno,skip);
																								self.addressLine1 := left.bill_AddressLine1;
																								self.addressLine2 := left.bill_AddressLine2;
																								self.prim_range := left.bill_prim_range;
																								self.predir := left.bill_predir;
																								self.prim_name := left.bill_prim_name;
																								self.addr_suffix := left.bill_addr_suffix;
																								self.postdir := left.bill_postdir;
																								self.unit_desig := left.bill_unit_desig;
																								self.sec_range := left.bill_sec_range;
																								self.p_city_name := left.bill_p_city_name;
																								self.st := left.bill_st;
																								self.z5 := left.bill_z5;));
		getCleanBillAddr := project(getCleanBillAddrFmt,transform(Healthcare_Shared.Layouts.userInputCleanMatch,
															//if they provided me a parsed street Name field don't bother to clean.
															doClean := left.addressLine1 <> '' or (left.prim_range <>'' and left.prim_name <> '' and ((left.p_city_name<>'' and left.st<>'') or left.z5<>''));
															getClnBillAddr:= if(doClean,Healthcare_Cleaners.Functions.doAddressClean(left,true,true)[1],dataset([],Healthcare_Cleaners.Layouts.cleanAddressOutput)[1]);
															self.bill_prim_range	:= if(doClean,getClnBillAddr.prim_range,left.prim_range);
															self.bill_predir			:= if(doClean,getClnBillAddr.predir,left.predir);
															self.bill_prim_name		:= if(doClean,getClnBillAddr.prim_name,left.prim_range);
															self.bill_addr_suffix	:= if(doClean,getClnBillAddr.addr_suffix,left.addr_suffix);
															self.bill_postdir			:= if(doClean,getClnBillAddr.postdir,left.postdir);
															self.bill_unit_desig	:= if(doClean,getClnBillAddr.unit_desig,left.unit_desig);
															self.bill_sec_range		:= if(doClean,getClnBillAddr.sec_range,left.sec_range);
															self.bill_p_city_name	:= if(doClean,getClnBillAddr.p_city_name,left.p_city_name);
															self.bill_st					:= if(doClean,getClnBillAddr.st,left.st);
															self.bill_z5					:= if(doClean,getClnBillAddr.zip,left.z5);
															self.bill_zip4				:= if(doClean,getClnBillAddr.zip4,'');
															self.clnBillAddr 			:= getClnBillAddr;
															self:=left;
															self:=[];));
		inputWithCleanBillAddr := join(inputWithCleanAddr,getCleanBillAddr,left.acctno=right.acctno,
																		transform(Healthcare_Shared.Layouts.userInputCleanMatch,
																					goodClean := right.clnBillAddr.err_type<>'E';//If good clean then use all the clean values
																					doClean := left.bill_AddressLine1 <> '' or (left.bill_prim_range <>'' and left.bill_prim_name <> '' and ((left.bill_p_city_name<>'' and left.bill_st<>'') or left.bill_z5<>''));
																					self.clnBillAddr 				:= right.clnBillAddr;
																					self.bill_prim_range 		:= if(goodClean and doClean,right.bill_prim_range,left.bill_prim_range);
																					self.bill_predir				:= if(goodClean and doClean,right.bill_predir,left.bill_predir);
																					self.bill_prim_name			:= if(goodClean and doClean,right.bill_prim_name,left.bill_prim_name);
																					self.bill_addr_suffix		:= if(goodClean and doClean,right.bill_addr_suffix,left.bill_addr_suffix);
																					self.bill_postdir				:= if(goodClean and doClean,right.bill_postdir,left.bill_postdir);
																					self.bill_unit_desig		:= if(goodClean and doClean,right.bill_unit_desig,left.bill_unit_desig);
																					self.bill_sec_range			:= if(goodClean and doClean,right.bill_sec_range,left.bill_sec_range);
																					self.bill_p_city_name		:= if(goodClean and doClean,right.bill_p_city_name,left.bill_p_city_name);
																					self.bill_st						:= if(goodClean and doClean,right.bill_st,left.bill_st);
																					self.bill_z5						:= if(goodClean and doClean,right.bill_z5,left.bill_z5);
																					self.bill_zip4					:= if(goodClean and doClean and right.bill_zip4<>'',right.bill_zip4,Left.bill_zip4);
																					self:=left;
																					self:=[];),left outer,
																					keep(Healthcare_Shared.Constants.BEST_ID), limit(0));
		return inputWithCleanBillAddr;
	end;
End;