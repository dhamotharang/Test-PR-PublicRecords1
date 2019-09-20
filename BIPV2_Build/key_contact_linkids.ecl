﻿import Business_Header_SS,corp2,BIPV2,business_header,ut,AutoStandardI,tools
       ,acf,diversity_certification,govdata,gsa,insurance_certification,martindale_hubbell
			 ,ncpdp,oig,one_click_data,poesfromemails,poesfromutilities,redbooks,saleschannel,sda_sdaa
			 ,teletrack,thrive,mdr,BIPV2_Suppression,bipv2_files,BIPV2_Tools,Suppress, Address;
import BIPV2_Contacts;

EXPORT key_contact_linkids :=
module
													 //BIPV2.File_Business_Sources(source not in [mdr.sourcetools.src_Dunn_Bradstreet,mdr.sourcetools.src_zoom])
  shared contacts_sources := 
                             BIPV2.File_Business_Sources(BIPV2.mod_sources.srcInContacts_Key(source))  //*** Removed zoom as per bug# 132603.
	                          +acf.ACF_As_Business_Linking_Contact()
														+diversity_certification.As_Business_Linking_Contact()
														+govdata.FL_Non_Profit_As_Business_Linking_Contact()
														+govdata.IA_Sales_Tax_As_Business_Linking_Contact()
														+govdata.MS_Workers_As_Business_Linking_Contact()
														+gsa.As_Business_Linking_Contact()
														+insurance_certification.As_Business_Linking_Contact()
														+martindale_hubbell.As_Business_Linking_Contact()
														+ncpdp.As_Business_Linking_Contact()
														+oig.OIG_As_Business_Linking_Contact()
														//+one_click_data.As_Business_Linking_Contact()    //*** Removed one_click_data as per bug# 132603.
														//+poesfromemails.As_Business_Linking_Contact()		 //*** Removed poesfromemails as per bug# 132603.
														+poesfromutilities.As_Business_Linking_Contact()
														+redbooks.As_Business_Linking_Contact()
														//+saleschannel.As_Business_Linking_Contact()			 //*** Removed saleschannel as per bug# 132603.
														+sda_sdaa.SDA_SDAA_As_Business_Linking_Contact()
														//+teletrack.As_Business_Linking_Contact()				 //*** Removed teletrack as per bug# 132603.
														//+thrive.As_Business_Linking_Contact()						 //*** Removed thrive as per bug# 132603.
														;

  didding_layout := {
     BIPV2.Layout_Business_Linking_Full - contact_name - company_address,
	  		address.layout_clean_name - name_score,
	  		address.Layout_Clean_125  
  };

  contacts_sources_with_id := distribute(project(contacts_sources, 
      transform(BIPV2.Layout_Business_Linking_Full, self.rcid:=counter; self:=left;)), rcid);

  ds := project(contacts_sources_with_id, transform(didding_layout, 																																						
    self.title := left.contact_name.title;
    self.fname := left.contact_name.fname;
    self.mname := left.contact_name.mname;
    self.lname := left.contact_name.lname;
    self.name_suffix := left.contact_name.name_suffix;
		
    self.predir := left.company_address.predir;
    self.prim_name := left.company_address.prim_name;
    self.prim_range := left.company_address.prim_range;
    self.addr_suffix := left.company_address.addr_suffix;
    self.unit_desig := left.company_address.unit_desig;																																								
    self.postdir := left.company_address.postdir;
    self.sec_range := left.company_address.sec_range;
    self.p_city_name := left.company_address.p_city_name;
    self.v_city_name := left.company_address.v_city_name;
    self.st := left.company_address.st;																																									
    self.zip := left.company_address.zip;
    self.zip4 := left.company_address.zip4;
    self := left;
		  self:=[]));
  // Same Append as done in BIPV2_Build.proc_ingest
  append := BIPV2_Files.tools_dotid().APPEND_DID(distribute(ds));//this can get skewed, so add distribute
  // append := ds;//this can get skewed, so add distribute

  shared contacts_sources_w_append := join(contacts_sources_with_id, append, 
    left.rcid=right.rcid, 
    transform(BIPV2.Layout_Business_Linking_Full,
        self.contact_did := if(right.contact_did<>0, right.contact_did, left.contact_did);
        self := left;),
		  keep(1));


  shared r1 :=
  record
	  unsigned8 rid:=0;
    BIPV2.IDlayouts.l_xlink_ids; 
    contacts_sources;
		//boolean executive_ind:='';
		boolean executive_ind:=False;
		integer executive_ind_order:=0;
  end;
  
  shared ds1 := contacts_sources_w_append;
  
  shared ds_add_ids := project(ds1,r1);
  shared ds_add_ids_commonbase := project(bipv2.commonbase.ds_built(BIPV2.mod_sources.srcInBase(source),ingest_status in ['New','Unchanged','Updated']),transform(r1
    ,self                              := left  
    ,self.company_address.prim_range	 := left.prim_range	
    ,self.company_address.predir			 := left.predir			
    ,self.company_address.prim_name		 := left.prim_name		
    ,self.company_address.addr_suffix	 := left.addr_suffix	
    ,self.company_address.postdir			 := left.postdir			
    ,self.company_address.unit_desig	 := left.unit_desig	
    ,self.company_address.sec_range		 := left.sec_range		
    ,self.company_address.p_city_name	 := left.p_city_name	
    ,self.company_address.v_city_name	 := left.v_city_name	
    ,self.company_address.st					 := left.st					
    ,self.company_address.zip					 := left.zip					
    ,self.company_address.zip4				 := left.zip4				
    ,self.company_address.cart				 := left.cart				
    ,self.company_address.cr_sort_sz	 := left.cr_sort_sz	
    ,self.company_address.lot					 := left.lot					
    ,self.company_address.lot_order		 := left.lot_order		
    ,self.company_address.dbpc				 := left.dbpc				
    ,self.company_address.chk_digit		 := left.chk_digit		
    ,self.company_address.rec_type		 := left.rec_type		
    ,self.company_address.fips_state	 := left.fips_state	
    ,self.company_address.fips_county	 := left.fips_county	
    ,self.company_address.geo_lat			 := left.geo_lat			
    ,self.company_address.geo_long		 := left.geo_long		
    ,self.company_address.msa					 := left.msa					
    ,self.company_address.geo_blk			 := left.geo_blk			
    ,self.company_address.geo_match		 := left.geo_match		
    ,self.company_address.err_stat		 := left.err_stat		
    ,self.contact_name.title			     := left.title			
    ,self.contact_name.fname			     := left.fname			
    ,self.contact_name.mname			     := left.mname			
    ,self.contact_name.lname			     := left.lname			
    ,self.contact_name.name_suffix     := left.name_suffix
    ,self.contact_name.name_score	     := left.name_score	
    ,self                              := []
  
  ));
  
  shared contacts_records             := ds_add_ids(contact_name.fname<>'' and contact_name.lname<>'');
  shared contacts_records_commonbase  := ds_add_ids_commonbase(contact_name.fname<>'' and contact_name.lname<>'');
  shared contacts_matchset            := ['F','A','P'];
 
  shared recordof(contacts_records) xform_add_deriveds(r1 le) := transform
   self.contact_job_title_derived := bipv2.bl_tables.contacttitle(le.contact_job_title_raw);
	 self.contact_type_derived      := bipv2.bl_tables.contacttypedesc(le.contact_type_raw);
	 self.contact_status_derived    := bipv2.bl_tables.contactstatus(le.contact_status_raw);
	 self                           := le;
  end;
  shared recordof(contacts_records) xform_add_exec_ind(r1 le, bipv2.bl_tables.executivetitles ri) := transform
	 self.executive_ind             := ri.position_title<>'';
	 self.executive_ind_order       := ri.order;
	 self                           := le;
  end;
	  
  shared p_add_deriveds_commonbase := project(contacts_records_commonbase,xform_add_deriveds(left));
	shared j_add_exec_ind_commonbase := join(p_add_deriveds_commonbase,bipv2.bl_tables.executivetitles,left.contact_job_title_derived=right.position_title,xform_add_exec_ind(left,right),left outer,lookup);
  shared p_add_deriveds := project(contacts_records,xform_add_deriveds(left));
	shared j_add_exec_ind := join(p_add_deriveds,bipv2.bl_tables.executivetitles,left.contact_job_title_derived=right.position_title,xform_add_exec_ind(left,right),left outer,lookup);
 
  ut.MAC_Sequence_Records(j_add_exec_ind,rid,add_rid);
 
