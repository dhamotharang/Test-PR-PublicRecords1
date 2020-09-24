import ut, FCRA, Doxie, RoxieKeyBuild,_Control, AVM_V2, header, data_Services, STD;
EXPORT reDID(string filedate, boolean runondev = false ) := module

	export ReDID_Wrapper(filetype
											,environment
											,baselayout
											,didfield
											,sortfield
											,usedatalandfiles = 'false'
											,getretval
											,replacerecords = 'true'
											,isxml = 'false') := macro
		
		#uniquename(basefilename)
		%basefilename% := if (_Control.ThisEnvironment.Name = 'Prod_Thor'
														,Overrides.getfilename(filetype,environment).basefile
														,if (usedatalandfiles
																,Overrides.getfilename(filetype,environment).basefile
																,regexreplace('~',Overrides.getfilename(filetype,environment).basefile,Data_Services.foreign_prod)
																)
														);
														
		// add filename
		#uniquename(recordwithvirtual)
		%recordwithvirtual% := record
			baselayout;
			//string255  OriginalFileName{virtual(LogicalFileName)};
		end;

	
		#uniquename(l_dataset)
		%l_dataset% := if (~isxml
											,dataset(regexreplace('@version@',%basefilename%,'qa'),%recordwithvirtual%,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt)
											,dataset(regexreplace('@version@',%basefilename%,'qa'),%recordwithvirtual%,xml(trim(Overrides.dictXMLTags(filetype).headtag)+'/'+trim(Overrides.dictXMLTags(filetype).rowtag)),opt)
											);
										
		
		#uniquename(recordwithphysical)
		%recordwithphysical% := record
			baselayout;
			unsigned6 olddid := 0;
			unsigned6 newdid := 0;
			boolean ischanged := false;
			string255  OriginalFileName := '';
		end;
	
		#uniquename(withfilename)
		%recordwithphysical% %withfilename%(%l_dataset% L) := transform
			self.olddid := (unsigned6)l.didfield;
			self := L;
		end;

		#uniquename(dwithfilename)
		%dwithfilename% := project(%l_dataset%, %withfilename%(left));
		
		#uniquename(redidretval)
		header.Mac_ReDID(%dwithfilename%,didfield,%redidretval%);
		
		#uniquename(persistfile) // to capture what changed
		%persistfile% := %redidretval% : persist('~persist::overrides::'+filetype+'_'+environment+'::redid', expire(100));
		
		#uniquename(replacexform) // replace records
		%recordwithphysical% %replacexform%(%dwithfilename% l, %persistfile% r) := transform
			//self.didfield := if ((string)r.didfield <> '',  r.didfield, l.didfield);
			self := l;
		end;

		#uniquename(dreplaced)
		%dreplaced% := join(
													%dwithfilename%
													,%persistfile%
													,left.olddid = right.olddid and left.sortfield = right.sortfield
													,%replacexform%(left,right)
													,left only
													,lookup
													);
		
		#uniquename(fulldataset) // replace records with did change for all non-flag files
		%fulldataset% := dedup(sort(distribute(if (~replacerecords
														,%dwithfilename% 
														,%dreplaced%) + %persistfile%),record, local),record, local) : independent;
		
		#uniquename(mvretval)
		RoxieKeybuild.Mac_SK_Move_V3(
								Overrides.getfilename(filetype,environment).basefile //keyname
								,'D'
								,%mvretval%
								,filedate
								,2);
		
		// revert back to original layout
		
		#uniquename(converttooriginal)
		baselayout %converttooriginal%(%fulldataset% l) := transform
			self := l;
		end;
		
		#uniquename(tooriginal) 
		%tooriginal% := dedup(sort(project(%fulldataset%,%converttooriginal%(left),local),record, local),record, local);
		
		#uniquename(mvretvalwithfilename)
		RoxieKeybuild.Mac_SK_Move_V3(
								Overrides.getfilename(filetype,environment).basefile + '_withfilename' //keyname
								,'D'
								,%mvretvalwithfilename%
								,filedate
								,2);
		
		getretval := if ( ~fileservices.fileexists
																			(regexreplace('@version@',Overrides.getfilename(filetype,environment).basefile,filedate)),
															sequential
																(
																	output(count(%l_dataset%),named(filetype+'_old_count'))
																	,if (~isxml
																			,sequential(
																				output(%tooriginal%,,regexreplace('@version@',Overrides.getfilename(filetype,environment).basefile,filedate),csv(separator('\t'),quote('\"'),terminator('\r\n')),overwrite)
																				//,output(%fulldataset%,,regexreplace('@version@',Overrides.getfilename(filetype,environment).basefile+'_withfilename',filedate),csv(separator('\t'),quote('\"'),terminator('\r\n')),overwrite)
																				)
																			,sequential(
																				output(%tooriginal%,,regexreplace('@version@',Overrides.getfilename(filetype,environment).basefile,filedate),XML(trim(Overrides.dictXMLTags(filetype).rowtag),heading('<'+trim(Overrides.dictXMLTags(filetype).headtag)+'>','</'+trim(Overrides.dictXMLTags(filetype).headtag)+'>')),overwrite)
																				//,output(%fulldataset%,,regexreplace('@version@',Overrides.getfilename(filetype,environment).basefile+'_withfilename',filedate),XML(trim(Overrides.dictXMLTags(filetype).rowtag),heading('<'+trim(Overrides.dictXMLTags(filetype).headtag)+'>','</'+trim(Overrides.dictXMLTags(filetype).headtag)+'>')),overwrite)
																				)
																		)
																	,%mvretval%
																/*	,%mvretvalwithfilename%*/
																	,output(count(%tooriginal%),named(filetype+'_new_count'))
																	),
															output(regexreplace('@version@',Overrides.getfilename(filetype,environment).basefile,filedate) + ' exists, no action taken')
															);
		
		
	endmacro;
	
	export roxieip := if (_Control.ThisEnvironment.Name = 'Prod_Thor',
														_Control.RoxieEnv.prodvip,		
														_Control.RoxieEnv.staging_neutral_roxieIP);
	
	export isNewHeader := if (_Control.ThisEnvironment.Name = 'Prod_Thor' or runondev,
													Header.IsNewProdHeaderVersion('overrides',,roxieip),
													false);

	export postprocess := function
			return sequential(
												header.PostDID_HeaderVer_Update('overrides',,roxieip),
												fileservices.RemoveOwnedSubfiles('~thor_data400::key::rid_did2_qa_foroverride', true)
												,STD.File.ClearSuperFile('~thor_data400::key::rid_did2_qa_foroverride')
													);
	end;

	export getnew() := function
	
		ReDID_Wrapper('flag','fcra',FCRA.Layout_Override_Flag_In,did,flag_file_id,,flagredid,false);
		ReDID_Wrapper('header','fcra',FCRA.Layout_Override_Header_In, head.did, head.persistent_record_ID,,headerredid);
		ReDID_Wrapper('pcr','fcra',FCRA.Layout_Override_PCR_In,did,uid,,pcrredid);
		ReDID_Wrapper('bankrupt_main','fcra',FCRA.layout_main_ffid_v3,did,flag_file_id,,bankrupt_mainredid,isxml := true);
		ReDID_Wrapper('bankrupt_search','fcra',FCRA.layout_search_ffid_v3,did,flag_file_id,,bankrupt_searchredid,isxml := true);
		ReDID_Wrapper('crim_offender','fcra',fcra.layout_override_crim_offender,did,flag_file_id,,crim_offenderredid);
		ReDID_Wrapper('offenders','fcra',fcra.key_override_crim.offenders_rec,did,flag_file_id,,offendersredid);
		ReDID_Wrapper('offenders_plus','fcra',fcra.key_override_crim.offenders_rec,did,flag_file_id,,offenders_plusredid);
		ReDID_Wrapper('liensv2_party','fcra',FCRA.Layout_Override_Liens_Party_In,did,flag_file_id,,liensv2_partyredid,isxml := true);
		ReDID_Wrapper('aircraft','fcra',fcra.layout_override_aircraft,did_out,flag_file_id,,aircraftredid);
		ReDID_Wrapper('watercraft','fcra',fcra.key_override_watercraft.sid_rec,did,flag_file_id,,watercraftredid);
		//CCPA-1042 - Add CCPA fields to Override ProfLic key, but not to input file yet
		ReDID_Wrapper('proflic','fcra',fcra.layout_override_proflic_in,did,flag_file_id,,proflicredid);
		ReDID_Wrapper('american_student','fcra',fcra.Layout_Override_Student_In,did,flag_file_id,,american_studentredid);
		ReDID_Wrapper('gong','fcra',fcra.Layout_Override_Gong_In,l_did,flag_file_id,,gongredid);
		ReDID_Wrapper('impulse','fcra',fcra.Layout_Override_impulse_In,did,flag_file_id,,impulseredid);
		ReDID_Wrapper('infutor','fcra',fcra.Layout_Override_Infutor,did,flag_file_id,,infutorredid);
		//CCPA-1044 - Add CCPA fields to Override Email Data key, but not to input file yet
		ReDID_Wrapper('email_data','fcra',FCRA.Layout_Override_Email_Data_In,did,flag_file_id,,email_dataredid);
		//CCPA-1048 - Add CCPA fields to Override Inquires key, but not to input file yet
		ReDID_Wrapper('Inquiries','fcra',FCRA.Layout_Override_Inquiries_In,Person_Q.Appended_ADL ,flag_file_id,,Inquiriesredid);
		//CCPA-1052 - Add CCPA fields to Override PAW key, but not to input file yet
		ReDID_Wrapper('paw','fcra',FCRA.Layout_Override_PAW_In,did,flag_file_id,,pawredid);
		ReDID_Wrapper('ssn_table','fcra',FCRA.Layout_Override_SSN_Table,combo.bestdid,flag_file_id,,ssn_tableredid);
		ReDID_Wrapper('alloy','fcra',FCRA.Layout_Override_Alloy_In,did,flag_file_id,,alloyredid);
		ReDID_Wrapper('american_student_new','fcra',FCRA.Layout_Override_Student_New_In,did,flag_file_id,,american_student_newredid);
		ReDID_Wrapper('ibehavior_consumer','fcra',FCRA.key_override_ibehavior.consumer_rec,did,flag_file_id,,ibehaviorredid);
		///////ReDID_Wrapper('aircraft','fcra',FCRA.key_override_faa.aircraft_rec,did_out ,,aircraftredid);
		ReDID_Wrapper('pilot_registration','fcra',FCRA.key_override_faa.airmen_rec,did_out ,flag_file_id,,pilotregredid);
		ReDID_Wrapper('concealed_weapons','fcra',FCRA.key_override_ccw.ccw_rec,did_out ,flag_file_id,,cwredid);
		ReDID_Wrapper('hunting_fishing','fcra',FCRA.key_override_hunting_fishing.hunt_rec,did_out ,flag_file_id,,hfredid);
		ReDID_Wrapper('atf','fcra',FCRA.key_override_atf.atf_rec,did_out ,flag_file_id,,atfredid);
		ReDID_Wrapper('marriage_search','fcra',FCRA.key_override_marriage.marriage_search_rec,did,flag_file_id,,msredid);
		ReDID_Wrapper('so_main','fcra',FCRA.key_override_sexoffender.SOff_rec,did,flag_file_id,,smredid);
		ReDID_Wrapper('property_search','fcra',FCRA.Key_Override_Property.search_override_layout,did,flag_file_id,,propertyredid);
		ReDID_Wrapper('ucc_party','fcra',FCRA.key_override_ucc.party_rec,did,flag_file_id,,uccpartyredid);
		ReDID_Wrapper('consumerstatement_lexid','fcra',FCRA.Layout_Override_CnsmrStmt_In,lexid ,ssn,,cslexidredid);
		ReDID_Wrapper('consumerstatement_ssn','fcra',FCRA.Layout_Override_CnsmrStmt_In,lexid ,ssn,,csssnredid);
		// 
		// ReDID_Wrapper('proflic_mari','fcra',FCRA.Key_Override_Proflic_Mari_ffid.Layout_Override_Proflic_Mari,did,flag_file_id,,mariredid);
		ReDID_Wrapper('proflic_mari','fcra',FCRA.Key_Override_Proflic_Mari_ffid.Layout_Override_Proflic_Mari,did,flag_file_id,,mariredid);
		ReDID_Wrapper('thrive','fcra',FCRA.Layout_Override_thrive,did,flag_file_id,,thriveredid);	
		ReDID_Wrapper('address_data','fcra',AVM_V2.layouts.Layout_Override_AVM_Address,did,flag_file_id,,addressdataredid);	
		ReDID_Wrapper('did_death','fcra',FCRA.key_override_death_master.Death_rec,did,flag_file_id,,deathredid);
	
		return	if (isNewHeader,
							sequential
								(
								if (~fileservices.superfileexists('~thor_data400::key::rid_did2_qa_foroverride'),
										fileservices.createsuperfile('~thor_data400::key::rid_did2_qa_foroverride')),
								if (fileservices.superfileexists('~thor_data400::key::rid_did2_qa'),
									if (fileservices.getsuperfilesubname('~thor_data400::key::rid_did2_qa_foroverride',1) = fileservices.getsuperfilesubname('~thor_data400::key::rid_did2_qa',1)
										,output('~thor_data400::key::rid_did2_qa_foroverride is current')
										,fileservices.addsuperfile('~thor_data400::key::rid_did2_qa_foroverride','~thor_data400::key::rid_did2_qa',,true)
											)
										),
								parallel(
										flagredid
										,pcrredid 
										,headerredid
										,bankrupt_mainredid
										,bankrupt_searchredid
										,crim_offenderredid
										,offendersredid
										,offenders_plusredid
										,liensv2_partyredid
										,aircraftredid
										,watercraftredid
										,proflicredid
										,american_studentredid
										,gongredid
										,impulseredid
										,infutorredid
										,email_dataredid
										,Inquiriesredid
										,pawredid
										,ssn_tableredid
										,alloyredid
										,american_student_newredid
										,ibehaviorredid
										//,aircraftredid
										,pilotregredid
										,cwredid
										,hfredid
										,atfredid
										,msredid
										,smredid
										,propertyredid
										,uccpartyredid
										,cslexidredid
										,csssnredid
										,mariredid
										,thriveredid
										,addressdataredid
										,deathredid
										),
										postprocess
									),
								output('No re-did')
						);
 
	end;

end;