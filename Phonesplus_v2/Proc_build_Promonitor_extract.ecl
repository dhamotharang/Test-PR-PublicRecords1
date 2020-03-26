import phonesplus,_control,ut,watchdog, mdr;

/*

 1) Extract the current Phonesplus records
 2) Append the DOB and SSN from watchdog - filebest
 3) Create a file and store it in thor
 4) Create a delta using the previous file and current file. 
 5) Despray the (new records and updated records) to be sent to Promonitor.
 
*/

DestinationIP         := _control.IPAddress.bctlpedata11; 
string v_process_date := ut.GetDate[1..8];
// string v_process_date := '20111204';

//thor_data400::base::phonesplusv2_20100809
//thor_data400::base::phonesplusv2_20100816
phones_plus_file    := dataset(PhonesPlus_V2.Names.phonesplusv2_base, phonesplus_v2.Layout_Phonesplus_Base, thor);
 // phones_plus_file    := dataset(ut.foreign_prod+ '~thor_data400::base::phonesplusv2_20111128', phonesplus_v2.Layout_Phonesplus_Base, thor);
//phones_plus_file    := dataset(ut.foreign_prod+ '~thor_data400::base::phonesplusv2_20111204', phonesplus_v2.Layout_Phonesplus_Base, thor);

date1 := MAP(v_process_date[5..6] ='01' => (string)((integer)v_process_date[1..4]-1 )+ '12',
             v_process_date[1..4] + INTFORMAT(((integer)v_process_date[5..6] -1),2,1)
						 );
date2 := MAP(v_process_date[5..6] ='01' => (string)((integer)v_process_date[1..4]-1 )+ '11',
             v_process_date[5..6] ='02' => (string)((integer)v_process_date[1..4]-1 )+ '12',
             v_process_date[1..4] + INTFORMAT(((integer)v_process_date[5..6] -2),2,1)
						 );								 

ds_phonesplus := distribute(phones_plus_file( did <> 0 and current_rec =true and 
                                              (datefirstseen = (integer)v_process_date[1..6] or 
																						   datefirstseen = (integer)date1 or 
													                     datefirstseen = (integer)date2
																						  ) and                          
												                      datefirstseen = datevendorfirstreported and 
																							Translation_Codes.fFlagIsOn(src_all,Translation_Codes.source_bitmap_code(mdr.sourceTools.src_gong_history)) =false
																						) ,HASH((INTEGER)did)
													 ); 

PhonePlus_Promonitor_rec := RECORD, MAXLENGTH(4096)
    string50   EXTERNAL_ID;
	  String9	   SSN;
    string2    DOB_MONTH;
    string2    DOB_DAY;
		string4    DOB_YEAR;
		string50   FIRST_NAME;
		string50   MIDDLE_NAME;
		string50   LAST_NAME;
		string50   STREET_1;
		string50   STREET_2;
		string50   STREET_3;
		string50   CITY;
		string2    STATE;
		string5    POSTAL_CODE;
		String1    COUNTRY;
		string11   ACCOUNT_ID;
		string20   USERNAME;
		string1    OPERATION_TYPE;
		string50   REFERENCE_ID;
		string50   DL_NUM;
		string2    DL_STATE;
		string3    CELL_PHONE_AREA_CODE;
		string7    CELL_PHONE_NUMBER;
		string3    WORK_PHONE_AREA_CODE;
		string7    WORK_PHONE_NUMBER;
		string3    HOME_PHONE_AREA_CODE;
		string7    HOME_PHONE_NUMBER;
		unsigned8  LINK_ID;
		string10   FAX_DATA;
		string10   PAGER;
		string10   OTHER;

 end;

 Temp_rec := record
    PhonePlus_Promonitor_rec;
		string process_date := '';
 		//string5    orig_listing_type;
		//string5    orig_phone_usage;
		//string5    append_phone_type;
 End;
 
 
Filebest := Watchdog.File_Best ; 

//output(table(ds_phonesplus,{DateFirstSeen,count(group)},DateFirstSeen));

