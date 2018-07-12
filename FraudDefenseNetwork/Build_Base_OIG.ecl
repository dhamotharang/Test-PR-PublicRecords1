Import ut,tools,_control,OIG,business_header, Header_Slimsort, didville, ut, DID_Add, Business_Header_SS, Business_HeaderV2,AID_Support,AID, 
AppendProviderAttributes, Health_Provider_Services, Health_Facility_Services, HealthCareFacility,BIPV2_Company_Names, address;

EXPORT Build_Base_OIG ( 
   string pversion
	,dataset(Layouts.Base.OIG)  inBaseOIG   = Files().Base.OIG.QA
	//,dataset(Layouts.Input.OIG) inOIGUpdate = Files().Input.OIG.Sprayed
	,boolean                    UpdateOIG    = FraudDefenseNetwork._Flags.Update.OIG
) := 
module 

  Provider_Key     := AppendProviderAttributes.Key_Provider_Attributes;
	Header_DS        := HealthCareFacility.Files.Facility_Header_DS;
  oig_all          := OIG.File_OIG_BaseFile;
	sanctype_codes   := ['1128A3','1128AA','1128B1','1128B7'];
	oig_sanctype     := oig_all(trim(StringLib.StringToUppercase(sanctype),left,right) in sanctype_codes);
	
  FraudDefenseNetwork.Functions.CleanFields(oig_sanctype ,oig_sanctypeUpper);	
	
	FraudDefenseNetwork.Layouts.Base.OIG	tPrep(Layouts.Input.OIG	pInput)	:=
	transform
				
				    self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'OIG';
						self.npi                             := if(( (unsigned) pInput.npi) <> 0, pInput.npi, '');
						self.waiverdate                      := if(( (unsigned) pInput.waiverdate) <> 0, pInput.waiverdate, '');
						self.sancdesc                        := map(pInput.sanctype ='1128AA' => 'CIVIL MONETARY PENALTY EXCLUSION',
						                                            pInput.sanctype ='1128B1' => 'CONVICTION RELATING TO FRAUD',
																											  pInput.sancdesc);
						self.dob                             := pInput.dob;	
						self.clean_business_name             := HealthCareFacility.clean_facility_name(pInput.busname);
						self.address_1                       := pInput.append_prep_address1;																						 
						self.address_2                       := pInput.append_prep_addresslast;																						 
						self.dt_first_seen                   := (unsigned)pInput.dt_first_seen;  
						self.dt_last_seen                    := (unsigned)pInput.dt_last_seen;  
						self.dt_vendor_last_reported         := (unsigned)pInput.dt_vendor_last_reported;
						self.dt_vendor_first_reported        := (unsigned)pInput.dt_vendor_first_reported;
					  self.current                         := 'C' ; 
						self                                 := pInput; 
						self                                 := []; 
   end;
	 
	oig_proj  	    := project(oig_sanctypeUpper,tPrep(left)):independent;
	oig_dedup_i     := dedup(sort(oig_proj(addr_type = 'P'),lastname,firstname,midname,-dt_last_seen),lastname,firstname,midname);
	oig_dedup_b     := dedup(sort(oig_proj(addr_type = 'B'),Busname,-dt_last_seen),Busname);
  oig_dedup       := oig_dedup_i + oig_dedup_b;
	
 FraudDefenseNetwork.Standardize_Name(oig_dedup, firstname,midname,lastname,suffix_name, oigCleanName); 
 
 	oig_forIDL     := project( oigCleanName ,transform(FraudDefenseNetwork.Layouts.Temp.oig,
			self.fname			                	:= left.cleaned_name.fname;
			self.mname			                	:= left.cleaned_name.mname;
			self.lname				                := left.cleaned_name.lname;
			self.name_suffix	                := left.cleaned_name.name_suffix;
      Clean_Address_182 								:= address.CleanAddress182(left.address_1, left.address_2);
			self.prim_range		                := Clean_Address_182[1..10];
			self.prim_name		                := Clean_Address_182[13..40];
			self.sec_range		                := Clean_Address_182[57..64];			
			self.v_city_name                  := Clean_Address_182[90..114]	;		
			self.state		                    := Clean_Address_182[115..116];
			self.zip5		 			                := Clean_Address_182[117..121];	
			self		 	    		                := left;
			));


	Did_Matchset := ['D','S','A','Z'];
		did_Add.MAC_Match_Flex(oig_forIDL, Did_Matchset,
													 ssn, dob, fname, mname, lname, name_suffix, 
													 prim_range, prim_name, sec_range, zip5, state,phone,
													 did,
													 FraudDefenseNetwork.Layouts.temp.oig,
													 false, did_score,	//these should default to zero in definition
													 75,	  //dids with a score below here will be dropped 	
													 oigIDL);	
												 
	  oigDIDUpdUnq      := dedup(sort(oigIDL(did<>0),did,-dt_last_seen),did); 
    oigBDIDUpdUnq     := dedup(sort(oig_dedup_b(bdid<>0),bdid,-dt_last_seen),bdid);

	  Health_Provider_Services.mac_get_best_lnpid_on_thor (oigDIDUpdUnq, lnpid,	fname, mname, lname, name_suffix,	,
																											 prim_range, prim_name,	sec_range, v_city_name,
																											 state, zip5,	ssn, dob, ,	,	,	,	,	, npi, upin1,
																											 , , , , oigDIDUpdLnpid, FALSE,38);
																																				
    oigDIDUpdLnpidNpi  := join(oigDIDUpdLnpid, Provider_Key,  keyed(left.lnpid = right.lnpid), transform(recordof(oigDIDUpdLnpid), 
                                                                        self.npi := if(left.npi ='', right.npinumber, left.npi);
																																				self     := left), left outer);		
																																				 
	  oigUpdate          := oigBDIDUpdUnq + project(oigDIDUpdLnpidNpi, Layouts.base.oig);
																																	
		oigUpdate_dist     := distribute(oigUpdate, hash64(did, bdid));	
		oigBase_dist       := distribute(inBaseOIG, hash64(did, bdid));		
		
		FraudDefenseNetwork.Layouts.Base.OIG getSrcRid(oigUpdate_dist l, oigBase_dist r) := transform
		self.dt_first_seen 													:= ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen 					        	      := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 								:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported               := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id						              := r.source_rec_id ;
		self.current							                  := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self 					:= l;
	end;
	
	//*** this join assigns the Src_rids for the older records.
	dBase_with_rids := join(oigUpdate_dist, oigBase_dist,
													left.cleaned_name.lname                       = right.cleaned_name.lname         and
													left.cleaned_name.fname                       = right.cleaned_name.fname         and
													left.cleaned_name.mname                       = right.cleaned_name.mname         and
													left.cleaned_name.name_suffix                 = right.cleaned_name.name_suffix   and
													left.busname                                  = right.busname       ,
													getSrcRid (left,right),
													left outer,
													keep(1),
													local);
	ut.MAC_Append_Rcid (dBase_with_rids, source_rec_id, pDataset_rollup);
	tools.mac_WriteFile(Filenames(pversion).Base.OIG.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping OIG atribute')
	);
	
end;
