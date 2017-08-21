import RoxieKeybuild;

export Proc_Build_New_FCRA_Override_Keys(string infiledate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_aircraft_ffid,
																						'~thor_data400::key::override::fcra::aircraft::qa::ffid','~thor_data400::key::override::fcra::aircraft::'+infiledate+'::ffid',
																						a,true);
																						
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_watercraft_ffid,
																						'~thor_data400::key::override::fcra::watercraft::qa::ffid','~thor_data400::key::override::fcra::watercraft::'+infiledate+'::ffid',
																						b,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_watercraft.sid,
																						'~thor_data400::key::override::fcra::watercraft::qa::watercraft_sid','~thor_data400::key::override::fcra::watercraft::'+infiledate+'::watercraft_sid',
																						bsid,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_watercraft.cid,
																						'~thor_data400::key::override::fcra::watercraft::qa::watercraft_cid','~thor_data400::key::override::fcra::watercraft::'+infiledate+'::watercraft_cid',
																						bcid,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_watercraft.wid,
																						'~thor_data400::key::override::fcra::watercraft::qa::watercraft_wid','~thor_data400::key::override::fcra::watercraft::'+infiledate+'::watercraft_wid',
																						bwid,true);

																			
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_proflic_ffid,
																						'~thor_data400::key::override::fcra::proflic::qa::ffid','~thor_data400::key::override::fcra::proflic::'+infiledate+'::ffid',
																						c,true);																						

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_student_ffid,
																						'~thor_data400::key::override::fcra::student::qa::ffid','~thor_data400::key::override::fcra::student::'+infiledate+'::ffid',
																						d,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.key_override_avm_ffid,
																						'~thor_data400::key::override::fcra::avm::qa::ffid','~thor_data400::key::override::fcra::avm::'+infiledate+'::ffid',
																						e,true);																						
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(fcra.Key_Override_Gong_FFID,
																						'~thor_data400::key::override::fcra::gong::qa::ffid','~thor_data400::key::override::fcra::gong::'+infiledate+'::ffid',
																						f,true);																						

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Impulse_FFID,
																						'~thor_data400::key::override::fcra::impulse::qa::ffid','~thor_data400::key::override::fcra::impulse::'+infiledate+'::ffid',
																						g,true);																						
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Infutor_FFID,
																						'~thor_data400::key::override::fcra::impulse::qa::ffid','~thor_data400::key::override::fcra::infutor::'+infiledate+'::ffid',
																						h,true);		
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Header_DID,
																						'~thor_data400::key::override::fcra::header::qa::did','~thor_data400::key::override::fcra::header::'+infiledate+'::did',
																						i,true);		
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_ADVO_ffid,
																						'~thor_data400::key::override::fcra::advo::qa::did','~thor_data400::key::override::fcra::advo::'+infiledate+'::ffid',
																						j,true);	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Email_Data_ffid,
																						'~thor_data400::key::override::fcra::email_data::qa::did','~thor_data400::key::override::fcra::email_data::'+infiledate+'::ffid',
																						k,true);	
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Inquiries_ffid,
																						'~thor_data400::key::override::fcra::inquiries::qa::did','~thor_data400::key::override::fcra::inquiries::'+infiledate+'::ffid',
																						l,true);	

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_PAW_ffid,
																						'~thor_data400::key::override::fcra::paw::qa::did','~thor_data400::key::override::fcra::paw::'+infiledate+'::ffid',
																						m,true);	

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Prop_Ownership_V4_FCRA,
																						'~thor_data400::key::override::fcra::ln_propertyv2::qa::did.ownershipv4','~thor_data400::key::override::fcra::ln_propertyv2::'+infiledate+'::did.ownershipv4',
																						n,true);	

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_crim.offenders,
																						'~thor_data400::key::override::fcra::crim::qa::offender','~thor_data400::key::override::fcra::crim::'+infiledate+'::offender',
																						o,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_crim.court_offenses,
																						'~thor_data400::key::override::fcra::crim::qa::courtoffenses','~thor_data400::key::override::fcra::crim::'+infiledate+'::courtoffenses',
																						p,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_crim.activity,
																						'~thor_data400::key::override::fcra::crim::qa::activity','~thor_data400::key::override::fcra::crim::'+infiledate+'::activity',
																						q,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_SSN_Table_FFID,
																						'~thor_data400::key::override::fcra::ssn_table::qa::ffid','~thor_data400::key::override::fcra::ssn_table::'+infiledate+'::ffid',
																						r,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Alloy_FFID,
																						'~thor_data400::key::override::fcra::alloy::qa::ffid','~thor_data400::key::override::fcra::alloy::'+infiledate+'::ffid',
																						s,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.Key_Override_Student_New_FFID,
																						'~thor_data400::key::override::fcra::student_new::qa::ffid','~thor_data400::key::override::fcra::student_new::'+infiledate+'::ffid',
																						t,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_ibehavior.consumer,
																						'~thor_data400::key::override::fcra::ibehavior_consumer::qa::ffid','~thor_data400::key::override::fcra::ibehavior_consumer::'+infiledate+'::ffid',
																						ibcb,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_ibehavior.purchase,
																						'~thor_data400::key::override::fcra::ibehavior_purchase::qa::ffid','~thor_data400::key::override::fcra::ibehavior_purchase::'+infiledate+'::ffid',
																						ibpb,true);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_faa.aircraft,
																						'~thor_data400::key::override::fcra::aircrafts::qa::ffid','~thor_data400::key::override::fcra::aircrafts::'+infiledate+'::ffid',
																						air,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_faa.aircraft_details,
																						'~thor_data400::key::override::fcra::aircraft_details::qa::ffid','~thor_data400::key::override::fcra::aircraft_details::'+infiledate+'::ffid',
																						ad,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_faa.aircraft_engine,
																						'~thor_data400::key::override::fcra::aircraft_engine::qa::ffid','~thor_data400::key::override::fcra::aircraft_engine::'+infiledate+'::ffid',
																						ae,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_faa.airmen_reg,
																						'~thor_data400::key::override::fcra::pilot_registration::qa::ffid','~thor_data400::key::override::fcra::pilot_registration::'+infiledate+'::ffid',
																						pr,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_faa.airmen_cert,
																						'~thor_data400::key::override::fcra::pilot_certificate::qa::ffid','~thor_data400::key::override::fcra::pilot_certificate::'+infiledate+'::ffid',
																						pc,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_ccw.concealed_weapons,
																						'~thor_data400::key::override::fcra::concealed_weapons::qa::ffid','~thor_data400::key::override::fcra::concealed_weapons::'+infiledate+'::ffid',
																						cw,true);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(FCRA.key_override_hunting_fishing.hunting_fishing,
																						'~thor_data400::key::override::fcra::hunting_fishing::qa::ffid','~thor_data400::key::override::fcra::hunting_fishing::'+infiledate+'::ffid',
																						hf,true);
return sequential(a,
										b,bsid,bcid,bwid,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,ibcb,ibpb,air,ad,ae,pr,pc,cw,
										hf);

end;