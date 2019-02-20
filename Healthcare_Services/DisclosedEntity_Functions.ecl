import iesp, Address, AutoStandardI, doxie, DeathV2_Services, Healthcare_Header_Services;

EXPORT DisclosedEntity_Functions := MODULE
	shared myLayout:=Healthcare_Services.DisclosedEntity_Layouts;
	
	export cleanInputName(string inName) := function
		return Address.CleanNameFields(Address.CleanPerson73(inName)).CleanNameRecord;
	end;
	export processIndividualInput(iesp.disclosed_entity_search.t_DisclosedEntitySearchByIndividual inRec) := function
		doClnName := inRec.Individual.Name.Full <> '';
		clnName := cleanInputName(inRec.Individual.Name.Full);
		returnVal := project(inRec, transform(myLayout.PersonLayout, 
																					self.FirstName:=stringlib.StringToUpperCase(if(doClnName,clnName.fname,inRec.Individual.Name.First));
																					self.MiddleName:=stringlib.StringToUpperCase(if(doClnName,clnName.mname,inRec.Individual.Name.Middle));
																					self.LastName:=stringlib.StringToUpperCase(if(doClnName,clnName.lname,inRec.Individual.Name.Last));
																					self.ssn:=inRec.SSN;
																					self.dob:=iesp.ECL2ESP.t_DateToString8(inRec.DOB);
																					self.PhoneNumber:=inRec.Individual.Phone10));
		return returnVal;
	end;
	export processBusinessInput(iesp.disclosed_entity_search.t_DisclosedEntitySearchByBusiness inRec) := function
		returnVal := project(inRec, transform(myLayout.BusinessLayout, 
																					self.CompanyName:=stringlib.StringToUpperCase(inRec.Company.CompanyName);
																					self.fein:=inRec.fein;
																					self.PhoneNumber:=inRec.Company.Phone10));
		return returnVal;
	end;
	export busNameMatch (string userInput, string fileData) := function
		rawUser := stringlib.StringFilter(stringlib.StringToUpperCase(userInput),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		rawFile := stringlib.StringFilter(stringlib.StringToUpperCase(fileData),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
		return stringlib.StringFind(rawFile,rawUser,1)>0 or stringlib.StringFind(rawUser,rawFile,1)>0;
	end;
	export getFeinBit (string inputfein, unsigned1 bitpos) := function
		val:=INTFORMAT((integer)inputfein,9,1);
		return (string)val[bitpos];
	end;
	export getCity(string city, string zip) := function
		return If(city ='' and zip ='', 'ANYTOWN',city);
	end;
	export cleanInputAddress(string street1, string street2, string city, string state, string zip) := function
		return Address.CleanFields(Address.GetCleanAddress(street1+street2,city+' '+state+' '+zip,address.Components.Country.US).str_addr);
	end;
	export processAddressRaw(string inStreetAddress1, string inStreetAddress2, string inCity, string inState, string inZip) := function
		doClnAddr := inStreetAddress1 <> '';
		clnTmpCity := getCity(inCity,inZip);
		ClnAddr := cleanInputAddress(inStreetAddress1,inStreetAddress2,clnTmpCity,inState,inZip);
		returnVal := ClnAddr;
		return returnVal;
	end;
	export processAddressInput(iesp.share.t_Address inAddr) := function
		doClnAddr := inAddr.StreetAddress1 <> '';
		clnTmpCity := getCity(inAddr.city,inAddr.zip5);
		ClnAddr := cleanInputAddress(inAddr.StreetAddress1,inAddr.StreetAddress2,clnTmpCity,inAddr.state,inAddr.zip5);
		returnVal := Project(inAddr, Transform(myLayout.AddressLayout,
																					 self.address1:= stringlib.StringToUpperCase(inAddr.StreetAddress1);
																					 self.address2:= stringlib.StringToUpperCase(inAddr.StreetAddress2);
																					 self.prim_range:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.prim_range,inAddr.StreetNumber));
																					 self.predir:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.predir,inAddr.StreetPreDirection));
																					 self.prim_name:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.prim_name,inAddr.StreetName));
																					 self.addr_suffix:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.addr_suffix,inAddr.StreetSuffix));
																					 self.postdir:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.postdir,inAddr.StreetPostDirection));
																					 self.unit_desig:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.unit_desig,inAddr.UnitDesignation));
																					 self.sec_range:= stringlib.StringToUpperCase(if(doClnAddr,ClnAddr.sec_range,inAddr.UnitNumber));
																					 self.p_city_name:= stringlib.StringToUpperCase(inAddr.city);
																					 self.st:= stringlib.StringToUpperCase(inAddr.state);
																					 self.z5:= inAddr.zip5));
		return returnVal;
	end;
	Export encodeAccountSeq(string acctno, unsigned1 seq):=function
		tmpid:=(string)seq +'000'+acctno;
		return (integer)tmpid;
	end;
	export buildEntityDSRow (String acctno, unsigned1 seq, string FName, string MName, string LName, string suffix, string ssn, 
													 String dob, string Phone, String company, string fein, string prim_range, string predir,
													 string prim_name, string addr_suffix, string postdir, string unit_desig, 
													 string sec_range, string city, string st, string zip,UNSIGNED6 grpID) := function
		string dod:='';
		string fullAddr:='';
		unsigned addrdate:=0;
		validAddr := prim_name <> '' and ((city <> '' and st <> '') or zip <> '');
		validName := LName <> '' and (ssn <> '' or dob <> '' or validAddr);
		validCompany := company <> '' and (fein <> '' or validAddr);
		validRow := validName or validCompany;
		ds := dataset([{acctno,seq,encodeAccountSeq(acctno,seq),0,0,FName,MName,LName,suffix,ssn,ssn,dob,dod,Phone,company,fein,
										prim_range,predir,prim_name,addr_suffix,postdir,unit_desig,sec_range,fullAddr,addrdate,
										city,st,zip,grpId,false}],Healthcare_Services.DisclosedEntity_Layouts.entityIds);
		return ds(validRow);
	end;
	Export checkSearchService (dataset(DisclosedEntity_Layouts.entityIds) inputRecs) := function
		verifySSNVerified := inputRecs((boolean)SSNVerified=false);
		fmtInputToSearchServiceResults := dedup(project(verifySSNVerified,transform(Healthcare_Header_Services.layouts.CombinedHeaderResultsDoxieLayout,
								self.acctno := left.acctno;
								self.Names := dataset([{0,0,'',left.FirstName,left.MiddleName,left.LastName,'','','',''}],Healthcare_Header_Services.Layouts.layout_nameinfo);
								self:=[])),all,hash);
		fmtInputToSearchServiceInput := dedup(project(verifySSNVerified,transform(Healthcare_Header_Services.layouts.autokeyInput,
									self.acctno := left.acctno;
									self.ssn := left.origssn;
									self.name_first := left.FirstName;
									self.name_middle:= left.MiddleName;
									self.name_last:= left.LastName;
									self:=[])),all,hash);
		checkSSN := join(fmtInputToSearchServiceResults,fmtInputToSearchServiceInput,left.acctno=right.acctno, 
								transform(DisclosedEntity_Layouts.entityIds, 
										self.acctno := left.acctno;
										self.SSNVerified := (boolean)Healthcare_Header_Services.Functions_Validation.SSNVerified(left,right);  
										self:=[]),
								keep(1), limit(0));
		rejoin:= join(inputRecs,checkSSN,left.acctno=right.acctno,
								transform(DisclosedEntity_Layouts.entityIds, 
										self.SSNVerified := if((boolean)left.SSNVerified=false,(boolean)right.SSNVerified,(boolean)left.SSNVerified);  
										self:=left),
								keep(1), limit(0),left outer);
		return rejoin;
	end;
	Export appendDeath (dataset(DisclosedEntity_Layouts.entityIds) inputRecs) := function
		gm := AutoStandardI.GlobalModule();
		deathparams := DeathV2_Services.IParam.GetDeathRestrictions(gm);
		glb_ok := deathparams.isValidGlb();
		deathRecs := join(inputRecs,doxie.Key_Death_MasterV2_ssa_Did,
								keyed(left.did = right.l_did)
								and	not DeathV2_Services.Functions.Restricted(right.src, right.glb_flag, glb_ok, deathparams),
								transform(DisclosedEntity_Layouts.entityIds, self.dod:=right.dod8;self:=left),
								keep(1), limit(0),left outer);
		return deathRecs;
	end;

end;
