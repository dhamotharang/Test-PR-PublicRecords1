 import	_control;

export Proc_Build_ECRulings_Keys(string pIndexVersion) := function

rKeyECRulings__autokey__nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeyECRulings__autokey__payload := RECORD
  unsigned6 fakeid;
  string dartid;
  string dateadded;
  string dateupdated;
  string website;
  string state;
  string euid;
  string policyarea;
  string casenumber;
  string memberstate;
  string lastdecisiondate;
  string title;
  string businessname;
  string region;
  string primaryobjective;
  string aidinstrument;
  string casetype;
  string durationdatefrom;
  string durationdateto;
  string notificationregistrationdate;
  string dgresponsible;
  string relatedcasenumber1;
  string relatedcaseinformation1;
  string relatedcasenumber2;
  string relatedcaseinformation2;
  string relatedcasenumber3;
  string relatedcaseinformation3;
  string relatedcasenumber4;
  string relatedcaseinformation4;
  string relatedcasenumber5;
  string relatedcaseinformation5;
  string provisionaldeadlinedate;
  string provisionaldeadlinearticle;
  string provisionaldeadlinestatus;
  string regulation;
  string relatedlink;
  string decpubid;
  string decisiondate;
  string decisionarticle;
  string decisiondetails;
  string pressrelease;
  string pressreleasedate;
  string publicationjournaldate;
  string publicationjournal;
  string publicationjournaledition;
  string publicationjournalyear;
  string publicationpriorjournal;
  string publicationpriorjournaldate;
  string econactid;
  string economicactivity;
  string compeventid;
  string eventdate;
  string eventdoctype;
  string eventdocument;
  unsigned6 did;
  unsigned6 bdid;
  string dt_vendor_first_reported;
  string dt_vendor_last_reported;
  string dt_first_seen;
  string dt_last_seen;
  string eu_country_code;
  unsigned8 __internal_fpos__;
 END;

 
rKeyECRulings__autokey__namewords2 :=RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
 rKeyECRulings__autokey__stnameb2 :=RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
 rKeyECRulings__autokey__addressb2 := RECORD
  string28 prim_name;
  string10 prim_range;
  string2 st;
  unsigned4 city_code;
  string5 zip;
  string8 sec_range;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
 rKeyECRulings__autokey__citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
END;

 rKeyECRulings__autokey__zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

								ds_nameb2					:=dataset([],rKeyECRulings__autokey__nameb2); 
                ds_payload				:=dataset([],rKeyECRulings__autokey__payload);
                ds_namewords2			:=dataset([],rKeyECRulings__autokey__namewords2);	
                ds_stnameb2				:=dataset([],rKeyECRulings__autokey__stnameb2);
								ds_addressb2			:=dataset([],rKeyECRulings__autokey__addressb2);
                ds_citystnameb2		:=dataset([],rKeyECRulings__autokey__citystnameb2);	
                ds_zipb2					:=dataset([],rKeyECRulings__autokey__zipb2);
								
								
								nameb2_IN				  :=index(ds_nameb2, {cname_indic,cname_sec,bdid}, {ds_nameb2}, '~prte::key::ECRulings::'+pIndexVersion+'::autokey::nameb2');
								namewords2_IN			:=index(ds_namewords2, {word,state,seq,bdid}, {ds_namewords2}, '~prte::key::ECRulings::'+pIndexVersion+'::autokey::namewords2');
								payload_IN				:=index(ds_payload, {fakeid}, {ds_payload}, '~prte::key::ECRulings::'+pIndexVersion+'::autokey::payload');
								stnameb2_IN				:=index(ds_stnameb2,{st,cname_indic,cname_sec,bdid}, {ds_stnameb2}, '~prte::key::ecrulings::'+pIndexVersion+'::autokey::stnameb2');
								addressb2_IN			:=index(ds_addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {ds_addressb2}, '~prte::key::ecrulings::'+pIndexVersion+'::autokey::addressb2');
								citystnameb2_IN		:=index(ds_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {ds_citystnameb2}, '~prte::key::ecrulings::'+pIndexVersion+'::autokey::citystnameb2');
								zipb2_IN					:=index(ds_zipb2, {zip,cname_indic,cname_sec,bdid}, {ds_zipb2}, '~prte::key::ecrulings::'+pIndexVersion+'::autokey::zipb2');
								
			
															 
return	sequential(
													parallel(	build(nameb2_IN	, update),																
                                    build(payload_IN			, update),
                                    build(namewords2_IN, update),
                                    build(stnameb2_IN, update),
																		build(addressb2_IN	, update),
                                    build(citystnameb2_IN, update),
                                    build(zipb2_IN, update)
															 ),
								
											PRTE.UpdateVersion('ECRulingsKeys',											//	Package name
																					pIndexVersion,											//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																	      )
										 );

end;
