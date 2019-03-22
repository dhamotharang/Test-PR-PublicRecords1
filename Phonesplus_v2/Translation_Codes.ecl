/*2011-09-08T19:55:48Z (a herzberg)
Bug: 79183
*/
import lib_stringlib, ut, mdr;
export Translation_Codes := module

export toll_free_area_codes := ['800','811','822','833','844','855','866','877','888','899'];
													
//-----Bit map for data sources in phonesplus													
export source_bitmap_code(string source = '')  := map(
													source = mdr.sourceTools.src_InfutorCID  	  	 		  		=> ut.bit_set(0,0),
													source = mdr.sourceTools.src_Cellphones_Kroll  	 				=> ut.bit_set(0,1),
													source = mdr.sourceTools.src_Cellphones_Traffix					=> ut.bit_set(0,2),
													source = mdr.sourceTools.src_Cellphones_Nextones 				=> ut.bit_set(0,3),
													source = mdr.sourceTools.src_Intrado	         		  		=> ut.bit_set(0,4),
													source = mdr.sourceTools.src_Targus_White_Pages  				=> ut.bit_set(0,5),
													source = mdr.sourceTools.src_Pcnsr		         		  		=> ut.bit_set(0,6),
													source = mdr.sourceTools.src_Gong_History		 		  			=> ut.bit_set(0,7),
													source = mdr.sourceTools.src_Equifax  									=> ut.bit_set(0,9),
													source = mdr.sourceTools.src_Utilities 									=> ut.bit_set(0,10),
													source = mdr.sourceTools.src_LnPropV2_Fares_Asrs 				=> ut.bit_set(0,11),
													source = mdr.sourceTools.src_Voters_v2									=> ut.bit_set(0,12),
													source = mdr.sourceTools.src_Util_Work_Phone						=> ut.bit_set(0,13),
													source = mdr.sourceTools.src_American_Students_List			=> ut.bit_set(0,14),
													source = mdr.sourceTools.src_Professional_License				=> ut.bit_set(0,15),
													source = mdr.sourceTools.src_Certegy 									  => ut.bit_set(0,16),
													source = mdr.sourceTools.src_EMerge_Hunt								=> ut.bit_set(0,17),
													source = mdr.sourceTools.src_EMerge_Master							=> ut.bit_set(0,18),
													source = mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs	=> ut.bit_set(0,19),
													source = mdr.sourceTools.src_LnPropV2_Lexis_Asrs				=> ut.bit_set(0,20),
													source = mdr.sourceTools.src_KY_Watercraft							=> ut.bit_set(0,21),
													source = mdr.sourceTools.src_EMerge_Boat								=> ut.bit_set(0,22),
													source = mdr.sourceTools.src_VA_Watercraft							=> ut.bit_set(0,23),
													source = mdr.sourceTools.src_NC_Watercraft							=> ut.bit_set(0,24),
													source = mdr.sourceTools.src_TUCS_Ptrack								=> ut.bit_set(0,25),
													source = mdr.sourceTools.src_EMerge_Cens								=> ut.bit_set(0,26),
													source = mdr.sourceTools.src_Federal_Firearms						=> ut.bit_set(0,27),
													source = mdr.sourceTools.src_EMerge_Fish								=> ut.bit_set(0,28),
													source = mdr.sourceTools.src_Federal_Explosives					=> ut.bit_set(0,29),
													source = mdr.sourceTools.src_MD_Watercraft							=> ut.bit_set(0,30),
													source = mdr.sourceTools.src_Miscellaneous	 						=> ut.bit_set(0,31),
													source = mdr.sourceTools.src_MO_Veh	 									  => ut.bit_set(0,32),
													source = mdr.sourceTools.src_MO_DL										  => ut.bit_set(0,33),
													source = mdr.sourceTools.src_MO_Experian_Veh						=> ut.bit_set(0,34),
													source = mdr.sourceTools.src_Experian_Credit_Header			=> ut.bit_set(0,35),
													source = mdr.sourceTools.src_MO_Watercraft							=> ut.bit_set(0,36),
													source =  mdr.sourceTools.src_Wired_Assets_Royalty			=> ut.bit_set(0,37),
													source =  mdr.sourceTools.src_Wired_Assets_Owned				=> ut.bit_set(0,38),
													source =  mdr.sourceTools.src_ZUtil_Work_Phone          => ut.bit_set(0,39),
													source =  mdr.sourceTools.src_ZUtilities                => ut.bit_set(0,40),
													source =  mdr.sourceTools.src_InquiryAcclogs            => ut.bit_set(0,41),
													source =  mdr.sourceTools.src_TU_CreditHeader           => ut.bit_set(0,42),
													source =  mdr.sourceTools.src_ibehavior				          => ut.bit_set(0,43),
													source =  mdr.sourceTools.src_thrive_lt				          => ut.bit_set(0,44),
													source =  mdr.sourceTools.src_thrive_pd				          => ut.bit_set(0,45),
													source =  mdr.sourceTools.src_AlloyMedia_Consumer	      => ut.bit_set(0,46),
													source =  mdr.sourceTools.src_Link2Tek	                => ut.bit_set(0,47),
													source =  mdr.sourceTools.src_NeustarWireless           => ut.bit_set(0,49), //Jira DF-24336
													0); //Max 64 sources

