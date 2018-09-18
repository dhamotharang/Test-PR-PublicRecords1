import	LN_PropertyV2_Fast,RoxieKeyBuild,LN_PropertyV2,ut,Std;

EXPORT proc4channel (string	filedate, boolean isFast)	:=	FUNCTION

SuperKeyName 					:= '~thor_data400::key::'+if(isFast,'property_fast','ln_propertyv2')+'::';
SuperKeyName_fcra			:= SuperKeyName + 'fcra::';
BaseKeyName  					:= '~thor_data400::key::ln_propertyv2::' + filedate ;//+if(isFast,'z','y');
BaseKeyName_fcra			:= '~thor_data400::key::ln_propertyv2::fcra::' + filedate ;//+if(isFast,'z','y');

// Fast Property Keys
// Key Information
k1	:= LN_PropertyV2_Fast.key_addl_fares_deed_fid(isFast); 			s1 	:= 'addlfaresdeed.fid';
k2 	:= LN_PropertyV2_Fast.key_addl_fares_tax_fid(isFast); 			s2 	:= 'addlfarestax.fid';
k6 	:= LN_PropertyV2_Fast.key_assessor_parcelnum(isFast); 			s6 	:= 'assessor.parcelNum';
k8 	:= LN_PropertyV2_Fast.key_deed_parcelnum(isFast);						s8 	:= 'deed.parcelNum';
k9 	:= LN_PropertyV2_Fast.key_deed_zip_loanamt(isFast);					s9 	:= 'deed.zip_loanamt';
k15	:= LN_PropertyV2_Fast.key_tax_summary(isFast);							s15 := 'tax_summary';
k16	:= LN_PropertyV2_Fast.Key_Prop_Address_V4(false,isFast);		s16	:= 'addr.full_v4';								k16f := LN_PropertyV2_Fast.Key_Prop_Address_V4(true,isFast);
k17	:= LN_PropertyV2_Fast.Key_Prop_Address_V4_No_Fares(isFast);	s17	:= 'addr.full_v4_no_fares';
k28 := LN_PropertyV2_Fast.key_deed_zip_avg_sales_price(isFast);	s28 := 'deed::zip_avg_sales_price';				
//	Ownership Keys Information
k18	:= LN_PropertyV2_Fast.Key_Prop_Ownership_V4(isFast);				s18	:= 'did.ownership_v4';						k18f := LN_PropertyV2_Fast.key_Prop_Ownership_FCRA_V4(isFast);
k19 := LN_PropertyV2_Fast.Key_Prop_Ownership_V4_No_Fares(isFast);s19 := 'did.ownership_v4_no_fares';		

k20 := LN_PropertyV2_Fast.key_ownership_did(false,isFast);			s20 := 'ownership.did';								k20f := LN_PropertyV2_Fast.key_ownership_did(true,isFast);
k21 := LN_PropertyV2_Fast.key_ownership(isFast).fipsAPN; 				s21 := 'ownership_fipsAPN';
k22 := LN_PropertyV2_Fast.key_ownership(isFast).rawaid; 				s22 := 'ownership_rawaid';
k23 := LN_PropertyV2_Fast.key_ownership(isFast).addr(); 				s23 := 'ownership_addr';							k23f := LN_PropertyV2_Fast.key_ownership(isFast).addr(true);
k24 := LN_PropertyV2_Fast.key_ownership(isFast).did(); 					s24 := 'ownership_did';								k24f := LN_PropertyV2_Fast.key_ownership(isFast).did(true);
k25 := LN_PropertyV2_Fast.key_ownership(isFast).bdid; 					s25 := 'ownership_bdid';

