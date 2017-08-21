import PRTE2_Prof_License_Mari, Prof_License_Mari, ut, PromoteSupers;


//current data
file_in_search 		:= Files.file_search;
dsDispActions 		:= Files.file_disciplinary;
dsIndvDetails			:= Files.file_individual;
dsRegActions			:= Files.file_regulatory;

//--customer data--//

//--new data--//
// dsClnNameAddr    := PRTE2_Prof_License_Mari.fCleanNameAddr(prepFile);

//Concatenate Base files


//Reference Files for lookup joins
cmvTransLkp		:= Prof_License_Mari.files_References.cmvtranslation;
LicTypeLkp		:= Prof_License_Mari.files_References.MARIcmvLicType;
LicProfLkp		:= Prof_License_Mari.files_References.MARIcmvProf;
LicSrcLkp			:= Prof_License_Mari.files_References.MARIcmvSrc; 
LicStatusLkp	:= Prof_License_Mari.files_References.MARIcmvLicStatus;

dsStdDesc		:=	JOIN(file_in_search, LicSrcLkp,	
												 left.std_source_upd = right.src_nbr,
														transform(Layouts.search,
																			self.std_source_desc := if(left.std_source_desc = '', ut.CleanSpacesAndUpper(right.src_name), left.std_source_desc);
																			self := left;
																			), 
																left outer, lookup);

	
dsLicenseState		:=	JOIN(dsStdDesc, cmvTransLkp,	
												 left.std_source_upd = right.source_upd,
														transform(Layouts.search,
																			self.license_state := ut.CleanSpacesAndUpper(right.lic_state);
																			self := left;
																			), 
																left outer, lookup);	
																
													
Layouts.search		xformOriginalBase(layouts.search le) := transform
self.cln_license_nbr	:= IF(trim(le.license_nbr) in ['','NR'],'', Prof_license_mari.fCleanLicenseNbr(le.license_nbr));
self.addr_zip5_1			:= if(length(trim(le.addr_zip5_1)) < 5, INTFORMAT((integer)le.addr_zip5_1,5,1),le.addr_zip5_1);
self.primary_key			:= IF(trim(le.license_nbr)  <> '' and trim(le.license_nbr) <> 'NR', 
																	HASH32(ut.CleanSpacesAndUpper(le.license_nbr) + ','
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
self.cmc_slpk					:= HASH64(trim(le.license_nbr,left,right) + ','
																+ trim(le.license_state,left,right) + ','
																+ trim(le.std_license_type,left,right) +','
																+ trim(le.std_source_upd,left,right) + ','
																+ trim(le.name_org,left,right) + ','
																+ trim(le.addr_addr1_1,left,right) + ','
																+ trim(le.addr_city_1,left,right) + ','
																+ trim(le.addr_state_1,left,right) + ','
																+ trim(self.addr_zip5_1));																				 
																			
self.persistent_record_id  := HASH64(trim(le.NAME_MARI_DBA,left,right) + ','
																		+	self.cmc_slpk +','
																		+ le.PCMC_SLPK + ','
																		+ le.MLTRECKEY +','
																		+ le.AFFIL_TYPE_CD  +','
																		+ le.NMLS_ID	+ ','
																		+ le.FOREIGN_NMLS_ID + ','
																		+ le.LICENSE_ID + ','
																		+ trim(le.REGULATOR,left,right) + ','
																		+ trim(le.FEDERAL_REGULATOR)
																		);
 self.enh_did_src					:= 'M';														
 self := le;
end;

prepFile := project(dsLicenseState,xformOriginalBase(left));

//Create MARI RID 
create_MariRid := Prof_License_Mari.fCreateMariRID(prepFile);

//Reassign Temporary MARI RID to MARI RID
reSetMariRid := project(create_MariRid, transform(Prof_License_Mari.layouts.final, self.mari_rid := left.tmp_mari_rid; self := left));

//-----------------------------------------------
//Setting Current Flag
// C = Latest record from updating source
// N = Latest record from non-updating source
// D = Latest record for mari_rid dropped in the latest update of updating source
// H = Latest record for mari_rid dropped in the latest update of non-updating source
// S = superseded record from updating source
// Z = superseded record from non-updating source
//---------------------------------------------------
SetCurrentFlag			 := Prof_License_Mari.fn_SetResultCode(reSetMariRid);

//Format base file to original layout
reformatSearch		:=	JOIN(SetCurrentFlag, create_MariRid,	
												 left.mari_rid = right.tmp_mari_rid and
												 left.persistent_record_id = right.persistent_record_id,
														transform(Layouts.search,
																			self.cust_name := right.cust_name;
																			self.bug_name := right.bug_name;
																			self := left;
																			), left outer, lookup);



PromoteSupers.Mac_SF_BuildProcess (dsDispActions,Constants.base_prefix_name+'disciplinary_actions',displinary_out,,,true);
PromoteSupers.Mac_SF_BuildProcess (dsIndvDetails,Constants.base_prefix_name+'individual_detail',detail_out,,,true);
PromoteSupers.Mac_SF_BuildProcess (dsRegActions,Constants.base_prefix_name+'regulatory_actions',regulatory_out,,,true);
PromoteSupers.Mac_SF_BuildProcess (reformatSearch,Constants.base_prefix_name+'search',base_out,,,true);

export proc_build_base := sequential(displinary_out,detail_out,regulatory_out,base_out);			


