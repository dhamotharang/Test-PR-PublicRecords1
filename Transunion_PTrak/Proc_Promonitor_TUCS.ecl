import ut,_control,lib_StringLib; 

// Only Update files need to be transfered to pro montior along with clean information. 
 
export Proc_Promonitor_TUCS(string full_filedate = '', string update_filedate0 = '', string DestinationIP = _Control.IPaddress.bctlpedata11) := function

update_filedate := if(full_filedate <>'', full_filedate, update_filedate0); 
//DestinationIP   := _control.IPAddress.edata12; 
t  := record 
		    string CPS_VENDOR_CD;	
			string NAME_FIRST	;
			string NAME_MID	;
			string NAME_LAST	;
			string NAME_SUFFIX	;
			string CLN_PRIM_ADDR;
			string CLN_PRIM_RANGE	;
			string CLN_PRE_DIR	;
			string CLN_PRIM_NAME;	
			string CLN_ADDR_SUFFIX;	
			string CLN_POST_DIR	;
			string CLN_SEC_ADDR	;
			string CLN_SEC_RANGE	;
			string CLN_UNIT_DESIG	;
			string CLN_REMAINDER	;
			string CLN_RRNUM	;
			string CLN_RRBOXNUM	;
			string CLN_POBOXNUM	;
			string CLN_CITY	;
			string CLN_STATE	;
			string CLN_ZIP5	;
			string CLN_ZIP4	;
			string SSN	;
			string CLN_BIRTH_DTE;	
			string HOME_AREA_CODE	;
			string HOME_PHONE_NUM	;
			string CLN_RECORD_TYPE_CD	;
			string CPS_ADDR_TYPE_CD;	
			string ADL ; 
			string PARTYID;
			string nametype ; 
			string orig_full_name; 
			
end; 

Update_In := distribute(Transunion_PTrak.Normalize_Transunion_Update(Full_filedate,Update_filedate),hash(VendorDocumentIdentifier )) ; 

base_in   := Transunion_PTrak.File_Transunion_DID_Out ; 
base_d    := dedup(distribute(base_in, hash(VendorDocumentIdentifier )),VendorDocumentIdentifier,
																		name,
																		CurrentName.Dob_YYYY,
																		CurrentName.Dob_MM,
																		CurrentName.Dob_DD,
																		CurrentName.DeathIndicator,
																		NormAddress.Address1,
																		NormAddress.Address2,
																		NormAddress.City,
																		NormAddress.State,
																		NormAddress.ZipCode,
																		SSNFull,
																		TelephoneNumber,all,local);  
																		
base_d_for_full := dedup(distribute(base_in, hash(VendorDocumentIdentifier )),VendorDocumentIdentifier,
																		fname,
																		mname,
																		lname,
																		name_suffix,
																		BIRTHDATE_unformatted,
																		DECEASEDINDICATOR,
																		prim_range,
																		prim_name,
																		sec_range,
																		Zip,
																		SSNFull,
																		TelephoneNumber,all,local); 

father_base := dataset('~thor400::base::transunion_PTrak_father',Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut, flat);
prev_base_d := dedup(distribute(father_base, hash(VendorDocumentIdentifier )),VendorDocumentIdentifier,
																		fname,
																		mname,
																		lname,
																		name_suffix,
																		BIRTHDATE_unformatted,
																		DECEASEDINDICATOR,
																		prim_range,
																		prim_name,
																		sec_range,
																		Zip,
																		SSNFull,
																		TelephoneNumber,all,local);

update_from_full := project(join(base_d, prev_base_d, 
											   left.VendorDocumentIdentifier =  right.VendorDocumentIdentifier and 
												 left.fname = right.fname and 
												 left.mname = right.mname and 
												 left.lname = right.lname and 
												 left.name_suffix = right.name_suffix and 
												 (left.BIRTHDATE_unformatted = right.BIRTHDATE_unformatted or
												 left.BIRTHDATE_unformatted = '') and
												 (left.DECEASEDINDICATOR = right.DECEASEDINDICATOR or
												 left.DECEASEDINDICATOR = '') and
												 left.prim_range = right.prim_range and
												 left.prim_name = right.prim_name and
												 (left.sec_range = right.sec_range or
												 left.sec_range = '') and 
												 left.zip = right.zip and
												 (left.SSNFull = right.SSNFull or
												 left.SSNFull = '') and
												 (left.TelephoneNumber = left.TelephoneNumber or
												 left.TelephoneNumber = ''),
												 left only,
												 local), Transunion_PTrak.Layout_Transunion_Out.NormNameAddressRec);
												 
																		
// join with base to get clean fields and ADL. 
																 
