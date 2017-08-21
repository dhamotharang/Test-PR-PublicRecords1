import ut,DID_Add,header_slimsort,watchdog,address, idl_header;

#option('skipFileFormatCrcCheck', 1);

basename:=cluster_name+'::base::Appriss_';	

Layout_Base_Bookings cleanaddress ( Appriss.file_bookings_base L ) := transform

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

  vcleanaddress 						:= address.CleanAddress182(TRIM(ap_addr)+TRIM(l.ap_address2),
                               ap_city+','+TRIM(L.ap_state)+','+ap_zip);
														 
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
	self.ssn                  := ''; 
	
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
	self := L;
end;

//dbookings              := distribute(Appriss.file_bookings_base,hash(booking_sid));
//bookings               := PROJECT(dbookings,cleanaddress(left),local);
//=================================================================================================================
//BUG  67739
Layout_Base_Bookings cleandates ( Appriss.file_bookings_base L ) := transform
self.scheduled_release_date := IF ( trim(L.scheduled_release_date) in ['99990102','88880101'],'',trim(L.scheduled_release_date));
self.sentence_exp_date := IF (trim(L.sentence_exp_date) in['99990102','88880101'],'' ,trim(L.sentence_exp_date));
self := L;
end;



 // dbookings              := distribute(Appriss.file_bookings_base,hash(booking_sid));
 // bookings               := PROJECT(dbookings,cleandates(left),local);
//=================================================================================================================
//BUG  67963
Layout_Base_Bookings cleanscars ( Appriss.file_bookings_base L ) := transform

// marks_scars_tatoos := MAP (regexfind('^([0]{8})|([1]{9})|([2]{9})|([3]{9})|([4]{9})|([5]{9})|([6]{9})|([7]{9})|([8]{9})|([9]{9})$',trim(L.marks_scars_tatoos))  => '' ,
                                // regexfind('^(N|!|T|N[/]*A|None|NON[E ]*[NOTED.]*|NON[E ]*[STATED.]*)$',trim(stringlib.stringtouppercase(L.marks_scars_tatoos)))  =>'',       
																// regexfind('^([N/AONE]*:[ N/AONE]*[:]*[ N/AONE]*)(.*)',trim(L.marks_scars_tatoos))  => regexreplace('^([N/AONE]*:[ N/AONE]*[:]*[ N/AONE]*)(.*)',trim(L.marks_scars_tatoos),'$2') ,
																// ~regexfind('[a-zA-Z0-9]',trim(L.marks_scars_tatoos)) => '',
																// trim(L.marks_scars_tatoos)[1..3] in [': :','Y  '] => trim(StringLib.StringCleanSpaces(L.marks_scars_tatoos[4..]),left,right),
																// trim(L.marks_scars_tatoos)[1..1] in [':','!']        => trim(StringLib.StringCleanSpaces(L.marks_scars_tatoos[2..]),left,right),
                                // StringLib.StringCleanSpaces(L.marks_scars_tatoos)
																// );
// self.marks_scars_tatoos := MAP( ~regexfind('[a-zA-Z0-9]',trim(marks_scars_tatoos)) => '',
                                // StringLib.StringCleanSpaces(marks_scars_tatoos)
															// );
															
//---------------------------------------------------------------------------------------------------------															
//BUG  67963 and 68305 
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
															
//BUG  67020 -- Part of the height is in weight. So set the wt to null and fix the height.
 string v_ht := MAP ( length(trim(l.hgt)) =1 and (integer)l.hgt >0 and (integer)l.wgt <12 and 
                      l.key_hgt <> ''  and l.key_wgt <> '' => trim(l.hgt)+ (string)INTFORMAT((integer)l.wgt,2,1),
                      l.key_hgt);
 string v_wgt:= MAP ( length(trim(l.hgt)) =1 and (integer)l.hgt >0 and (integer)l.wgt <12 and 
                      l.key_hgt <> ''  and l.key_wgt <> '' => '',
                      l.key_wgt);

 self.key_hgt:= v_ht;
 self.key_wgt:= v_wgt;

self := L;
end;

