IMPORT  doxie, mdr, prte2_Ecrash, STD, BIPV2, ut, FLAccidents_Ecrash;

EXPORT keys := MODULE

EXPORT key_ecrash0 	:= INDEX(FILES.ds_ecrash0, {string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash0}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash0'); 

EXPORT key_ecrash1 	:= INDEX(FILES.ds_ecrash1, {string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash1}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash1');  
	 
EXPORT key_ecrash2v := INDEX(FILES.ds_ecrash2v,{string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash2v}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash2v');  

EXPORT key_ecrash3v := INDEX(FILES.ds_ecrash3v,{string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash3v}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash3v');

// Ecrash4 Key
layouts.key_ecrash4 	xpndrecs4(files.base_ecrash4 L, key_ecrash0 R) := transform
	self.report_code						:= 'FA';
	self.report_category				:= STD.Str.ToUpperCase('Auto Report');
	self.report_code_desc				:= STD.Str.ToUpperCase('Auto Accident');
	self.vehicle_incident_city	:= if(L.accident_nbr= R.accident_nbr,R.city_town_name,'');
	self.vehicle_incident_st		:= '';
	self.accident_nbr 					:= l.accident_nbr;  
	self.orig_accnbr 						:= l.accident_nbr; 
	self.driver_dob  						:= l.driver_dob[5..8]+l.driver_dob[1..4] ;  //inofming dob format MMDDCCYY
	self 	:= L;
	self	:= [];
	end;

pflc4 := join(distribute(files.base_ecrash4,hash(accident_nbr)),
							distribute(pull(key_ecrash0),hash(accident_nbr)),
							left.accident_nbr = right.accident_nbr,
							xpndrecs4(left,right),left outer,local);

pntl4		:= project(files.base_alpharetta, transform(layouts.key_ecrash4, 	
																										self.did := (string12)left.did;
																										self := left, self := []));
pinq4		:= project(files.base_cru_inquired, transform(layouts.key_ecrash4, self.did := (string12)left.did, self := left, self := []));
allrecs := dedup(pflc4 + pntl4 + pinq4,record,all);

EXPORT key_ecrash4 	:= INDEX(allrecs, {string40 l_acc_nbr := accident_nbr}, {allrecs}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash4');

EXPORT key_ecrash5 	:= INDEX(FILES.ds_ecrash5, {string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash5}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash5');

EXPORT key_ecrash6 	:= INDEX(FILES.ds_ecrash6, {string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash6}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash6'); 

EXPORT key_ecrash7 	:= INDEX(FILES.ds_ecrash7, {string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash7}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash7'); 

EXPORT key_ecrash8	:= INDEX(FILES.ds_ecrash8, {string40 l_acc_nbr := accident_nbr}, {FILES.ds_ecrash8}, Constants.KeyName_ecrash +'::'+ doxie.Version_SuperKey + '::ecrash8'); 

// Use File_KeybuildV2.out file
EXPORT key_ecrashv2_bdid 		:= INDEX(dedup(file_keybuildV2.out(b_did <> '',b_did <> '0'),all), {unsigned6 l_bdid := (integer)b_did}, {accident_nbr,orig_accnbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::bdid');
	
EXPORT key_ecrashv2_did 		:= INDEX(dedup(file_keybuildV2.out(did <> '',did <> '0'),all), {unsigned6 l_did := (integer)did},{accident_nbr,vin,orig_accnbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::did');

EXPORT key_ecrashv2_dlnbr 	:= INDEX(file_keybuildV2.out(driver_license_nbr<>''), {l_dlnbr := driver_license_nbr},{accident_nbr,orig_accnbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::dlnbr');

EXPORT key_ecrashv2_dol 		:= INDEX(files_addl.ds_dol,{accident_date,report_code,jurisdiction_state, jurisdiction},{files_addl.ds_dol}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::dol');

EXPORT key_ecrashv2_vin 		:= INDEX(file_keybuildV2.out(vin<>'' and vin<>'0' ), {l_vin := vin}, {accident_nbr,orig_accnbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::vin'); 

//Use Vin Key
ecrash_vin_base := pull(key_ecrashv2_vin);
ds_vin7 := project(ecrash_vin_base, transform(Layouts.ecrashv2_vin7, 
																							len:=length(trim(left.l_vin));
																							self.l_vin7 :=left.l_vin[len-6..len];
																							self :=left;	
																							self := [];
																							))(trim(l_vin7)<>'');

EXPORT key_ecrashv2_vin7 		:= INDEX(ds_vin7, {l_vin7}, {l_vin,accident_nbr,orig_accnbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::vin7'); 
	
EXPORT key_ecrashv2_tagnbr 	:= INDEX(file_keybuildV2.out(tag_nbr<>''), {l_tagnbr := tag_nbr},{accident_nbr,orig_accnbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::tagnbr7');  


EXPORT key_ecrashv2_accnbr 	:= INDEX(files_addl.ds_accnbr, {l_accnbr, report_code,jurisdiction_state, jurisdiction}, {files_addl.ds_accnbr},
																			Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::accnbr');


EXPORT key_ecrashv2_accnbrv1 := INDEX(files_addl.ds_accnbrv1, {l_accnbr, report_code, jurisdiction_state, jurisdiction}, {files_addl.ds_accnbrv1},
																			Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::accnbrv1');
	 
EXPORT key_ecrashv2_agencyid_sentdate := INDEX(files_addl.ds_agencyid_sentdate, {jurisdiction_nbr}, {MaxSent_to_hpcc_date}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::agencyid_sentdate'); 

EXPORT Key_ecrashv2_LastName := INDEX(files_addl.ds_lastname_state, {lname,jurisdiction_state,jurisdiction}, {files_addl.ds_lastname_state}, 
																			Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::LastName_State'); 

EXPORT key_ecrashv2_prefname_state 	:= INDEX(files_addl.ds_prefname_state,{fname,jurisdiction_state,jurisdiction}, {files_addl.ds_prefname_state},
																			Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::prefname_state');
	
EXPORT key_ecrashv2_standlocation 	:= INDEX(file_stAndLocation, {Partial_Accident_location,jurisdiction_state, jurisdiction},
																					{file_stAndLocation},
																					Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::standlocation');
	 

EXPORT key_ecrashv2_supplemental 		:= INDEX(Files.ds_Supplemental,	{super_report_id}, 											
																					{report_id,hash_key,accident_nbr,report_code,jurisdiction,jurisdiction_state,accident_date,orig_accnbr,work_type_id,report_type_id,agency_ori,addl_report_number,Vendor_Code,vendor_report_id,Page_Count},
																					Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::supplemental');

	
EXPORT key_ecrashv2_reportid := INDEX(files.ds_reportid, {report_id}, {Super_report_id}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::ReportId');

EXPORT Key_eCrashv2_reportlinkId := INDEX(files_addl.ds_reportLinkID, {reportlinkid}, {files_addl.ds_reportLinkID}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::ReportLinkId');

EXPORT key_ecrashv2_photoid 	:= INDEX(Files.ds_photoid, {Super_report_id,Document_id,Report_Type}, {Files.ds_photoid}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::PhotoId');
	
	
//Use key_EcrashV2_accnbrv1 as input	
//Delta Date Key
MaxDate := MAX(pull(key_ecrashv2_accnbrv1)(report_code in ['EA','TM','TF'] and work_type_id not in ['2','3'] and trim(report_type_id,all) in ['A','DE']),(integer)date_vendor_last_reported);
STRING8 Delta_Date := IF ((INTEGER)MaxDate > 0,INTFORMAT((INTEGER)MaxDate,8,1),(STRING8)Std.Date.Today());
DateFile := DATASET([{'DELTADATE',Delta_Date}],FLAccidents_Ecrash.Layouts.Delta_Date);
file_deltadate := DateFile;

EXPORT key_ecrashv2_deltadate 		:= INDEX(file_deltadate, {delta_text},{delta_text,date_added}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::deltadate');



// Partial Acct NBR Key
in_accnbr := key_ecrashv2_accnbrv1(KEYED(report_code in ['EA','TM','TF']) and WILD(l_accnbr) and work_type_id not in ['2','3'] and trim(report_type_id,all) in ['A','DE']);
parse_report := project(in_accnbr, transform(Layouts.slim_partial_report_nbr, 
																						 part_num := if(trim(std.str.Filterout(left.l_accnbr,'0-'),left,right) ='' , '', trim(left.l_accnbr,left,right));
  																					 SELF.f1 := part_num[1..4];
																						 SELF.f2 := if(length(trim(part_num[2..5],left,right)) < 4 , '',part_num[2..5]) ;
																						 SELF.f3 := if(length(trim(part_num[3..6],left,right)) < 4 , '',part_num[3..6]);
																						 SELF.f4 := if(length(trim(part_num[4..7],left,right)) < 4 , '',part_num[4..7]);
																						 SELF.f5 := if(length(trim(part_num[5..8],left,right)) < 4 , '',part_num[5..8]);
																						 SELF.f6 := if(length(trim(part_num[6..9],left,right)) < 4 , '',part_num[6..9]);
																						 SELF.f7 := if(length(trim(part_num[7..10],left,right)) < 4 , '',part_num[7..10]);
																						 SELF.f8 := if(length(trim(part_num[8..11],left,right)) < 4 , '',part_num[8..11]);
																						 SELF.f9 := if(length(trim(part_num[9..12],left,right)) < 4 , '',part_num[9..12]) ; 
																						 SELF.f10 := if(length(trim(part_num[10..13],left,right)) < 4 , '',part_num[10..13]); 
																						 SELF.f11 := if(length(trim(part_num[11..14],left,right)) < 4 , '',part_num[11..14]);
																						 SELF.f12 := if(length(trim(part_num[12..15],left,right)) < 4 , '',part_num[12..15]);
																						 SELF.f13 := if(length(trim(part_num[13..16],left,right)) < 4 , '',part_num[13..16]);
																						 SELF.f14 := if(length(trim(part_num[14..17],left,right)) < 4 , '',part_num[14..17]);
																						 SELF.f15 := if(length(trim(part_num[15..18],left,right)) < 4 , '',part_num[15..18]);
																						 SELF.f16 := if(length(trim(part_num[16..19],left,right)) < 4 , '',part_num[16..19]);
																						 SELF.f17 := if(length(trim(part_num[17..20],left,right)) < 4 , '',part_num[17..20]);
																						 SELF.f18 := if(length(trim(part_num[18..21],left,right)) < 4 , '',part_num[18..21]);
																						 SELF.f19 := if(length(trim(part_num[19..22],left,right)) < 4 , '',part_num[19..22]);
																						 SELF.f20 := if(length(trim(part_num[20..23],left,right)) < 4 , '',part_num[20..23]);
																						 SELF.f21 := if(length(trim(part_num[21..24],left,right)) < 4 , '',part_num[21..24]);
																						 SELF.f22 := if(length(trim(part_num[22..25],left,right)) < 4 , '',part_num[22..25]);
																						 SELF.f23 := if(length(trim(part_num[23..26],left,right)) < 4 , '',part_num[23..26]);
																						 SELF.f24 := if(length(trim(part_num[24..27],left,right)) < 4 , '',part_num[24..27]);
																						 SELF.f25 := if(length(trim(part_num[25..28],left,right)) < 4 , '',part_num[25..28]);
																						 SELF.f26 := if(length(trim(part_num[26..29],left,right)) < 4 , '',part_num[26..29]);
																						 SELF.f27 := if(length(trim(part_num[27..30],left,right)) < 4 , '',part_num[27..30]);
																						 SELF.f28 := if(length(trim(part_num[28..31],left,right)) < 4 , '',part_num[28..31]);
																						 SELF.f29 := if(length(trim(part_num[29..32],left,right)) < 4 , '',part_num[29..32]);
																						 SELF.f30 := if(length(trim(part_num[30..33],left,right)) < 4 , '',part_num[30..33]);
																						 SELF.f31 := if(length(trim(part_num[31..34],left,right)) < 4 , '',part_num[31..34]);
																						 SELF.f32 := if(length(trim(part_num[32..35],left,right)) < 4 , '',part_num[32..35]);
																						 SELF.f33 := if(length(trim(part_num[33..36],left,right)) < 4 , '',part_num[33..36]);
																						 SELF.f34 := if(length(trim(part_num[34..37],left,right)) < 4 , '',part_num[34..37]);
																						 SELF.f35 := if(length(trim(part_num[35..38],left,right)) < 4 , '',part_num[35..38]);
																						 SELF.f36 := if(length(trim(part_num[36..39],left,right)) < 4 , '',part_num[36..39]);
																						 SELF.f37 := if(length(trim(part_num[37..40],left,right)) < 4 , '',part_num[37..40]);
																						 SELF := left, self := []));
																						 
Layouts.slim_rec tslim(parse_report L, integer cnt) := transform
		self.partial_report_nbr := choose(cnt, l.f1,
																					 l.f2,
																					 l.f3,
																					 l.f4,
																					 l.f5,
																					 l.f6,
                                           l.f7,
                                           l.f8,
                                           l.f9,
                                           l.f10,
                                           l.f11,
                                           l.f12,
                                           l.f13,
                                           l.f14,
                                           l.f15,
                                           l.f16,
                                           l.f17,
                                           l.f18,
                                           l.f19,
                                           l.f20,
                                           l.f21,
                                           l.f22, 
																					 l.f23,
																					 l.f24,
																					 l.f25,
																					 l.f26,
																					 l.f27,
																					 l.f28,
																					 l.f29,
																					 l.f30,
																					 l.f31,
																					 l.f32,
																					 l.f33,
																					 l.f34,
																					 l.f35,
																					 l.f36,
																					 l.f37);						  	
		self := L;
		self := [];
	end;
					   
	norm_report 	:= normalize(parse_report, 37, tslim(left, counter))(partial_report_nbr <>''); 
  ds_partialaccnbr := dedup(distribute(project(norm_report, transform(layouts.slim_rec, 
																																		self.partial_report_nbr := if(trim(std.str.filterout(left.partial_report_nbr,'0-'),left,right) ='' , '', 
																																																	trim(left.partial_report_nbr,left,right)),
																																		self := left))(partial_report_nbr <>''),hash(l_accnbr)), all,local);
													 
EXPORT key_ecrashv2_partialaccnbr := INDEX(ds_partialaccnbr,{partial_report_nbr,report_code,jurisdiction_state,jurisdiction,accident_date}, {ds_partialaccnbr},
																					 Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::partialaccnbr'); 


// Use File_Keybuild_analytics
EXPORT key_ecrashv2analytics_byagencyid := INDEX(file_byAgencyID(agencyid <>''), {AgencyID, accident_date}, {file_byAgencyID}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::analytics_byagencyid'); 
	 
EXPORT key_ecrashv2analytics_bycollisiontype := INDEX(file_byCollisionType(agencyid <>''), {agencyid, Accident_date}, {file_byCollisionType}, 	Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::analytics_byCollisionType'); 
	 
EXPORT key_ecrashv2analytics_bydow 		:= INDEX(file_ByDOW(agencyid <>''), {agencyid, Accident_date}, {file_ByDOW}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::analytics_bydow'); 
	 
EXPORT key_ecrashv2analytics_byhod 		:= INDEX(file_ByHOD(agencyid <>''), {agencyid, Accident_date}, {file_ByHOD}, Constants.KeyName_ecrashv2 + '::'+ doxie.Version_SuperKey + '::analytics_byhod'); 
	 
EXPORT key_ecrashv2analytics_byinter 	:= INDEX(file_BYInter(agencyid <>''), {agencyid, Accident_date}, {file_BYInter}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::analytics_byinter'); 

EXPORT key_ecrashv2analytics_bymoy 		:= INDEX(file_ByMOY(agencyid <>''),{agencyid, Accident_date}, {file_ByMOY}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::analytics_bymoy'); 

//New Key for BuyCash KY Integration
EXPORT key_ecrashV2_agency 						:= INDEX(files.base_agencycmbnd, {Agency_State_Abbr,Agency_Name,Agency_ori}, 
																									{Mbsi_Agency_ID, Cru_Agency_ID, Cru_State_Number, Source_ID, Append_Overwrite_Flag}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::agency'); 

								                            
EXPORT Key_LinkIds   := MODULE

  // DEFINE THE INDEX
	EXPORT out_SuperKeyName		:= Constants.KeyName_ecrashv2 + '::'+ doxie.Version_SuperKey +'::linkids'; //SuperKeyName

	SHARED Base						  	:= File_KeybuildV2.out;

  Keybuild_Base             := PROJECT(Base,layouts.linkids);
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Keybuild_Base, k, out_SuperKeyName);
	EXPORT Key := k;

	//DEFINE THE INDEX ACCESS
	EXPORT kFetch(
		DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs, 
		STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																								//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																								//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		UNSIGNED2 ScoreThreshold = 0								//Applied at lowest leve of ID
		) :=
	FUNCTION

		BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level)
		RETURN out;																					

	END;

END;
	
	
//New Keys for  BuyCrash Appriss Ingretation
EXPORT	key_ecrashv2_DlnNbrDLState :=	INDEX(Files_Addl.ds_DLNbrState,{driver_license_nbr,dlnbr_st,jurisdiction_state,jurisdiction}
																							,{Files_Addl.ds_DLNbrState}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::DlnNbrDLState'); 

EXPORT	key_ecrashv2_LicensePlateNbr :=	INDEX(Files_Addl.ds_LicensePlateNbr, {tag_nbr,tagnbr_st,jurisdiction_state,jurisdiction}, {Files_Addl.ds_LicensePlateNbr}
																							  ,Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::LicensePlateNbr'); 
																								
EXPORT	key_ecrashv2_OfficerBadgeNbr :=	INDEX(Files_Addl.ds_OfficerBadgeNbr, {officer_id,jurisdiction_state,jurisdiction}, {Files_Addl.ds_OfficerBadgeNbr}
																								,Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::OfficerBadgeNbr'); 

EXPORT	key_ecrashv2_VinNbr :=	INDEX(Files_Addl.ds_VinNbr, {vin,jurisdiction_state,jurisdiction}, {Files_Addl.ds_VinNbr}, Constants.KeyName_ecrashv2+ '::' + doxie.Version_SuperKey + '::VinNbr'); 		
																				
END;