// Key build call-out
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k1, SuperKeyName + s1, BaseKeyName + '::'+s1, key1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k2, SuperKeyName + s2, BaseKeyName + '::'+s2, key2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k6, SuperKeyName + s6, BaseKeyName + '::'+s6, key6);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k8, SuperKeyName + s8, BaseKeyName + '::'+s8, key8);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k9, SuperKeyName + s9, BaseKeyName + '::'+s9, key9);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k15,SuperKeyName +s15,	BaseKeyName + '::'+s15,key15);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k16,SuperKeyName +s16, BaseKeyName + '::'+s16,key16);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k17,SuperKeyName	+s17, BaseKeyName + '::'+s17,key17);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k18,SuperKeyName +s18,	BaseKeyName + '::'+s18,key18);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k19,SuperKeyName +s19,	BaseKeyName + '::'+s19,key19);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k28,SuperKeyName +s28, BaseKeyName + '::'+s28,key28);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k20,SuperKeyName +s20, BaseKeyName + '::'+s20,key20);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k21,SuperKeyName +s21, BaseKeyName + '::'+s21,key21);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k22,SuperKeyName +s22, BaseKeyName + '::'+s22,key22);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k23,SuperKeyName +s23, BaseKeyName + '::'+s23,key23);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k24,SuperKeyName +s24, BaseKeyName + '::'+s24,key24);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k25,SuperKeyName +s25, BaseKeyName + '::'+s25,key25);

Keys	:=	sequential(	key1,key2,key6,key8,key9,key15,key16,key17,key18,key19,
										key20, key21, key22, key23, key24, key25, key28);

//Build Non-FCRA Keys
// Key Information 

k14 := LN_PropertyV2_Fast.key_addr_fid(false,isFast); 			s14 := 'addr_search.fid';			k14f	:=LN_PropertyV2_Fast.key_addr_fid(true,isFast);
k3	:= LN_PropertyV2_Fast.key_addl_legal_fid(false,isFast); s3 	:= 'addllegal.fid';				k3f 	:=LN_PropertyV2_Fast.key_addl_legal_fid(true,isFast);
k4	:= LN_PropertyV2_Fast.key_addl_names(false,isFast);			s4 	:= 'addlnames.fid';				k4f		:=LN_PropertyV2_Fast.key_addl_names(true,isFast);
k5	:= LN_PropertyV2_Fast.key_assessor_fid(false,isFast);		s5 	:= 'assessor.fid';				k5f		:=LN_PropertyV2_Fast.key_assessor_fid(true,isFast);
k13	:= LN_PropertyV2_Fast.key_county_fid(false,isFast);		 	s13 := 'search.fid_county';		k13f	:=LN_PropertyV2_Fast.key_county_fid(true,isFast);
k7	:= LN_PropertyV2_Fast.key_deed_fid(false,isFast);		 		s7 := 'deed.fid';							k7f		:=LN_PropertyV2_Fast.key_deed_fid(true,isFast);
k10	:= LN_PropertyV2_Fast.key_property_did(false,isFast);		s10 := 'search.did';					k10f	:=LN_PropertyV2_Fast.key_property_did(true,isFast);
k12	:= LN_PropertyV2_Fast.key_search_fid(false,isFast);		 	s12 := 'search.fid';					k12f	:=LN_PropertyV2_Fast.key_search_fid(true,isFast);
k11	:= LN_PropertyV2_Fast.key_search_bdid(isFast);		 			s11 := 'search.bdid';
//Build BIPv2 LinkIds key
k26	:= LN_PropertyV2_Fast.key_LinkIds.Key(isFast);		 			s26 := 'search.linkids';
k27	:= LN_PropertyV2_Fast.key_search_fid_LinkIds(isFast);	 	s27 := 'search.fid_linkids';	

// Key build call-out
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k14,SuperKeyName+s14, BaseKeyName + '::'+s14,key14);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k3 ,SuperKeyName+ s3, BaseKeyName + '::' +s3,key3);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k4 ,SuperKeyName+ s4, BaseKeyName + '::' +s4,key4);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k5 ,SuperKeyName+ s5, BaseKeyName + '::' +s5,key5);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k13,SuperKeyName+s13, BaseKeyName + '::' +s13,key13);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k7 ,SuperKeyName+ s7, BaseKeyName + '::' +s7,key7);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k10,SuperKeyName+s10, BaseKeyName + '::' +s10,key10);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k12,SuperKeyName+s12, BaseKeyName + '::' +s12,key12);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k11,SuperKeyName+s11, BaseKeyName + '::' +s11,key11);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k26,SuperKeyName+s26, BaseKeyName + '::' +s26,key26);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k27,SuperKeyName+s27, BaseKeyName + '::' +s27,key27);