Temp_rec Append_dob_ssn (ds_phonesplus l	,recordof(Filebest) r) :=
		transform
		self.EXTERNAL_ID    := StringLib.Data2String(l.CellPhoneIDKey);
		self.SSN   			    := r.ssn;
		self.DOB_MONTH      := MAP( regexfind('^([0-9]{8})$',trim(l.dob))   =>l.dob[5..6],
		                           trim((string) r.dob[5..6]) not in ['0','00'] => (string) r.dob[5..6],
															 '');
    self.DOB_DAY        := MAP( regexfind('^([0-9]{8})$',trim(l.dob))  =>l.dob[7..8],
		                           trim((string) r.dob[7..8]) not in ['0','00'] => (string) r.dob[7..8] ,
															 '');
		self.DOB_YEAR       := MAP( regexfind('^([0-9]{8})$',trim(l.dob))   =>l.dob[1..4],
		                           trim((string) r.dob[1..4]) not in ['0','00'] =>(string) r.dob[1..4],
															 '');
		self.FIRST_NAME     := trim(StringLib.StringFilterOut(l.fname,'()@'));
		self.MIDDLE_NAME    := trim(l.mname);
		self.LAST_NAME      := trim(l.lname);
		self.STREET_1       := trim(trim(trim(trim(
		                            IF (l.prim_range <> '',    trim(l.prim_range),'')+
		                            IF (l.predir     <> '',' '+trim(l.predir),''),LEFT)+
																IF (l.prim_name  <> '',' '+trim(l.prim_name),''),LEFT)+
																IF (l.addr_suffix<> '',' '+trim(l.addr_suffix),''),LEFT)+
																IF (l.postdir    <> '',' '+l.postdir,''),LEFT,RIGHT);
																
		self.STREET_2       := trim(trim(l.unit_desig)+' '+l.sec_range);
		self.STREET_3       := '';
		self.CITY           := l.v_city_name; 
		self.STATE          := l.state;
		self.POSTAL_CODE    := l.zip5;
		self.COUNTRY        := '';
		self.ACCOUNT_ID     := '208';
		self.USERNAME       := 'PSDataLoad';
		self.OPERATION_TYPE := '';
		self.REFERENCE_ID   := '';
		self.DL_NUM         := '';
		self.DL_STATE       := ''; 
		
		
		string PAGER              := Map( l.append_phone_type in ['PAGE'] or l.orig_phone_usage = 'G' => 'Y',
		                                  '');
																			
    string cell               := Map( l.append_phone_type in ['CELL','LNDLN PRTD TO CELL'] =>'Y',
		                                  '');															
																		 
		string FAX_DATA           := Map( pager <> '' or cell <> '' =>'',
		                                  stringlib.stringfind(l.orig_phone_usage,'F',1)  > 0 or 
		                                  stringlib.stringfind(l.orig_phone_usage,'D',1)  > 0 => 'Y',
																		  '');  	
																			
    self.PAGER                := Map( pager ='Y' => l.cellphone,
		                                  '');
																			
    self.FAX_DATA             := Map( FAX_DATA ='Y' => l.cellphone,
		                                  '');
																			
    self.CELL_PHONE_AREA_CODE := Map( cell ='Y' => l.npa,
		                                  '');
																		 
		self.CELL_PHONE_NUMBER    := Map( cell ='Y' => l.phone7,
	 	                                  '');
    string WORK               := Map( cell ='Y' or PAGER ='Y' or FAX_DATA ='Y' => '',
		                                 (stringlib.stringfind(l.orig_listing_type,'B',1) > 0 or stringlib.stringfind(l.orig_listing_type,'G',1) > 0 ) and 
																		  stringlib.stringfind(l.orig_listing_type,'R',1) = 0  => 'Y',
																			
																			stringlib.stringfind(l.orig_listing_type,'B',1) > 0 and stringlib.stringfind(l.orig_listing_type,'R',1) > 0 and 
																		 (stringlib.stringfind(l.orig_phone_usage,'W',1)  > 0 or 
																			stringlib.stringfind(l.orig_phone_usage,'O',1)  > 0) => 'Y',
																			 
																			l.orig_listing_type = '' and 
																			(stringlib.stringfind(l.orig_phone_usage,'W',1)  > 0 or 
																			 stringlib.stringfind(l.orig_phone_usage,'O',1)  > 0) => 'Y',
																			 
																		  '');																		 
		self.WORK_PHONE_AREA_CODE := Map( WORK ='Y' => l.npa,
		                                  '');
																		 
		self.WORK_PHONE_NUMBER    := Map( WORK ='Y' => l.phone7,
		                                  '');
																			
    string home               := Map( cell ='Y' or PAGER ='Y' or FAX_DATA ='Y' or WORK ='Y' => '',
		
		                                 stringlib.stringfind(l.orig_listing_type,'R',1) > 0 and stringlib.stringfind(l.orig_listing_type,'B',1) = 0 => 'Y',
																		 
																		 //stringlib.stringfind(l.orig_listing_type,'R',1) > 0 and stringlib.stringfind(l.orig_listing_type,'B',1) >0 and						 
																		(stringlib.stringfind(l.orig_phone_usage,'P',1)  > 0  or 
																		 stringlib.stringfind(l.orig_phone_usage,'R',1)  > 0  or 
																		 stringlib.stringfind(l.orig_phone_usage,'S',1)  > 0  or 
																		 stringlib.stringfind(l.orig_phone_usage,'C',1)  > 0  or
																		 stringlib.stringfind(l.orig_phone_usage,'T',1)  > 0  or
																		 stringlib.stringfind(l.orig_phone_usage,'H',1)  > 0) //and 
																		 //stringlib.stringfind(l.orig_phone_usage,'W',1) = 0   and 
																		 //stringlib.stringfind(l.orig_phone_usage,'O',1) = 0 
																		 => 'Y',
																		 
																		 //l.orig_listing_type = '' and						 
																		(stringlib.stringfind(l.orig_phone_usage,'P',1)  > 0  or 
																		 stringlib.stringfind(l.orig_phone_usage,'R',1)  > 0  or 
																		 stringlib.stringfind(l.orig_phone_usage,'S',1)  > 0  or 
																		 stringlib.stringfind(l.orig_phone_usage,'C',1)  > 0  or
																		 stringlib.stringfind(l.orig_phone_usage,'T',1)  > 0  or
																		 stringlib.stringfind(l.orig_phone_usage,'H',1)  > 0)  => 'Y',
																			
																		 l.orig_phone_usage = '' and (length(trim(l.orig_listing_type)) >1 or l.orig_listing_type ='') and 
																		 l.append_phone_type in ['POTS','VOIP','FREE','Puerto Rico/US Virgin Isl'] => 'Y',
																		 '');				
																		 
		self.HOME_PHONE_AREA_CODE := Map(HOME ='Y' => l.npa,
																		 '');
																 
		self.HOME_PHONE_NUMBER    := Map(HOME ='Y' => l.phone7,
																			
																		 '');
    self.other                := Map(	cell ='' and PAGER ='' and FAX_DATA ='' and WORK ='' and home ='' => l.cellphone,
		                                  '');
		self.LINK_ID              := l.did;
		self.process_date         := v_process_date;
		self := l;
		end;
		
											