//-----Bit map translation for EQ											
export	string	fGet_eq_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Equifax)),			' ' + mdr.sourceTools.src_Equifax,''));
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;

//-----Bit map translation for Other header sources									
export	string	fGet_other_hdr_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',							if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Utilities 										)),' ' + 	mdr.sourceTools.src_Utilities 								,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_LnPropV2_Fares_Asrs 					)),' ' + 	mdr.sourceTools.src_LnPropV2_Fares_Asrs 			,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Voters_v2											)),' ' + 	mdr.sourceTools.src_Voters_v2									,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Util_Work_Phone								)),' ' + 	mdr.sourceTools.src_Util_Work_Phone						,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_American_Students_List				)),' ' + 	mdr.sourceTools.src_American_Students_List		,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Professional_License					)),' ' + 	mdr.sourceTools.src_Professional_License			,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Certegy 											)),' ' + 	mdr.sourceTools.src_Certegy 									,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_EMerge_Hunt										)),' ' + 	mdr.sourceTools.src_EMerge_Hunt								,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_EMerge_Master									)),' ' + 	mdr.sourceTools.src_EMerge_Master							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs			)),' ' + 	mdr.sourceTools.src_LnPropV2_Lexis_Deeds_Mtgs	,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_LnPropV2_Lexis_Asrs						)),' ' + 	mdr.sourceTools.src_LnPropV2_Lexis_Asrs				,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_KY_Watercraft									)),' ' + 	mdr.sourceTools.src_KY_Watercraft							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_EMerge_Boat										)),' ' + 	mdr.sourceTools.src_EMerge_Boat								,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_VA_Watercraft									)),' ' + 	mdr.sourceTools.src_VA_Watercraft							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_NC_Watercraft									)),' ' + 	mdr.sourceTools.src_NC_Watercraft							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_TUCS_Ptrack										)),' ' + 	mdr.sourceTools.src_TUCS_Ptrack								,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_EMerge_Cens										)),' ' + 	mdr.sourceTools.src_EMerge_Cens								,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Federal_Firearms							)),' ' + 	mdr.sourceTools.src_Federal_Firearms					,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_EMerge_Fish										)),' ' + 	mdr.sourceTools.src_EMerge_Fish								,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Federal_Explosives						)),' ' + 	mdr.sourceTools.src_Federal_Explosives				,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_MD_Watercraft									)),' ' + 	mdr.sourceTools.src_MD_Watercraft							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Miscellaneous									)),' ' + 	mdr.sourceTools.src_Miscellaneous							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_MO_Veh												)),' ' + 	mdr.sourceTools.src_MO_Veh										,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_MO_DL													)),' ' + 	mdr.sourceTools.src_MO_DL											,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_MO_Experian_Veh								)),' ' + 	mdr.sourceTools.src_MO_Experian_Veh						,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Experian_Credit_Header				)),' ' + 	mdr.sourceTools.src_Experian_Credit_Header		,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_MO_Watercraft									)),' ' + 	mdr.sourceTools.src_MO_Watercraft							,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_ZUtil_Work_Phone							)),' ' + 	mdr.sourceTools.src_ZUtil_Work_Phone					,'')
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_ZUtilities										)),' ' + 	mdr.sourceTools.src_ZUtilities								,'')	
																					+if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_TU_CreditHeader							  )),' ' + 	mdr.sourceTools.src_TU_CreditHeader				    ,'')			
											  );
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;	