// Build FCRA keys

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(k14f,SuperKeyName_fcra+s14, BaseKeyName_fcra + '::'+s14,key14_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k3f ,SuperKeyName_fcra+ s3, BaseKeyName_fcra + '::' +s3,key3_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k4f ,SuperKeyName_fcra+ s4, BaseKeyName_fcra + '::' +s4,key4_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k5f ,SuperKeyName_fcra+ s5, BaseKeyName_fcra + '::' +s5,key5_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k13f,SuperKeyName_fcra+s13, BaseKeyName_fcra + '::' +s13,key13_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k7f ,SuperKeyName_fcra+ s7, BaseKeyName_fcra + '::' +s7,key7_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k10f,SuperKeyName_fcra+s10, BaseKeyName_fcra + '::' +s10,key10_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k12f,SuperKeyName_fcra+s12, BaseKeyName_fcra + '::' +s12,key12_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k16f,SuperKeyName_fcra+s16, BaseKeyName_fcra + '::' +s16,key16_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k18f,SuperKeyName_fcra+s18, BaseKeyName_fcra + '::' +s18,key18_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k20f,SuperKeyName_fcra+s20, BaseKeyName_fcra + '::' +s20,key20_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k23f,SuperKeyName_fcra+s23, BaseKeyName_fcra + '::' +s23,key23_fcra);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(k24f,SuperKeyName_fcra+s24, BaseKeyName_fcra + '::' +s24,key24_fcra);

Keys_fcra	:=	parallel(	key14			,key3			,key4			,key5			,key13			,key7			,key10,
												key12, key11, key26, key27,

												key14_fcra,key3_fcra,key4_fcra,key5_fcra,key13_fcra	,key7_fcra,key10_fcra, 
												key12_fcra, key16_fcra,  key18_fcra, key20_fcra, key23_fcra, key24_fcra
                        );

//Move Keys
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::addlfaresdeed.fid',					BaseKeyName+'::addlfaresdeed.fid',					mv1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::addlfarestax.fid',						BaseKeyName+'::addlfarestax.fid',						mv2);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::assessor.parcelNum',					BaseKeyName+'::assessor.parcelNum',					mv6);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::deed.parcelNum',							BaseKeyName+'::deed.parcelNum',							mv8);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::deed.zip_loanamt',						BaseKeyName+'::deed.zip_loanamt',						mv9);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::tax_summary',								BaseKeyName+'::tax_summary',								mv15);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::addr.full_v4',								BaseKeyName+'::addr.full_v4',								mv16);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::addr.full_v4_no_fares',			BaseKeyName+'::addr.full_v4_no_fares',			mv17);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did.ownership_v4',						BaseKeyName+'::did.ownership_v4',						mv18);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::did.ownership_v4_no_fares',	BaseKeyName+'::did.ownership_v4_no_fares',	mv19);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::deed::zip_avg_sales_price',  BaseKeyName+'::deed::zip_avg_sales_price',  mv28);


// New ownership keys
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ownership_did',							BaseKeyName+'::ownership_did',							mv20);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ownership_fipsAPN',					BaseKeyName+'::ownership_fipsAPN',					mv21);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ownership_rawaid',						BaseKeyName+'::ownership_rawaid',						mv22);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ownership_addr',							BaseKeyName+'::ownership_addr',							mv23);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ownership.did',							BaseKeyName+'::ownership.did',							mv24);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(SuperKeyName+'@version@::ownership_bdid',							BaseKeyName+'::ownership_bdid',							mv25);


Move_keys_orig	:=	parallel(	mv1, mv2, mv6, mv8,mv9,mv15,mv16,mv17,mv18,mv19,
															mv20, mv21, mv22, mv23, mv24, mv25,mv28);
															