// dbookings              := distribute(Appriss.file_bookings_base,hash(booking_sid));
// bookings               := PROJECT(dbookings,cleanscars(left),local);
//========================================================================================
//Name cleaning//
Layout_Base_Bookings cleanname ( Appriss.file_bookings_base L ) := transform
L_ap_fname := IF(regexfind('[a-zA-Z ]' ,trim(L.ap_fname)),trim(L.ap_fname),'');
L_ap_mname := IF(regexfind('[a-zA-Z ]' ,trim(L.ap_mname)),trim(L.ap_mname),'');
L_ap_lname := IF(regexfind('[a-zA-Z ]' ,trim(L.ap_lname)),trim(L.ap_lname),'');

string firstnametemp := MAP(regexfind('[Xx][Xx][Xx]+' ,trim(L_ap_fname))   => '',
                            regexfind('([a-zA-Z ]+)(, )(JR|SR)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z ]+)(, )(JR|SR)',trim(L_ap_fname),'$1'),
                            regexfind('([a-zA-Z]+)(, )(JR|SR)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z]+)(, )(JR|SR)',trim(L_ap_fname),'$1'),
                            regexfind('(JR|SR|III|II|IV|3RD|2ND|1ST)(, )([a-zA-Z ]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z ]+)',trim(L_ap_fname),'$3'),
                            regexfind('(JR|SR|III|II|IV|3RD|2ND|1ST)(, )([a-zA-Z]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z]+)',trim(L_ap_fname),'$3'),
										        regexfind('(JR|SR|III|II|IV|3RD|2ND|1ST),' ,trim(L_ap_fname))   => '',
                            L_ap_fname
								           );