//-----Bit map translation for Other sources
export	string	fGet_other_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_InfutorCID							)),	' ' + mdr.sourceTools.src_InfutorCID						,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Cellphones_Kroll				)),	' ' + mdr.sourceTools.src_Cellphones_Kroll			,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Cellphones_Traffix			)),	' ' + mdr.sourceTools.src_Cellphones_Traffix		,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Cellphones_Nextones		)),	' ' + mdr.sourceTools.src_Cellphones_Nextones		,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Targus_White_Pages			)),	' ' + mdr.sourceTools.src_Targus_White_Pages		,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Pcnsr									)),	' ' + mdr.sourceTools.src_Pcnsr									,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Gong_History						)),	' ' + mdr.sourceTools.src_Gong_History					,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Intrado								)),	' ' + mdr.sourceTools.src_Intrado								,'')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Wired_Assets_Owned			)),	' ' +  mdr.sourceTools.src_Wired_Assets_Owned		,'')										
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_Wired_Assets_Royalty		)),	' ' +  mdr.sourceTools.src_Wired_Assets_Royalty	,'')	
									  +	   if(fFlagIsOn(bitmap_src, source_bitmap_code(mdr.sourceTools.src_InquiryAcclogs					)),	' ' +  mdr.sourceTools.src_InquiryAcclogs	,'')	
										+		 if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Ibehavior							)),' ' + 	mdr.sourceTools.src_Ibehavior,'')	
										+    if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Thrive_LT							)),' ' + 	mdr.sourceTools.src_Thrive_LT,'')	
										+    if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Thrive_PD							)),' ' + 	mdr.sourceTools.src_Thrive_PD,'')		
										+    if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_AlloyMedia_Consumer)),' ' + 	mdr.sourceTools.src_AlloyMedia_Consumer,'')
										+    if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_Link2Tek              )),' ' + 	mdr.sourceTools.src_Link2Tek,'')
										+    if(fFlagIsOn(bitmap_src, source_bitmap_code(	mdr.sourceTools.src_NeustarWireless       )),' ' + 	mdr.sourceTools.src_NeustarWireless,'') //Jira DF-24336										
										);
										
										
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;



export	string fGet_all_sources (unsigned bitmap_src) := function
return  StringLib.StringCleanSpaces(fGet_other_sources_from_bitmap(bitmap_src) + ' ' +
             fGet_other_hdr_sources_from_bitmap(bitmap_src) + ' ' + 
   	         fGet_eq_sources_from_bitmap(bitmap_src));
end;

	
//-----Bit map translation for EDA match indicator
export	string	fGet_eda_match_bitmap(unsigned bitmap_match) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
		string		translated_value		:=	if(bitmap_match = 0,
											   '',	
											   if(fFlagIsOn(bitmap_match, ut.bit_set(0,0)),			' Phone','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,1)),			' Did-Lphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,2)),		  ' Did','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,3)),		  ' Lname-Addr-Lphone7','')
                    +	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,4)),			' Lname-Addr','')
											  );

		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ',',');
end;

//-----Bit map translation for Non-pub match indicator
export	string	fGet_nonpub_match_bitmap(unsigned bitmap_match) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
		string		translated_value		:=	if(bitmap_match = 0,
											   '',	
											   if(fFlagIsOn(bitmap_match, ut.bit_set(0,0)),			' Gong-Did','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,1)),			' Gong-LName-Addr','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,2)),			' Gong-LName-Addr-Fphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,3)),			' Gong-Did-Fphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,4)),			' Targ-Did','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,5)),			' Targ-LName-Addr','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,6)),			' Targ-LName-Addr-Fphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,7)),			' Targ-Did-Fphone7','')
											  );
								

		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ',',');
end;

