import Address, header_services, header, ut, utility_business, VersionControl, bipv2, MDR, business_header_ss, business_header, utilfile;

export Build_Util_Bus_base (string pversion) := module
	
	//**** Filtered Business Utility records from the Utility file.
  dUtilBusRecs := utilfile.fn_util_base(utilfile.file_util.full_base);
																			 
	//**** Adding choicepoint business utility data.
	cp_utility_bus_base := utility_business.Files().base.built;

	utilfile.Layout_Utility_Bus_Base tTransform(Utility_Business.Layouts.base l) := transform
				self 						:= l;
				self 						:= [];
		end;  
	
	cp_utility_bus_base2 :=  project(cp_utility_bus_base, tTransform(left));
		
	//**** Combine Business recs with CP recs	
	dUtilBusBase := dUtilBusRecs + cp_utility_bus_base2;
	
	//**** Dedup on the Whole Record 
	dsDist	:= distribute	(dUtilBusBase ,hash(id));
	dsSort	:= sort				(dsDist	,record, local);
	dsDedup	:= dedup			(dsSort	,record, local);
	
	// Rollup to prevent duplicate source_record_ids
	dsDedup_dist := distribute(dsDedup, hash(id));
	dsDedup_sort := sort(dsDedup_dist ,record ,except 
											prim_range ,predir ,prim_name	,addr_suffix 
											,postdir ,unit_desig	,sec_range ,p_city_name
											,v_city_name ,st ,zip ,zip4 ,cart ,cr_sort_sz ,lot
											,lot_order,	dbpc ,chk_digit ,rec_type ,county ,geo_lat
											,geo_long ,msa ,geo_blk ,geo_match	,err_stat	,local );	
 
	utilfile.Layout_Utility_Bus_Base RollupUpdate(utilfile.Layout_Utility_Bus_Base l, utilfile.Layout_Utility_Bus_Base r) := transform
	  self.source_rec_id	 := if (l.source_rec_id <> 0,l.source_rec_id,r.source_rec_id);
	  self := l;
	end;

	dsDedup_Rollup := rollup(dsDedup_sort ,RollupUpdate(left, right) ,record ,except 
											prim_range ,predir ,prim_name	,addr_suffix 
											,postdir ,unit_desig	,sec_range ,p_city_name
											,v_city_name ,st ,zip ,zip4 ,cart ,cr_sort_sz ,lot
											,lot_order,	dbpc ,chk_digit ,rec_type ,county ,geo_lat
											,geo_long ,msa ,geo_blk ,geo_match	,err_stat	,local );												 										
	
	//**** Stamp BDIDs and BIPV2 IDs onto the records 
	
		// Add source_rec_ids and sequence numbers	
		dseq := record
			UtilFile.Layout_Utility_Bus_Base;
			unsigned8 seq_num;
		end;

		// Source_Rec_Id is a hash of the raw fields
		dseq into_seq(dsDedup_Rollup L,integer cnt) := transform
			self.seq_num := cnt;
			self.source_rec_id := HASH64( ut.CleanSpacesAndUpper(L.id) +
																		ut.CleanSpacesAndUpper(L.exchange_serial_number) +
																		ut.CleanSpacesAndUpper(L.date_first_seen) +
																		ut.CleanSpacesAndUpper(L.date_added_to_exchange) +
																		ut.CleanSpacesAndUpper(L.connect_date) +
																		ut.CleanSpacesAndUpper(L.record_date) +
																		ut.CleanSpacesAndUpper(L.util_type) +
																		ut.CleanSpacesAndUpper(L.orig_lname) +
																		ut.CleanSpacesAndUpper(L.orig_fname) +
																		ut.CleanSpacesAndUpper(L.orig_mname) +
																		ut.CleanSpacesAndUpper(L.orig_name_suffix) +
																		ut.CleanSpacesAndUpper(L.dob) +
																		ut.CleanSpacesAndUpper(L.addr_dual) +
																		ut.CleanSpacesAndUpper(L.addr_type) +
																		ut.CleanSpacesAndUpper(L.address_street) +
																		ut.CleanSpacesAndUpper(L.address_street_Name) +
																		ut.CleanSpacesAndUpper(L.address_street_Type) +
																		ut.CleanSpacesAndUpper(L.address_street_direction) +
																		ut.CleanSpacesAndUpper(L.address_apartment) +
																		ut.CleanSpacesAndUpper(L.address_city) +
																		ut.CleanSpacesAndUpper(L.address_state) +
																		ut.CleanSpacesAndUpper(L.address_zip) +
																		ut.CleanSpacesAndUpper(L.ssn) +
																		ut.CleanSpacesAndUpper(L.work_phone) +
																		ut.CleanSpacesAndUpper(L.phone) +
																		ut.CleanSpacesAndUpper(L.drivers_license_state_code) +
																		ut.CleanSpacesAndUpper(L.drivers_license) +
																		ut.CleanSpacesAndUpper(L.csa_indicator) +
																		ut.CleanSpacesAndUpper(L.company_name) );  
			self := L;
		end;

		dUtilBusBase_seq := distribute(project(dsDedup_Rollup,into_seq(LEFT,COUNTER)), hash(seq_num));		
 
		// Slim record for Bdiding		
		BdidSlim_Rec := record
				string100 	company_name := '';
				string20    fname 			 := '';
				string20    mname  			 := '';
				string20    lname  			 := '';
				string9     ssn          := '';						
				string10  	prim_range				;
				string28		prim_name					;
				string8			sec_range					;
				string25    city              ;
				string5			zip5							;
				string2			state							;
				string10		phone							;
				integer8		bdid					:= 0;
				unsigned1		bdid_score		:= 0;
				bipv2.IDlayouts.l_xlink_ids   ;
				unsigned8 	source_rec_id := 0;
				string2     source_mdr        ;
				unsigned8		seq_num				    ;
			end;

		BDidSlim_Rec tSlimForBdiding(dseq l) := transform
		    self.company_name  := l.company_name; 
				self.fname 				 := l.fname;	 
				self.mname  			 := l.mname;
				self.lname  			 := l.lname;		 
				self.ssn      		 := l.ssn;          						
				self.prim_range		 := l.prim_range;			
				self.prim_name		 := l.prim_name;				
				self.sec_range		 := l.sec_range;				
				self.city     		 := l.p_city_name;         
				self.zip5					 := l.zip;			 
				self.state				 := l.st;			  
				self.phone				 := l.phone;			 
				self.bdid					 := 0;	 
				self.bdid_score		 := 0;	 
				self.source_rec_id := l.source_rec_id;
				self.source_mdr  	 := MDr.sourceTools.src_Utilities;
				self.seq_num			 := l.seq_num;
		end;   

		dSlimForBdiding :=  project(dUtilBusBase_seq,tSlimForBdiding(left));

		BDID_Matchset := ['A','P'];

		Business_Header_SS.MAC_Add_BDID_Flex(
			 dSlimForBdiding											// Input Dataset						
			,BDID_Matchset                        // BDID Matchset what fields to match on           
			,company_name	                        // company_name	              
			,prim_range		                        // prim_range		              
			,prim_name		                        // prim_name		              
			,zip5					                        // zip5					              
			,sec_range		                        // sec_range		              
			,state				                        // state				              
			,phone				                        // phone				              
			,'' 					                        // fein              
			,bdid													        // bdid												
			,BdidSlim_Rec												  // Output Layout 
			,true                                 // output layout has bdid score field?                       
			,bdid_score                           // bdid_score                 
			,dBdidOut                             // Output Dataset     
			,																			// deafult threshold
			,																			// use prod version of superfiles
			,																			// default is to hit prod from dataland, and on prod hit prod.		
			,BIPV2.xlink_version_set							// Create BIP Keys only
			,																			// Url
			, 		 			    											// Email
			,city       													// City
			,fname 																// fname
			,mname 																// mname
			,lname																// lname
			,ssn                                  // contact ssn
			,source_mdr                           // source 
			,source_rec_id                        // source_rec_id
			,                      );             // src_matching_is_priority default FALSE 


		dBDidOut_dist	 := distribute(dBDidOut(bdid!=0 or dotid!=0 or empid!=0 or powid!=0 or proxid!=0 or seleid!=0 or orgid!=0 or ultid!=0) ,seq_num);
		
		dAddUniqueId_dist := distribute	(dUtilBusBase_seq ,seq_num );
		
		// Slim record for Bdiding with bdid back as a string12		
		BdidSlim_Rec2 := record
				string100 	company_name  ;
				string20    fname 			  ;
				string20    mname  			  ;
				string20    lname  			  ;
				string9     ssn           ;						
				string10  	prim_range		;
				string28		prim_name			;
				string8			sec_range			;
				string25    city          ;
				string5			zip5					;
				string2			state					;
				string10		phone					;
				string12		bdid					;
				unsigned1		bdid_score		;
				bipv2.IDlayouts.l_xlink_ids;
				unsigned8 	source_rec_id ;
				string2     source_mdr    ;
				unsigned8		seq_num				;
			end;
	
	 /* Convert BDID to string 12 */
    BdidSlim_Rec2 recast(dBDidOut_dist L) := transform
			self.bdid	:= intformat(l.bdid,12,1);
			self 			:= l;
			self 			:= [];
		end;

		dBDidOut_dist2 := project(dBDidOut_dist, recast(left));			
					
		Layout_Utility_Bus_Base tAssignBdids(dseq l, BdidSlim_Rec2 r) := transform
			self.bdid				:= if(r.bdid 				<> '', r.bdid				,'');
			self.bdid_score	:= if(r.bdid_score	<> 0, r.bdid_score	, 0);
			self.DotID		 	:= if(r.DotID				<> 0, r.DotID				, 0);
			self.DotScore	 	:= if(r.DotScore		<> 0, r.DotScore		, 0);
			self.DotWeight 	:= if(r.DotWeight		<> 0, r.DotWeight		, 0);
			self.EmpID		 	:= if(r.EmpID				<> 0, r.EmpID				, 0);
			self.EmpScore	 	:= if(r.EmpScore		<> 0, r.EmpScore		, 0);
			self.EmpWeight 	:= if(r.EmpWeight		<> 0, r.EmpWeight		, 0);
			self.POWID		 	:= if(r.POWID				<> 0, r.POWID				, 0);
			self.POWScore	 	:= if(r.POWScore		<> 0, r.POWScore		, 0);
			self.POWWeight 	:= if(r.POWWeight		<> 0, r.POWWeight		, 0);
			self.ProxID			:= if(r.ProxID			<> 0, r.ProxID			, 0);
			self.ProxScore 	:= if(r.ProxScore		<> 0, r.ProxScore		, 0);
			self.ProxWeight	:= if(r.ProxWeight	<> 0, r.ProxWeight	, 0);
			self.SeleID		 	:= if(r.SeleID			<> 0, r.SeleID			, 0);
			self.SeleScore 	:= if(r.SeleScore		<> 0, r.SeleScore		, 0);
			self.SeleWeight	:= if(r.SeleWeight	<> 0, r.SeleWeight	, 0);
			self.OrgID			:= if(r.OrgID				<> 0, r.OrgID				, 0);
			self.OrgScore		:= if(r.OrgScore		<> 0, r.OrgScore		, 0);
			self.OrgWeight	:= if(r.OrgWeight		<> 0, r.OrgWeight		, 0);
			self.UltID			:= if(r.UltID				<> 0, r.UltID				, 0);
			self.UltScore		:= if(r.UltScore		<> 0, r.UltScore		, 0);
			self.UltWeight	:= if(r.UltWeight		<> 0, r.UltWeight		, 0);			
			self 						:= l;
		end;

		dAssignBdids := join( dAddUniqueId_dist
												 ,dBDidOut_dist2
												 ,left.seq_num = right.seq_num
												 ,tAssignBdids(left, right)
												 ,left outer ,local );
		
	//**** End of stamp BDIDs and BIPV2 IDs  

	export create_base := dAssignBdids;
		
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).base.new	,create_base	,Build_Base_File	);
	
	export full_build := 
				sequential(
					Build_Base_File
					,Promote(pversion).Base.New2Built
					,Promote(pversion).Base.built2qa
				);
		
	export All :=
	if(VersionControl.IsValidVersion(pversion)
		,sequential(full_build)		
		,output('No Valid version parameter passed, skipping UtilFile.build_Util_bus_base atribute')
	);
		
end;