phonesplus_ds := join( ds_phonesplus( lname <> '' and fname <> '' and regexfind('[0-9]',lname,0 ) = '' and 
                                     regexfind('^[aA]*$|^[bB]*$|^[cC]*$|^[dD]*$|^[eE]*$|^[fF]*$|^[gG]*$|^[hH]*$|^[iI]*$|^[jJ]*$|^[kK]*$|^[lL]*$|^[mM]*$|^[nN]*$|^[oO]*$|^[pP]*$|^[qQ]*$|^[rR]*$|^[sS]*$|^[tT]*$|^[uU]*$|^[vV]*$|^[wW]*$|^[xX]*$|^[yY]*$|^[zZ]*$',trim(lname),0)='' 
																		 )
											,Filebest
											,(unsigned6)left.did= right.did
											,Append_dob_ssn(left,right)
											,left outer
											,local) ;
											
// export Promonitor_despray :=  sequential(out_phonesplus,phonesplus_d);  
 ut.MAC_SF_BuildProcess(phonesplus_ds( street_1 <>'' and city <> '' and state <> '' and postal_code<> '' and 
                                       (ssn <> '' or dob_month+dob_day+dob_year <> '') ),'~thor_Data400::out::Promonitor::PhonesPlus',OutPhoneplus,2);
 
 //sort_phonesplus_ds := Sort(phonesplus_ds,record,local);
 old_phonesplus_ds  := distribute(dataset('~thor_Data400::out::Promonitor::PhonesPlus_father', Temp_rec, thor),HASH(LAST_NAME,FIRST_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR)) ; 
 new_phonesplus_ds  := distribute(dataset('~thor_Data400::out::Promonitor::PhonesPlus'       , Temp_rec, thor),HASH(LAST_NAME,FIRST_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR)) ; 
