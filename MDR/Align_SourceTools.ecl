import ut, vehlic, atf, watercraft, business_header,VersionControl;

export Align_SourceTools :=
module
	
	export set_mapping_source_codes := ['AF','AW'/*,'LP','PR'*/];
	
	export mapping_layout :=
	record
		
		string old_source_code;
		qstring34 vendor_id;
		string new_source_code;
		unsigned6 bdid;
		
	end;
	
	/*
	function
		pass in all source datasets that business headers needs to join to to get additional info for mapping
		the source codes
		return a dataset with old source code, vendor_id, and new_source code
	*/
	export fCreateMappingDataset(
	
		 dataset(atf.layout_firearms_explosives_out					) pATF				= ATF.file_firearms_explosives_base
		,dataset(Watercraft.Layout_Watercraft_Search_Base		) pWatercraft = Watercraft.File_Base_Search_Prod
	
	) :=
	function
		
		// -- ATF
		mapping_layout tATF(atf.layout_firearms_explosives_out l) :=
		transform
		
			self.old_source_code	:= 'AF';
			self.vendor_id				:= l.license_number;
			self.new_source_code	:= if(l.record_type = 'F','FF','FE');
			self.bdid							:= (unsigned6)l.bdid;		
		
		end;

		// -- Watercraft
		mapping_layout tWatercraft(Watercraft.Layout_Watercraft_Search_Base l) :=
		transform
		
			self.old_source_code	:= 'AW';
			self.vendor_id				:= l.state_origin + trim(l.watercraft_key,left,right) + trim(l.sequence_key,left,right);
			self.new_source_code	:= Watercraft.Header_Source_Code(l.Source_Code, l.State_Origin);
			self.bdid							:= (unsigned6)l.bdid;		
		
		end;
	

	  dATF_slim					:= project	(pATF					,tATF					(left));
	  dWatercraft_slim 	:= project	(pWatercraft	,tWatercraft	(left));
	                          
		dConcat := 
				dATF_slim				
			+ dWatercraft_slim
			;
	
		dConcat_dedup := dedup(dConcat, record, all)
			: persist('~thor_data400::persist::mdr::SourceMappingTools::fCreateMappingDataset')
			;
	
		return dConcat_dedup;
		
	end;

	export dMappingdataset := fCreateMappingDataset(dataset(ut.foreign_prod + '~thor_data400::base::atf_firearms_explosives',atf.layout_firearms_explosives_out,flat));

	export fForward(
	
		 string			pSource
		,string			pVendor_id
		,unsigned4	pFein
	
	) :=
	function
	
	return 
		map(
			 pSource = 'FF'															=> 'FL'		// Florida FBN(used to step on federal firearms)
			,pSource = 'DC'															=> 'DF'		// DCA(changing from accurint DOC)
			,pSource = 'DE'															=> 'DA'		// DEA(changing from Death master)
			,pSource = 'EB'															=> 'ER'		// EBR
			,pSource = 'FA'															=> 'AR'		// FAA Aircraft change to Header source for that
			,pSource = 'FC'															=> 'FK'		// FCC 
			,pSource = 'FD'															=> 'FI'		// FDIC(changing from FL DL)
			,pSource = 'ID'															=> 'IC'		// Infousa Dead Companies(changing from ID DL)
			,pSource = 'MD'															=> 'ML'		// Medical Information Directory(from MO DL)
			,pSource = 'B'															=> 'BA'		// Bankruptcy(to header Bankruptcy source)
			,pSource = 'ED'															=> 'EY'		// Employee Directories(from NM DL)
			,pSource = 'D' and pFein != 0								=> 'DN'		// D&B Fein
			,pSource = 'ST' and pVendor_id[1..2] = 'CA'	=> 'FT'		// California Sales Tax
			,pSource = 'ST' and pVendor_id[1..2] = 'IA'	=> 'IT'		// Iowa Sales Tax
			,pSource = 'C'															=> mdr.sourceTools.fCorpV2	(trim(pVendor_id))
			,pSource = 'IF'															=> mdr.sourceTools.fFBNV2		(trim(pVendor_id))
			,pSource in ['PR','LP']											=> mdr.sourceTools.fProperty(trim(pVendor_id[4..7]))	//first 3 chars are source code and vendor source flag
			,pSource in ['AE','MV']											=> mdr.sourceTools.fVehicles(trim(pVendor_id[1..2]), trim(pSource))
			,pSource = 'WC' and pVendor_id[1..2] = 'MS' => 'MW'	// OR Workman's comp can stay, since it is not in header
			,pSource
		);	
	
	end;

	export fBackward(
	
		 string pSource
		,string pVendor_id
	
	) :=
	function
	
	return 
		map(
			 pSource = 'FL'																		=> 'FF'		// Florida FBN(used to step on federal firearms)
			,pSource = 'DF'																		=> 'DC'		// DCA(changing from accurint DOC)
			,pSource = 'DA'																		=> 'DE'		// DEA(changing from Death master)
			,pSource = 'ER'																		=> 'EB'		// EBR  from emerges boats
			,pSource = 'AR'																		=> 'FA'		// FAA Aircraft change to Header source for that(also step on LnPropV2_Fares_Asrs)
			,pSource = 'FK'																		=> 'FC'		// FCC (steps on FL criminal history)
			,pSource = 'FI'																		=> 'FD'		// FDIC(changing from FL DL)
			,pSource = 'IC'																		=> 'ID'		// Infousa Dead Companies(changing from ID DL)
			,pSource = 'ML'																		=> 'MD'		// Medical Information Directory(from MO DL)
			,pSource = 'BA'																		=> 'B'		// Bankruptcy(to header Bankruptcy source) little trickier
			,pSource = 'EY'																		=> 'ED'		// Employee Directories(from NM DL)
			,pSource = 'MW'																		=> 'WC'		// MS workers comp
			,pSource = 'DN'																		=> 'D'		// D&B Fein
			,MDR.sourceTools.SourceIsState_Sales_Tax(pSource)	=> 'ST'
			,MDR.sourceTools.SourceIsCorpV2					(pSource)	=> 'C'		
			,MDR.sourceTools.SourceIsFBNV2					(pSource)	=> 'IF'		
			,MDR.sourceTools.SourceIsProperty				(pSource)	=> if(trim(pVendor_id)[3] = 'F', 'PR','LP')
			,MDR.sourceTools.SourceIsExperianVehicle(pSource)	=> 'AE'
			,MDR.sourceTools.SourceIsDirectVehicle	(pSource)	=> 'MV'
			,pSource
		);	
	
	end;

	export Forward := 
	module
	
		export fBusinessHeader(

			dataset(business_header.Layout_Business_Header_base) pDataset	= business_header.files().base.business_headers.qa

		) :=
		function

			business_header.Layout_Business_Header_base tChangeSource(business_header.Layout_Business_Header_base l) :=
			transform
				// make sure to change the code for the as business header also at the same time
				self.source := fForward(l.source, l.vendor_id,l.fein);
				self 				:= l;
			
			end;
			
			dChangedSources_tomap := pDataset(source in set_mapping_source_codes);
			dChangedSources_rest	:= pDataset(source not in set_mapping_source_codes);
			
			dNewly_mapped_sources := join(
				 dChangedSources_tomap
				,dMappingdataset
				,		left.source			= right.old_source_code
				and left.vendor_id	= right.vendor_id
				,transform(recordof(pDataset), self.source := right.new_source_code; self := left)
//				,local
				,keep(1)
			);

			dChangedSources := project(dChangedSources_rest(not(source in ['LP','PR'] and vendor_id = '')), tChangeSource(left));
			
			return (dNewly_mapped_sources + dChangedSources)(trim(source) != '');

		end;

		export fBusinessContacts(

			dataset(business_header.Layout_Business_Contact_Full_new) pDataset	= business_header.files().base.business_contacts.qa

		) :=
		function

			business_header.Layout_Business_Contact_Full_new tChangeSource(business_header.Layout_Business_Contact_Full_new l) :=
			transform
				// make sure to change the code for the as business header also at the same time
				self.source := if(l.from_hdr = 'N', fForward(l.source, l.vendor_id,l.company_fein), l.source);
				self 				:= l;
			
			end;
			
			dChangedSources_tomap := pDataset(source in set_mapping_source_codes,from_hdr = 'N');
			dChangedSources_rest	:= pDataset(not(source in set_mapping_source_codes and from_hdr = 'N'));

			dNewly_mapped_sources := join(
				 dMappingdataset
				,dChangedSources_tomap
				,		right.source		= left.old_source_code
				and right.vendor_id	= left.vendor_id
				,transform(recordof(pDataset), self.source := left.new_source_code; self := right)
//				,local
				,keep(1)
			);

			dChangedSources := project(dChangedSources_rest(not(source in ['LP','PR'] and vendor_id = '')), tChangeSource(left));

			return (dNewly_mapped_sources + dChangedSources)(trim(source) != '');

		end;
	end;
	
	export Backward :=
	module
		
		export fBusinessHeader(

			dataset(business_header.Layout_Business_Header_base) pDataset	= business_header.files().base.business_headers.qa

		) :=
		function

			business_header.Layout_Business_Header_base tChangeSource(business_header.Layout_Business_Header_base l) :=
			transform
				// make sure to change the code for the as business header also at the same time
				self.source := fBackward(l.source, l.vendor_id);
				self 				:= l;
			
			end;
			
			dChangedSources_tomap := pDataset(MDR.sourceTools.SourceIsATF(source) or MDR.sourceTools.sourceIsWC(source));
			dChangedSources_rest 	:= pDataset(not(MDR.sourceTools.SourceIsATF(source) or MDR.sourceTools.sourceIsWC(source)));

			dNewly_mapped_sources := join(
				 dChangedSources_tomap
				,dMappingdataset
				,		left.source			= right.new_source_code
				and left.vendor_id	= right.vendor_id
				,transform(recordof(pDataset), self.source := right.old_source_code; self := left)
//				,local
				,keep(1)
			);

			dChangedSources := project(dChangedSources_rest, tChangeSource(left));
			
			return (dNewly_mapped_sources + dChangedSources)(trim(source) != '');

		end;

		export fBusinessContacts(

			dataset(business_header.Layout_Business_Contact_Full_new) pDataset	= business_header.files().base.business_contacts.qa

		) :=
		function

			business_header.Layout_Business_Contact_Full_new tChangeSource(business_header.Layout_Business_Contact_Full_new l) :=
			transform
				// make sure to change the code for the as business header also at the same time
				self.source := if(l.from_hdr = 'N', fBackward(l.source, l.vendor_id), l.source);
				self 				:= l;
			
			end;
			
			dChangedSources_tomap := pDataset((MDR.sourceTools.SourceIsATF(source) or MDR.sourceTools.sourceIsWC(source)),from_hdr = 'N');
			dChangedSources_rest 	:= pDataset(not((MDR.sourceTools.SourceIsATF(source) or MDR.sourceTools.sourceIsWC(source)) and from_hdr = 'N'));
			
			dNewly_mapped_sources := join(
				 dMappingdataset
				,dChangedSources_tomap
				,		right.source		= left.new_source_code
				and right.vendor_id	= left.vendor_id
				,transform(recordof(pDataset), self.source := left.old_source_code; self := right)
//				,local
				,keep(1)
			);

			dChangedSources := project(dChangedSources_rest, tChangeSource(left));

			return (dNewly_mapped_sources + dChangedSources)(trim(source) != '');

		end;
	
	end;
	
	// test this:
	export ftest_mapping(
		 dataset(business_header.Layout_Business_Header_base			) pBHDataset	= business_header.files().base.business_headers.qa
		,dataset(business_header.Layout_Business_Contact_Full_new	) pBCDataset	= business_header.files().base.business_contacts.qa
	
	) :=
	function
	
		// -- map source codes before, after
		dbhforward := Forward.fBusinessHeader		(pBHDataset);
		dbcforward := Forward.fBusinessContacts	(pBCDataset);
		
		dbhbackward := Backward.fBusinessHeader		(dbhforward);
		dbcbackward := Backward.fBusinessContacts	(dbcforward);
       
		// -- Stats on sources before, after
		pBHDataset_source_stats		:= table(pBHDataset	,{source, unsigned8 cnt := count(group)},source,few);
		dbhforward_source_stats		:= table(dbhforward	,{source, unsigned8 cnt := count(group)},source,few);
		dbhbackward_source_stats	:= table(dbhbackward,{source, unsigned8 cnt := count(group)},source,few);
		pBCDataset_source_stats		:= table(pBCDataset	,{source, unsigned8 cnt := count(group)},source,few);
		dbcforward_source_stats		:= table(dbcforward	,{source, unsigned8 cnt := count(group)},source,few);
		dbcbackward_source_stats	:= table(dbcbackward,{source, unsigned8 cnt := count(group)},source,few);

		// -- compare backwards to original
		dbh_diff_source_counts 			:= join(pBHDataset_source_stats, dbhbackward_source_stats,left.source = right.source,transform({string source,unsigned8 current_cnt,unsigned8 new_cnt}, self := left;self.current_cnt := left.cnt;self.new_cnt := right.cnt))(current_cnt != new_cnt);
		dbc_diff_source_counts 			:= join(pBCDataset_source_stats, dbcbackward_source_stats,left.source = right.source,transform({string source,unsigned8 current_cnt,unsigned8 new_cnt}, self := left;self.current_cnt := left.cnt;self.new_cnt := right.cnt))(current_cnt != new_cnt);
		dbh_missing_orig_sources 		:= join(pBHDataset_source_stats, dbhbackward_source_stats,left.source = right.source,transform({string source,unsigned8 current_cnt,unsigned8 new_cnt}, self := left;self.current_cnt := left.cnt;self.new_cnt := right.cnt),right only);
		dbh_missing_mapped_sources	:= join(pBHDataset_source_stats, dbhbackward_source_stats,left.source = right.source,transform({string source,unsigned8 current_cnt,unsigned8 new_cnt}, self := left;self.current_cnt := left.cnt;self.new_cnt := right.cnt),left only);
		dbc_missing_orig_sources 		:= join(pBCDataset_source_stats, dbcbackward_source_stats,left.source = right.source,transform({string source,unsigned8 current_cnt,unsigned8 new_cnt}, self := left;self.current_cnt := left.cnt;self.new_cnt := right.cnt),right only);
		dbc_missing_mapped_sources	:= join(pBCDataset_source_stats, dbcbackward_source_stats,left.source = right.source,transform({string source,unsigned8 current_cnt,unsigned8 new_cnt}, self := left;self.current_cnt := left.cnt;self.new_cnt := right.cnt),left only);

		// -- Examples of each source code and it's vendor_id
		
		returnresult := parallel(
		
			 output(pBHDataset_source_stats		,named('pBHDataset_source_stats'	),all)
			,output(dbhforward_source_stats		,named('dbhforward_source_stats'	),all)
			,output(dbhbackward_source_stats	,named('dbhbackward_source_stats'	),all)
			,output(pBCDataset_source_stats		,named('pBCDataset_source_stats'	),all)
			,output(dbcforward_source_stats		,named('dbcforward_source_stats'	),all)
			,output(dbcbackward_source_stats	,named('dbcbackward_source_stats'	),all)
		                  
			,output(dbh_diff_source_counts 			,named('dbh_diff_source_counts' 		),all)
			,output(dbc_diff_source_counts 			,named('dbc_diff_source_counts' 		),all)
			,output(dbh_missing_orig_sources 		,named('dbh_missing_orig_sources'		),all)
			,output(dbh_missing_mapped_sources	,named('dbh_missing_mapped_sources'	),all)
			,output(dbc_missing_orig_sources 		,named('dbc_missing_orig_sources' 	),all)
			,output(dbc_missing_mapped_sources	,named('dbc_missing_mapped_sources'	),all)
		);   
		
		return returnresult;
	
	end;
	
	export f_mapping(
		 string																											pversion
		,dataset(business_header.Layout_Business_Header_base			) pBHDataset	= business_header.files().base.business_headers.qa
		,dataset(business_header.Layout_Business_Contact_Full_new	) pBCDataset	= business_header.files().base.business_contacts.qa
		,boolean																										pOverwrite	= false
	) :=
	function
	
		shared dbhforward := Forward.fBusinessHeader		(pBHDataset);
		shared dbcforward := Forward.fBusinessContacts	(pBCDataset);
    
		shared names := business_header.filenames(pversion).base;
		
		// -- Stats on sources before, after
		shared pBHDataset_source_stats		:= table(pBHDataset	,{source, unsigned8 cnt := count(group)},source,few);
		shared dbhforward_source_stats		:= table(dbhforward	,{source, unsigned8 cnt := count(group)},source,few);
		shared pBCDataset_source_stats		:= table(pBCDataset	,{source, unsigned8 cnt := count(group)},source,few);
		shared dbcforward_source_stats		:= table(dbcforward	,{source, unsigned8 cnt := count(group)},source,few);

		// -- Examples of each source code and it's vendor_id
		VersionControl.macBuildNewLogicalFile( names.Search.new					,dbhforward		,BuildSearch				,,,pOverwrite);
		VersionControl.macBuildNewLogicalFile( names.contactsPlus.new		,dbcforward		,Build_ContactsPlus	,,,pOverwrite);

		returnresult := parallel(
			 BuildSearch				
			,Build_ContactsPlus	 
			,output(pBHDataset_source_stats		,named('pBHDataset_source_stats'	),all)
			,output(dbhforward_source_stats		,named('dbhforward_source_stats'	),all)
			,output(pBCDataset_source_stats		,named('pBCDataset_source_stats'	),all)
			,output(dbcforward_source_stats		,named('dbcforward_source_stats'	),all)
		                  
		);   
		
		return returnresult;
	
	end;
	
end;
