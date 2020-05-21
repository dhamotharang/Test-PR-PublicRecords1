import business_header_ss,ut, lib_fileservices, header_services, address, MDR, Data_Services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
bh_base := PRTE2_Business_Header.Files().Base.Business_Headers.built;
f_best  := PRTE2_Business_Header.BestAll(bh_base, 'EB_AE_DNB',, TRUE);  //Set param to true to retrieve best non D&B
#ELSE
bh_base := Business_Header.filters.bases.business_header_best(Files().Base.Business_Headers.built);
f_best  := Business_Header.BestAll(bh_base, 'EB_AE_DNB',, TRUE);  //Set param to true to retrieve best non D&B
#END;

bh_best_layout := Business_Header.Layout_BH_Best;

bh_best_layout  filterDNBAddressPhone(bh_best_layout l) := 
transform
	self.prim_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.prim_range	);
	self.predir				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.predir			);
	self.prim_name		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.prim_name	);
	self.addr_suffix	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.addr_suffix);
	self.postdir			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.postdir		);
	self.unit_desig		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.unit_desig	);
	self.sec_range		:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,''	,l.sec_range	);
	self.zip					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,0	,l.zip				);
	self.zip4					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.addr_source)	,0	,l.zip4				);
	//self.county				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.county			);
	//self.msa					:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.msa				);
	//self.geo_lat			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_lat		);
	//self.geo_long			:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,''	,l.geo_long		);
	self.phone				:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.phone_source)	,0	,l.phone			);
	//self.phone_score	:= if(MDR.sourceTools.SourceIsDunn_Bradstreet(l.source)	,0	,l.phone_score);
	self 				:= l;                                                    
end;

bh_base_filtered := project(f_best, filterDNBAddressPhone(left));
// need to match back to BH to see if the dnb records with address information have another source

//** Commented the below trasform "tblanksource" code to retain the source values as per Jira# DF-27729 Business Header Best key Source Update 
//Business_Header.Layout_BH_Best tblanksource(Business_Header.Layout_BH_Best l) :=
//transform
//	self.source := '';
//	self := l;
//end;

//CNG W20070816-150957 dat//////////////////////////////////

Drop_Header_Layout := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
Record
	string15 bdid;	         
	string10 dt_last_seen;
	string120 company_name;
	string10 prim_range;
	string2   predir;
	string28 prim_name;
	string4  addr_suffix;
	string2   postdir;
	string5  unit_desig;
	string8  sec_range;
	string25 city;
	string2   state;
	string8 zip;
	string5 zip4;
	string15 phone;
	string10 fein;       
	string3 best_flags;
	string2   source;	 
    string2   DPPA_State;
    string2 eor;
end;

header_services.Supplemental_Data.mac_verify('file_business_best_inj.txt', Drop_Header_Layout, attr);

Base_File_Append_In := attr();

business_header.Layout_BH_Best reformat_header(Base_File_Append_In L) := //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT
 transform
	self.bdid := (unsigned6) L.bdid;
	self.dt_last_seen := (unsigned4) L.dt_last_seen;
	self.zip := (unsigned3) L.zip;
	self.zip4 := (unsigned2) L.zip4;
	self.phone := (unsigned6) L.phone;
	self.fein := (unsigned4) L.fein;
	self.best_flags := (unsigned3) L.best_flags;
  self := L;
	self := [];	

 end;
 
 
Base_File_Append := project(Base_File_Append_In, reformat_header(left)); //REMOVE WHEN WE START TO RECEIVE FILES IN THE CORRECT LAYOUT

/////////////////////////////////////////////////////

//** Commented as pe Jira# DF-27729 Business Header Best key Source Update 
//in_hdr := project(bh_base_filtered, tblanksource(left));

mainDataSet := bh_base_filtered + Base_File_Append;

f_bbs := join(	mainDataSet, 
								Base_File_Append,
								left.bdid = right.bdid,
								left only,
								lookup);


#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
rDataSet := f_bbs;
#ELSE
rDataSet := f_bbs + Base_File_Append;
#END;

/////////////////////////////////////////////////////
// Start of code to suppress data based on an MD5 Hash of DID+Address
Suppression_Layout := header_services.Supplemental_Data.layout_in;

header_services.Supplemental_Data.mac_verify('didaddressbusiness_sup.txt',Suppression_Layout,supp_ds_func);
 
Suppression_In := supp_ds_func();

dSuppressedIn := project(Suppression_In, header_services.Supplemental_Data.in_to_out(left));

rHashDIDAddress := header_services.Supplemental_Data.layout_out;

rFullOut_HashDIDAddress := record
 business_header.Layout_BH_Best;
 rHashDIDAddress;
 data16 hval1;
end;

rFullOut_HashDIDAddress tHashDIDAddress(business_header.Layout_BH_Best l) := transform                            
 self.hval := hashmd5(intformat(l.bdid,12,1),(string)l.state,(string)l.zip,(string)l.city,
									(string)l.prim_name,(string)l.prim_range,(string)l.predir,(string)l.addr_suffix,(string)l.postdir,(string)l.sec_range);
 self.hval1 := hashmd5(intformat(l.bdid,12,1));
 self := l;
end;

dHeader_withMD5 := project(rDataSet, tHashDIDAddress(left));

business_header.Layout_BH_Best tSuppress(dHeader_withMD5 l) := transform
 self := l;
end;

full_out_suppress := join(dHeader_withMD5,dSuppressedIn,
                          left.hval = right.hval,
            						  tSuppress(left),
						              left only,lookup);

/////////////////////////////////////////////////////////////////////////

f_best_blanksource := full_out_suppress;

EXPORT Key_BH_Best := INDEX(
	f_best_blanksource, 
	{bdid},
	{f_best_blanksource}-business_header.layout_BH_exclusions,
	ut.foreign_prod+'thor_data400::key::business_header.Best_' + business_header_ss.key_version );
