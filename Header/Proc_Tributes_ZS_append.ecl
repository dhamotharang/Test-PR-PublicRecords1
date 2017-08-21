IMPORT Header, infutor, ut,versioncontrol,_Control,did_add, Death_Master;

x:=fileservices.getsuperfilesubname('~thor_data400::in::ssa_deathm_raw',1);
filedate:=x[stringlib.stringfind(x, '20', 1)..];

Death_Master_did := Header.File_Did_Death_Master     ((unsigned6) did > 0,fname<>'',lname<>'');
SSA_wkly_raw     := Death_Master.File_SSADeathmaster(fname<>'',lname<>'');

rec_death_extract :=
	RECORD
		SSA_wkly_raw;
		string8   filedate;
		string1   LineFeed := '';
		string8   dod8_cln:='';
		unsigned6 did := 0;
	END;

SSA_wkly_raw_cln := PROJECT(SSA_wkly_raw
												,TRANSFORM(rec_death_extract
													,self.dod8_cln := ut.ConvertDate(stringlib.stringcleanspaces(left.dod8), '%m%d%Y','%Y%m%d')
													,self := left
													,self:=[]
													));

death_filtered_total := project(Death_Master_did
																		,TRANSFORM(rec_death_extract
																			,self.did:=(unsigned6)left.did
																			,self:=left
																			,self:=[]
																		));

death_filtered_dup := DEDUP(sort(distribute(death_filtered_total, hash(did))
																	,did, -filedate,-ssn,local),did,local);

rs_death_extract_DIDs := JOIN(distribute(SSA_wkly_raw_cln,hash(fname,lname,mname,ssn))
														 ,distribute(death_filtered_dup,hash(fname,lname,mname,ssn))
														 ,    left.ssn = right.ssn
															and left.lname = right.lname
															and left.fname = right.fname
															and left.mname = right.mname
															and left.name_suffix = right.name_suffix
															and left.dod8_cln = right.dod8
															 ,TRANSFORM(rec_death_extract-dod8_cln
																		,self.did := right.did
																		,self := left
																		,self := right
																		)
														 ,LEFT OUTER
														 ,local
														); 

consumer_filtered := infutor.infutor_header(src<>'WP',(unsigned)zip > 0);
consumer_dup := DEDUP(sort(consumer_filtered,did,-dt_last_seen,local),did,local);

ofile := JOIN(distribute(rs_death_extract_DIDs,hash(did)),consumer_dup
						 ,left.did = right.did
								,TRANSFORM({rec_death_extract-[did,filedate],string12 did}
								,self.st_country_code := case(right.st
																						,'AL' => '01'
																						,'AK' => '02'
																						,'AZ' => '03'
																						,'AR' => '04'
																						,'CA' => '05'
																						,'CO' => '06'
																						,'CT' => '07'
																						,'DE' => '08'
																						,'DC' => '09'
																						,'FL' => '10'
																						,'GA' => '11'
																						,'HI' => '12'
																						,'ID' => '13'
																						,'IL' => '14'
																						,'IN' => '15'
																						,'IA' => '16'
																						,'KS' => '17'
																						,'KY' => '18'
																						,'LA' => '19'
																						,'ME' => '20'
																						,'MD' => '21'
																						,'MA' => '22'
																						,'MI' => '23'
																						,'MN' => '24'
																						,'MS' => '25'
																						,'MO' => '26'
																						,'MT' => '27'
																						,'NE' => '28'
																						,'NV' => '29'
																						,'NH' => '30'
																						,'NJ' => '31'
																						,'NM' => '32'
																						,'NY' => '33'
																						,'NC' => '34'
																						,'ND' => '35'
																						,'OH' => '36'
																						,'OK' => '37'
																						,'OR' => '38'
																						,'PA' => '39'
																						,'PR' => '40'
																						,'RI' => '41'
																						,'SC' => '42'
																						,'SD' => '43'
																						,'TN' => '44'
																						,'TX' => '45'
																						,'UT' => '46'
																						,'VT' => '47'
																						,'VI' => '48'
																						,'VA' => '49'
																						,'WA' => '50'
																						,'WV' => '51'
																						,'WI' => '52'
																						,'WY' => '53'
																						,'AFRICA' => '54'
																						,'ASIA' => '55'
																						,'CANADA' => '56'
																						,'CENTRAL AMERICA & WEST INDIES' => '57'
																						,'EUROPE' => '58'
																						,'MX' => '59'
																						,'OCEANIA' => '60'
																						,'PHILIPINNES' => '61'
																						,'SOUTH AMERICA' => '62'
																						,'US ADMINISTRATION' => '63'
																						,'AS' => '64'
																						,'GU' => '65'
																						, ''
																						)
								,self.zip_lastres := right.zip
								,self.did := if(left.did>0,intformat(left.did,12,1),'')
								,self := left
								,self := right)
						 ,LEFT OUTER
						 ,local
						):persist('~thor_data400::persist::weekly_ssa_death_tributes'); 