string suffix       := MAP(regexfind('([a-zA-Z ]+)(, )(JR|SR|III|II|IV|3RD|2ND|1ST)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z ]+)(, )(JR|SR)',trim(L_ap_fname),'$3'),
                           regexfind('([a-zA-Z]+)(, )(JR|SR|III|II|IV|3RD|2ND|1ST)' ,trim(L_ap_fname))   => regexreplace('([a-zA-Z]+)(, )(JR|SR)',trim(L_ap_fname),'$3'),
                           regexfind('(JR|SR|III|II|IV|3RD|2ND|1ST)(, )([a-zA-Z ]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z ]+)',trim(L_ap_fname),'$1'),
										       regexfind('(JR|SR|III|II|IV|3RD|2ND|1ST)(, )([a-zA-Z]+)' ,trim(L_ap_fname))   => regexreplace('(JR|SR|III|II|IV)(, )([a-zA-Z]+)',trim(L_ap_fname),'$1'),
										       regexfind('(JR|SR|III|II|IV|3RD|2ND|1ST)(,)' ,trim(L_ap_fname))   => trim(L_ap_fname),
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
 
// FML_name := MAP( L_ap_lname = L_ap_fname and L_ap_fname = L_ap_mname => '',
                  // middlename <> '' and regexfind('JR|SR|III|II|IV|JUNIOR|SENIOR|3RD|2ND|1ST' ,trim(middlename)) = true and  
			  					// stringlib.stringfind(trim(middlename),' ',1) <> 0 =>'',
                  // middlename <> '' and middlename not in ['SR','JR','III','II','IV','JUNIOR','SENIOR','3RD','2ND','1ST'] and 
									
									// stringlib.stringfind(firstname,' ',1) =0 =>trim(trim(firstname+' '+middlename,left,right)+' '+trim(L_ap_lname),left,right),
									// '');
	
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
// output(firstname);
// output(middlename);
// output(suffix);

// output(FML_name,named('FML_name'));
// output(LFM_name,named('LFM_name'));

   tempName          := IF (FML_name <> '' , address.CleanPersonFML73(FML_name),
										        address.CleanPersonLFM73(LFM_name)
													 )	;
//regexfind('JR|SR|III|II|IV|JUNIOR|SENIOR|3RD|2ND|1ST' ,trim(middlename)) = true

  self.title        := MAP(l.did =0 and (trim(l.ap_lname) <> trim(l.lname ) or 
	                                       trim(l.ap_fname) <> trim(l.fname)  or
																				 trim(l.ap_mname) <> trim(l.mname)) => tempName[1..5],
	                          trim(l.lname) ='' => tempName[1..5],
														stringlib.stringfind(trim(l.lname),' ',1) >0 => tempName[1..5],
													 l.title);
													 
	self.fname			  := MAP(l.did =0 and (trim(l.ap_lname) <> trim(l.lname ) or 
	                                       trim(l.ap_fname) <> trim(l.fname)  or
																				 trim(l.ap_mname) <> trim(l.mname)) => tempName[6..25],
	                          trim(l.lname) ='' => tempName[6..25],
														stringlib.stringfind(trim(l.lname),' ',1) >0 => tempName[6..25],
													 l.fname
													);
	self.mname			  := MAP(l.did =0 and (trim(l.ap_lname) <> trim(l.lname ) or 
	                                       trim(l.ap_fname) <> trim(l.fname)  or 
																				 trim(l.ap_mname) <> trim(l.mname)) => tempName[26..45], 
	                          trim(l.lname) ='' => tempName[26..45],
													  stringlib.stringfind(trim(l.lname),' ',1) >0 => tempName[26..45],
													 l.mname
													);
  string templname   :=  if(tempName[46..48] in ['JR ','SR '],
										        tempName[49..65],
										        tempName[46..65])	;
													 
	self.lname				 := MAP(l.did =0 and (trim(l.ap_lname) <> trim(l.lname) or 
	                                        trim(l.ap_fname) <> trim(l.fname) or 
																				  trim(l.ap_mname) <> trim(l.mname) ) => templname, 
	                          trim(l.lname) ='' => templname,
													  stringlib.stringfind(trim(l.lname),' ',1) >0 =>templname,
													  l.lname);
													
  string tempSuffix  := if(tempName[46..48] in ['JR ','SR '],
	  									      tempName[46..48],
		  								      tempName[66..70]);
													
	self.name_suffix  := MAP(l.did =0 and (trim(l.ap_lname) <> trim(l.lname) or 
	                                       trim(l.ap_fname) <> trim(l.fname) or 
																				 trim(l.ap_mname) <> trim(l.mname))=>tempSuffix, 
	                         trim(l.lname) ='' =>tempSuffix,
													 stringlib.stringfind(trim(l.lname),' ',1) >0 =>tempSuffix,
													 l.name_suffix
													);
	self.name_score	  := MAP(l.did =0 and (trim(l.ap_lname) <> trim(l.lname) or 
	                                       trim(l.ap_fname) <> trim(l.fname) or 
																				 trim(l.ap_mname) <> trim(l.mname)) =>tempName[71..73], 
	                         trim(l.lname) ='' =>tempName[71..73],
													 stringlib.stringfind(trim(l.lname),' ',1) >0 =>tempName[71..73],
													l.name_score
													);
	self.ssn := '';
	self := L;
end;
dbookings              := distribute(Appriss.file_bookings_base(),hash(booking_sid));
//booking_sid IN [ '27293552','26986251','27110219','41969971','47781246']
bookings               := PROJECT(dbookings,cleanname(left),local);
//Flip names before DID process
//ut.mac_flipnames(bookings, fname, mname, lname, cleanFlipName);

lMatchSet := ['S','A','D'];

did_Add.MAC_Match_Flex//_Sensitive  // NOTE <- removed sensitive macro 4/15/2008
	(bookings, lMatchSet,						
	 ap_ssn, date_of_birth, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip5, state, fake_phone_field, 
	 did,
	 Layout_Base_Bookings, //bookings_rec_norm,
	 false, fake_DID_Score_field,
	 75,						//dids with a score below here will be dropped
	 ds_bookings_with_did
	)

DID_Add.MAC_Add_SSN_By_DID(ds_bookings_with_did, did, ssn, ds_bookings_with_ssn)

ut.MAC_SF_BuildProcess(ds_bookings_with_ssn,basename+'bookings',outbookings,3,false,true);

//ut.MAC_SF_BuildProcess(bookings,basename+'bookings',outbookings,3,false,true);

export Proc_clean_address_onetime := sequential(outbookings);
 //ds_bookings_with_ssn :persist( 'persist::appriss::NameCleanTest'); //