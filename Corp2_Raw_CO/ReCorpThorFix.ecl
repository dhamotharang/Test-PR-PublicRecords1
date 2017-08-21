import Corp2, Corp2_Mapping, Corp2_Raw_CO;
#workunit('name', 'CO ThorFix');
#workunit('protect',true);
#workunit('priority','high');
#workunit('priority',12);
#option ('activitiesPerCpp', 50);
#OPTION('multiplePersistInstances',FALSE);
keySet						:= ['08-19851019238'];

pversion		 			:=	'20170213'; //new version of data

state_origin			:= 'CO';
state_fips	 			:= '08';	
state_desc	 			:= 'COLORADO';
dsCurrentCont			:=	distribute(corp2.files().base_xtnd.cont.qa,hash(corp_key))(corp_state_origin=state_origin): independent; // Current QA superfile for corp file
dsCurrentCorp			:=	distribute(corp2.files().base_xtnd.corp.qa,hash(corp_key))(corp_state_origin=state_origin): independent; // Current QA superfile for corp file
//output(dsCurrentCorp,named('dsCurrentCorp'));
//output(count(dsCurrentCorp),named('cnt_dsCurrentCorp'));			// sanity check count
//output(dsCurrentCont,named('dsCurrentCont'));
//output(count(dsCurrentCont),named('cnt_dsCurrentCont'));					// sanity check count
//---------------------------------------------
//CORP
//---------------------------------------------
MyLayout	:= record
	Corp2.Layout_Corporate_Direct_Corp_Base_Expanded;
	string norm_address1;
	string norm_address2;
	string norm_address3;
	string norm_address4;
	string norm_address5;
	string norm_address6;
	string norm_addrtype;
	string norm_addrdesc;
end;

/////////////////////////////////////////////////////
//1)  First fix corp_orig_org_bus_type_desc = UNKNOWN
//		for all of Colorado records.
//		Secondly, fix corp_orig_org_structure_desc if
//		corp_orig_org_structure_desc = TRADEMARK.
//		Note: Per Rosemary, please remove the 
//					corp_orig_org_bus_type_desc field when
// 					the output is "UNKNOWN".
//		Note: Per Rosemary, please remove the 
//					CORP_ORIG_ORG_STRUCTURE_DESC of â€œTRADEMARKâ€,
//				  since we have the name type as â€œTRADEMARKâ€.
/////////////////////////////////////////////////////
Corp2.Layout_Corporate_Direct_Corp_Base_Expanded FixBusTypeDescTransform(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded Input)	:=	transform
    self.corp_orig_org_structure_desc := if(corp2.t2u(input.corp_orig_org_structure_desc) = 'TRADEMARK','',corp2.t2u(input.corp_orig_org_structure_desc));
		self.corp_orig_bus_type_desc			:= if(corp2.t2u(input.corp_orig_bus_type_desc) = 'UNKNOWN','',corp2.t2u(input.corp_orig_bus_type_desc));
    self							            		:= input;
end;

FixedOrigBusTypeDesc		:= project(dsCurrentCorp, FixBusTypeDescTransform(left));
output(FixedOrigBusTypeDesc,named('FixedOrigBusTypeDesc'));
output(count(FixedOrigBusTypeDesc),named('cnt_FixedOrigBusTypeDesc'));								// sanity check count

TMDataToFix				:=  FixedOrigBusTypeDesc(corp2.t2u(corp_ln_name_type_desc) = 'TRADEMARK');
NotTMData					:=  FixedOrigBusTypeDesc(corp2.t2u(corp_ln_name_type_desc) <> 'TRADEMARK');
output(TMDataToFix,named('TMDataToFix'));
output(count(TMDataToFix),named('cnt_TMDataToFix'));															// sanity check count
output(NotTMData,named('NotTMData'));
output(count(NotTMData),named('cnt_NotTMData'));																	// sanity check count


/////////////////////////////////////////////////////
//2)  Fix corp_foreign_domestic_ind: 
//		Note: Per Rosemary, please remove the corp_foreign_domestic_ind field.  We haven't
//					been mapping this indicator for name types and every indicator will be domestic.
/////////////////////////////////////////////////////

//Note: Didn't separate out corp_foreign_domestic_ind
//			field for records with and without this field
//			populated because the field was 99.9% populated.
//--------------------------------------------
// Transform to fix corp_foreign_domestic_ind.
//--------------------------------------------
Corp2.Layout_Corporate_Direct_Corp_Base_Expanded FixForeignDomesticIndTransform(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded Input)	:=	transform
		self.corp_foreign_domestic_ind		:= '';
    self							                := input;