//Move non-fcra
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::addr_search.fid',	BaseKeyName+'::addr_search.fid',  mv14);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::addllegal.fid',		BaseKeyName+'::addllegal.fid',		mv3);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::addlnames.fid',   	BaseKeyName+'::addlnames.fid',  	mv4);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::assessor.fid', 		BaseKeyName+'::assessor.fid', 		mv5);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::search.fid_county',	BaseKeyName+'::search.fid_county',  mv13);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::deed.fid',						BaseKeyName+'::deed.fid',						mv7);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::search.did',   			BaseKeyName+'::search.did',  				mv10);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::search.fid', 				BaseKeyName+'::search.fid', 				mv12);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::search.bdid', 				BaseKeyName+'::search.bdid', 				mv11);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::search.linkids', 		BaseKeyName+'::search.linkids', 		mv26);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName+'@version@::search.fid_linkids',	BaseKeyName+'::search.fid_linkids',	mv27);


// Move FCRA keys

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::addr_search.fid',	BaseKeyName_fcra+'::addr_search.fid',   mv14_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::addllegal.fid',		BaseKeyName_fcra+'::addllegal.fid',			mv3_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::addlnames.fid',   BaseKeyName_fcra+'::addlnames.fid',   	mv4_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::assessor.fid', 		BaseKeyName_fcra+'::assessor.fid', 			mv5_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::search.fid_county',		BaseKeyName_fcra+'::search.fid_county',   mv13_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::deed.fid',						BaseKeyName_fcra+'::deed.fid',						mv7_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::search.did',   				BaseKeyName_fcra+'::search.did',   				mv10_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::search.fid', 					BaseKeyName_fcra+'::search.fid', 					mv12_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::bdid', 								BaseKeyName_fcra+'::bdid', 								mv11_fcra);

Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::addr.full_v4', 				BaseKeyName_fcra+'::addr.full_v4', 				mv16_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::deedv2.fid', 					BaseKeyName_fcra+'::deedv2.fid', 					mv17_fcra);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::did.ownership_v4', 		BaseKeyName_fcra+'::did.ownership_v4', 		mv18_fcra);


//Move FCRA Ownership Keys
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::ownership_did',				BaseKeyName_fcra+'::ownership_did',		mv20_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::ownership_addr',			BaseKeyName_fcra+'::ownership_addr', 	mv23_fcra);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(SuperKeyName_fcra+'@version@::ownership.did',   		BaseKeyName_fcra+'::ownership.did',   mv24_fcra);


Move_keys_new	:=	parallel(mv3, mv4, mv5, mv7, mv10, mv11, mv12, mv13, mv14, mv26, mv27,
													mv3_fcra, mv4_fcra, mv5_fcra, mv7_fcra, mv10_fcra,
													 mv12_fcra, mv13_fcra, mv14_fcra,
													mv16_fcra,  mv18_fcra,
													mv20_fcra, mv23_fcra, mv24_fcra);

//Move Orig to QA
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::addlfaresdeed.fid',					'Q',mv1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::addlfarestax.fid',					'Q',mv2_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::assessor.parcelNum',				'Q',mv6_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::deed.parcelNum',						'Q',mv8_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::deed.zip_loanamt',					'Q',mv9_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::tax_summary',								'Q',mv15_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::addr.full_v4',							'Q',mv16_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::addr.full_v4_no_fares',			'Q',mv17_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::did.ownership_v4',					'Q',mv18_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::did.ownership_v4_no_fares',	'Q',mv19_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::deed::zip_avg_sales_price', 'Q',mv28_qa,2);

// New ownership keys
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ownership_did',							'Q',mv20_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ownership_fipsAPN',					'Q',mv21_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ownership_rawaid',					'Q',mv22_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ownership_addr',						'Q',mv23_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ownership.did',							'Q',mv24_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(SuperKeyName+'@version@::ownership_bdid',						'Q',mv25_qa,2);


To_qa_orig	:=	parallel(mv1_qa, mv2_qa, mv6_qa, mv8_qa, mv9_qa, mv15_qa, 
													mv16_qa, mv17_qa, mv18_qa, mv19_qa,
													mv20_qa, mv21_qa, mv22_qa, mv23_qa, mv24_qa,mv25_qa, mv28_qa);