j := join( base_d,if(full_filedate <> '', update_from_full, Update_In),

							trim(left.VendorDocumentIdentifier,left,right) =trim(right.VendorDocumentIdentifier,left,right) and 
							trim(left.name,left,right) = trim(right.name,left,right) and 
							ut.NNEQ_Date((unsigned)(trim(right.CurrentName.Dob_YYYY,left,right)+
							(string)INTFORMAT((unsigned)trim(right.CurrentName.Dob_MM,left,right),2,1)+
							(string)INTFORMAT((unsigned)trim(right.CurrentName.Dob_DD,left,right),2,1)), 
							(unsigned)(trim(left.CurrentName.Dob_YYYY,left,right)+
							(string)INTFORMAT((unsigned)trim(left.CurrentName.Dob_MM,left,right),2,1)+
							(string)INTFORMAT((unsigned)trim(left.CurrentName.Dob_DD,left,right),2,1))) and 
							trim(right.NormAddress.Address1,left,right)			 = trim(left.NormAddress.Address1,left,right) and 
							trim(right.NormAddress.Address2,left,right)			 = trim(left.NormAddress.Address2,left,right) and 
							trim(right.NormAddress.City	,left,right)			 = trim(left.NormAddress.City,left,right) and
							trim(right.NormAddress.State,left,right)			 = trim(left.NormAddress.State,left,right) and 
							ut.NNEQ_SSN( left.SSNFull,right.SSNFull) ,
						
								
							      transform({t}, 
                                   
											searchpattern1 := '^(PO BOX|PO BOX|POB|P O B+) ([0-9]+)$';
											searchpattern2 := '^(RURAL ROUTE|RR+) ([0-9]+)$';
											searchpattern3 := '^(RURAL ROUTE|RR+) ([0-9]+) (BOX) ([0-9]+)$';
											searchpattern4 := '^(RURAL ROUTE|RR+) ([0-9]+) (BOX) ([0-9]+[A-Z])$';

											self.CPS_VENDOR_CD    := '006';	
											self.NAME_FIRST	      := if(left.VendorDocumentIdentifier<>'', left.fname,right.CurrentName.FirstName);
											self.NAME_MID	      := if(left.VendorDocumentIdentifier<>'',left.mname,right.CurrentName.MiddleName);
											self.NAME_LAST	      := if(left.VendorDocumentIdentifier<>'',left.lname,right.CurrentName.LastName);
											self.NAME_SUFFIX	  := if(left.VendorDocumentIdentifier<>'',left.name_suffix,right.CurrentName.Suffix);
											
											self.CLN_PRIM_ADDR    := if(left.VendorDocumentIdentifier<>'',trim(left.prim_range,left,right)+' '+ trim(left.predir,left,right)+' '+trim(left.prim_name,left,right)+' '+ trim(left.addr_suffix,left,right)+' ' +trim(left.postdir,left,right)
											                               , Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[1..46]) ;
											self.CLN_PRIM_RANGE	  := if(left.VendorDocumentIdentifier<>'',left.prim_range, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[1..10]) ;
											self.CLN_PRE_DIR	  := if(left.VendorDocumentIdentifier<>'',left.predir, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[11..12]) ;
											self.CLN_PRIM_NAME    := if(left.VendorDocumentIdentifier<>'',left.prim_name, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[13..40]) ;	
											self.CLN_ADDR_SUFFIX  := if(left.VendorDocumentIdentifier<>'',left.addr_suffix, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[41..44]) ;	
											self.CLN_POST_DIR	  := if(left.VendorDocumentIdentifier<>'',left.postdir, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[45..46]) ;
											self.CLN_SEC_ADDR	  := if(left.VendorDocumentIdentifier<>'',trim(left.unit_desig,left,right)+' '+trim(left.sec_range,left,right), Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[47..64]) ;
											self.CLN_SEC_RANGE	  := if(left.VendorDocumentIdentifier<>'',left.sec_range, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[57..64]) ;
											self.CLN_UNIT_DESIG   := if(left.VendorDocumentIdentifier<>'',left.unit_desig, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[47..56]) ;
											self.CLN_REMAINDER	  := '';
											
											t_rrbox :=  if(left.VendorDocumentIdentifier<>'',trim(left.prim_name,left,right)+ ' '+trim(left.unit_desig,left,right)+' '+trim(left.sec_range,left,right), 
											               Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[13..40]+' '+ 
														   Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[47..56]+' '+
                                                           Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[57..64]); 
											
											self.CLN_RRNUM	      := if(regexfind(searchpattern2,lib_StringLib.StringLib.StringCleanSpaces(trim(self.CLN_PRIM_NAME,left,right)) )=true,
											                            self.CLN_PRIM_NAME[Transunion_PTrak.Fn_BOX_NUM.StrIndexRR(self.CLN_PRIM_NAME) ..],
																		if(regexfind(searchpattern3,lib_StringLib.StringLib.StringCleanSpaces(trim(t_rrbox,left,right)) )=true, 
																		t_rrbox[Transunion_PTrak.Fn_BOX_NUM.StrIndexRR(t_rrbox) ..(StringLib.StringFind(t_rrbox,' BOX',1)-1)],
																		if(regexfind(searchpattern4,lib_StringLib.StringLib.StringCleanSpaces(trim(t_rrbox,left,right)) )=true,
																		t_rrbox[Transunion_PTrak.Fn_BOX_NUM.StrIndexRR(t_rrbox) ..(StringLib.StringFind(t_rrbox,' BOX',1)-1)]
																		,''))); 
											
											self.CLN_RRBOXNUM	  := if(regexfind(searchpattern3,lib_StringLib.StringLib.StringCleanSpaces(trim(t_rrbox,left,right)) )=true,
											                           t_rrbox[Transunion_PTrak.Fn_BOX_NUM.StrIndexRRBOX(t_rrbox) ..],
																	   if(regexfind(searchpattern4,lib_StringLib.StringLib.StringCleanSpaces(trim(t_rrbox,left,right)) )=true,
																	   t_rrbox[Transunion_PTrak.Fn_BOX_NUM.StrIndexRRBOX(t_rrbox) ..],
																	   '')) ;
											
											self.CLN_POBOXNUM	  := if(regexfind(searchpattern1,lib_StringLib.StringLib.StringCleanSpaces(trim(self.CLN_PRIM_NAME,left,right)) )=true,
											                           self.CLN_PRIM_NAME[Transunion_PTrak.Fn_BOX_NUM.StrIndexPob(self.CLN_PRIM_NAME) ..],''); 
								           
										    self.CLN_CITY	      := if(left.VendorDocumentIdentifier<>'',left.v_city_name, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[90..114]) ;
											self.CLN_STATE	      := if(left.VendorDocumentIdentifier<>'',left.st , Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[115..116]) ;
											self.CLN_ZIP5	      := if(left.VendorDocumentIdentifier<>'',left.zip, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[117..121]) ;
											self.CLN_ZIP4	      := if(left.VendorDocumentIdentifier<>'',left.zip4, Transunion_PTrak.Fn_BOX_NUM.fn_missing_addr_clean(right.NormAddress.Address1,right.NormAddress.Address2,right.NormAddress.City,right.NormAddress.State,right.NormAddress.ZipCode)[122..125]) ;
											
											self.SSN	          := right.SSNFull ;
											self.CLN_BIRTH_DTE    := right.CurrentName.Dob_YYYY + right.CurrentName.Dob_MM + right.CurrentName.Dob_DD;	
											self.HOME_AREA_CODE	  := '';
											self.HOME_PHONE_NUM	  := if(right.TelephoneNumber in ut.Set_BadPhones , '', right.TelephoneNumber);
											self.CLN_RECORD_TYPE_CD := right.RECORDTYPE;
											self.CPS_ADDR_TYPE_CD  := map((integer)right.RECORDTYPE =1 => 'C', 
																		    (integer)right.RECORDTYPE =2 => 'P1', 
																			(integer)right.RECORDTYPE =3 => 'P2', 
																			(integer)right.RECORDTYPE =5 => 'P3', 
																			(integer)right.RECORDTYPE =6 => 'P4', 
																			(integer)right.RECORDTYPE =7 => 'P5', 
																			(integer)right.RECORDTYPE =8 => 'P6',
																			(integer)right.RECORDTYPE =9 => 'P7',''); 
							   
											self.ADL      := (string) left.did; 
											self.PARTYID  := right.VendorDocumentIdentifier ; 
											self.nametype := if(left.VendorDocumentIdentifier<>'',left.nametype,right.nametype);
											self.orig_full_name := trim(right.CurrentName.FirstName,left,right) +' '+ trim(right.CurrentName.MiddleName,left,right)+' '+trim(right.CurrentName.LastName,left,right)+ ' '+trim(right.CurrentName.Suffix,left,right),
											
										
          ), right outer,local); 


