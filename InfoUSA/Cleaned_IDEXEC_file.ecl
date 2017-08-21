import Address,Business_HeaderV2, address, ut, idl_header, aid;

//file_in := Business_HeaderV2.Source_Files.infousa_idexec.BusinessHeader;
file_in := InfoUSA.File_IDEXEC_In;

//#################remove html encoded charcters to latin################



infousa.Layout_IDEXEC_in xform_cleanExecNames(file_in le) := transform
self.exec_full_name := map(regexfind('&#8217;',le.exec_full_name)=true => regexreplace('&#8217;',le.exec_full_name,'\''),
													 regexfind('&#8211;',le.exec_full_name)=true => regexreplace('&#8211;',le.exec_full_name,'-'),
//													 regexfind('&#269;',le.exec_full_name)=true => regexreplace('&#269;',le.exec_full_name,'?'),
//													 regexfind('&#287;',le.exec_full_name)=true => regexreplace('&#287;',le.exec_full_name,'?'),	
//													 regexfind('&#305;',le.exec_full_name)=true => regexreplace('&#305;',le.exec_full_name,'?'),	
													le.exec_full_name	
														) ;
self := le;
end;

file_out := Project(file_in,xform_cleanExecNames(left));

Layout_AID := record
	InfoUSA.Layout_Cleaned_IDEXEC_file;
	AID.Common.xAID	Raw_AID;
	string100	Firm_prep_addr_line1;
	string50	Firm_prep_addr_line_last;
end;


Layout_AID xform_clean(file_out InputRecord) := transform
self.Firm_Name := stringlib.StringToUpperCase(InputRecord.Firm_Name);
string73 tempExecName := 
	stringlib.StringToUpperCase(if(trim(InputRecord.Exec_full_name,left,right) <> '',
	   Address.CleanPersonfml73(trim(InputRecord.Exec_full_name,left,right)) ,									
	'')
	);

	self.Exec_Clean_title						:= tempExecName[1..5]			;
	self.Exec_Clean_fname						:= tempExecName[6..25]			;
	self.Exec_Clean_mname						:= tempExecName[26..45]			;
	self.Exec_Clean_lname						:= tempExecName[46..65]			;
	self.Exec_Clean_name_suffix	    := tempExecName[66..70]			;
	self.Exec_Clean_cleaning_score	:= tempExecName[71..73]			;
/*
string182 tempFirmAddressReturn := stringlib.StringToUpperCase(
										if(InputRecord.loc_address_1 <> '' or
										   InputRecord.loc_address_2 <> '' ,
											 
											 if(trim(InputRecord.loc_address_3,left,right) ='',
											 Address.CleanAddress182(trim(InputRecord.loc_address_1,left,right),trim(InputRecord.loc_address_2,left,right)),
 											 Address.CleanAddress182((trim(InputRecord.loc_address_1,left,right)+','+ trim(InputRecord.loc_address_2,left,right)),trim(InputRecord.loc_address_3,left,right))
												 ),''));							 

self.Firm_Address_Clean_prim_range := 		tempFirmAddressReturn[1..10]			;
self.Firm_Address_Clean_predir     :=			tempFirmAddressReturn[11..12]			;
self.Firm_Address_Clean_prim_name	 := 		tempFirmAddressReturn[13..40]			;
self.Firm_Address_Clean_addr_suffix:= 		tempFirmAddressReturn[41..44]			;
self.Firm_Address_Clean_postdir		 :=			tempFirmAddressReturn[45..46]			;
self.Firm_Address_Clean_unit_desig	:= 		tempFirmAddressReturn[47..56]			;
self.Firm_Address_Clean_sec_range		:= 		tempFirmAddressReturn[57..64]			;
self.Firm_Address_Clean_p_city_name	:= 		tempFirmAddressReturn[65..89]			;
self.Firm_Address_Clean_v_city_name	:= 		tempFirmAddressReturn[90..114]			;
self.Firm_Address_Clean_st					:= 		tempFirmAddressReturn[115..116]			;
self.Firm_Address_Clean_zip					:=		tempFirmAddressReturn[117..121]			;
self.Firm_Address_Clean_zip4				:=		tempFirmAddressReturn[122..125]			;
self.Firm_Address_Clean_cart				:=		tempFirmAddressReturn[126..129]			;
self.Firm_Address_Clean_cr_sort_sz	:=		tempFirmAddressReturn[130]			;
self.Firm_Address_Clean_lot					:=		tempFirmAddressReturn[131..134]			;
self.Firm_Address_Clean_lot_order		:=		tempFirmAddressReturn[135]			;
self.Firm_Address_Clean_dpbc				:=		tempFirmAddressReturn[136..137]			;
self.Firm_Address_Clean_chk_digit		:=		tempFirmAddressReturn[138]			;
self.Firm_Address_Clean_record_type	:=		tempFirmAddressReturn[139..140]			;
self.Firm_Address_Clean_ace_fips_st	:=		tempFirmAddressReturn[141..142]			;
self.Firm_Address_Clean_fipscounty	:=		tempFirmAddressReturn[143..145]			;
self.Firm_Address_Clean_geo_lat			:=		tempFirmAddressReturn[146..155]			;
self.Firm_Address_Clean_geo_long		:=		tempFirmAddressReturn[156..166]			;
self.Firm_Address_Clean_msa					:=		tempFirmAddressReturn[167..170]			;
self.Firm_Address_Clean_geo_match		:=		tempFirmAddressReturn[178]			;
self.Firm_Address_Clean_err_stat		:=		tempFirmAddressReturn[179..182]			;
*/
//////////////////////////////////////////////////////////////////////////////////////
// -- Prepare Addresses for Cleaning using macro
//////////////////////////////////////////////////////////////////////////////////////
city := if (StringLib.StringFind(InputRecord.loc_address_2,',',1) > 1,
						stringlib.stringtouppercase(trim(InputRecord.loc_address_2[1..StringLib.StringFind(InputRecord.loc_address_2,',',1)-1],left,right)),
						stringlib.stringtouppercase(InputRecord.loc_address_2	));
