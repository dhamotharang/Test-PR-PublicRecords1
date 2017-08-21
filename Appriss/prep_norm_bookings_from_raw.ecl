import address;
/*
This will 
 1. Separate the bookings from the raw parent child structure
 2. Format the dates and timestamps into standard format
 3. Clean Names and Addresses

*/

layout_prep_booking_rec normBookings(layout_in_bookings_raw_xml L):= TRANSFORM

  ap_addr1 := MAP( stringlib.stringfind(l.ap_address1,'/',2) <> 0 => stringlib.stringfilterout(l.ap_address1,'/'),
	                 stringlib.stringfilterout(l.ap_address1,'0-.') = '' => '',
									 stringlib.stringfilterout(l.ap_address1,'0;/\\-.]\'') = '' => '',
									 regexfind('[\'"][a-zA-z][\'"]',l.ap_address1)=> stringlib.stringfilterout(l.ap_address1,'"\''),
									 regexfind('(^[0]+ )(.*)',l.ap_address1) => trim(regexreplace('(^[0]+ )(.*)',l.ap_address1,'$2'),left,right),
	                 l.ap_address1);
									 
	ap_addr2 := MAP( stringlib.stringfind(ap_addr1,'.',2) <> 0 => stringlib.stringfilterout(ap_addr1,'.'),
	                 ap_addr1);
									 
	ap_addr3 := MAP( ap_addr2[1..1] in ['.','\''] => ap_addr2[2..],
									 ap_addr2);
									 									 
  ap_addr  := trim(stringlib.stringfilterout(ap_addr3,'!%\\*+$^~@'),left,right);
  
	ap_city1  := MAP(regexfind('^N[ ]*/[ ;]*A$',trim(L.ap_city,left,right),0) <> '' => '',
	                 regexfind('[A-Za-z]',L.ap_city,0) ='' => '',
		 							 //regexfind('^#[0-9]+ [A-Za-z]+',L.ap_city) => stringlib.stringfilterout(L.ap_city,'0123456789#'),
	                 TRIM(L.ap_city)
									);
	ap_city   := 		trim(stringlib.stringfilterout(ap_city1,'.!%\\*+$^~@'),left,right);						
									
	ap_zip   := If ((integer)TRIM(L.ap_zipcode) =0 , '', TRIM(L.ap_zipcode));		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//bug 84251
