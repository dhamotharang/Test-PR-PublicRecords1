import versioncontrol;
export PersistNames(

	boolean	pUseOtherEnvironment = false	//if true on dataland, use prod, if true on prod, use dataland

):=
INLINE module
	export Root 	:= _dataset(pUseOtherEnvironment).thor_cluster_persists + 'persist::Business_Header::'		;
	export RootSS := _dataset(pUseOtherEnvironment).thor_cluster_persists + 'persist::Business_Header_SS::'	;

	export AppendAID											:= Root + 'Append_AID'													;
	export BADist													:= Root + 'BA_Dist'															;
	export BCDID													:= Root + 'BC_DID'															;
	export BCExtra												:= Root + 'BC_Extra'														;
	export BCInit													:= Root + 'BC_Init'															;
	export BCScored												:= Root + 'BC_Scored'														;
	export Best_All												:= Root + 'BestAll'															;
	export Best_Joined										:= Root + 'BestJoined'													;
	export BHAddrStats										:= Root + 'BH_Addr_Stats'												;
	export BHBasicMatchClean							:= Root + 'BH_Basic_Match_Clean'								;
	export BHBasicMatchFEIN								:= Root + 'BH_Basic_Match_FEIN'									;
	export BHBasicMatchForRels						:= Root + 'BH_Basic_Match_ForRels'							;
	export BHBasicMatchNameAddr						:= Root + 'BH_Basic_Match_NameAddr'							;
	export BHBasicMatchNoAddress					:= Root + 'BH_Basic_Match_NoAddress'						;
	export BHBasicMatchSALT								:= Root + 'BH_Basic_Match_SALT'									;
	export BHBDIDSIC											:= Root + 'BH_BDID_SIC'													;
	export BHBDIDSICFCRA									:= Root + 'BH_BDID_SIC_FCRA'										;
	export BHBQIStats											:= Root + 'BH_BQI_Stats'												;
	export BHContFixCorpDates							:= Root + 'BH_Cont_Fix_Corp_Dates'							;
	export BHInit													:= Root + 'BH_Init'															;
	export BHInitialBase									:= Root + 'BH_Initial_Base'											;
	export BHMatchInit										:= Root + 'BH_Match_Init'												;
	export BHMatches											:= Root + 'BH_Matches'													;
	export BHMatchesAppend								:= Root + 'BH_Matches::DomainsBusinesses'				;
	export BHMergedBase										:= Root + 'BH_Merged_Base'											;
	export BHRelativeGroupAddr						:= Root + 'BH_Relative_Group_Addr'							;
	export BHRelativeGroupDUNSTree				:= Root + 'BH_Relative_Group_DUNS_Tree'					;
	export BHRelativeGroupName						:= Root + 'BH_Relative_Group_Name'							;
	export BHRelativeGroupRollup					:= Root + 'BH_Relative_Group_Rollup'						;
	export BHRelativeMatchABIHierarchy		:= Root + 'BH_Relative_Match_ABI_Hierarchy'			;
	export BHRelativeMatchAddr						:= Root + 'BH_Relative_Match_Addr'							;
	export BHRelativeMatchDCAHierarchy		:= Root + 'BH_Relative_Match_DCA_Hierarchy'			;
	export BHRelativeMatchDCAHierarchySG		:= Root + 'BH_Relative_Match_DCA_Hierarchy'	+ '.BH_Super_Group'		;
	export BHRelativeMatchDUNSTree				:= Root + 'BH_Relative_Match_DUNS_Tree'					;
	export BHRelativeMatchFBN							:= Root + 'BH_Relative_Match_FBN'								;
	export BHRelativeMatchFEIN						:= Root + 'BH_Relative_Match_FEIN'							;
	export BHRelativeMatchGong						:= Root + 'BH_Relative_Match_Gong'							;
	export BHRelativeMatchID							:= Root + 'BH_Relative_Match_ID'								;
	export BHRelativeMatchMailAddr				:= Root + 'BH_Relative_Match_Mail_Addr'					;
	export BHRelativeMatchName						:= Root + 'BH_Relative_Match_Name'							;
	export BHRelativeMatchNamePhone				:= Root + 'BH_Relative_Match_Name_Phone'				;
	export BHRelativeMatchNameAddr				:= Root + 'BH_Relative_Match_NameAddr'					;
	export BHRelativeMatchPhone						:= Root + 'BH_Relative_Match_Phone'							;
	export BHRelativeMatchSharedContacts	:= Root + 'BH_Relative_Match_Shared_Contacts'		;
	export BHRelativeMatchUCC							:= Root + 'BH_Relative_Match_UCC'								;
	export BHRelativeMatchLP							:= Root + 'BH_Relative_Match_LP'								;
	export BHRelativeMatchL2							:= Root + 'BH_Relative_Match_L2'								;
	export BHSuperGroup										:= Root + 'BH_Super_Group'											;
	export BusinessAssociates							:= Root + 'Business_Associates'									;
	export EqContacts											:= Root + 'Eq_Contacts'													;
	export EqContactsWithEmployer					:= Root + 'Eq_Contacts::HasEmployer'						;
	export fDCAForGroups									:= Root + 'fDCA_For_Groups'											;
	export HeaderContacts									:= Root + 'Header_Contacts'											;					
	export MaxRCID												:= Root + 'Max_RCID'														;					
	export PhonesPlusContacts							:= Root + 'PhonesPlus_Contacts'									;	
	export Query_GetEBROnlyBdids					:= Root + 'QueryGetEBROnlyBdids'								;
	export buscontactsdids								:= Root + 'proc_build_business_contacts_output_files.buscontactsdids'									;
	export pawdids												:= Root + 'proc_build_business_contacts_output_files.pawdids'									;
	export MOXIEBHContactsKeys						:= Root + 'MOXIE_BH_Contacts_Keys'							;
	export FileBusinessHeaderFetch				:= Root + 'File_business_header_fetch'					;
	export FileBusinessHeaderPlus					:= Root + 'File_business_header_plus'						;

	export CompanyNameAddressJoinBackZip	:= RootSS + 'CompanyName_Address::JoinBackZip'	;
	export CompanyNameAddress							:= RootSS + 'CompanyName_Address'								;
	export CompanyNameAddressBroadJoinBackZip	:= RootSS + 'CompanyName_AddressBroad::JoinBackZip'	;
	export CompanyNameAddressBroad				:= RootSS + 'CompanyName_AddressBroad'					;
	export CompanyNameFein								:= RootSS + 'CompanyName_Fein'									;
	export CompanyNamePhone								:= RootSS + 'CompanyName_Phone'									;


	
	export MACParseGeo	:=
	module

		shared MACParseGeoRoot	:= Root + 'MAC_Parse_Geo::';
		
		export Raw					:= MACParseGeoRoot + 'Raw'					;
		export CityCount		:= MACParseGeoRoot + 'CityCount'		;
		export CityAffinity	:= MACParseGeoRoot + 'CityAffinity'	;
		export City					:= MACParseGeoRoot + 'City'					;

	end;
	

	export dAll_Filenames :=
	dataset([
	
				 {BADist													}							
        ,{BCDID														}							
        ,{BCExtra													}							
        ,{BCInit													}							
        ,{BCScored												}							
        ,{Best_All												}							
        ,{Best_Joined											}						
        ,{BHAddrStats											}						
        ,{BHBasicMatchClean								}				
        ,{BHBasicMatchFEIN								}	
				,{BHBasicMatchForRels							}
        ,{BHBasicMatchNameAddr						}				
        ,{BHBasicMatchNoAddress						}			
        ,{BHBDIDSIC												}					
        ,{BHBDIDSICFCRA										}					
        ,{BHBQIStats											}						
        ,{BHContFixCorpDates							}				
        ,{BHInit													}							
        ,{BHInitialBase										}					
        ,{BHMatchInit											}						
        ,{BHMatches												}					
        ,{BHMatchesAppend									}					
        ,{BHMergedBase										}							
        ,{BHRelativeGroupAddr							}				
        ,{BHRelativeGroupDUNSTree					}			
        ,{BHRelativeGroupName							}				
        ,{BHRelativeGroupRollup						}			
        ,{BHRelativeMatchABIHierarchy			}		
        ,{BHRelativeMatchAddr							}				
        ,{BHRelativeMatchDCAHierarchy			}		
        ,{BHRelativeMatchDUNSTree					}			
        ,{BHRelativeMatchFBN							}				
        ,{BHRelativeMatchFEIN							}				
        ,{BHRelativeMatchGong							}				
        ,{BHRelativeMatchID								}				
        ,{BHRelativeMatchMailAddr					}			
        ,{BHRelativeMatchName							}				
        ,{BHRelativeMatchNamePhone				}			
        ,{BHRelativeMatchNameAddr					}			
        ,{BHRelativeMatchPhone						}	
        ,{BHRelativeMatchSharedContacts		}	
        ,{BHRelativeMatchUCC							}				
        ,{BHSuperGroup										}						
        ,{BusinessAssociates							}					
        ,{EqContacts											}
        ,{HeaderContacts									}
				,{PhonesPlusContacts							}
        ,{MACParseGeo.Raw									}			
        ,{MACParseGeo.CityCount						}			
        ,{MACParseGeo.CityAffinity				}			
        ,{MACParseGeo.City								}			
        ,{Query_GetEBROnlyBdids						}
				,{MaxRCID													}
				,{CompanyNameAddressJoinBackZip		}
				,{CompanyNameAddress							}
				,{CompanyNameFein									}
				,{CompanyNamePhone								}
				,{buscontactsdids									}
				,{pawdids													}
				,{MOXIEBHContactsKeys							}
				,{FileBusinessHeaderFetch					}
				,{FileBusinessHeaderPlus					}
          
	], versioncontrol.Layout_Names)
	;
end;