//-----Bit map translation for Ported indicator
export	string	fGet_ported_match_bitmap(unsigned bitmap_match) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
		string		translated_value		:=	if(bitmap_match = 0,
											   '',	
											   if(fFlagIsOn(bitmap_match, ut.bit_set(0,0)),			' Phone10','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,1)),			' Phone7','')
											  );

		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ',',');
end;

//-----Vendor/ source confidence score
export source_conf(string source = '')  := map(
													//Sources other than header
													source = mdr.sourceTools.src_Link2Tek             => 11,
													source = mdr.sourceTools.src_InquiryAcclogs       => 10,
													source = mdr.sourceTools.src_InfutorCID  					=> 10,
													source = mdr.sourceTools.src_Cellphones_Kroll			=> 9,
													source = mdr.sourceTools.src_Cellphones_Traffix 	=> 9,
													source = mdr.sourceTools.src_Cellphones_Nextones	=> 9,
													source = mdr.sourceTools.src_Intrado							=> 5,
													source = mdr.sourceTools.src_Targus_White_Pages		=> 6,
													source = mdr.sourceTools.src_Pcnsr								=> 5,
													source = mdr.sourceTools.src_Gong_History   			=> 5,
													source = mdr.sourceTools.src_Wired_Assets_Owned 	=> 5,
													source = mdr.sourceTools.src_Wired_Assets_Royalty => 5,
													//Header sources
													source = mdr.sourceTools.src_Utilities   					=> 9,
													source = mdr.sourceTools.src_Util_Work_Phone  		=> 9,
													source = mdr.sourceTools.src_TUCS_Ptrack  				=> 0,
													5);

//------Caption for Basic Rules...In the future this will be converted to a bit map
export rules_bitmap_code(string rules = '')  := map(
															rules = 'Active-EDA-Phone' 				 => ut.bit_set(0,0),
															rules = 'Active-EDA-Record'	       => ut.bit_set(0,1),
															rules = 'Disconnected-EDA'         => ut.bit_set(0,2),
															rules = 'Non-pub' 								 => ut.bit_set(0,3),
															rules = 'Ported-Neustar' 					 => ut.bit_set(0,4),
															rules = 'Seen-Once'                => ut.bit_set(0,5),
															rules = 'High-Vendor-Conf'         => ut.bit_set(0,6),
															rules = 'Low-Vendor-Conf'          => ut.bit_set(0,7),
															rules = 'Cellphone-Latest'         => ut.bit_set(0,8),
															rules = 'Non-pub-for-someone-else' => ut.bit_set(0,9),

															//------Caption for Last resort rules
															rules = 'Targ-Non-pub' 						 => ut.bit_set(0,10),
															rules = 'Ported-Cell-Type'         => ut.bit_set(0,11),
															rules = 'Ported-Best-No-Active'    => ut.bit_set(0,12),
															rules = 'Source-Latest'            => ut.bit_set(0,13),
															rules = 'Med-Vendor-Conf-Cell'     => ut.bit_set(0,14),
															rules = 'Last-Resort-Cell'         => ut.bit_set(0,15),
															rules = 'Household'                => ut.bit_set(0,16),
															rules = 'Hdr-Household'            => ut.bit_set(0,17),
															rules = 'Included-for-someone-else'=> ut.bit_set(0,18),
															rules = 'Deceased'								 => ut.bit_set(0,19),
															rules = 'Gongh-Disconnect'				 => ut.bit_set(0,20),
															rules = 'Consortium-Disconnect'    => ut.bit_set(0,21),
															rules = 'Consortium-RPC'    => ut.bit_set(0,22),
															rules = 'IQ-Wrong-Party'    => ut.bit_set(0,23),
															rules = 'IQ-RPC'    => ut.bit_set(0,24),
															rules = 'Ins-Verified-Above' => ut.bit_set(0,25),
															rules = 'Ins-Verified-Below' => ut.bit_set(0,26),
															rules = 'FileOne-Verified-Above' => ut.bit_set(0,27),
															rules = 'FileOne-Verified-Below' => ut.bit_set(0,28),
															rules = 'TelNet' => ut.bit_set(0,29),
															rules = 'Neustar-Verified' => ut.bit_set(0,30),			//Bug 162654
															//JIRA DF-24336 NeustarWireless Start
															rules = 'NeustarWireless-Verified-A' => ut.bit_set(0,32),
															rules = 'NeustarWireless-Verified-B' => ut.bit_set(0,33),
															rules = 'NeustarWireless-Verified-C' => ut.bit_set(0,34),
															rules = 'NeustarWireless-Verified-D' => ut.bit_set(0,35),
															rules = 'NeustarWireless-Verified-E' => ut.bit_set(0,36),
															rules = 'NeustarWireless-Activity-Status-A1' => ut.bit_set(0,37),
															rules = 'NeustarWireless-Activity-Status-A2' => ut.bit_set(0,38),
															rules = 'NeustarWireless-Activity-Status-A3' => ut.bit_set(0,39),
															rules = 'NeustarWireless-Activity-Status-A4' => ut.bit_set(0,40),
															rules = 'NeustarWireless-Activity-Status-A5' => ut.bit_set(0,41),
															rules = 'NeustarWireless-Activity-Status-A6' => ut.bit_set(0,42),
															rules = 'NeustarWireless-Activity-Status-A7' => ut.bit_set(0,43),
															rules = 'NeustarWireless-Activity-Status-I1' => ut.bit_set(0,44),
															rules = 'NeustarWireless-Activity-Status-I2' => ut.bit_set(0,45),
															rules = 'NeustarWireless-Activity-Status-I3' => ut.bit_set(0,46),
															rules = 'NeustarWireless-Activity-Status-I4' => ut.bit_set(0,47),
															rules = 'NeustarWireless-Activity-Status-I5' => ut.bit_set(0,48),
															rules = 'NeustarWireless-Activity-Status-I6' => ut.bit_set(0,49),
															rules = 'NeustarWireless-Activity-Status-I7' => ut.bit_set(0,50),
															rules = 'NeustarWireless-Activity-Status-U' => ut.bit_set(0,51),
															rules = 'NeustarWireless-Prepaid-Y' => ut.bit_set(0,52),
															rules = 'NeustarWireless-Prepaid-N' => ut.bit_set(0,53),
															rules = 'NeustarWireless-Cord-Cutter-Y' => ut.bit_set(0,54),
															rules = 'NeustarWireless-Cord-Cutter-N' => ut.bit_set(0,55),
															//JIRA DF-24336 NeustarWireless End
															0b);
															
export	string	fGet_rules_caption_from_bitmap(unsigned bitmap_rules) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_rules)	:=	pValue & bitmap_rules = bitmap_rules;
		string		translated_value		:=	if(bitmap_rules = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Phone')),			' Active-EDA-Phone','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Record')),			' Active-EDA-Record','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Disconnected-EDA')),			' Disconnected-EDA','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub')),					' Non-pub','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Neustar')),				' Ported-Neustar','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Seen-Once')),					' Seen-Once','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('High-Vendor-Conf')),			' High-Vendor-Conf','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Low-Vendor-Conf')),			' Low-Vendor-Conf','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Cellphone-Latest')),			' Cellphone-Latest','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub-for-someone-else')),	' Non-pub-for-someone-else','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Targ-Non-pub' )),				' Targ-Non-pub','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Cell-Type')),			' Ported-Cell-Type','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Best-No-Active')),		' Ported-Best-No-Active','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Source-Latest')),				' Source-Latest','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Med-Vendor-Conf-Cell')),		' Med-Vendor-Conf-Cell','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Last-Resort-Cell')),			' Last-Resort-Cell','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Household')),					' Household','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Hdr-Household')),				' Hdr-Household','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Included-for-someone-else')),	' Included-for-someone-else','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Deceased')),	' Deceased','')		
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Gongh-Disconnect')),	' Gongh-Disconnect','')	
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Consortium-Disconnect')),	' Consortium-Disconnect','')	
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Consortium-RPC')),	' Consortium-RPC','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('IQ-Wrong-Party')),	' IQ-Wrong-Party','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('IQ-RPC')),	' IQ-RPC','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ins-Verified-Above')),	' Ins-Verified-Above','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ins-Verified-Below')),	' Ins-Verified-Below','')										
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('FileOne-Verified-Above')),	' FileOne-Verified-Above','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('FileOne-Verified-Below')),	' FileOne-Verified-Below','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('TelNet')),	' TelNet','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Neustar-Verified')),	' Neustar-Verified','')		//Bug 162654
										//JIRA DF-24336 NeustarWireless Start
										+  	 if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-A')), ' NeustarWireless-Verified-A','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-B')), ' NeustarWireless-Verified-B','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-C')), ' NeustarWireless-Verified-C','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-D')), ' NeustarWireless-Verified-D','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-E')), ' NeustarWireless-Verified-E','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A1')), ' NeustarWireless-Activity-Status-A1','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A2')), ' NeustarWireless-Activity-Status-A2','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A3')), ' NeustarWireless-Activity-Status-A3','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A4')), ' NeustarWireless-Activity-Status-A4','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A5')), ' NeustarWireless-Activity-Status-A5','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A6')), ' NeustarWireless-Activity-Status-A6','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A7')), ' NeustarWireless-Activity-Status-A7','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I1')), ' NeustarWireless-Activity-Status-I1','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I2')), ' NeustarWireless-Activity-Status-I2','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I3')), ' NeustarWireless-Activity-Status-I3','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I4')), ' NeustarWireless-Activity-Status-I4','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I5')), ' NeustarWireless-Activity-Status-I5','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I6')), ' NeustarWireless-Activity-Status-I6','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I7')), ' NeustarWireless-Activity-Status-I7','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-U')), ' NeustarWireless-Activity-Status-U','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Prepaid-Y')), ' NeustarWireless-Prepaid-Y','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Prepaid-N')), ' NeustarWireless-Prepaid-N','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Cord-Cutter-Y')), ' NeustarWireless-Cord-Cutter-Y','')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Cord-Cutter-N')), ' NeustarWireless-Cord-Cutter-N','')
										//JIRA DF-24336 NeustarWireless End
										);