shared dDataset       := add_rid;
shared layoutOrigFile	:= {recordof(contacts_records) - rid,unsigned4 global_sid,unsigned8 record_sid};
shared layoutSeqFile	:= recordof(dDataset);
shared bdidSlimLayout	:=
record
	unsigned8		unique_id					;
	string100 	company_name			;
	string10  	prim_range				;
	string28		prim_name					;
	string5			zip5							;
	string8			sec_range					;
	string2			state		 					;
	string10		phone		  		    ;
	string9			fein		  		    ;
	string34		source_group	    ;
	unsigned6		bdid					:= 0;
	unsigned1		bdid_score		:= 0;
	string50		URL					      ;
	string50		Email				      ;
	string25		City					    ;
	string20		Contact_fname     ;
	string20		Contact_mname     ;
	string20		Contact_lname     ;
	string9		Contact_ssn     ;
  string      source;
  unsigned      source_record_id;
	unsigned6		proxid				:= 0;
	unsigned2		proxweight				:= 0;
	unsigned2		proxscore 				:= 0;
	unsigned6		seleid				:= 0;
	unsigned2		seleweight				:= 0;
	unsigned2		selescore 				:= 0;
	unsigned6		empid					:= 0;
	unsigned2		empweight					:= 0;
	unsigned2		empscore 					:= 0;
	unsigned6		orgid					:= 0;
	unsigned2		orgweight					:= 0;
	unsigned2		orgscore 					:= 0;
	unsigned6		powid					:= 0;
	unsigned2		powweight					:= 0;
	unsigned2		powscore 					:= 0;
	unsigned6		ultid					:= 0;
	unsigned2		ultweight					:= 0;
	unsigned2		ultscore 					:= 0;
	unsigned6		dotid					:= 0;
	unsigned2		dotweight					:= 0;
	unsigned2		dotscore 					:= 0;
	end;
