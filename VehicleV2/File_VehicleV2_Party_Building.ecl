import	Std;

dVehiclePartyBase	:=	VehicleV2.Files.Base.Party_BIP;

// Blank out title number for experian states ME and NE
// VehicleV2.Layout_Base.Party_bip	tBlankTitleNum(dVehiclePartyBase	pInput)	:=
//Modified for CCPA-103 layout additions
VehicleV2.Layout_Base.Party_CCPA	tBlankTitleNum(dVehiclePartyBase	pInput)	:=
transform
	self.Ttl_Number	:=	if(	(pInput.source_code	=	'AE'	and	pInput.state_origin	=	'ME')	or	pInput.state_origin	=	'NE',
													'',
													pInput.Ttl_Number
												);
												
	// Blank out plate number for experian state LA 
	// DF18154 - balnk out plate number for experian state LA only if the files were received on or before 20160818
  self.Reg_True_License_Plate      := if(pInput.source_code	=	'AE'	and	pInput.state_origin	=	'LA' and pInput.Date_Vendor_First_Reported<=20160818, '',pInput.Reg_True_License_Plate ); 
  self.Reg_License_Plate           := if(pInput.source_code	=	'AE'	and	pInput.state_origin	=	'LA' and pInput.Date_Vendor_First_Reported<=20160818, '',pInput.Reg_License_Plate  ); 
  self.Reg_Previous_License_Plate  := if(pInput.source_code	=	'AE'	and	pInput.state_origin	=	'LA' and pInput.Date_Vendor_First_Reported<=20160818, '',pInput.Reg_Previous_License_Plate ); 
  self.Reg_License_Plate_Type_Code := if(pInput.source_code	=	'AE'	and	pInput.state_origin	=	'LA' and pInput.Date_Vendor_First_Reported<=20160818, '',pInput.Reg_License_Plate_Type_Code); 
  self.Reg_License_Plate_Type_Desc := if(pInput.source_code	=	'AE'	and	pInput.state_origin	=	'LA' and pInput.Date_Vendor_First_Reported<=20160818, '',pInput.Reg_License_Plate_Type_Desc ); 
	self			                       :=	pInput;
end;

dVehicleV2PartyBldg	:=	project(dVehiclePartyBase,tBlankTitleNum(left));

ConvertYYYYMMToNumberOfMonths(integer	pInput)	:= 
	 (((integer)(((string)pInput)[1..4])*12)	+	((integer)(((string)pInput)[5..6])));
	 
VehicleV2.Layout_Base.Party_Base_BIP	tReformat2Bldg(dVehicleV2PartyBldg	pInput)	:=
transform
	self.orig_DOB													:=	if(ConvertYYYYMMToNumberOfMonths((integer)(STRING8)Std.Date.Today()) - ConvertYYYYMMToNumberOfMonths((integer)pInput.orig_DOB) > 180, pInput.orig_DOB ,'');
	self.Date_First_Seen					:=	(unsigned3)((string)pInput.Date_First_Seen)[1..6];
	self.Date_Last_Seen						:=	(unsigned3)((string)pInput.Date_Last_Seen)[1..6];
	self.Date_Vendor_First_Reported			:=	(unsigned3)((string)pInput.Date_Vendor_First_Reported)[1..6];
	self.Date_Vendor_Last_Reported			:=	(unsigned3)((string)pInput.Date_Vendor_Last_Reported)[1..6];
	self.append_clean_name.title			:=	pInput.title;                                                                                                                      
	self.append_clean_name.fname			:=	pInput.fname;                                                                                                                      
	self.append_clean_name.mname			:=	pInput.mname;                                                                                                                      
	self.append_clean_name.lname			:=	pInput.lname;                                                                                                                      
	self.append_clean_name.name_suffix		:=	pInput.name_suffix;                                                                                                                      
	self.append_clean_name.name_score		:=	pInput.name_score; 
	self.append_clean_address.prim_range	:=	pInput.ace_prim_range;                                                                      
	self.append_clean_address.predir		:=	pInput.ace_predir;                                                                      
	self.append_clean_address.prim_name		:=	pInput.ace_prim_name;                                                                      
	self.append_clean_address.addr_suffix	:=  pInput.ace_addr_suffix;                                                                      
	self.append_clean_address.postdir		:=	pInput.ace_postdir;                                                                      
	self.append_clean_address.unit_desig	:=	pInput.ace_unit_desig;                                                                      
	self.append_clean_address.sec_range		:=	pInput.ace_sec_range;                                                                      
	self.append_clean_address.v_city_name	:=	pInput.ace_v_city_name;
	self.append_clean_address.st			:=	pInput.ace_st;
	self.append_clean_address.zip5			:=	pInput.ace_zip5;
	self.append_clean_address.zip4			:=	pInput.ace_zip4;
	self.append_clean_address.fips_state	:=	pInput.ace_fips_state;
	self.append_clean_address.fips_county	:=	pInput.ace_fips_county;
	self.append_clean_address.geo_lat		:=	pInput.ace_geo_lat;
	self.append_clean_address.geo_long		:=	pInput.ace_geo_long;
	self.append_clean_address.cbsa			:=	pInput.ace_cbsa;
	self.append_clean_address.geo_blk		:=	pInput.ace_geo_blk;
	self.append_clean_address.geo_match		:=	pInput.ace_geo_match;
	self.append_clean_address.err_stat		:=	pInput.ace_err_stat;
	self.DotID														:= pInput.DotID;
	self.DotScore													:= pInput.DotScore;
	self.DotWeight												:= pInput.DotWeight;
	self.EmpID														:= pInput.EmpID;
	self.EmpScore													:= pInput.EmpScore;
	self.EmpWeight												:= pInput.EmpWeight;
	self.POWID														:= pInput.POWID;
	self.POWScore													:= pInput.POWScore;
	self.POWWeight												:= pInput.POWWeight;
	self.ProxID														:= pInput.ProxID;
	self.ProxScore												:= pInput.ProxScore;
	self.ProxWeight												:= pInput.ProxWeight;
	self.SELEID														:= pInput.SELEID;
	self.SELEScore												:= pInput.SELEScore;
	self.SELEWeight												:= pInput.SELEWeight;	
	self.OrgID														:= pInput.OrgID;
	self.OrgScore													:= pInput.OrgScore;
	self.OrgWeight												:= pInput.OrgWeight;
	self.UltID														:= pInput.UltID;
	self.UltScore													:= pInput.UltScore;
	self.UltWeight												:= pInput.UltWeight;
	//Added for CCPA-103
	self.global_sid                       := pInput.global_sid;
	self.record_sid                       := pInput.record_sid;
	//Added for DF-25578
	self.raw_name                         := pInput.raw_name;
	self																	:=	pInput;
end;

dVehicleV2Party	:=	project(dVehicleV2PartyBldg,tReformat2Bldg(left));

// Bug 62451
// Filter out lien holder information for experian state LA
dVehicleV2PartyFilter	:=	dVehicleV2Party(~(	(source_code	=	'AE'	and	state_origin	=	'LA'	and	orig_name_type	=	'7')	or
																							(source_code	=	'DI'	and	state_origin	=	'NM')
																						)
																					);


//Filter out record per legal request - DF-16726
dVehicleV2PartySuppress := dVehicleV2PartyFilter(append_DID != 154640963692);

export	File_VehicleV2_Party_Building	:=	dVehicleV2PartySuppress;