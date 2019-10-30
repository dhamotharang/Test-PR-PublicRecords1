import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,Health_Facility_Services,HealthCareFacility,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, Health_Provider_Services
,Scrubs_SureScripts,Scrubs,BIPV2_Company_Names;

EXPORT Update_Base (string filedate, boolean pUseProd = false) := MODULE

	EXPORT Mark_history (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		pLayout_base hist(pLayout_base L):= TRANSFORM
				SELF.record_type	:= 'H';
				SELF							:= L;
		END;
		RETURN PROJECT(pBaseFile, hist(LEFT));
	ENDMACRO;
	
	EXPORT Clean_addr (pBaseFile, pLayout_base)	:= FUNCTIONMACRO
		UNSIGNED4	lFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;		
		AID.MacAppendFromRaw_2Line(pBaseFile,Prepped_addr1,Prepped_addr2,RawAID,cleanAddr, lFlags);

		pLayout_base addr(cleanAddr L)	:= TRANSFORM
			SELF.RawAID     := L.aidwork_rawaid;
			SELF.ACEAID			:= L.aidwork_acecache.aid;
			SELF.prim_range := stringlib.stringfilterout(L.aidwork_acecache.prim_range,'.');
			SELF.prim_name  := stringlib.stringfilterout(L.aidwork_acecache.prim_name,'.^!$+<>@=%?*\'');
			SELF.sec_range  := stringlib.stringfilterout(L.aidwork_acecache.sec_range,'.>$!%*@=?&\'');
			SELF.v_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.v_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.v_city_name,'');
			SELF.p_city_name:= IF(LENGTH(stringlib.stringfilterout(stringlib.stringtouppercase(L.aidwork_acecache.p_city_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ-. '))=0,L.aidwork_acecache.p_city_name,'');
			SELF.zip        := L.aidwork_acecache.zip5;
			SELF.fips_st    := L.aidwork_acecache.county[1..2];
			SELF.fips_county:= L.aidwork_acecache.county[3..5];
			SELF.msa        := IF(L.aidwork_acecache.msa='','',L.aidwork_acecache.msa+'0');
			SELF            := L.aidwork_acecache;
			SELF            := L;
		END;
		RETURN PROJECT(cleanAddr, addr(LEFT));
	ENDMACRO;
	
	EXPORT Clean_name (pBaseFile, pLayout_base, useFull = false) := FUNCTIONMACRO
		NID.Mac_CleanParsedNames(pBaseFile, CleanNames
															, firstname:=FirstName,lastname:=Lastname
															,middlename:=Middlename											
															,namesuffix:= SuffixName
															,includeInRepository:=true, normalizeDualNames:=false);
			 pLayout_base tr(cleanNames L) := TRANSFORM
											 SELF.title    := IF(l.nameType='P' and L.cln_title IN ['MR','MS'], L.cln_title, '');
											 SELF.fname    := if(l.nameType='P',L.cln_fname,'');
											 SELF.mname    := if(l.nameType='P',L.cln_mname,'');
											 SELF.lname    := if(l.nameType='P',L.cln_lname,'');
											 SELF.name_suffix  := if(l.nameType='P',ut.fGetSuffix(L.cln_suffix),'');
											 SELF.name_type := l.nameType;
											 SELF              := L;
			 END; // Transform
		RETURN PROJECT(cleanNames,tr(LEFT));													
	ENDMACRO;

	EXPORT _Base := FUNCTION
		//Add to previous base
		hist_base	:= Mark_history(HMS_SureScripts.Files(filedate,pUseProd).base.built, HMS_SureScripts.layouts.base);		
		std_input	:= HMS_SureScripts.StandardizeInputFile(filedate,pUseProd).base;
		cleanNames := Clean_name(std_input,HMS_SureScripts.Layouts.base);
		cleanAdd_a	:= Clean_addr(cleanNames, HMS_SureScripts.Layouts.base):PERSIST('~thor400_data::Persist::base::hms::surescripts::addresses');
		//cleanAdd_a := dataset('~thor400_data::Persist::base::hms::surescripts::addresses',HMS_SureScripts.Layouts.base,THOR); 
	base_and_update := if(nothor(FileServices.GetSuperFileSubCount(Filenames(filedate, pUseProd).lBaseTemplate_built)) = 0
													 ,cleanAdd_a
													 ,cleanAdd_a + hist_base); 
														
	new_base_d := distribute(base_and_update, hash(lastname, firstname, AddressLine1, AddressLine2, zipcode));  // Need more than these?, Why not just SPI?
	
	new_base_s := sort(new_base_d
		,spi
		,dea
		,StateLicenseNumber
		,lastname
		,firstname
		,clinicname
		,AddressLine1
		,AddressLine2
		,zipcode
		,PhonePrimary
		,Email
		,NPI
		,MedicareNumber
		,MedicaidNumber
		,DentistLicenseNumber											
	,local);
																	 						
	Layouts.base t_rollup (new_base_s  le, new_base_s ri) := transform
		 self.dt_first_seen            := ut.EarliestDate (le.dt_first_seen, ri.dt_first_seen);
		 self.dt_last_seen             := ut.LatestDate (le.dt_last_seen, ri.dt_last_seen);
		 self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
		 self.dt_vendor_last_reported  := ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
		 self.source_rid := if(le.dt_vendor_last_reported > ri.dt_vendor_last_reported, le.source_rid, ri.Source_rid);
		 self := if(le.dt_vendor_last_reported > ri.dt_vendor_last_reported,le,ri);
	end;
	base_f := rollup(new_base_s,
									left.spi = right.spi
									and left.dea = right.dea
									and left.StateLicenseNumber = right.StateLicenseNumber												
									and left.lastname = right.lastname
									and left.firstname = right.firstname
									and left.clinicname = right.clinicname											
									and left.AddressLine1 = right.AddressLine1
									and left.AddressLine2 = right.AddressLine2	
									and left.zipcode = right.zipcode																																	
									and left.PhonePrimary = right.PhonePrimary
									and left.Email = right.Email
									and left.NPI = right.NPI
									and left.MedicareNumber = right.MedicareNumber
									and left.MedicaidNumber = right.MedicaidNumber
									and left.DentistLicenseNumber = right.DentistLicenseNumber
									,t_rollup(left, right)
									,local);
	HMS_SureScripts.Layouts.base  GetSourceRID(base_f L)	:= TRANSFORM
   			SELF.source_rid := HASH64(hashmd5(
													 trim(L.spi)+','
													 +trim(L.dea)+','
													 +trim(L.StateLicenseNumber)+','
													 +trim(L.PrefixName)+','
													 +trim(L.firstName)+','
													 +trim(L.MiddleName)+','
													 +trim(L.lastName)+','
													 +trim(L.SuffixName)+','
													 +trim(L.ClinicName)+','
													 +trim(L.Prepped_Addr1)+','
													 +trim(L.Prepped_addr2)+','
													 +trim(L.ClinicName)+','
													 +trim(L.PhonePrimary)+','
													 +trim(L.Email)+','
													 +trim(L.ActiveStartTime)+','
													 +trim(L.ActiveEndTime)+','
													 +trim(L.ServiceLevel)+','
													 +trim(L.PartnerAccount)+','
													 +trim(L.LastModifiedDate)+','
													 +trim(L.Version)+','
													 +trim(L.NPI)+','
													 +trim(L.NPILocation)+','
													 +trim(L.MedicareNumber)+','
													 +trim(L.MedicaidNumber)+','
													 +trim(L.DentistLicenseNumber)+','
													 +trim(L.SocialSecurity)
													));
   			SELF							:= L;
   		END;
			
  d_rid:=project(base_f,GetSourceRID(left));

	matchset := ['A','Z','P'];	 
	did_add.MAC_Match_Flex
		(d_rid, matchset,foo					
		 ,'', fname, mname, lname, name_suffix, 
		 prim_range, prim_name, sec_range, zip, st, clean_phone, //PhonePrimary, 
		 DID, Layouts.base, true, did_score,
		 75, d_did);

	did_add.MAC_Add_SSN_By_DID(d_did,did,best_ssn,d_ssn,false);
	
	did_add.MAC_Add_DOB_By_DID(d_ssn,did,best_dob,d_dob0,false);
		
	d_dob:=project(d_dob0
							,transform({d_dob0}
							,self.did:= left.did
							,self.did_score:=if(self.did=0,0,left.did_score)
							,self:=left));

		bdid_matchset := ['A','P'];
		Business_Header_SS.MAC_Add_BDID_Flex
		(
				 d_dob //d_dob0
				,bdid_matchset
				,ClinicName			//firmname					// Company name field
				,prim_range
				,prim_name
				,zip						//orig_zip
				,sec_range
				,st 						//license_state	// No separate state for License. Using home state
				,PhonePrimary		//phone_number
				,foo
				,bdid
				,HMS_SureScripts.Layouts.base
				,TRUE
				,bdid_score
				,d_bdid
				,
				,
				,
				,BIPV2.xlink_version_set
				,
				,
				,p_city_name
				,
				,
				,
				,
				,src
				,source_rid
				,
				,
		);	//Business_Header_SS.MAC_Add_BDID_Flex

		Health_Facility_Services.mac_get_best_lnpid_on_thor (
				d_bdid
				,LNPID
				,clean_Clinic_Name											
				,prim_range
				,PRIM_Name
				,SEC_RANGE
				,v_city_name
				,ST
				,ZIP
				,//sanc_tin
				,//tin1
				,PhonePrimary  //phone1
				,fax
				,//sanc_sancst
				,//sanc_licnbr
				,//Input_DEA_NUMBER
				,				// Group Key. Tried first 10 char of SPI but got error
				,npi //npi_num
				,//clia_num
				,MedicareNumber//medicare_fac_num
				,MedicaidNumber//Input_MEDICAID_NUMBER
				,//ncpdp_id
				,//taxonomy
				,BDID
				,SRC
				,SOURCE_RID
				,dLnpidOut
				,false
				,30 
				);

		with_lnpid:=dLnpidOut(lnpid>0);
		no_lnpid:=dLnpidOut(lnpid=0);

		Health_Provider_Services.mac_get_best_lnpid_on_thor (
			no_lnpid
			,lnpid
			,fname
			,mname
			,lname
			,name_suffix
			,							//gender
			,prim_range
			,prim_name
			,sec_range
			,v_city_name
			,st
			,zip					//orig_zip
			,best_ssn
			,best_dob
			,phonePrimary
			,st						//license_state
			,							//License_Number
			,							//tin1
			,dea					//dea_Number
			,						// Group Key
			,
			,							//UPIN
			,DID
			,BDID
			,SRC
			,SOURCE_RID
			,result,false,38
		);
		spec_todo := result +with_lnpid;
		spec_Details := dataset('~Thor400_data::base::hms::surescripts::speccodes::SpecialtyCodes', hms_Surescripts.Layouts.Base_SpecialtyCodes, THOR);
		HMS_SureScripts.Layouts.Base xform( spec_todo L,  spec_Details R) := Transform
			//SELF.In_Code := L.In_Code;
			SELF.Spec_Code := R.Spec_Code;
			SELF.Spec_Desc := R.Spec_Desc;
			SELF.Activity_Code := R.Activity_Code;
			SELF.Practice_Type_Code := R.Practice_Type_Code;
			SELF.Practice_Type_Desc := R.Practice_Type_Desc;
			SELF := L;
		end;
		
		

		Merged_Specialty := JOIN(spec_todo, spec_Details, LEFT.SpecialtyCodePrimary = RIGHT.In_code, xform(LEFT,Right), LEFT OUTER, LOOKUP);
		spec_to_taxonomy := dataset('~Thor400_Data::BASE::HMS::SureScripts::HMS_SPEC_To_Taxonomy::HMS_SPEC_To_Taxonomy'
																,hms_Surescripts.Layouts.HMS_SPEC_To_Taxonomy, THOR);
		HMS_SureScripts.Layouts.Base xform2( Merged_Specialty L,  spec_to_taxonomy R) := Transform
			//SELF.In_Code := L.In_Code;
			SELF.Taxonomy := R.Taxonomy;
			SELF := L;
			SELF := [];
		end;																
																
		Merged_Taxonomy := JOIN(Merged_Specialty, spec_to_taxonomy, LEFT.Spec_code = RIGHT.Spec_code, xform2(LEFT,Right), LEFT OUTER, LOOKUP);
		return Merged_Taxonomy;				
	End; //Function
END; // Module