end;

AllFixedForeignDomesticInd	:= project(TMDataToFix, FixForeignDomesticIndTransform(left));
output(AllFixedForeignDomesticInd,named('AllFixedForeignDomesticInd'));
output(count(AllFixedForeignDomesticInd),named('cnt_AllFixedForeignDomesticInd'));	// sanity check count

//--------------------------------------------
//3)  Transform to remove the registrant address
// 		from the corp_address1* and corp_address2*
// 		fields.
//--------------------------------------------
Corp2.Layout_Corporate_Direct_Corp_Base_Expanded CleanUpCorpAddressTransform(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded l)	:=	transform
			self.corp_address1_type_cd									:= '';
			self.corp_address1_type_desc								:= '';
			self.corp_address1_line1										:= '';
			self.corp_address1_line2										:= '';
			self.corp_address1_line3										:= '';  //Registrant information was being mapped to Corporation Addresses
			self.corp_address1_line4										:= ''; 	//which is incorrect.  Cleaning up corporation records.
			self.corp_address1_line5										:= '';
			self.corp_address1_line6										:= '';
			self.corp_prep_addr1_line1									:= '';
			self.corp_prep_addr1_last_line							:= '';
			self.corp_address2_type_cd									:= '';
			self.corp_address2_type_desc								:= '';			
			self.corp_address2_line1										:= '';
			self.corp_address2_line2										:= '';
			self.corp_address2_line3										:= '';
			self.corp_address2_line4										:= '';
			self.corp_address2_line5										:= '';
			self.corp_address2_line6										:= '';			
			self.corp_prep_addr2_line1									:= '';
			self.corp_prep_addr2_last_line							:= '';
			self.corp_addr1_prim_range									:= '';
			self.corp_addr1_predir											:= '';
			self.corp_addr1_prim_name										:= '';
			self.corp_addr1_addr_suffix									:= '';
			self.corp_addr1_postdir											:= '';
			self.corp_addr1_unit_desig									:= '';
			self.corp_addr1_sec_range										:= '';
			self.corp_addr1_p_city_name									:= '';
			self.corp_addr1_v_city_name									:= '';
			self.corp_addr1_state												:= '';
			self.corp_addr1_zip5												:= '';
			self.corp_addr1_zip4												:= '';
			self.corp_addr1_cart												:= '';
			self.corp_addr1_cr_sort_sz									:= '';
			self.corp_addr1_lot													:= '';
			self.corp_addr1_lot_order										:= '';
			self.corp_addr1_dpbc												:= '';
			self.corp_addr1_chk_digit										:= '';
			self.corp_addr1_rec_type										:= '';
			self.corp_addr1_ace_fips_st									:= '';
			self.corp_addr1_county											:= '';
			self.corp_addr1_geo_lat											:= '';
			self.corp_addr1_geo_long										:= '';
			self.corp_addr1_msa													:= '';
			self.corp_addr1_geo_blk											:= '';
			self.corp_addr1_geo_match										:= '';
			self.corp_addr1_err_stat										:= '';
			self.corp_addr2_prim_range									:= '';
			self.corp_addr2_predir											:= '';
			self.corp_addr2_prim_name										:= '';
			self.corp_addr2_addr_suffix									:= '';
			self.corp_addr2_postdir											:= '';
			self.corp_addr2_unit_desig									:= '';
			self.corp_addr2_sec_range										:= '';
			self.corp_addr2_p_city_name									:= '';
			self.corp_addr2_v_city_name									:= '';
			self.corp_addr2_state												:= '';
			self.corp_addr2_zip5												:= '';
			self.corp_addr2_zip4												:= '';
			self.corp_addr2_cart												:= '';
			self.corp_addr2_cr_sort_sz									:= '';
			self.corp_addr2_lot													:= '';
			self.corp_addr2_lot_order										:= '';
			self.corp_addr2_dpbc												:= '';
			self.corp_addr2_chk_digit										:= '';
			self.corp_addr2_rec_type										:= '';
			self.corp_addr2_ace_fips_st									:= '';
			self.corp_addr2_county											:= '';
			self.corp_addr2_geo_lat											:= '';
			self.corp_addr2_geo_long										:= '';
			self.corp_addr2_msa													:= '';
			self.corp_addr2_geo_blk											:= '';
			self.corp_addr2_geo_match										:= '';
			self.corp_addr2_err_stat										:= '';			
			self							                					:= l;