// comb_phonesplus_ds := Sort(new_phonesplus_ds+old_phonesplus_ds,link_id,external_id,last_name,first_name,middle_name,process_date,local);
	comb_phonesplus_ds := If (nothor(FileServices.GetSuperFileSubCount('~thor_Data400::out::Promonitor::PhonesPlus_father') <> 0), 
                           Sort(new_phonesplus_ds+old_phonesplus_ds,LAST_NAME,FIRST_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,STREET_1,STREET_2,CITY,STATE,POSTAL_CODE,
CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,FAX_DATA,PAGER,OTHER,process_date,local),
													 Sort(new_phonesplus_ds,LAST_NAME,FIRST_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,STREET_1,STREET_2,CITY,STATE,POSTAL_CODE,
CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,FAX_DATA,PAGER,OTHER,process_date,local)
													);
 dedup_set          := dedup(comb_phonesplus_ds,LAST_NAME,FIRST_NAME,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,STREET_1,STREET_2,CITY,STATE,POSTAL_CODE,
CELL_PHONE_AREA_CODE,CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,FAX_DATA,PAGER,OTHER,left,local);
 out_changedrecords := dedup_set(process_date = v_process_date);

output_phonesplus := output(out_changedrecords,
                            {EXTERNAL_ID,SSN,DOB_MONTH,DOB_DAY,DOB_YEAR,FIRST_NAME,MIDDLE_NAME,LAST_NAME,STREET_1,STREET_2,STREET_3,
														 CITY,STATE,POSTAL_CODE,COUNTRY,ACCOUNT_ID,USERNAME,OPERATION_TYPE,REFERENCE_ID,DL_NUM,DL_STATE,CELL_PHONE_AREA_CODE,
                             CELL_PHONE_NUMBER,WORK_PHONE_AREA_CODE,WORK_PHONE_NUMBER,HOME_PHONE_AREA_CODE,HOME_PHONE_NUMBER,LINK_ID,FAX_DATA,PAGER,OTHER},
                             '~thor_Data400::out::promonitor::PhonesPlusExtract_'+v_process_date,csv(
                             HEADING('EXTERNAL_ID|SSN|DOB_MONTH|DOB_DAY|DOB_YEAR|FIRST_NAME|MIDDLE_NAME|LAST_NAME|STREET_1|STREET_2|STREET_3|CITY|STATE|POSTAL_CODE|COUNTRY|ACCOUNT_ID|USERNAME|OPERATION_TYPE|REFERENCE_ID|DL_NUM|DL_STATE|CELL_PHONE_AREA_CODE|CELL_PHONE_NUMBER|WORK_PHONE_AREA_CODE|WORK_PHONE_NUMBER|HOME_PHONE_AREA_CODE|HOME_PHONE_NUMBER|LINK_ID|FAX_DATA|PAGER|OTHER\n','',SINGLE)
                             ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE);
														 
 phonesplus_d := fileservices.despray('~thor_Data400::out::promonitor::PhonesPlusExtract_'+v_process_date, DestinationIP, '/data/hds_180/pro_monitor/build/phonesplus/'+'PhonesPlusExtract_'+v_process_date+'.txt',,,,TRUE); 

//output(phonesplus_ds(Link_id = 23686));
export Proc_build_Promonitor_extract := sequential(OutPhoneplus,
                                                   output_phonesplus,
																									 phonesplus_d
																									 );