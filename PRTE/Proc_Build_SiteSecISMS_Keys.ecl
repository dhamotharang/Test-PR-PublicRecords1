import	_control;

export Proc_Build_SiteSecISMS_Keys(string pIndexVersion) := function

rKeySiteSec__autokey__addressb2 := RECORD
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

rKeySiteSec__autokey__citystnameb2 := RECORD
  unsigned4 city_code;
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeySiteSec__autokey__nameb2 := RECORD
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeySiteSec__autokey__namewords2 := RECORD
  string40 word;
  string2 state;
  unsigned1 seq;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeySiteSec__autokey__payload := RECORD
  unsigned6 fakeid;
  unsigned8 date_firstseen;
  unsigned8 date_lastseen;
  string70 certificationbodydescrip;
  string6 dartid;
  unsigned8 dateadded;
  unsigned8 dateupdated;
  string40 website;
  string4 state;
  string250 businessname;
  string250 businesslocation;
  string150 businessdba;
  string40 country;
  string70 certificatenumber;
  string70 certificationbody;
  string20 certificationtype;
  unsigned6 did;
  unsigned6 bdid;
  unsigned6 zero;
 END;
 
rKeySiteSec__autokey__stnameb2:= RECORD
  string2 st;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;

rKeySiteSec__autokey__zipb2 := RECORD
  integer4 zip;
  string40 cname_indic;
  string40 cname_sec;
  unsigned6 bdid;
  unsigned4 lookups;
 END;
 
ds_addressb2		:=dataset([],rKeySiteSec__autokey__addressb2);
ds_citystnameb2	:=dataset([],rKeySiteSec__autokey__citystnameb2);
ds_nameb2				:=dataset([],rKeySiteSec__autokey__nameb2);
ds_namewords2		:=dataset([],rKeySiteSec__autokey__namewords2);
ds_payload			:=dataset([],rKeySiteSec__autokey__payload);
ds_stnameb2 		:=dataset([],rKeySiteSec__autokey__stnameb2);
ds_zipb2				:=dataset([],rKeySiteSec__autokey__zipb2);

addressb2_IN		:=index(ds_addressb2,		 {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid},
											 {ds_addressb2},   '~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::addressb2');
citystnameb2_IN	:=index(ds_citystnameb2, {city_code,st,cname_indic,cname_sec,bdid},
											 {ds_citystnameb2},'~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::citystnameb2');											 
nameb2_IN				:=index(ds_nameb2, 		   {cname_indic,cname_sec,bdid},
											 {ds_nameb2}, 	   '~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::nameb2');
namewords2_IN		:=index(ds_namewords2, 	 {word,state,seq,bdid},
											 {ds_namewords2},  '~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::namewords2');
payload_IN			:=index(ds_payload,      {fakeid},
											 {ds_payload},     '~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::payload');
stnameb2_IN			:=index(ds_stnameb2,     {st,cname_indic,cname_sec,bdid},
											 {ds_stnameb2},    '~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::stnameb2');											 
zipb2_IN				:=index(ds_zipb2, 		   {zip,cname_indic,cname_sec,bdid}, 
											 {ds_zipb2}, 			 '~prte::key::SiteSec_ISMS::'+pIndexVersion+'::autokey::zipb2');											 														 
return	sequential(
										parallel(												
																build(addressb2_IN, update),
																build(citystnameb2_IN, update),
																build(nameb2_IN	, update),
																build(namewords2_IN, update),
																build(payload_IN, update),
																build(stnameb2_IN, update),	
																build(zipb2_IN, update)
															 ),
								
								PRTE.UpdateVersion('SiteSecISMSKeys',				    //	Package name
																pIndexVersion,											//	Package version
																_control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																 'B',																//	B = Boca, A = Alpharetta
																 'N',																//	N = Non-FCRA, F = FCRA
																 'N'																//	N = Do not also include boolean, Y = Include boolean, too
																	)
										 );
end;
