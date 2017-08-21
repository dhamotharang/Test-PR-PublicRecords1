import RoxieKeyBuild;

export Mac_Override_SK_Move(string filedate) 
:= function

NewFileCheck(string DatasetName)
 :=
  if(fileservices.getsuperfilesubname('~thor_data400::base::override::fcra::building::'+DatasetName,1)
							= fileservices.getsuperfilesubname('~thor_data400::base::override::fcra::built::'+DatasetName,1),
	false,true	
	)
 ;

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(													'~thor_data400::key::override::fcra::bankrupt_filing::@version@::ffid','~thor_data400::key::override::fcra::bankrupt_filing::'+filedate+'::ffid',
																						a);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::bankrupt_search::@version@::ffid','~thor_data400::key::override::fcra::bankrupt_search::'+filedate+'::ffid',
																						b);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(													'~thor_data400::key::override::fcra::bankrupt_filing::@version@::ffid_v3','~thor_data400::key::override::fcra::bankrupt_filing::'+filedate+'::ffid_v3',
																						c);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::bankrupt_search::@version@::ffid_v3','~thor_data400::key::override::fcra::bankrupt_search::'+filedate+'::ffid_v3',
																						d);

		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::criminal_offender::@version@::ffid','~thor_data400::key::override::fcra::criminal_offender::'+filedate+'::ffid',
																						e);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::criminal_offenses::@version@::ffid','~thor_data400::key::override::fcra::criminal_offenses::'+filedate+'::ffid',
																						f);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::criminal_punishment::@version@::ffid','~thor_data400::key::override::fcra::criminal_punishment::'+filedate+'::ffid',
																						g);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::flag::@version@::did','~thor_data400::key::override::fcra::flag::'+filedate+'::did',
																						h);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::flag::@version@::ssn','~thor_data400::key::override::fcra::flag::'+filedate+'::ssn',
																						i);		
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::liens::@version@::ffid','~thor_data400::key::override::fcra::liens::'+filedate+'::ffid',
																						l);

/*RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::vehicles::@version@::ffid','~thor_data400::key::override::fcra::vehicles::'+filedate+'::ffid',
																						m);
*/ 

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pcr::@version@::did','~thor_data400::key::override::fcra::pcr::'+filedate+'::did',
																						p);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pcr::@version@::ssn','~thor_data400::key::override::fcra::pcr::'+filedate+'::ssn',
																						q);
																						
// -- new nonfcra keys
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::pcr::@version@::did','~thor_data400::key::override::pcr::'+filedate+'::did',
																						p2);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::pcr::@version@::ssn','~thor_data400::key::override::pcr::'+filedate+'::ssn',
																						q2);																						

// ---------------------------------

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pcr::@version@::uid','~thor_data400::key::override::fcra::pcr::'+filedate+'::uid',
																						r);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::pii::@version@::ssn','~thor_data400::key::override::pii::'+filedate+'::ssn',
																						s);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::pii::@version@::did','~thor_data400::key::override::pii::'+filedate+'::did',
																						t);		

// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						// '~thor_data400::key::override::fcra::property_assessor::@version@::ffid','~thor_data400::key::override::fcra::property_assessor::'+filedate+'::ffid',
																						// u);
																						
// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						// '~thor_data400::key::override::fcra::property_deeds::@version@::ffid','~thor_data400::key::override::fcra::property_deeds::'+filedate+'::ffid',
																						// v);

// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						// '~thor_data400::key::override::fcra::ln_property::@version@::did.ownership','~thor_data400::key::override::fcra::ln_property::'+filedate+'::did.ownership',
																						// w);																						

// RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						// '~thor_data400::key::override::fcra::property_search::@version@::ffid','~thor_data400::key::override::fcra::property_search::' +filedate+ '::ffid',
																						// x);									

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::liensv2_main::@version@::ffid','~thor_data400::key::override::fcra::liensv2_main::'+filedate+'::ffid',
																						y);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::liensv2_party::@version@::ffid','~thor_data400::key::override::fcra::liensv2_party::'+filedate+'::ffid',
																						z);