end;

FixTMCorpAddress		:= dedup(sort(distribute(project(AllFixedForeignDomesticInd, CleanUpCorpAddressTransform(left)),hash(corp_key)),record,local),record,local);
output(FixTMCorpAddress,named('FixTMCorpAddress'));
output(count(FixTMCorpAddress),named('cnt_FixTMCorpAddress'));	// sanity check count


//---------------------------------------------
//CONT
//---------------------------------------------

/////////////////////////////////////////////////////
//4)  Fix Registrant Address fields.
//		Note: Currently the "corp" record contains this information and we need to create a contact
//				 	record for these "registrants".
//		Note: Per Rosemary, the registrant mailing address was mapped to the corp address fields
//					and the busines address was mapped to the ra.  Both of these addresses should be
//					mapped to the agent addresses.
/////////////////////////////////////////////////////

	
//********************************************************************
//Normalize the file on Registrant's address 
//********************************************************************
MyLayout NormTMRegistrantAddrTransform(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded l, unsigned1 c) := transform,
skip(c = 1 and corp2.t2u(l.corp_address1_line1+l.corp_address1_line2+l.corp_address1_line3+l.corp_address1_line4+l.corp_address1_line5+l.corp_address1_line6) = '' or
		 c = 2 and corp2.t2u(l.corp_address2_line1+l.corp_address2_line2+l.corp_address2_line3+l.corp_address2_line4+l.corp_address2_line5+l.corp_address2_line6) = ''
		)						
	self.norm_address1													:= choose(c,corp2.t2u(l.corp_address1_line1),corp2.t2u(l.corp_address2_line1));
	self.norm_address2	 												:= choose(c,corp2.t2u(l.corp_address1_line2),corp2.t2u(l.corp_address2_line2));
	self.norm_address3													:= choose(c,corp2.t2u(l.corp_address1_line3),corp2.t2u(l.corp_address2_line3));
	self.norm_address4													:= choose(c,corp2.t2u(l.corp_address1_line4),corp2.t2u(l.corp_address2_line4));
	self.norm_address5													:= choose(c,corp2.t2u(l.corp_address1_line5),corp2.t2u(l.corp_address2_line5));
	self.norm_address6													:= choose(c,corp2.t2u(l.corp_address1_line6),corp2.t2u(l.corp_address2_line6));
	self.norm_addrtype													:= choose(c,'B','M');
	self.norm_addrdesc													:= choose(c,'BUSINESS','MAILING');
	self 																				:= l;
	self 																				:= [];
end;

HasRegistrantAddress 			:= AllFixedForeignDomesticInd(corp2.t2u(corp_address1_line1+corp_address1_line2+corp_address1_line3+corp_address1_line4+corp_address1_line5+corp_address1_line6+
																												corp_address2_line1+corp_address2_line2+corp_address2_line3+corp_address2_line4+corp_address2_line5+corp_address2_line6)<>'');
HasNoRegistrantAddress 		:= AllFixedForeignDomesticInd(corp2.t2u(corp_address1_line1+corp_address1_line2+corp_address1_line3+corp_address1_line4+corp_address1_line5+corp_address1_line6+
																												corp_address2_line1+corp_address2_line2+corp_address2_line3+corp_address2_line4+corp_address2_line5+corp_address2_line6)='');
																										
NormRegistrantAddress			:= normalize(HasRegistrantAddress,2,NormTMRegistrantAddrTransform(left, counter));

NoRegistrantAddressProj		:= project(HasNoRegistrantAddress,transform(MyLayout,self := left; self := [];));																							 

AllTMRegistrantAddress		:= NormRegistrantAddress + NoRegistrantAddressProj;