file_v_tucs := output(j,,'~thor_data::out::promonitor::tucs_'+update_filedate,csv(
					  HEADING('CPS_VENDOR_CD|NAME_FIRST|NAME_MID|NAME_LAST|NAME_SUFFIX|CLN_PRIM_ADDR|CLN_PRIM_RANGE|CLN_PRE_DIR|CLN_PRIM_NAME|CLN_ADDR_SUFFIX|CLN_POST_DIR|CLN_SEC_ADDR|CLN_SEC_RANGE|CLN_UNIT_DESIG|CLN_REMAINDER|CLN_RRNUM|CLN_RRBOXNUM|CLN_POBOXNUM|CLN_CITY| CLN_STATE|CLN_ZIP5|CLN_ZIP4|SSN|CLN_BIRTH_DTE|HOME_AREA_CODE|HOME_PHONE_NUM|CLN_RECORD_TYPE_CD|CPS_ADDR_TYPE_CD|ADL|PARTYID|nametype|ORIG_FULL_NAME|\n','',SINGLE)
					  ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);

tucs_d := fileservices.despray('~thor_data::out::promonitor::tucs_'+update_filedate, DestinationIP, '/data/hds_180/pro_monitor/build/tucs/tucs_'+update_filedate+'.txt',,,,TRUE); 

tucs_despray := sequential(file_v_tucs,tucs_d); 
return tucs_despray ; 
end; 