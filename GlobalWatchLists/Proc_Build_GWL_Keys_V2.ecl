import	RoxieKeyBuild,ut;

export	Proc_Build_GWL_Keys_V2(string	pFileDate)	:=
function
	string	vSuperKeyNamePrefix		:=	GlobalWatchLists.constants.Cluster	+	'key::globalWatchLists::@version@::';
	string	vLogicalKeyNamePrefix	:=	GlobalWatchLists.constants.Cluster	+	'key::globalWatchLists::'	+	pFileDate;
	
	// Build V2 Keys
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_AddlInfo_V4,
																							vSuperKeyNamePrefix	+	'addlinfo',
																							vLogicalKeyNamePrefix	+	'::addlinfo',
																							a1
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_Addresses_V4,
																							vSuperKeyNamePrefix	+	'address',
																							vLogicalKeyNamePrefix	+	'::address',
																							a2
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_AddressIndex_V4,
																							vSuperKeyNamePrefix	+	'address_index',
																							vLogicalKeyNamePrefix	+	'::address_index',
																							a3
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_Country_V4,
																							vSuperKeyNamePrefix	+	'countries',
																							vLogicalKeyNamePrefix	+	'::countries',
																							a4
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_CountryAKAs_V4,
																							vSuperKeyNamePrefix	+	'country_aka',
																							vLogicalKeyNamePrefix	+	'::country_aka',
																							a5
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_CountryIndex_V4,
																							vSuperKeyNamePrefix	+	'country_index',
																							vLogicalKeyNamePrefix	+	'::country_index',
																							a6
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_Entity_V4,
																							vSuperKeyNamePrefix	+	'entities',
																							vLogicalKeyNamePrefix	+	'::entities',
																							a7
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_IDIndex_V4,
																							vSuperKeyNamePrefix	+	'id_index',
																							vLogicalKeyNamePrefix	+	'::id_index',
																							a8
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_IDNumbers_V4,
																							vSuperKeyNamePrefix	+	'id_numbers',
																							vLogicalKeyNamePrefix	+	'::id_numbers',
																							a9
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_NameIndex_V4,
																							vSuperKeyNamePrefix	+	'name_index',
																							vLogicalKeyNamePrefix	+	'::name_index',
																							a10
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_Names_V4,
																							vSuperKeyNamePrefix	+	'names',
																							vLogicalKeyNamePrefix	+	'::names',
																							a11
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_PhoneIndex_V4,
																							vSuperKeyNamePrefix	+	'phone_index',
																							vLogicalKeyNamePrefix	+	'::phone_index',
																							a12
																						);
	RoxieKeyBuild.MAC_SK_BuildProcess_v2_local(	GlobalWatchLists.key_GlobalWatchLists_PhoneNumbers_V4,
																							vSuperKeyNamePrefix	+	'phonenumbers',
																							vLogicalKeyNamePrefix	+	'::phonenumbers',
																							a13
																						);
	
	// Move to built
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'addlinfo',
																					vLogicalKeyNamePrefix	+	'::addlinfo',
																					b1
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'address',
																					vLogicalKeyNamePrefix	+	'::address',
																					b2
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'address_index',
																					vLogicalKeyNamePrefix	+	'::address_index',
																					b3
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'countries',
																					vLogicalKeyNamePrefix	+	'::countries',
																					b4
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'country_aka',
																					vLogicalKeyNamePrefix	+	'::country_aka',
																					b5
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'country_index',
																					vLogicalKeyNamePrefix	+	'::country_index',
																					b6
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'entities',
																					vLogicalKeyNamePrefix	+	'::entities',
																					b7
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'id_index',
																					vLogicalKeyNamePrefix	+	'::id_index',
																					b8
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'id_numbers',
																					vLogicalKeyNamePrefix	+	'::id_numbers',
																					b9
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'name_index',
																					vLogicalKeyNamePrefix	+	'::name_index',
																					b10
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'names',
																					vLogicalKeyNamePrefix	+	'::names',
																					b11
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'phone_index',
																					vLogicalKeyNamePrefix	+	'::phone_index',
																					b12
																				);
	RoxieKeyBuild.Mac_SK_Move_To_Built_V2(	vSuperKeyNamePrefix	+	'phonenumbers',
																					vLogicalKeyNamePrefix	+	'::phonenumbers',
																					b13
																				);

  buildKeys	:=	parallel(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13);
	
	moveKeys2Built	:=	parallel(b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13);
	
	// Move keys from built to QA
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'addlinfo','Q',move1);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'address','Q',move2);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'address_index','Q',move3);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'countries','Q',move4);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'country_aka','Q',move5);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'country_index','Q',move6);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'entities','Q',move7);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'id_index','Q',move8);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'id_numbers','Q',move9);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'name_index','Q',move10);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'names','Q',move11);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'phone_index','Q',move12);
	RoxieKeyBuild.MAC_SK_Move_V2(vSuperKeyNamePrefix	+	'phonenumbers','Q',move13);
	
	moveKeys2QA	:=	parallel(move1,move2,move3,move4,move5,move6,move7,move8,move9,move10,move11,move12,move13);
	
  return sequential(buildKeys,moveKeys2Built,moveKeys2QA);
end;