self.mstatus	 := MAP(stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.key_mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='M' => 'MARRIED',
                      stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.key_mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='S' => 'SINGLE',
											stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.key_mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='D' => 'DIVORCED',
											stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.key_mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='W' => 'WIDOW',
									    stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='M' => 'MARRIED',
                      stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='S' => 'SINGLE',
											stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='D' => 'DIVORCED',
											stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\') ='W' => 'WIDOW',
											l.mstatus in ['MAR/SEP'] => trim(l.mstatus),
											regexfind('[0-9]',l.mstatus,0)= '' and length(trim(l.mstatus)) =3 and 
                      regexfind('^D[IE]V$',stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~;`!@#$%^,+[]-&*(/)?.|\\')) => stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~`!@#$%^,;[]-&*(/)?.|\\'),
										  
											regexfind('[0-9]',l.mstatus,0)= '' and length(trim(l.mstatus)) >3 and 
                      regexfind('COHABIT|DOM[ESTIC PTR]|^D[IE]V$|LIFE[ PARTNER]|LIVE[ ]*IN|MARRIAGE|SINGLE|MARRIED|^(S[SEA]+[P][PARATEDS]*)$|^([IS][SINLEUAG	]*[NG][EA]*[L][ER]*)$|^(WIFE)$|^(GIRL[ ]*FRIEND)$|^(ROOM[ ]*MATE)$|^(RE)*(NOT)*[ ]*[MN][SAERID ]*[R][R][SAERID ]*$|^(RE)*(NOT)*[ ]*[MN][SAERID ]*[R][SAERI ]+[D]$|^([DI][EUIV]+[IVOARCSED]*)$|^(E[NGAED]*)$|^(UN[MARRIED]*)$|^W[IDOWEDR]*$',
											          stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~;`!@#$%^,+[]-&*(/)?.|\\')) => stringlib.stringfilterout(trim(stringlib.stringtouppercase(l.mstatus)),'~`!@#$%^,;+[]-&*(/)?.|\\'),
										            '');
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//vcleanname 								:= Address.CleanPersonLFM73(L.ap_full_name);
//Bug 72058

L_ap_fname := IF(regexfind('[a-zA-Z ]' ,trim(L.ap_fname)),trim(L.ap_fname),'');
L_ap_mname := IF(regexfind('[a-zA-Z ]' ,trim(L.ap_mname)),trim(L.ap_mname),'');
L_ap_lname := IF(regexfind('[a-zA-Z ]' ,trim(L.ap_lname)),trim(L.ap_lname),'');

string firstnametemp := MAP(regexfind('[Xx][Xx][Xx]+' ,trim(L_ap_fname))   => '',
                            regexfind('([a-zA-Z ]+)(, )(JR|SR)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z ]+)(, )(JR|SR)',trim(L_ap_fname),'$1'),
                            regexfind('([a-zA-Z]+)(, )(JR|SR)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z]+)(, )(JR|SR)',trim(L_ap_fname),'$1'),
                            regexfind('(JR|SR|III|II|IV)(, )([a-zA-Z ]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z ]+)',trim(L_ap_fname),'$3'),
                            regexfind('(JR|SR|III|II|IV)(, )([a-zA-Z]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z]+)',trim(L_ap_fname),'$3'),
										        regexfind('(JR|SR|III|II|IV),' ,trim(L_ap_fname))   => '',
                            L_ap_fname
								           );
string suffix       := MAP(regexfind('([a-zA-Z ]+)(, )(JR|SR|III|II|IV)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z ]+)(, )(JR|SR)',trim(L_ap_fname),'$3'),
                           regexfind('([a-zA-Z]+)(, )(JR|SR|III|II|IV)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z]+)(, )(JR|SR)',trim(L_ap_fname),'$3'),
                           regexfind('(JR|SR|III|II|IV)(, )([a-zA-Z ]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z ]+)',trim(L_ap_fname),'$1'),
										       regexfind('(JR|SR|III|II|IV)(, )([a-zA-Z]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z]+)',trim(L_ap_fname),'$1'),
										       regexfind('(JR|SR|III|II|IV)(,)' ,trim(L_ap_fname))   => trim(L_ap_fname),
                           ''
								          );				
										
string firstname    := trim(firstnametemp,left,right);

string middlenametmp := MAP(regexfind('[Xx][Xx][Xx]+' ,trim(L_ap_mname))   => '',
                            regexfind('(NMN|NMI)([ ][0-9a-zA-Z]+)' ,trim(L_ap_mname))   => regexreplace('(NMN|NMI)([ ][0-9a-zA-Z]+)',    trim(L_ap_mname),'$2'),
                            regexfind('([/(]NMN[/)])([ ][0-9a-zA-Z]+)',trim(L_ap_mname)) => regexreplace('([/(]NMN[/)])([ ][0-9a-zA-Z]+)',trim(L_ap_mname),'$2'),
									          regexfind('([/(]NMI[/)])([ ][0-9a-zA-Z]+)',trim(L_ap_mname)) => regexreplace('([/(]NMI[/)])([ ][0-9a-zA-Z]+)',trim(L_ap_mname),'$2'),                  
									          regexfind('([0-9a-zA-Z]+)([ ][/(].*[/)])' ,trim(L_ap_mname)) => regexreplace('([0-9a-zA-Z]+)([ ][/(].*[/)])', trim(L_ap_mname),'$1'), 
                            trim(L_ap_mname) in ['NMN','NMI','(NMN)','(NMI)']=>'',
									          L_ap_mname
								          );
//output(middlenametmp)		;						 
 string middlename := trim(trim(middlenametmp,left,right)+' '+suffix,left,right);
 
 FML_name := MAP( L_ap_lname = L_ap_fname and L_ap_fname = L_ap_mname => '',
                  middlename <> '' and  
                  middlename not in ['SR','JR','III','II','IV','JUNIOR','SENIOR','3RD','2ND','1ST'] and 
									stringlib.stringfind(middlename,' ',1) =0 and 
									stringlib.stringfind(firstname,' ',1) =0 =>trim(trim(firstname+' '+middlename,left,right)+' '+trim(L_ap_lname),left,right),
									
									'');
									
 LFM_name := MAP(FML_name <> '' => '',
                 L_ap_lname = L_ap_fname and L_ap_fname = L_ap_mname => L_ap_lname,
                 trim(trim(trim(L_ap_lname)+', '+firstname,left,right)+' '+ middlename,left,right)
								);

 vCleanName := IF (FML_name <> '' , Address.CleanPersonFML73(FML_name),
					       Address.CleanPersonLFM73(LFM_name)
					  		 )	;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
vcleanaddress 						:= Address.CleanAddress182(TRIM(ap_addr)+TRIM(l.ap_address2),
                               ap_city+','+TRIM(L.ap_state)+','+ap_zip);

self.creation_ts					:=fnDateTime(L.creation_ts);
self.last_change_ts				:=fnDateTime(L.last_change_ts);
self.arrest_ts						:=fnDateTime(L.arrest_ts);
self.booking_ts						:=fnDateTime(L.booking_ts);
self.booking_ts_raw				:=fnDateTime(L.booking_ts_raw);
self.release_ts						:=fnDateTime(L.release_ts);
self.offense_ts						:=fnDateTime(L.offense_ts);
//
self.arrest_date      		:=fnDateTime(L.arrest_date);
self.booking_date      		:=fnDateTime(L.booking_date);
self.release_date     		:=fnDateTime(L.release_date);
self.offense_date      		:=fnDateTime(L.offense_date);
self.scheduled_release_date      :=IF ( trim(L.scheduled_release_date) in ['99990102','88880101'],'',fnDateTime(L.scheduled_release_date));
self.sentence_exp_date           :=IF (trim(L.sentence_exp_date) in['99990102','88880101'],'' ,fnDateTime(L.sentence_exp_date));
self.date_of_birth     		:=fnDateTime(L.date_of_birth);
self.dob     					 		:=fnDateTime(L.dob);
////////////////////////////////////////////////////////////// Added 20101029
 self.dlnumber :=  MAP (trim(l.dlnumber) IN ['REVOKED','SUSPENDED'] =>trim(l.dlnumber),
                        regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.dlnumber),0) = '' =>'',
												trim(l.dlnumber) <> '' and regexfind('[a-zA-Z]*[0-9][a-zA-Z]*',trim(l.dlnumber)) => trim(l.dlnumber),
												//(integer)l.dlnumber = 0 => '',
												''  );

 self.fbi_nbr  :=  MAP (regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.fbi_nbr),0) = '' =>'',
                        l.fbi_nbr <> '' and regexfind('[a-zA-Z]*[0-9][a-zA-Z]*',trim(l.fbi_nbr)) =>trim(l.fbi_nbr),
												//(integer)l.fbi_nbr = 0 => '',
												'');  
												
 self.state_id :=  MAP (regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.state_id),0) = '' =>'',
                        l.state_id <> '' and regexfind('[a-zA-Z]*[0-9]*[a-zA-Z]*',trim(l.state_id)) =>trim(l.state_id),
                        //(integer)l.state_id = 0 => '',
												''); 		
												
	self.HOME_PHONE := MAP(length(stringlib.stringfilterout(l.home_phone,'()+- ')) < 10  => '',
	                       regexfind('^([0]{10})|([1]{10})|([2]{10})|([3]{10})|([4]{10})|([5]{10})|([6]{10})|([7]{10})|([8]{10})|([9]{10})',stringlib.stringfilterout(l.home_phone,'()+- ')) => '',
												 stringlib.stringfilterout(l.home_phone,'()- '));
												 
  self.WORK_PHONE := MAP(length(stringlib.stringfilterout(l.work_phone,'()+- ')) < 10 =>'',
	                       regexfind('^([0]{10})|([1]{10})|([2]{10})|([3]{10})|([4]{10})|([5]{10})|([6]{10})|([7]{10})|([8]{10})|([9]{10})',stringlib.stringfilterout(l.work_phone,'()+- '))=> '',
	                       stringlib.stringfilterout(l.work_phone,'()- '));
	
	self.ap_ssn     := MAP(trim(l.ap_ssn) = 'EXPUNGED' => trim(l.ap_ssn),
                          regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.ap_ssn),0) = '' =>'',
												  regexfind('^([0]{8})|([1]{9})|([2]{9})|([3]{9})|([4]{9})|([5]{9})|([6]{9})|([7]{9})|([8]{9})|([9]{9})',l.ap_ssn)	 => '',
												  l.ap_ssn <> '' and regexfind('([0-9])',l.ap_ssn) => trim(l.ap_ssn),
													''); 					
													
 // self.ap_ssn   :=  MAP (trim(l.ap_ssn) = 'EXPUNGED' => trim(l.ap_ssn),
                        // regexfind('[a-zA-Z]*[1-9][a-zA-Z]*',trim(l.ap_ssn),0) = '' =>'',
												// l.ap_ssn <> '' and regexfind('([0-9])',l.ap_ssn) => trim(l.ap_ssn),
												//(integer)l.ap_ssn = 0 => '',
												// '');	
												
