import header;
export Persists(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
module
	
	shared pname := Persistnames(pUseOtherEnvironment);
	
	
//	export BADist													:= Dataset(Persistnames.BADist												,flat);
	export BCDID													:= Dataset(pname.BCDID													,Layout_Business_Contacts_Temp,flat);
	export BCExtra												:= Dataset(pname.BCExtra												,Layout_Business_Contacts_Temp,flat);
	export BCInit													:= Dataset(pname.BCInit													,Layout_Business_Contacts_Temp,flat);
	export BCScored												:= Dataset(pname.BCScored												,Layout_Business_Contacts_Temp,flat);
	export Best_All												:= Dataset(pname.Best_All												,Layout_BH_Best,flat);
	export Best_Joined										:= Dataset(pname.Best_Joined										,Layout_BH_Best,flat);
	export BHAddrStats										:= Dataset(pname.BHAddrStats										,Layout_BH_Addr_Stats,flat);
	export BHBasicMatchClean							:= Dataset(pname.BHBasicMatchClean							,Layout_Business_Header_Temp,flat);
	export BHBasicMatchFEIN								:= Dataset(pname.BHBasicMatchFEIN								,Layout_Business_Header_Temp,flat);
	export BHBasicMatchNameAddr						:= Dataset(pname.BHBasicMatchNameAddr						,Layout_Business_Header_Temp,flat);
	export BHBasicMatchNoAddress					:= Dataset(pname.BHBasicMatchNoAddress					,Layout_Business_Header_Temp,flat);
	export BHBasicMatchSALT								:= Dataset(pname.BHBasicMatchSALT								,Layout_Business_Header_Temp,flat);
	export BHBDIDSIC											:= Dataset(pname.BHBDIDSIC											,Layout_SIC_Code,flat);
	export BHBDIDSICFCRA									:= Dataset(pname.BHBDIDSICFCRA									,Layout_SIC_Code,flat);
	export BHBQIStats											:= Dataset(pname.BHBQIStats											,Layout_BQI_Stats,flat);
	export BHContFixCorpDates							:= Dataset(pname.BHContFixCorpDates							,Layout_Business_Contact_Full,flat);
	export BHInit													:= Dataset(pname.BHInit													,Layout_Business_Header_New,flat);
	export BHInitialBase									:= Dataset(pname.BHInitialBase									,Layout_Business_Header_New,flat);
	export BHMatchInit										:= Dataset(pname.BHMatchInit										,Layout_Business_Header_Temp,flat);
	export BHMatches											:= Dataset(pname.BHMatches											,Layout_Business_Header_New,flat);
	export BHMatchesAppend								:= Dataset(pname.BHMatchesAppend								,Layout_Business_Header_New,flat);
	export BHMergedBase										:= Dataset(pname.BHMergedBase										,Layout_Business_Header_New,flat);
	export BHRelativeGroupAddr						:= Dataset(pname.BHRelativeGroupAddr						,Layout_Relative_Match,flat);
	export BHRelativeGroupDUNSTree				:= Dataset(pname.BHRelativeGroupDUNSTree				,Layout_Relative_Match,flat);
	export BHRelativeGroupName						:= Dataset(pname.BHRelativeGroupName						,Layout_Relative_Match,flat);
	export BHRelativeGroupRollup					:= Dataset(pname.BHRelativeGroupRollup					,Layout_Business_Relative_Group,flat);
	export BHRelativeMatchABIHierarchy		:= Dataset(pname.BHRelativeMatchABIHierarchy		,Layout_Relative_Match,flat);
	export BHRelativeMatchAddr						:= Dataset(pname.BHRelativeMatchAddr						,Layout_Relative_Match,flat);
	export BHRelativeMatchDCAHierarchy		:= Dataset(pname.BHRelativeMatchDCAHierarchy		,Layout_Relative_Match,flat);
	export BHRelativeMatchDUNSTree				:= Dataset(pname.BHRelativeMatchDUNSTree				,Layout_Relative_Match,flat);
	export BHRelativeMatchFBN							:= Dataset(pname.BHRelativeMatchFBN							,Layout_Relative_Match,flat);
	export BHRelativeMatchFEIN						:= Dataset(pname.BHRelativeMatchFEIN						,Layout_Relative_Match,flat);
	export BHRelativeMatchGong						:= Dataset(pname.BHRelativeMatchGong						,Layout_Relative_Match,flat);
	export BHRelativeMatchID							:= Dataset(pname.BHRelativeMatchID							,Layout_Relative_Match,flat);
	export BHRelativeMatchMailAddr				:= Dataset(pname.BHRelativeMatchMailAddr				,Layout_Relative_Match,flat);
	export BHRelativeMatchName						:= Dataset(pname.BHRelativeMatchName						,Layout_Relative_Match,flat);
	export BHRelativeMatchNamePhone				:= Dataset(pname.BHRelativeMatchNamePhone				,Layout_Relative_Match,flat);
	export BHRelativeMatchNameAddr				:= Dataset(pname.BHRelativeMatchNameAddr				,Layout_Relative_Match,flat);
	export BHRelativeMatchPhone						:= Dataset(pname.BHRelativeMatchPhone						,Layout_Relative_Match,flat);
	export BHRelativeMatchSharedContacts	:= Dataset(pname.BHRelativeMatchSharedContacts	,Layout_Relative_Match,flat);
	export BHRelativeMatchUCC							:= Dataset(pname.BHRelativeMatchUCC							,Layout_Relative_Match,flat);
	export BHRelativeMatchLP							:= Dataset(pname.BHRelativeMatchLP							,Layout_Relative_Match,flat);
	export BHRelativeMatchL2							:= Dataset(pname.BHRelativeMatchL2							,Layout_Relative_Match,flat);
	export BHSuperGroup										:= Dataset(pname.BHSuperGroup										,Layout_BH_Super_Group,flat);
	export BusinessAssociates							:= Dataset(pname.BusinessAssociates							,header.Layout_relatives,flat);
	export EqContacts											:= Dataset(pname.EqContacts											,Layout_Business_Contacts_Temp,flat);
	export FileBusinessHeaderFetch				:= Dataset(pname.FileBusinessHeaderFetch				,Layouts.File_Hdr_Biz_Keybuild_Layout,flat);
	export FileBusinessHeaderPlus					:= Dataset(pname.FileBusinessHeaderPlus				,Layout_Business_Header_Base_Plus_Orig,flat);
//	export EqContactsWithEmployer					:= Dataset(pname.EqContactsWithEmployer				,,flat);
	export HeaderContacts									:= Dataset(pname.HeaderContacts									,Layout_Business_Contacts_Temp,flat);
//	export MaxRCID												:= Dataset(pname.MaxRCID												,,flat);
	export PhonesPlusContacts							:= Dataset(pname.PhonesPlusContacts							,Layout_Business_Contacts_Temp,flat);
//	export Query_GetEBROnlyBdids					:= Dataset(pname.Query_GetEBROnlyBdids					,,flat);
/*	export buscontactsdids								:= Dataset(pname.buscontactsdids								,,flat);
	export pawdids												:= Dataset(pname.pawdids												,,flat);
	export MOXIEBHContactsKeys						:= Dataset(pname.MOXIEBHContactsKeys						,,flat);
                                                                                               
	export CompanyNameAddressJoinBackZip	:= Dataset(pname.CompanyNameAddressJoinBackZip	,,flat);
	export CompanyNameAddress							:= Dataset(pname.CompanyNameAddress						,,flat);
	export CompanyNameFein								:= Dataset(pname.CompanyNameFein								,,flat);
	export CompanyNamePhone								:= Dataset(pname.CompanyNamePhone							,,flat);
                                                                                            
	export MACParseGeo	:=                           
	module

		export Raw					:= Dataset(pname.MACParseGeo.Raw						,,flat);
		export CityCount		:= Dataset(pname.MACParseGeo.CityCount			,,flat);
		export CityAffinity	:= Dataset(pname.MACParseGeo.CityAffinity	,,flat);
		export City					:= Dataset(pname.MACParseGeo.City					,,flat);
                                                                        
	end;                             
*/
end;