bdidSlimLayout tSlimForBdiding(layoutSeqFile l) :=
transform
	self.unique_id		:= l.rid												;
	self.company_name	:= l.company_name					;
	self.prim_range		:= l.company_address.prim_range;
	self.prim_name		:= l.company_address.prim_name;
	self.zip5					:= l.company_address.zip;
	self.sec_range		:= l.company_address.sec_range;
	self.state				:= l.company_address.st;
	self.city			  	:= l.company_address.v_city_name;
	self.phone				:= l.company_phone;
	self.bdid					:= 0																		;
	self.bdid_score		:= 0																		;
	self.source_group := '';
	self.fein					:= l.company_fein;
	self.URL				:= '';
	self.Email			:= '';
	self.Contact_fname	:= l.contact_name.fname;
	self.Contact_mname	:= l.contact_name.mname;
	self.Contact_lname	:= l.contact_name.lname;
	self.Contact_ssn  	:= l.contact_ssn;
  self.source         := l.source;
  self.source_record_id := l.source_record_id;
end;
dSlimForBdiding := project(dDataset,tSlimForBdiding(left));
dDedupSlim	:= dedup(dedup(dSlimForBdiding	,except unique_id, bdid, bdid_score,source,source_record_id, local),except unique_id, bdid, bdid_score,source,source_record_id,all);
  Business_Header_SS.MAC_Match_Flex
  (
     dDedupSlim
    ,contacts_matchset
    ,company_name
    ,prim_range,prim_name,zip5,sec_range,state
    ,phone
    ,fein
    ,bdid
    ,bdidSlimLayout
    ,false
    ,''
    ,contacts_bipd
    ,
    ,
    ,
    ,
    ,bipv2.IDconstants.xlink_versions_BDID_BIP
    ,url
    ,email
    ,city
    ,contact_fname
    ,contact_mname
    ,contact_lname
    ,contact_ssn
    ,source
    ,source_record_id
    ,true
  );