// self.HOME_PHONE := If(length(stringlib.stringfilterout(l.home_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.home_phone,'()- '));
// self.WORK_PHONE := If(length(stringlib.stringfilterout(l.work_phone,'()+- ')) < 10 ,'',stringlib.stringfilterout(l.work_phone,'()- '));
marks_scars_tatoos := MAP (regexfind('^([0]{8})|([1]{9})|([2]{9})|([3]{9})|([4]{9})|([5]{9})|([6]{9})|([7]{9})|([8]{9})|([9]{9})$',trim(L.marks_scars_tatoos))  => '' ,
                                regexfind('^(N|!|T|N[/]*A|None|NON[E ]*[NOTED.]*|NON[E ]*[STATED.]*)$',trim(stringlib.stringtouppercase(L.marks_scars_tatoos)))  =>'',       
																regexfind('^([N/AONE]*:[ N/AONE]*[:]*[ N/AONE]*)(.*)',trim(L.marks_scars_tatoos))  => regexreplace('^([N/AONE]*:[ N/AONE]*[:]*[ N/AONE]*)(.*)',trim(L.marks_scars_tatoos),'$2') ,
																~regexfind('[a-zA-Z0-9]',trim(L.marks_scars_tatoos)) => '',
																trim(L.marks_scars_tatoos)[1..3] in [': :','Y  '] => trim(StringLib.StringCleanSpaces(L.marks_scars_tatoos[4..]),left,right),
																trim(L.marks_scars_tatoos)[1..1] in [':','!']        => trim(StringLib.StringCleanSpaces(L.marks_scars_tatoos[2..]),left,right),
                                StringLib.StringCleanSpaces(L.marks_scars_tatoos)
																);                                                                                                     