/*RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::vehiclesv2_main::@version@::ffid','~thor_data400::key::override::fcra::vehiclesv2_main::'+filedate+'::ffid',
																						mm);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::vehiclesv2_party::@version@::ffid','~thor_data400::key::override::fcra::vehiclesv2_party::'+filedate+'::ffid',
																						nn);
*/ 
// New keys

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::aircraft::@version@::ffid','~thor_data400::key::override::fcra::aircraft::'+filedate+'::ffid',
																						oo);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::watercraft::@version@::ffid','~thor_data400::key::override::fcra::watercraft::'+filedate+'::ffid',
																						pp);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::watercraft::@version@::watercraft_sid','~thor_data400::key::override::fcra::watercraft::'+filedate+'::watercraft_sid',
																						ppsid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::watercraft::@version@::watercraft_cid','~thor_data400::key::override::fcra::watercraft::'+filedate+'::watercraft_cid',
																						ppcid);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::watercraft::@version@::watercraft_wid','~thor_data400::key::override::fcra::watercraft::'+filedate+'::watercraft_wid',
																						ppwid);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::proflic::@version@::ffid','~thor_data400::key::override::fcra::proflic::'+filedate+'::ffid',
																						qq);																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::student::@version@::ffid','~thor_data400::key::override::fcra::student::'+filedate+'::ffid',
																						rr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::avm::@version@::ffid','~thor_data400::key::override::fcra::avm::'+filedate+'::ffid',
																						ss);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::gong::@version@::ffid','~thor_data400::key::override::fcra::gong::'+filedate+'::ffid',
																						tt);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::impulse::@version@::ffid','~thor_data400::key::override::fcra::impulse::'+filedate+'::ffid',
																						imp1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::infutor::@version@::ffid','~thor_data400::key::override::fcra::infutor::'+filedate+'::ffid',
																						inf1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::header::@version@::did','~thor_data400::key::override::fcra::header::'+filedate+'::did',
																						head1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::advo::@version@::ffid','~thor_data400::key::override::fcra::advo::'+filedate+'::ffid',
																						advo1);	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::email_data::@version@::ffid','~thor_data400::key::override::fcra::email_data::'+filedate+'::ffid',
																						email1);	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::inquiries::@version@::ffid','~thor_data400::key::override::fcra::inquiries::'+filedate+'::ffid',
																						inquiries1);	

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::paw::@version@::ffid','~thor_data400::key::override::fcra::paw::'+filedate+'::ffid',
																						paw1);	

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::ln_propertyv2::@version@::did.ownershipv4','~thor_data400::key::override::fcra::ln_propertyv2::'+filedate+'::did.ownershipv4',
																						propv41);	
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::fcra::override::pii::@version@::ssn','~thor_data400::key::fcra::override::pii::'+filedate+'::ssn',
																						fcra_s);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::fcra::override::pii::@version@::did','~thor_data400::key::fcra::override::pii::'+filedate+'::did',
																						fcra_t);		

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::crim::@version@::offender','~thor_data400::key::override::fcra::crim::'+filedate+'::offender',
																						offkey);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::crim::@version@::courtoffenses','~thor_data400::key::override::fcra::crim::'+filedate+'::courtoffenses',
																						coffkey);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::crim::@version@::activity','~thor_data400::key::override::fcra::crim::'+filedate+'::activity',
																						actkey);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::ssn_table::@version@::ffid','~thor_data400::key::override::fcra::ssn_table::'+filedate+'::ffid',
																						ssntablekey);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::alloy::@version@::ffid','~thor_data400::key::override::fcra::alloy::'+filedate+'::ffid',
																						alloykey);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::student_new::@version@::ffid','~thor_data400::key::override::fcra::student_new::'+filedate+'::ffid',
																						snewkey);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::ibehavior_consumer::@version@::ffid','~thor_data400::key::override::fcra::ibehavior_consumer::'+filedate+'::ffid',
																						ibc);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::ibehavior_purchase::@version@::ffid','~thor_data400::key::override::fcra::ibehavior_purchase::'+filedate+'::ffid',
																						ibp);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::aircrafts::@version@::ffid','~thor_data400::key::override::fcra::aircrafts::'+filedate+'::ffid',
																						air);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::aircraft_details::@version@::ffid','~thor_data400::key::override::fcra::aircraft_details::'+filedate+'::ffid',
																						ad);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::aircraft_engine::@version@::ffid','~thor_data400::key::override::fcra::aircraft_engine::'+filedate+'::ffid',
																						ae);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pilot_registration::@version@::ffid','~thor_data400::key::override::fcra::pilot_registration::'+filedate+'::ffid',
																						pr);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pilot_certificate::@version@::ffid','~thor_data400::key::override::fcra::pilot_certificate::'+filedate+'::ffid',
																						pc);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::concealed_weapons::@version@::ffid','~thor_data400::key::override::fcra::concealed_weapons::'+filedate+'::ffid',
																						cw);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::hunting_fishing::@version@::ffid','~thor_data400::key::override::fcra::hunting_fishing::'+filedate+'::ffid',
																						hf);
																						
RoxieKeyBuild.Mac_SK_Move(																'~thor_data400::key::override::fcra::bankrupt_filing::@version@::ffid','Q',
																						a1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::bankrupt_search::@version@::ffid','Q',
																						b1);

RoxieKeyBuild.Mac_SK_Move(																'~thor_data400::key::override::fcra::bankrupt_filing::@version@::ffid_v3','Q',
																						c1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::bankrupt_search::@version@::ffid_v3','Q',
																						d1);
																					
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::criminal_offender::@version@::ffid','Q',
																						e1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::criminal_offenses::@version@::ffid','Q',
																						f1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::criminal_punishment::@version@::ffid','Q',
																						g1);

																					
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::flag::@version@::did','Q',
																						h1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::flag::@version@::ssn','Q',
																						i1);		
																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::liens::@version@::ffid','Q',
																						l1);