contacts_bipd_full := join(
	 dSlimForBdiding
	,contacts_bipd
	,		left.company_name	 = right.company_name		
	and	left.prim_range		 = right.prim_range			
	and	left.prim_name		 = right.prim_name			
	and	left.zip5					 = right.zip5						
	and	left.sec_range		 = right.sec_range			
	and	left.state				 = right.state					
	and	left.phone				 = right.phone					
	and	left.source_group = right.source_group 	
	and	left.fein				 = right.fein						
	and	left.URL					 = right.URL							
	and	left.Email				 = right.Email						
	and	left.City					= right.City							
	and	left.Contact_fname = right.Contact_fname		
	and	left.Contact_mname = right.Contact_mname		
	and	left.Contact_lname = right.Contact_lname		
	,transform(
		recordof(contacts_bipd)
		,self.bdid				:= right.bdid				;
		,self.bdid_score	:= right.bdid_score	;
		,self.proxid			:= right.proxid		  ;
		,self.proxweight	:= right.proxweight ;
		,self.proxscore 	:= right.proxscore  ;
		,self.seleid			:= right.seleid		  ;
		,self.seleweight	:= right.seleweight ;
		,self.selescore 	:= right.selescore  ;
		,self.empid				:= right.empid			;
		,self.empweight		:= right.empweight	;
		,self.empscore 		:= right.empscore 	;
		,self.orgid				:= right.orgid			;
		,self.orgweight		:= right.orgweight	;
		,self.orgscore 		:= right.orgscore 	;
		,self.powid				:= right.powid			;
		,self.powweight		:= right.powweight	;
		,self.powscore 		:= right.powscore 	;
		,self.ultid				:= right.ultid			;
		,self.ultweight		:= right.ultweight	;
		,self.ultscore 		:= right.ultscore 	;
		,self.dotid				:= right.dotid			;
		,self.dotweight		:= right.dotweight	;
		,self.dotscore 		:= right.dotscore 	;
		 self							:= left							;
	)
);
dBDidOut := contacts_bipd_full;
dBDidOut_dist		:= distribute	(dBDidOut							,unique_id						);
pDataset_dist 	:= distribute	(dDataset							,rid									);
layoutOrigFile tAssignBdids(layoutSeqFile l, bdidSlimLayout r) :=
transform
	self.company_bdid	 := if(r.bdid 		  <> 0, r.bdid				,0);
	self.proxid		     := if(r.proxid		  <> 0 ,r.proxid		  ,0);
	self.proxweight    := if(r.proxweight <> 0 ,r.proxweight  ,0);
	self.proxscore     := if(r.proxscore  <> 0 ,r.proxscore   ,0);
	self.seleid		     := if(r.seleid		  <> 0 ,r.seleid		  ,0);
	self.seleweight    := if(r.seleweight <> 0 ,r.seleweight  ,0);
	self.selescore     := if(r.selescore  <> 0 ,r.selescore   ,0);
	self.empid			   := if(r.empid			<> 0 ,r.empid			  ,0);
	self.empweight	   := if(r.empweight	<> 0 ,r.empweight	  ,0);
	self.empscore 	   := if(r.empscore 	<> 0 ,r.empscore 	  ,0);
	self.orgid			   := if(r.orgid			<> 0 ,r.orgid			  ,0);
	self.orgweight	   := if(r.orgweight	<> 0 ,r.orgweight	  ,0);
	self.orgscore 	   := if(r.orgscore 	<> 0 ,r.orgscore 	  ,0);
	self.powid			   := if(r.powid			<> 0 ,r.powid			  ,0);
	self.powweight	   := if(r.powweight	<> 0 ,r.powweight	  ,0);
	self.powscore 	   := if(r.powscore 	<> 0 ,r.powscore 	  ,0);
	self.ultid			   := if(r.ultid			<> 0 ,r.ultid			  ,0);
	self.ultweight	   := if(r.ultweight	<> 0 ,r.ultweight	  ,0);
	self.ultscore 	   := if(r.ultscore 	<> 0 ,r.ultscore 	  ,0);
	self.dotid			   := if(r.dotid			<> 0 ,r.dotid			  ,0);
	self.dotweight	   := if(r.dotweight	<> 0 ,r.dotweight	  ,0);
	self.dotscore 	   := if(r.dotscore 	<> 0 ,r.dotscore 	  ,0);
  self.global_sid    := 0;
  self.record_sid    := 0;
	self 						   := l;