p:=project(ofile,{SSA_wkly_raw});

ut.MAC_SF_BuildProcess(p,'~thor_data400::out::weekly_ssa_death_tributes',doIt,pcompress:=true,pVersion:=filedate);

d1:=doIt;
d2:=output(table(ofile,{rec_type,cnt:=count(group)},rec_type), named('count_rs_death_extract_all_rec_types'));
d3:=output(count(ofile((unsigned8) did > 0)), named('count_rs_death_extract_has_a_DID'));
d4:=output(count(ofile(zip_lastres <> '')), named('count_rs_death_extract_has_a_zip'));
d5:=output(sort(ofile((unsigned8) did = 0), ssn), named('sample_rs_death_extract_No_DID'));

///////////////////////////////////////////////////////////////////////////////

string pDestinationpath	:=	'/hds_2/Tributes/';
string pDestinationIP		:=	_Control.IPAddress.edata12;

Destinationpath	:=	pDestinationpath;

myfilestodespray:=dataset(	[
						{'~thor_data400::out::weekly_ssa_death_tributes',pDestinationIP,Destinationpath+'weekly_ssa_death_tributes_'+filedate}
						],	versioncontrol.Layout_DKCs.Input);

d6:=versioncontrol.fDesprayFiles(myfilestodespray,,,'DesprayListInfo',true);

///////////////////////////////////////////////////////////////////////////////

ProdVer:=did_add.get_EnvVariable('DeathMaster_Build_Version');
output(ProdVer,named('Deathmaster'));
fn:='~thor_data400::out::weekly_ssa_death_tributes_flag';
flg:=dataset(fn,{string8 Prod_Ver},flat,opt);

IsNewVer := if(fileservices.fileExists(fn),ProdVer <> flg[1].Prod_Ver, true);

NewVer:=dataset([{ProdVer}],{string8 Prod_Ver});

buildIt:= if(IsNewVer
							,sequential(
													output('IsNewVer=true; creating new append')
													,d1,d2,d3,d4,d5,d6
													,output(NewVer,,'~thor_data400::out::weekly_ssa_death_tributes_flag',overwrite,compressed)
													,fileservices.sendemail(
													//'jose.bello@lexisnexis.com,michael.gould@lexisnexis.com',
													'jose.bello@lexisnexis.com,datareceiving@lexisnexis.com,engineering@tributes.com,michael.gould@lexisnexis.com',
													'Weekly Tributes SSA Death zip and state append',
													'Weekly Tributes SSA Death zip and state append '
													+ filedate + ' is ready for pickup at transfer.seisint.com -> outgoing\n\n'
													+ 'it contains ' + count(p) + ' records'
													);

													)
							,output('IsNewVer=false; nothing done')
					)
;

EXPORT Proc_Tributes_ZS_append := buildIt;