marks_scars_tatoos1 := MAP (regexfind('(.*)(<STRONG>[ ]*)(.*)(</STRO[NG>]*[ ]*)(.*)',trim(marks_scars_tatoos))  => regexreplace('(.*)(<STRONG>[ ]*)(.*)(</STRO[NG>]*[ ]*)(.*)',trim(marks_scars_tatoos),'$1 $3 $5') ,
                            regexfind('(.*)(<STRONG>[ ]*)(.*)',trim(marks_scars_tatoos))  => regexreplace('(.*)(<STRONG>[ ]*)(.*)',trim(marks_scars_tatoos),'$1 $3') ,
														marks_scars_tatoos);
marks_scars_tatoos2 := MAP (regexfind('(.*)(<BR>[ ]*<BR>*[ ]*)(.*)(<BR>+[ ]*)(.*)',trim(marks_scars_tatoos1))  => regexreplace('(.*)(<BR>[ ]*<BR>*[ ]*)(.*)(<BR>+[ ]*)(.*)',trim(marks_scars_tatoos1),'$1 $3 $5') ,
                            regexfind('(.*)(<BR>+[ ]*)(.*)(<BR>+[ ]*)(.*)',trim(marks_scars_tatoos1))  => regexreplace('(.*)(<BR>+[ ]*)(.*)(<BR>+[ ]*)(.*)',trim(marks_scars_tatoos1),'$1 $3 $5') ,
														regexfind('(.*)(<BR>[ ]*<BR>*[ ]*)(.*)',trim(marks_scars_tatoos1))  => regexreplace('(.*)(<BR>[ ]*<BR>*[ ]*)(.*)',trim(marks_scars_tatoos1),'$1 $3') ,
														regexfind('(.*)(<BR>+[ ]*)(.*)',trim(marks_scars_tatoos1))  => regexreplace('(.*)(<BR>+[ ]*)(.*)',trim(marks_scars_tatoos1),'$1 $3') ,
         										marks_scars_tatoos1);
