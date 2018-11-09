import ut;
export Mapping_IN_As_ProfLic:= Function

Prof_License.Layout_proLic_in 	Map_IN_Trans(Layout_IN_raw.clean_input L) := TRANSFORM
	 SELF.date_first_seen 		 := L.DateAdded;
	 SELF.date_last_seen 		 := L.DateUpdated;
	 SELF.profession_or_board 	 := L.Profession;
	 SELF.source_st 			 := L.state;
	 SELF.prolic_key 			 := IF(L.LicenseNo <> '',
		                               (HASH32(Trim(L.state,left,right) + 'OKC') + Trim(L.LicenseNo,left,right)),
																	 '');
	 SELF.company_name 			:= L.BusinessName;
	 self.title                 := L.title;
	 self.fname           		:= L.fname;
	 self.mname           		:= L.mname;
	 self.lname          		:= L.lname;
	 self.name_suffix	 		:= L.name_suffix;
     SELF.orig_name 			 := trim(l.NameTitle) +trim(' '+ l.NameFirst) + trim(' '+ l.NameMiddle) + trim(' '+l.NameLast) + trim(' '+ l.NameSuffix);
	 SELF.orig_license_number 	 := L.LicenseNo;
     SELF.orig_addr_1 			 := if(L.Address='' or TRIM(L.Address,left,right) = 'ADDRESS NOT AVAILABLE', '',TRIM(L.Address,left,right));
     SELF.orig_city 			 := L.AddressCity;
     SELF.orig_st				 := L.AddrState;
     SELF.orig_zip 				 := L.Zip;
	 SELF.zip4                	 := L.zip4;
     SELF.county_str			 := L.County;
     SELF.license_number 		 := L.LicenseNo;
     SELF.license_type 			 := L.LicenseType;
     SELF.issue_date 			 :=  if ( regexfind('[/]', L.LicenseDateFrom) ,ut.date_slashed_MMDDYYYY_to_YYYYMMDD( L.LicenseDateFrom), L.LicenseDateFrom);
     SELF.expiration_date 		 := if ( regexfind('[/]', L.LicenseDateTo) ,ut.date_slashed_MMDDYYYY_to_YYYYMMDD(L.LicenseDateTo),L.LicenseDateTo); 
     SELF.status 				 := L.LicenseStatus;
	 SELF.vendor 				 := 'OKC';
     SELF						 :=[];
end;

  Map_IN_Clean				:=project( Prof_License.File_IN_Clean,Map_IN_Trans(left)) ;
  
  pDataset_sort				:=	sort(distribute(Map_IN_Clean,(integer)prolic_key) 
									,except 
									date_first_seen                
									,date_last_seen,local 
									);
   
Prof_License.Layout_proLic_in  Rollup_dates(Prof_License.Layout_proLic_in  l, Prof_License.Layout_proLic_in  r) := transform
	self.date_first_seen			:=	if(l.date_first_seen > r.date_first_seen, r.date_first_seen, l.date_first_seen);
	self.date_last_seen				:=	if(l.date_last_seen  < r.date_last_seen,  r.date_last_seen,  l.date_last_seen);
   	self                			:= l;
	end;
	
	Map_IN_rollup 					:= rollup( 	pDataset_sort
												,Rollup_dates(left, right)
												,except	date_first_seen,date_last_seen,local);
							  
return Map_IN_rollup; 
end;	