/*RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::vehicles::@version@::ffid','Q',
																						m1);
*/

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pcr::@version@::did','Q',
																						p1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pcr::@version@::ssn','Q',
																						q1);
// --- new nonfcra keys																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::pcr::@version@::did','Q',
																						p3);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::pcr::@version@::ssn','Q',
																						q3);

// -- new nonfcra keys
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pcr::@version@::uid','Q',
																						r1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::pii::@version@::ssn','Q',
																						s1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::pii::@version@::did','Q',
																						t1);
																						
// RoxieKeyBuild.Mac_SK_Move(
																						// '~thor_data400::key::override::fcra::property_assessor::@version@::ffid','Q',
																						// u1);
																						
// RoxieKeyBuild.Mac_SK_Move(
																						// '~thor_data400::key::override::fcra::property_deeds::@version@::ffid','Q',
																						// v1);

// RoxieKeyBuild.Mac_SK_Move(
																						// '~thor_data400::key::override::fcra::ln_property::@version@::did.ownership','Q',
																						// w1);																						

// RoxieKeyBuild.Mac_SK_Move(
																						// '~thor_data400::key::override::fcra::property_search::@version@::ffid','Q',
																						// x1);		

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::liensv2_main::@version@::ffid','Q',
																						y1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::liensv2_party::@version@::ffid','Q',
																						z1);



/*RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::vehiclesv2_main::@version@::ffid','Q',
																						y2);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::vehiclesv2_party::@version@::ffid','Q',
																						z2);
*/
// New Keys
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::aircraft::@version@::ffid','Q',
																						oo1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::watercraft::@version@::ffid','Q',
																						pp1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::watercraft::@version@::watercraft_sid','Q',
																						pp1sid);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::watercraft::@version@::watercraft_cid','Q',
																						pp1cid);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::watercraft::@version@::watercraft_wid','Q',
																						pp1wid);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::proflic::@version@::ffid','Q',
																						qq1);																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::student::@version@::ffid','Q',
																						rr1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::avm::@version@::ffid','Q',
																						ss1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::gong::@version@::ffid','Q',
																						tt1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::impulse::@version@::ffid','Q',
																						imp11);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::infutor::@version@::ffid','Q',
																						inf11);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::header::@version@::did','Q',
																						head11);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::advo::@version@::ffid','Q',
																						advo11);	
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::email_data::@version@::ffid','Q',
																						email11);	
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::inquiries::@version@::ffid','Q',
																						inquiries11);	

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::paw::@version@::ffid','Q',
																						paw11);	

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::ln_propertyv2::@version@::did.ownershipv4','Q',
																						propv411);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::fcra::override::pii::@version@::ssn','Q',
																						fcra_s1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::fcra::override::pii::@version@::did','Q',
																						fcra_t1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::crim::@version@::offender','Q',
																						offkey1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::crim::@version@::courtoffenses','Q',
																						coffkey1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::crim::@version@::activity','Q',
																						actkey1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::ssn_table::@version@::ffid','Q',
																						ssntablekey1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::alloy::@version@::ffid','Q',
																						alloykey1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::student_new::@version@::ffid','Q',
																						snewkey1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::ibehavior_consumer::@version@::ffid','Q',
																						ibc1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::ibehavior_purchase::@version@::ffid','Q',
																						ibp1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::aircrafts::@version@::ffid','Q',
																						air1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::aircraft_details::@version@::ffid','Q',
																						ad1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::aircraft_engine::@version@::ffid','Q',
																						ae1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pilot_registration::@version@::ffid','Q',
																						pr1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pilot_certificate::@version@::ffid','Q',
																						pc1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::concealed_weapons::@version@::ffid','Q',
																						cw1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::hunting_fishing::@version@::ffid','Q',
																						hf1);


MoveKeyToSK := sequential(
						//a,b,
						c,d,e,f,g,h,i,l,/*m,*/p,q,p2,q2,r,s,t,y,z,/*mm,nn,*/oo,pp,ppsid,ppcid,ppwid,qq,rr,ss,tt,imp1,inf1,head1,advo1,email1,inquiries1,paw1,propv41,fcra_s,fcra_t,
						offkey, coffkey, actkey,ssntablekey,alloykey,snewkey, ibc, ibp,air,ad,ae,pr,pc,
						//a1,b1,
						c1,d1,e1,f1,g1,h1,i1,l1,/*m1,*/p1,q1,p3,q3,r1,s1,t1,y1,z1,/*y2,z2,*/oo1,pp1,pp1cid,pp1sid,pp1wid,qq1,rr1,ss1,tt1,imp11,inf11,head11,
						advo11,email11,inquiries11,paw11,propv411,fcra_s1,fcra_t1,
						offkey1, coffkey1, actkey1,ssntablekey1,alloykey1,snewkey1,
						ibc1, ibp1,air1,ad1,ae1,pr1,pc1,cw,cw1,hf,hf1
						
						
						);


return MoveKeyToSK;

end;