return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ','/');
end;


															
export	string	fGet_rules_caption_as_bitmap(unsigned bitmap_rules) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_rules)	:=	pValue & bitmap_rules = bitmap_rules;
		string		translated_value		:=	if(bitmap_rules = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Phone')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Record')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Disconnected-EDA')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub')),					'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Neustar')),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Seen-Once')),					'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('High-Vendor-Conf')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Low-Vendor-Conf')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Cellphone-Latest')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub-for-someone-else')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Targ-Non-pub' )),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Cell-Type')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Best-No-Active')),		'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Source-Latest')),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Med-Vendor-Conf-Cell')),		'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Last-Resort-Cell')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Household')),					'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Hdr-Household')),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Included-for-someone-else')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Deceased')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Gongh-Disconnect')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Consortium-Disconnect')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Consortium-RPC')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('IQ-Wrong-Party')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('IQ-RPC')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ins-Verified-Above')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ins-Verified-Below')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('FileOne-Verified-Above')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('FileOne-Verified-Below')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('TelNet')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Neustar-Verified')),	'X','0')
										//JIRA DF-24336 NuestarWireless Start
									+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-A')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-B')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-C')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-D')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Verified-E')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A1')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A2')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A3')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A4')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A5')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A6')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-A7')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I1')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I2')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I3')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I4')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I5')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I6')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-I7')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Activity-Status-U')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Prepaid-Y')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Prepaid-N')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Cord-Cutter-Y')), 'X','0')
										+    if(fFlagIsOn(bitmap_rules, rules_bitmap_code('NeustarWireless-Cord-Cutter-N')), 'X','0')
										//JIRA DF-24336 NuestarWireless End
										);
