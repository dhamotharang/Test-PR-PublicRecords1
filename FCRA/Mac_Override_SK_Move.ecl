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


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::override::fcra::bankrupt_filing::@version@::ffid','~thor_data400::key::override::fcra::bankrupt_filing::'+filedate+'::ffid',
																						a);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::bankrupt_search::@version@::ffid','~thor_data400::key::override::fcra::bankrupt_search::'+filedate+'::ffid',
																						b);

		
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::criminal_offender::@version@::ffid','~thor_data400::key::override::fcra::criminal_offender::'+filedate+'::ffid',
																						d);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::criminal_offenses::@version@::ffid','~thor_data400::key::override::fcra::criminal_offenses::'+filedate+'::ffid',
																						e);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::criminal_punishment::@version@::ffid','~thor_data400::key::override::fcra::criminal_punishment::'+filedate+'::ffid',
																						f);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::flag::@version@::did','~thor_data400::key::override::fcra::flag::'+filedate+'::did',
																						h);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::flag::@version@::ssn','~thor_data400::key::override::fcra::flag::'+filedate+'::ssn',
																						i);		
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::liens::@version@::ffid','~thor_data400::key::override::fcra::liens::'+filedate+'::ffid',
																						l);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::vehicles::@version@::ffid','~thor_data400::key::override::fcra::vehicles::'+filedate+'::ffid',
																						m);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pcr::@version@::did','~thor_data400::key::override::fcra::pcr::'+filedate+'::did',
																						p);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pcr::@version@::ssn','~thor_data400::key::override::fcra::pcr::'+filedate+'::ssn',
																						q);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::pcr::@version@::uid','~thor_data400::key::override::fcra::pcr::'+filedate+'::uid',
																						r);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::pii::@version@::ssn','~thor_data400::key::override::pii::'+filedate+'::ssn',
																						s);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::pii::@version@::did','~thor_data400::key::override::pii::'+filedate+'::did',
																						t);		

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::property_assessor::@version@::ffid','~thor_data400::key::override::fcra::property_assessor::'+filedate+'::ffid',
																						u);
																						
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::property_deeds::@version@::ffid','~thor_data400::key::override::fcra::property_deeds::'+filedate+'::ffid',
																						v);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::ln_property::@version@::did.ownership','~thor_data400::key::override::fcra::ln_property::'+filedate+'::did.ownership',
																						w);																						

RoxieKeyBuild.Mac_SK_Move_to_Built_v2(
																						'~thor_data400::key::override::fcra::property_search::@version@::ffid','~thor_data400::key::override::fcra::property_search::' +filedate+ '::ffid',
																						x);									




RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::override::fcra::bankrupt_filing::@version@::ffid','Q',
																						a1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::bankrupt_search::@version@::ffid','Q',
																						b1);

																					
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::criminal_offender::@version@::ffid','Q',
																						d1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::criminal_offenses::@version@::ffid','Q',
																						e1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::criminal_punishment::@version@::ffid','Q',
																						f1);

																					
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::flag::@version@::did','Q',
																						h1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::flag::@version@::ssn','Q',
																						i1);		
																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::liens::@version@::ffid','Q',
																						l1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::vehicles::@version@::ffid','Q',
																						m1);


RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pcr::@version@::did','Q',
																						p1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pcr::@version@::ssn','Q',
																						q1);
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::pcr::@version@::uid','Q',
																						r1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::pii::@version@::ssn','Q',
																						s1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::pii::@version@::did','Q',
																						t1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::property_assessor::@version@::ffid','Q',
																						u1);
																						
RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::property_deeds::@version@::ffid','Q',
																						v1);

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::ln_property::@version@::did.ownership','Q',
																						w1);																						

RoxieKeyBuild.Mac_SK_Move(
																						'~thor_data400::key::override::fcra::property_search::@version@::ffid','Q',
																						x1);		

MoveKeyToSK := sequential(
						if( (NewFileCheck('bankrupt_main') and NewFileCheck('bankrupt_search')),
						sequential(a,b,a1,b1),
						output('No bk key to move to built, QA')),
						if( (NewFileCheck('crim_offender') and NewFileCheck('crim_offenses') and NewFileCheck('crim_punishment')) ,
						sequential(d,e,f,d1,e1,f1),
						output('No crim key to move to built, QA')),
						if( NewFileCheck('flag'),
						sequential(h,i,h1,i1),
						output('No flag key to move to built, QA')),
						if( NewFileCheck('liens'),
						sequential(l,l1),
						output('No liens key to move to built, QA')),
						if( NewFileCheck('vehicles'),
						sequential(m,m1),
						output('No veh key to move to built, QA')),
						if( NewFileCheck('pcr'),
						sequential(p,q,r,s,t,p1,q1,r1,s1,t1),
						output('No pcr key to move to built, QA'))
						);


return MoveKeyToSK;

end;