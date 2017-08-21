import Address, Ut, lib_stringlib, _Control, business_header,_Validate, mdr,Health_Facility_Services,HealthCareFacility,
Header, Header_Slimsort, didville, ut, DID_Add,Business_Header_SS, NID, AID, Health_Provider_Services
,Scrubs_SureScripts,Scrubs,NPPES,HMS_Medicaid_Common;

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
		//NID.Mac_CleanFullNames(pBaseFile, cleaned_name_output, Provider_name);
 		NID.Mac_CleanParsedNames(pBaseFile, CleanNames
   															, firstname:=FirstName,lastname:=Lastname
   															// ,middlename:=Middlename											
   															// ,namesuffix:= SuffixName
   															,includeInRepository:=true, normalizeDualNames:=false);
   			 pLayout_base tr(cleanNames L) := TRANSFORM
   											 SELF.title    := IF(l.nameType='P' and L.cln_title IN ['MR','MS'], L.cln_title, '');
   											 SELF.fname    := if(l.nameType='P',L.cln_fname,'');
   											 // SELF.mname    := if(l.nameType='P',L.cln_mname,'');
   											 SELF.lname    := if(l.nameType='P',L.cln_lname,'');
   											 // SELF.name_suffix  := if(l.nameType='P',ut.fGetSuffix(L.cln_suffix),'');
   											 SELF.name_type := l.nameType;
   											 SELF              := L;
   			 END; // Transform

		RETURN PROJECT(cleanNames,tr(LEFT));													
	ENDMACRO;

	EXPORT _Base := FUNCTION
		//Add to previous base
		//hist_base	:= Mark_history(HMS_Medicaid_VT.Files(filedate,pUseProd).base.built, HMS_Medicaid_VT.layouts.base);		
		std_input	:= HMS_Medicaid_VT.StandardizeInputFile(filedate,pUseProd).base;
		cleanNames := Clean_name(std_input,HMS_Medicaid_Common.Layouts.base_VT);
// cleanNames;		
		cleanAdd_a	:= Clean_addr(cleanNames, HMS_Medicaid_Common.Layouts.base_VT);