marks_scars_tatoos3 := MAP (regexfind('(.*)((&NBSP;)+[ ]*)(.*)((&NBSP;)+[ ]*)(.*)',trim(marks_scars_tatoos2))  => regexreplace('(.*)((&NBSP;)+[ ]*)(.*)((&NBSP;)+[ ]*)(.*)',trim(marks_scars_tatoos2),'$1 $3 $5') ,
														regexfind('(.*)((&NBSP;)+[ ]*)(.*)',trim(marks_scars_tatoos2))  => regexreplace('(.*)(&NBSP;+[ ]*)(.*)',trim(marks_scars_tatoos2),'$1 $3') ,
														marks_scars_tatoos2);		
marks_scars_tatoos4 := MAP (regexfind('(.*)(<P>+[ ]*)(.*)(</P>+[ ]*)(.*)',trim(marks_scars_tatoos3))  => regexreplace('(.*)(<P>+[ ]*)(.*)(</P>+[ ]*)(.*)',trim(marks_scars_tatoos3),'$1 $3 $5') ,
														regexfind('(.*)(<P>+[ ]*)(.*)',trim(marks_scars_tatoos3))  => regexreplace('(.*)(<P>+[ ]*)(.*)',trim(marks_scars_tatoos3),'$1 $3') ,
														marks_scars_tatoos3);															
marks_scars_tatoos5 := MAP (regexfind('(<FONT STYLE="BACKGROUND-COLOR:)(.*)(">)(.*)',trim(marks_scars_tatoos4))  => regexreplace('(<FONT STYLE="BACKGROUND-COLOR:)(.*)(">)(.*)',trim(marks_scars_tatoos4),'$4') ,
														marks_scars_tatoos4);	

marks_scars_tatoos6 := MAP (regexfind('(.*)(<U>+[ ]*)(.*)((</U>)+[ ]*)(.*)',trim(marks_scars_tatoos5))  => regexreplace('(.*)(<U>+[ ]*)(.*)(</U>+[ ]*)(.*)',trim(marks_scars_tatoos5),'$1 $3 $5') ,
                            regexfind('(.*)(<U>+[ ]*)(.*)',trim(marks_scars_tatoos5))  => regexreplace('(.*)(<U>+[ ]*)(.*)',trim(marks_scars_tatoos5),'$1 $3') ,
														marks_scars_tatoos5);	