return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ','');
end;


//-----Vendor/ source File name
export source_file(string vendor = '')   := map(vendor = mdr.sourceTools.src_Pcnsr  		=> 'PConsumer',
												vendor = mdr.sourceTools.src_Intrado		=> 'INTRADO-BNA',
												vendor = mdr.sourceTools.src_Targus_White_Pages		=> 'TargusWP',
												vendor = mdr.sourceTools.src_Gong_History		=> 'Gong History',
												vendor = mdr.sourceTools.src_InfutorCID		=> 'Infutor CID',
												//cellphone vendors
												vendor = mdr.sourceTools.src_Cellphones_Kroll		=> 'KROLL',
												vendor = mdr.sourceTools.src_Cellphones_Traffix		=> 'TRAFFIX',
												vendor = mdr.sourceTools.src_Cellphones_Nextones		=> 'NEXTONES',
												vendor =  mdr.sourceTools.src_Wired_Assets_Owned		=> 'Wired Assets Owned',
												vendor = mdr.sourceTools.src_Wired_Assets_Royalty		=> 'Wired Assets Royalty',
												vendor = mdr.sourceTools.src_InquiryAcclogs		=> 'Inquiry Tracking Logs',
												vendor = mdr.sourceTools.src_IBehavior		=> 'IBehavior',
												vendor = mdr.sourceTools.src_Thrive_LT		=> 'Thrive LT',
												vendor = mdr.sourceTools.src_Thrive_PD		=> 'Thrive PD',
												vendor = mdr.sourceTools.src_AlloyMedia_Consumer  => 'Alloy Media Consumer',
												vendor = mdr.sourceTools.src_Link2Tek  => 'Link2Tek',
												vendor = mdr.sourceTools.src_NeustarWireless  => 'Neustar Wireless Phones',
												'Header');

												
export fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;

export cellphone_types := ['CELL', 'LNDLN PRTD TO CELL'];												
end;