end;
dAssignBdids := join(
	 pDataset_dist
	,dBDidOut_dist
	,left.rid = right.unique_id
	,tAssignBdids(left, right)
	,left outer
	,local)
;
dAssignBdids_commonbase := project(j_add_exec_ind_commonbase  ,transform(layoutOrigFile,
	self.proxweight    := 100;
	self.seleweight    := 100;
	self.empweight	   := 100;
	self.orgweight	   := 100;
	self.powweight	   := 100;
	self.ultweight	   := 100;
	self.dotweight	   := 100;
	self.dotscore 	   := 100;
	self.proxscore     := 100;
	self.selescore     := 100;
	self.empscore 	   := 100;
	self.powscore 	   := 100;
	self.orgscore 	   := 100;
	self.ultscore 	   := 100;
  self.global_sid    := 0;
  self.record_sid    := 0;
  self               := left
));
  shared ds_concat_prep := dAssignBdids + dAssignBdids_commonbase : persist('~persist::BIPV2_Build::key_contact_linkids.ds_concat_prep');
  
  export ds_prop_did := BIPV2_Tools.Propagate_DID(ds_concat_prep,'contact_linkids','key');
  shared contacts_bipd_pst          :=   ds_prop_did : persist('persist::bip_contacts');
  export contacts_bipd_dst          :=   dataset('~thor400_20::persist::bip_contacts',layoutOrigFile,flat);
  // DEFINE THE INDEX
  shared superfile_name := keynames(, tools._Constants.IsDataland).contact_linkids.QA;
		
  export dkeybuild      := Suppress.applyRegulatory.applyContactBIPV2(contacts_bipd_pst);
  
  export Key := BIPV2_Contacts.key_contact_linkids.Key(dkeybuild, superfile_name);
  
  // -- ensure easy access to different logical and super versions of the key
  export keyvs := BIPV2_Contacts.key_contact_linkids.keyvs;
  export keybuilt       := BIPV2_Contacts.key_contact_linkids.keybuilt;
  export keyQA          := BIPV2_Contacts.key_contact_linkids.keyQA;
  export keyfather      := BIPV2_Contacts.key_contact_linkids.keyfather;
  export keygrandfather := BIPV2_Contacts.key_contact_linkids.keygrandfather;
  
  // export kfetch_layout :={Key};
  export kfetch_layout := BIPV2_Contacts.key_contact_linkids.kfetch_layout;
	
  //DEFINE THE INDEX ACCESS
  export kFetch      := BIPV2_Contacts.key_contact_linkids.kFetch;
	
	//DEFINE THE INDEX ACCESS
  export kFetchMarketing      := BIPV2_Contacts.key_contact_linkids.kFetchMarketing;

  
end;