SELF.Firm_prep_addr_line1 		 := Address.Addr1FromComponents(
																			stringlib.stringtouppercase(InputRecord.loc_address_1	)
																			,''
																			,''
																			,''
																			,''
																			,''
																			,''
																		); 
SELF.Firm_prep_addr_line_last := Address.Addr2FromComponents(
																			 stringlib.stringtouppercase(city )	
																			,stringlib.stringtouppercase(InputRecord.Loc_State_Province	)	
																			,trim(InputRecord.Loc_Postal_Code,left,right)[1..5]
																		);
self.IDEXEC_key								:= InputRecord.exec_id+InputRecord.firm_id+hash64(trim(InputRecord.Firm_name,left,right),trim(InputRecord.Exec_full_name,left,right));
self 													:= InputRecord;
self													:= [];
end;

dPrep_file := Project(file_out,xform_clean(left));

// Flip names that may have been wrongly parsed by the name cleaner.
ut.mac_flipnames(dPrep_file, Exec_Clean_fname, Exec_Clean_mname, Exec_Clean_lname, dPrep_file_w_flipnames);

dPrep_US_Addr_recs := dPrep_file_w_flipnames(stringlib.stringtouppercase(trim(loc_country_name,left,right))='UNITED STATES');

//*** Applying AID macro to clean the addresses.
HasAddress	:=	trim(dPrep_US_Addr_recs.Firm_prep_addr_line1, left,right) != ''
						and trim(dPrep_US_Addr_recs.Firm_prep_addr_line_last, left,right) != '';
								
dPrep_file_With_address			:= dPrep_US_Addr_recs(HasAddress);
dPrep_file_Without_address	:= dPrep_US_Addr_recs(not(HasAddress));

unsigned4	lFlags 	:= AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

AID.MacAppendFromRaw_2Line(dPrep_file_With_address, Firm_prep_addr_line1, Firm_prep_addr_line_last, Raw_AID, dCleaned_withAID, lFlags);

dCleanedAddr := project(
	dCleaned_withAID
	,transform(
		InfoUSA.Layout_IDEXEC_Base
		,
		self.ace_aid													:= left.aidwork_acecache.aid					;
		self.raw_aid													:= left.aidwork_rawaid								;
				
		self.Firm_Address_Clean_prim_range		:= left.aidwork_acecache.prim_range	;
		self.Firm_Address_Clean_predir				:= left.aidwork_acecache.predir			;
		self.Firm_Address_Clean_prim_name			:= left.aidwork_acecache.prim_name	;
		self.Firm_Address_Clean_addr_suffix		:= left.aidwork_acecache.addr_suffix;
		self.Firm_Address_Clean_postdir				:= left.aidwork_acecache.postdir		;
		self.Firm_Address_Clean_unit_desig		:= left.aidwork_acecache.unit_desig	;
		self.Firm_Address_Clean_sec_range			:= left.aidwork_acecache.sec_range	;
		self.Firm_Address_Clean_p_city_name		:= left.aidwork_acecache.p_city_name;
		self.Firm_Address_Clean_v_city_name		:= left.aidwork_acecache.v_city_name;
		self.Firm_Address_Clean_st						:= left.aidwork_acecache.st					;
		self.Firm_Address_Clean_zip						:= left.aidwork_acecache.zip5				;
		self.Firm_Address_Clean_zip4					:= left.aidwork_acecache.zip4				;
		self.Firm_Address_Clean_cart					:= left.aidwork_acecache.cart				;
		self.Firm_Address_Clean_cr_sort_sz		:= left.aidwork_acecache.cr_sort_sz	;
		self.Firm_Address_Clean_lot						:= left.aidwork_acecache.lot				;
		self.Firm_Address_Clean_lot_order			:= left.aidwork_acecache.lot_order	;
		self.Firm_Address_Clean_dpbc					:= left.aidwork_acecache.dbpc				;
		self.Firm_Address_Clean_chk_digit			:= left.aidwork_acecache.chk_digit	;
		self.Firm_Address_Clean_record_type		:= left.aidwork_acecache.rec_type		;
		self.Firm_Address_Clean_ace_fips_st		:= left.aidwork_acecache.county[1..2];
		self.Firm_Address_Clean_fipscounty		:= left.aidwork_acecache.county[3..];
		self.Firm_Address_Clean_geo_lat				:= left.aidwork_acecache.geo_lat		;
		self.Firm_Address_Clean_geo_long			:= left.aidwork_acecache.geo_long		;
		self.Firm_Address_Clean_msa						:= left.aidwork_acecache.msa				;
		self.Firm_Address_Clean_geo_match			:= left.aidwork_acecache.geo_match	;
		self.Firm_Address_Clean_err_stat			:= left.aidwork_acecache.err_stat		;							
		self																	:= left															;
	)
)
+ project(dPrep_file_Without_address, transform(InfoUSA.Layout_IDEXEC_Base, self := left, self := []));
//*** End of AID.


export Cleaned_IDEXEC_file := dCleanedAddr;