import PRTE2_Prof_License_Mari, Prof_License_Mari, ut, PromoteSupers,PRTE2;


file_in_search 		:= Files.file_search(Cust_Name='LN_PR');

dsClnNameAddr    := PRTE2_Prof_License_Mari.fCleanNameAddr(file_in_search);

file_in_search2 := project(dsClnNameAddr,Transform(Layouts.search,
self:=left;
self:=[];
));

file_in_search3:=Files.file_search(Cust_Name !='LN_PR') + file_in_search2;

dsStdDesc		:=	JOIN(file_in_search3, Prof_License_Mari.files_References.MARIcmvSrc,	
												 left.std_source_upd = right.src_nbr,
														transform(Layouts.search,
																			self.std_source_desc := if(left.std_source_desc = '', ut.CleanSpacesAndUpper(right.src_name), left.std_source_desc);
																			self := left;
																			), 
																left outer, lookup);

	
dsLicenseState		:=	JOIN(dsStdDesc, Prof_License_Mari.files_References.cmvtranslation,	
												 left.std_source_upd = right.source_upd,
														transform(Layouts.search,
																			self.license_state := ut.CleanSpacesAndUpper(right.lic_state);
																			self := left;
																			), 
																left outer, lookup);	
																
													
Layouts.search		xformOriginalBase(layouts.search le) := transform
self.cln_license_nbr	:= IF(trim(le.license_nbr) in ['','NR'],'', Prof_license_mari.fCleanLicenseNbr(le.license_nbr));
self.addr_zip5_1			:= if(length(le.addr_zip5_1) < 5, INTFORMAT((integer)le.addr_zip5_1,5,1),le.addr_zip5_1);
self.primary_key			:= IF(trim(le.license_nbr)  <> '' and trim(le.license_nbr) <> 'NR', 
																	HASH32(le.license_nbr + ','
																				 + ut.CleanSpacesAndUpper(le.off_license_nbr) + ','
																				 + ut.CleanSpacesAndUpper(le.license_state) + ','
																				 + ut.CleanSpacesAndUpper(le.std_source_upd)
																				 ),
																				 0);
//******************************
/*
If multiple DBA(s) are received on the same record, requires normailization, addl logic for mltreckey field
IF records needs to be associated, addl logic is required for pcmc_slpk field
*/
//*******************************//
self.mltreckey		:= le.mltreckey;
self.pcmc_slpk    := le.pcmc_slpk;
self.cmc_slpk					:= HASH64(le.license_nbr + ','
																+ le.license_state + ','
																+ le.std_license_type +','
																+ le.std_source_upd + ','
																+ le.name_org + ','
																+ le.addr_addr1_1 + ','
																+ le.addr_city_1 + ','
																+ le.addr_state_1 + ','
																+ self.addr_zip5_1);																				 
																			
self.persistent_record_id  := HASH64(le.NAME_MARI_DBA + ','
																		+	self.cmc_slpk +','
																		+ le.PCMC_SLPK + ','
																		+ le.MLTRECKEY +','
																		+ le.AFFIL_TYPE_CD  +','
																		+ le.NMLS_ID	+ ','
																		+ le.FOREIGN_NMLS_ID + ','
																		+ le.LICENSE_ID + ','
																		+ le.REGULATOR + ','
																		+ le.FEDERAL_REGULATOR
																		);
 self.enh_did_src					:= 'M';														
 self := le;
end;

prepFile := project(dsLicenseState,xformOriginalBase(left));

//Create MARI RID 
create_MariRid := Prof_License_Mari.fCreateMariRID(prepFile);

//Reassign Temporary MARI RID to MARI RID
reSetMariRid := project(create_MariRid, transform(layouts.search, self.mari_rid := left.tmp_mari_rid; self := left));

reformatSearch:=project(reSetMariRid,
Transform(Layouts.search,
Self:=Left;
self := []; 
));

//

cln_individual:=project(Files.file_individual,
Transform(layouts.indv_detail,
self.cln_start_dte:=if(left.start_dte !='',left.start_dte,'');
self.cln_end_dte:=if(left.end_dte !='',left.end_dte,'');
Self:=Left;
));

cln_disciplinary:=project(files.file_disciplinary,
Transform(layouts.disp_action,
self.cln_Action_dte:=if(left.Action_dte !='',Prof_License_Mari.DateCleaner.ToYYYYMMDD(Left.Action_dte),'');
Self:=Left;
));


cln_regulatory :=project(Files.file_regulatory,
Transform(Layouts.reg_action,
self.cln_Action_dte:=if(left.Action_dte !='',Prof_License_Mari.DateCleaner.ToYYYYMMDD(Left.Action_dte),'');
Self:=Left;
));


PromoteSupers.Mac_SF_BuildProcess (cln_disciplinary,Constants.base_prefix_name+'disciplinary_actions',displinary_out,,,true);
PromoteSupers.Mac_SF_BuildProcess (cln_individual,Constants.base_prefix_name+'individual_detail',detail_out,,,true);
PromoteSupers.Mac_SF_BuildProcess (cln_regulatory,Constants.base_prefix_name+'regulatory_actions',regulatory_out,,,true);
PromoteSupers.Mac_SF_BuildProcess (reformatSearch,Constants.base_prefix_name+'search',base_out,,,true);

export proc_build_base := sequential(displinary_out,detail_out,regulatory_out,base_out);			