//CleanAdd_a;

	base_and_update := if(nothor(FileServices.GetSuperFileSubCount(HMS_Medicaid_Common.Filenames('VT',filedate, pUseProd).lBaseTemplate_built)) = 0
													 ,cleanAdd_a
													 ,cleanAdd_a );//+ hist_base); 
														
	new_base_d := distribute(base_and_update, hash(Provider_ID, Provider_Name, Provider_address));  // Need more than these?, Why not just SPI?
	
	new_base_s := sort(new_base_d,
							Provider_ID,
							NPI,
							Taxonomy,
							Provider_Name,
							Provider_Address,
							Phone	,local);
																	 						
	HMS_Medicaid_Common.Layouts.base_VT t_rollup (new_base_s  le, new_base_s ri) := transform
		 self.dt_first_seen            := ut.EarliestDate (le.dt_first_seen, ri.dt_first_seen);
		 self.dt_last_seen             := ut.LatestDate (le.dt_last_seen, ri.dt_last_seen);
		 self.dt_vendor_first_reported := ut.EarliestDate(le.dt_vendor_first_reported, ri.dt_vendor_first_reported);
		 self.dt_vendor_last_reported  := ut.LatestDate(le.dt_vendor_last_reported, ri.dt_vendor_last_reported);
		 self.source_rid := if(le.dt_vendor_last_reported > ri.dt_vendor_last_reported, le.source_rid, ri.Source_rid);
		 self := if(le.dt_vendor_last_reported > ri.dt_vendor_last_reported,le,ri);
	end;
	base_f := rollup(new_base_s,
									left.Provider_ID = right.Provider_ID
									and left.NPI = right.NPI
									and left.Taxonomy = right.Taxonomy												
									and left.Provider_Name = right.Provider_Name
									and left.Provider_Address = right.Provider_Address
									and left.Phone = right.Phone											
									,t_rollup(left, right)
									,local);
	HMS_Medicaid_Common.Layouts.base_VT  GetSourceRID(base_f L)	:= TRANSFORM
   			SELF.source_rid := HASH64(hashmd5(
													 trim(L.Provider_ID)+','
													 +trim(L.NPI)+','
													 +trim(L.Taxonomy)+','
													 +trim(L.Provider_Name)+','
													 +trim(L.Provider_Address)+','
													 +trim(L.Phone)
													));
   			SELF							:= L;
   		END;
			
  d_rid:=project(base_f,GetSourceRID(left));

	matchset := ['A','Z','P'];	 
	did_add.MAC_Match_Flex
		(d_rid, matchset,foo					
		 ,'', fname, mname, lname, name_suffix, 
		 prim_range, prim_name, sec_range, zip, st, phone, //PhonePrimary, 
		 DID, HMS_Medicaid_Common.Layouts.base_VT, true, did_score,
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
				,Provider_Name			//Clinic Name,firmname					// Company name field
				,prim_range
				,prim_name
				,zip						//orig_zip
				,sec_range
				,st 						//license_state	// No separate state for License. Using home state
				,Phone		//phone_number
				,foo
				,bdid
				,HMS_Medicaid_Common.Layouts.base_VT
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
				,Provider_Name											
				,prim_range
				,PRIM_Name
				,SEC_RANGE
				,v_city_name
				,ST
				,ZIP
				,//sanc_tin
				,//tin1
				,Phone  //phone1
				,				//fax
				,//sanc_sancst
				,//sanc_licnbr
				,//Input_DEA_NUMBER
				,				// Group Key. Tried first 10 char of SPI but got error
				,npi //npi_num
				,//clia_num
				,//medicare_fac_num
				,//Input_MEDICAID_NUMBER
				,//ncpdp_id
				,taxonomy
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
			,//mname
			,lname
			,//name_suffix
			,							//gender
			,prim_range
			,prim_name
			,sec_range
			,v_city_name
			,st
			,zip					//orig_zip
			,best_ssn
			,best_dob
			,phone
			,st						//license_state
			,							//License_Number
			,							//tin1
			,//dea					//dea_Number
			,						// Group Key
			,
			,							//UPIN
			,DID
			,BDID
			,SRC
			,SOURCE_RID
			,result,false,38
		);
		myData_T := result +with_lnpid;
		myData_S := SORT(myData_T, NPI);
		myData := dedup(myData_S, NPI);
		myDataNONPI := myData(npi = '');
		HMS_Medicaid_Common.Layouts.base_VT xform( MyData L,  NPPES.File_NPPES_Keybuild R) := Transform
			SELF.entity_type_code := 1;
			SELF.CompanyName := '';
			SELF := L;
		end;

		HMS_Medicaid_Common.Layouts.base_VT xformOrg( MyData L,  NPPES.File_NPPES_Keybuild R) := Transform
			SELF.entity_type_code := 2;
			SELF.FirstName := '';
			SELF.LastName := '';
			SELF.CompanyName := L.Provider_Name;
			SELF := L;
		end;

		// HMS_Medicaid_VT.Layouts.base xformNoNPI( MyData L,  NPPES.File_NPPES_Keybuild R) := Transform
			// SELF := L;
		// end;
		 Matched_T := JOIN(myData,NPPES.File_NPPES_Keybuild, LEFT.NPI = RIGHT.NPI and Right.entity_type_code = '1',xform(LEFT,Right));
		 Matched_S := SORT(Matched_T,NPI);
		 matchedtbl := dedup(Matched_S, NPI);
		 myBatch_O := JOIN(myData,NPPES.File_NPPES_Keybuild, LEFT.NPI = RIGHT.NPI and Right.entity_type_code = '2',xformOrg(LEFT,Right));
		 myBatch_S := SORT(myBatch_O, NPI);
		 myBatch := dedup(myBatch_S, NPI);
		 MatchedNPI_T := matchedtbl + myBatch + myDataNONPI;
		 MatchedNPI_S := SORT(MatchedNPI_T, NPI);
		 MatchedNPI := dedup(MatchedNPI_S,NPI);
		 NoNPI_Match_T := JOIN(myData,MatchedNPI, LEFT.NPI = RIGHT.NPI, LEFT ONLY);//,xform(LEFT,Right));
		 AllRecs_T := matchedtbl + myBatch + myDataNONPI +NoNPI_Match_T;
		 AllRecs_S := SORT(AllRecs_T, NPI);
		 myAll := dedup(AllRecs_S, NPI);
		
		return myAll;				
	End; //Function
END; // Module