// Move New to QA

Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::addr_search.fid',   'Q',mv14_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::addllegal.fid',		  'Q',mv3_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::addlnames.fid',     'Q',mv4_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::assessor.fid', 		  'Q',mv5_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::search.fid_county',	'Q',mv13_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::deed.fid',					'Q',mv7_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::search.did',   			'Q',mv10_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::search.fid', 				'Q',mv12_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::search.bdid', 			'Q',mv11_qa,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::search.linkids', 		'Q',mv26_qa,3);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName+'@version@::search.fid_linkids','Q',mv27_qa,2);
//Move FCRA Keys to QA
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::addr_search.fid',	  'Q',mv14_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::addllegal.fid',		  'Q',mv3_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::addlnames.fid',   	  'Q',mv4_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::assessor.fid', 		  'Q',mv5_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::search.fid_county',  'Q',mv13_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::deed.fid',					  'Q',mv7_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::search.did',   		  'Q',mv10_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::search.fid', 			  'Q',mv12_qa_fcra,2);
//Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::bdid', 						  'Q',mv11_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::addr.full_v4',			  'Q',mv16_qa_fcra,2);
//Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::deedv2.fid', 			  'Q',mv17_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::did.ownership_v4',   'Q',mv18_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::ownership_did',			'Q',mv20_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::ownership_addr', 		'Q',mv23_qa_fcra,2);
Roxiekeybuild.MAC_SK_Move_v2(SuperKeyName_fcra+'@version@::ownership.did', 			'Q',mv24_qa_fcra,2);

To_qa_fcra	:=	parallel(	mv14_qa, mv3_qa, mv4_qa, mv5_qa, mv13_qa, mv7_qa, mv10_qa,
													mv12_qa, mv11_qa, mv26_qa, mv27_qa, 
													
													mv14_qa_fcra,mv3_qa_fcra, mv4_qa_fcra, mv5_qa_fcra, mv13_qa_fcra,
													mv7_qa_fcra, mv10_qa_fcra,mv12_qa_fcra, /*mv11_qa_fcra,*/
													mv16_qa_fcra,/*mv17_qa_fcra,*/ mv18_qa_fcra,
													mv20_qa_fcra, mv23_qa_fcra, mv24_qa_fcra);
													
// OTHER STUFF

// Build Autokeys
autokeys	:=	LN_PropertyV2_Fast.proc_build_autokeys(filedate,isFast);

// Build Boolean Keys
assessor_boolean_keys	:=	LN_PropertyV2_Fast.Proc_Build_Boolean_Keys(filedate,isFast) : success(output('PropertyV2_Fast Assessor Boolean keys created successfully.'));
deeds_boolean_keys		:=	LN_PropertyV2_Fast.Proc_Build_Deed_Boolean_Keys(filedate,isFast) : success(output('PropertyV2_Fast Deeds Boolean keys created successfully.'));

update_property_dops	:=	parallel(	RoxieKeyBuild.updateversion('LNPropertyV2Keys', filedate, 'kgummadi@seisint.com'),
																		RoxieKeyBuild.updateversion('FCRA_LNPropertyV2Keys', filedate, 'kgummadi@seisint.com')
																	);
update_avm_dops				:=	parallel(	RoxieKeyBuild.updateversion('AVMV2Keys', filedate, 'kgummadi@seisint.com'),
																		RoxieKeyBuild.updateversion('FCRA_AVMV2Keys', filedate, 'kgummadi@seisint.com')
																	);

buildKey	:=	sequential( LN_PropertyV2_Fast.BuildLogger.update(filedate,'key_build_start_date',(STRING8)Std.Date.Today()),
													parallel(Keys, Keys_fcra),
												  parallel(Move_keys_orig, Move_keys_new),
												  parallel(to_qa_orig, To_qa_fcra),
													LN_PropertyV2_Fast.Proc_FCRA_Field_Deprecation_Stats(isFast),				//DF-21968
													autokeys,
													deeds_boolean_keys,
													assessor_boolean_keys,																
													/* STILL TO BE DONE !!
													update_property_dops,
													AVM_V2.Proc_Build_File_and_Keys(filedate),
													update_avm_dops
													*/
												 LN_PropertyV2_Fast.BuildLogger.update(filedate,'key_build_end_date',(STRING8)Std.Date.Today()),
												);	
return	buildKey;

end;