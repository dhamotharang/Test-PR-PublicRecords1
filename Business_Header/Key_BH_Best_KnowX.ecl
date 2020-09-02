import business_header_ss,ut, lib_fileservices, header_services,codes,mdr,data_services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
bh_base := PRTE2_Business_Header.Files().Base.Business_Headers.built;
f_best  := PRTE2_Business_Header.BestAll(bh_base, 'EB_AE_DNB_For_Knowx',, TRUE);  //Set param to true to retrieve best non D&B);
#ELSE
bh_base := Business_Header.filters.bases.business_header_best(Files().Base.Business_Headers.built);
f_best  := Business_Header.BestAll(bh_base, 'EB_AE_DNB_For_Knowx',, TRUE);  //Set param to true to retrieve best non D&B);
#END;

codesV3 := codes.Key_Codes_V3;

required_src_set := set(codesV3(file_name = 'BUSINESS-HEADER'

                                    AND field_name= (STRING50)'CONSUMER-PORTAL'

                                    AND field_name2= (STRING5)'ALLOW' )
										,code);


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

bh_base_filtered := project(f_best(source in required_src_set), filterDNBAddressPhone(left));


// need to match back to BH to see if the dnb records with address information have another source

//** Commented the below trasform "tblanksource" code to retain the source values as per Jira# DF-27729 Business Header Best key Source Update /*
// Business_Header.Layout_BH_Best tblanksource(Business_Header.Layout_BH_Best l) :=
// transform
	// self.source := '';
	// self := l;
// end;

//** Commented as pe Jira# DF-27729 Business Header Best key Source Update
//in_hdr := project(bh_base_filtered, tblanksource(left));

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
rDataSet := bh_base_filtered;
#ELSE
rDataSet := Business_Header.Prep_Build.applyBusinessBestInj(bh_base_filtered);;
#END;

full_out_suppress := project(Business_Header.Prep_Build.applyDidAddressBusiness_sup2(rDataSet), Business_Header.Layout_BH_Best);

f_best_blanksource_unique := full_out_suppress;

EXPORT Key_BH_Best_KnowX := INDEX(
	f_best_blanksource_unique, 
	{bdid},
	{f_best_blanksource_unique}-business_header.layout_BH_exclusions,
	ut.foreign_prod+'thor_data400::key::business_header.Best_Knowx_' + business_header_ss.key_version );