marks_scars_tatoos7 := MAP (regexfind('(.*)(<EM>+[ ]*)(.*)((</EM>)+[ ]*)(.*)',trim(marks_scars_tatoos6))  => regexreplace('(.*)(<EM>+[ ]*)(.*)(</EM>+[ ]*)(.*)',trim(marks_scars_tatoos6),'$1 $3 $5') ,
														marks_scars_tatoos6);	

														
self.marks_scars_tatoos := MAP( ~regexfind('[a-zA-Z0-9]',trim(marks_scars_tatoos7)) => '',
                                stringlib.stringfind(marks_scars_tatoos7,'<LF>',1) >0 => stringlib.stringfindreplace(marks_scars_tatoos7,'<LF>',''),
                                StringLib.StringCleanSpaces(marks_scars_tatoos7)
															);	
															
															
//self.scheduled_release_date := IF ( trim(L.scheduled_release_date) in ['99990102','88880101'],'',trim(L.scheduled_release_date));
//self.sentence_exp_date := IF (trim(L.sentence_exp_date) in['99990102','88880101'],'' ,trim(L.sentence_exp_date));
															

												
//////////////////////////////////////////////////////////////
	self.title			      		:= vCleanName[1..5];
	self.fname			      		:= vCleanName[6..25];
	self.mname			      		:= vCleanName[26..45];
	//self.lname			      		:= vCleanName[46..65];
	self.lname			      		:=if(vCleanName[46..48] in ['JR ','SR '],
										             vCleanName[49..65],
										             vCleanName[46..65])	;
														
	//self.name_suffix	    		:= vCleanName[66..70];
	self.name_suffix          := if(vCleanName[46..48] in ['JR ','SR '],
	  									            vCleanName[46..48],
		  								            vCleanName[66..70]);
																	
	self.name_score					  := vCleanName[71..73];
	self.prim_range    				:= vCleanAddress[1..10];
	self.predir 	      			:= vCleanAddress[11..12];
	self.prim_name 	  				:= vCleanAddress[13..40];
	self.addr_suffix   				:= vCleanAddress[41..44];
	self.postdir 	    				:= vCleanAddress[45..46];
	self.unit_desig 	  			:= vCleanAddress[47..56];
	self.sec_range 	  				:= vCleanAddress[57..64];
	self.p_city_name	  			:= vCleanAddress[65..89];
	self.v_city_name	  			:= vCleanAddress[90..114];
	self.state			      		:= vCleanAddress[115..116];
	self.zip5		      				:= vCleanAddress[117..121];
	self.zip4 		      			:= vCleanAddress[122..125];
	self.cart 		      			:= vCleanAddress[126..129];
	self.cr_sort_sz 	 		 		:= vCleanAddress[130];
	self.lot 		      				:= vCleanAddress[131..134];
	self.lot_order 	  				:= vCleanAddress[135];
	self.dpbc 		      			:= vCleanAddress[136..137];
	self.chk_digit 	  				:= vCleanAddress[138];
	self.rec_type		  				:= vCleanAddress[139..140];
	self.ace_fips_st	  			:= vCleanAddress[141..142];
	self.ace_fips_county 	 		:= vCleanAddress[143..145];
	self.geo_lat 	    				:= vCleanAddress[146..155];
	self.geo_long 	    			:= vCleanAddress[156..166];
	self.msa 		      				:= vCleanAddress[167..170];
	self.geo_blk							:= vCleanAddress[171..177];
	self.geo_match 	  				:= vCleanAddress[178];
	self.err_stat 	    			:= vCleanAddress[179..182];
	self.ssn					    		:= ''; // These will be filled in by the macro
	self.did              		:= 0;  //   "
// The rest of the fields
	self:=L;
END;

export prep_norm_bookings_from_raw :=PROJECT(file_in_bookings_raw_xml,normBookings(LEFT));