//--------------------------------------------
// Transform to fix the data
//--------------------------------------------
Corp2.Layout_Corporate_Direct_Cont_Base_Expanded RegistrantTransform(MyLayout l)	:=	transform
			self.corp_address1_type_cd									:= '';
			self.corp_address1_type_desc								:= '';
			self.corp_address1_line1										:= '';
			self.corp_address1_line2										:= '';
			self.corp_address1_line3										:= '';  //Registrant information was being mapped to Corporation Addresses
			self.corp_address1_line4										:= ''; 	//which is incorrect.  Cleaning up corporation fields.
			self.corp_address1_line5										:= '';	
			self.corp_address1_line6										:= '';	//Need to create these as contact records.
			self.corp_prep_addr_line1										:= '';	
			self.corp_prep_addr_last_line								:= '';
      self.cont_name															:= Corp2_Mapping.fCleanBusinessName(state_origin,state_desc,l.corp_ra_name).BusinessName;
			self.cont_address_type_cd							  		:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).ifAddressExists,l.norm_addrtype,'');
			self.cont_address_type_desc				  				:= if(Corp2_Mapping.fAddressExists(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).ifAddressExists,l.norm_addrdesc,'');
			self.cont_address_line1			 			  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).AddressLine1;
			self.cont_address_line2			 	  						:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).AddressLine2;
			self.cont_address_line3						  				:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).AddressLine3;
			self.cont_prep_addr_line1						  			:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).PrepAddrLine1;
			self.cont_prep_addr_last_line						  	:= Corp2_Mapping.fCleanAddress(state_origin,state_desc,l.norm_address1,l.norm_address2,l.norm_address3,l.norm_address4,l.norm_address5,l.norm_address6).PrepAddrLastLine;
			self.corp_addr1_prim_range									:= '';
			self.corp_addr1_predir											:= '';
			self.corp_addr1_prim_name										:= '';
			self.corp_addr1_addr_suffix									:= '';
			self.corp_addr1_postdir											:= '';
			self.corp_addr1_unit_desig									:= '';
			self.corp_addr1_sec_range										:= '';
			self.corp_addr1_p_city_name									:= '';
			self.corp_addr1_v_city_name									:= '';
			self.corp_addr1_state												:= '';
			self.corp_addr1_zip5												:= '';
			self.corp_addr1_zip4												:= '';
			self.corp_addr1_cart												:= '';
			self.corp_addr1_cr_sort_sz									:= '';
			self.corp_addr1_lot													:= '';
			self.corp_addr1_lot_order										:= '';
			self.corp_addr1_dpbc												:= '';
			self.corp_addr1_chk_digit										:= '';
			self.corp_addr1_rec_type										:= '';
			self.corp_addr1_ace_fips_st									:= '';
			self.corp_addr1_county											:= '';
			self.corp_addr1_geo_lat											:= '';
			self.corp_addr1_geo_long										:= '';
			self.corp_addr1_msa													:= '';
			self.corp_addr1_geo_blk											:= '';
			self.corp_addr1_geo_match										:= '';
			self.corp_addr1_err_stat										:= '';
			//Note: The contact layout does not have "corp_addr2_*" fields.
			self							                					:= l;
			self							                					:= [];
end;


FixTMContAddress		:= project(AllTMRegistrantAddress, RegistrantTransform(left));
output(FixTMContAddress,named('FixTMContAddress'));
output(count(FixTMContAddress),named('cnt_FixTMContAddress'));	// sanity check count

AllCorp							:= dedup(sort(distribute(FixTMCorpAddress + NotTMData,hash(corp_key)),record,local),record,local);
AllCont							:= dedup(sort(distribute(FixTMContAddress + dsCurrentCont,hash(corp_key)),record,local),record,local);

output(dsCurrentCorp,named('OldCorpMapping'));
output(count(dsCurrentCorp),named('cnt_OldCorpMapping'));	// sanity check count
output(dsCurrentCont,named('dsOldContMapping'));
output(count(dsCurrentCont),named('cnt_dsOldContMapping'));	// sanity check count
output(AllCorp,named('NewCorpMapping'));
output(count(AllCorp),named('cnt_NewCorpMapping'));	// sanity check count
output(AllCont,named('NewContMapping'));
output(count(AllCont),named('cnt_NewContMapping'));	// sanity check count
/*
//---------------------------------------------
// output new version of the data, clear superfiles & add to superfiles
//---------------------------------------------
sequential(	output(AllCorp,,'~thor_data400::base::corp2::co::' + pversion + '::corp_xtnd',overwrite,__compressed__),						
						// parallel(	FileServices.clearsuperfile('~thor_data400::base::corp2::built::corp_xtnd'),
											// FileServices.clearsuperfile('~thor_data400::base::corp2::qa::corp_xtnd') ),
						// parallel(	Fileservices.Addsuperfile(	'~thor_data400::base::corp2::built::corp_xtnd',
																									// '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	),
											// Fileservices.Addsuperfile(	'~thor_data400::base::corp2::QA::corp_xtnd',
		    																	// '~thor_data400::base::corp2::' + pversion + '::corp_xtnd'	)	)
					);
*/