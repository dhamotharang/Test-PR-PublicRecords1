
import ut;


def :=   dataset('~thor200_144::in::sex_offender::hd::defendant_cw',hygenics_soff.Layout_In_SO_Defendant,CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID'); 


// reformat defendantadditionalinfo
Layout_In_SO_Defendant tr_cleanup_defendant(def l) := TRANSFORM


//clean 
Street_Address :=  map(regexfind('(.*)(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo) = true  
											  => regexreplace('(.*)(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo,'$3'),
                             regexfind('(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo) = true  
											        => regexreplace('(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo,'$2'),'');		

state :=  map(regexfind('(.*)(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo) = true  
							 => regexreplace('(.*)(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo,'$5'),
                    regexfind('(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo) = true  
						     	   => regexreplace('(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo,'$4'),'');		
												 
zip :=  map(regexfind('(.*)(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo) = true  
						 => regexreplace('(.*)(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo,'$6'), 
                 regexfind('(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo) = true  
						      => regexreplace('(WORK: )(.*)(, )([A-Z]+)( [0-9]+)',l.defendantadditionalinfo,'$5'),'');		

reformat_work_address := map(Street_Address + state + zip <> ''
                         => 'EMPLOYER ADDRESSES: ' + trim(Street_Address,left,right) 
                            + '; EMPLOYER STATE: ' + trim(state,left,right) 
										        + '; EMPLOYER ZIP: ' +  trim(zip,left,right) + ';','');	                                                               
														
school_address := map(regexfind('(SCHOOL: )(.*)',l.defendantadditionalinfo) = true  
							                 => regexreplace('(SCHOOL: )(.*)',l.defendantadditionalinfo,'$2'),'');
															 
reformat_school_address :=  map(school_address <> ''
                                => 'SCHOOL ADDRESS: ' + trim(school_address,left,right) + ';','');	
																
// clean street defendantadditionalinfo
street_clean1 := map(l.street = 'HOMELESS' => '',                                                                                                                                               
										l.street = 'HOMELSS' => '',
										l.street = 'STREETS' => '',                                                                                                                                              
										l.street = 'TRANSIENT' => '',
										l.street = 'UNKNOWN' => '',
										l.street = 'TRANSIENT ADAMS COUNTY' => '',
										l.street = 'NORTH MAIN BY HAMPTON INN BY DAUGHTERS HOUSE' => '',  
										l.street = 'UNKNOWN' => '',
										l.street = 'TRANS TRANSIENT' => '',                                                                                                                                          
										l.street = 'TRANSIENT' => '',   
										l.street = 'CONTACT DOC RECORDS' => '',                                                                                                                                      
										l.street = '0 0' => '',                                                                                                                                                      
										l.street = '0 CONTACT DOC RECORDS' => '',                                                                                                                                    
										l.street = '0 HOMELESS' => '',
										l.street = '0 TRANSIENT' => '',                                                                                                                                              
										l.street = '00 HOMELESS' => '',                                                                                                                                              
										l.street = '00 LACKS A FIXED RESIDENCE' => '',                                                                                                                               
										l.street = '00 TRANSIENT' => '',                                                                                                                                             
										l.street = '000 000' => '', 
										l.street = '000 NONE' => '',                                                                                                                                                 
										l.street = '000 TRANSIENT' => '',                                                                                                                                            
										l.street = '000 UNKNOWN' => '',
										l.street = '0000 UNKNOWN' => '',   
										l.street = '0000 TRANSIENT' => '',   
										l.street = '0000 NONE' => '',   
										l.street = 'STREETS' => '',                                                                                                                                                  
										l.street = 'TRANSIENT' => '', 
										l.street = '01 TRANSIENT' => '',
										l.street = 'PARKING LOT AT SANTA FE &AMP; BOWLES LIVING IN VEHICLE NEAR LOWE' => '',   
										l.street = 'CONTACT DOC RECORDS' => '', 
										l.street = 'FEDERAL CORRECTIONAL INST' => '',   
										l.street = '0000 HOMELESS' => '',   
										l.street = 'TRANSIENT ACROSS FROM VILLAGE SOUTH' => '',
										l.street = '000 HOMELESS' => '',										
										l.street =  '0000 LACKS A FIXED RESIDENCE' => '',	                                                                                                                          
										l.street = '0000 LACKS FIXED RESIDENCE' => '',	
										l.street =  '0000 CONTACT DOC RECORDS' => '',	
										l.street = 'TRANSIENT BELLINGHAM' => '',	
										l.street =  '000 CONTACT DOC RECORDS' => '',	                                                                                                                                  
										l.street = '000 FEDERAL/COLFAX TRANSIENT' => '',	
										l.street =  '000 LACKS A FIXED RESIDENCE' => '', 										
                    l.street =  'SAFEWAY, WAL-MART, KING SOOPERS PARKING LOTS' => '',                                                                                                           
                    l.street =  'SHERIDAN &AMP; EVANS' => '', 
										l.street =  '01 LACKS A FIXED RESIDENCE' => '', 										
										l.street);						 

street_clean2 :=  map(regexfind('(TRANSIENT )(\\()(.*)(\\))(.*)',street_clean1) = true  
						         => regexreplace('(TRANSIENT )(\\()(.*)(\\))(.*)',street_clean1,'$3'), street_clean1);	
								 
street_clean3 := StringLib.StringFindReplace(
                  StringLib.StringFindReplace(
									StringLib.StringFindReplace(
									StringLib.StringFindReplace(
									StringLib.StringFindReplace(
                  StringLib.StringFindReplace(
									StringLib.StringFindReplace(
                	StringLib.StringFindReplace(
                  StringLib.StringFindReplace(
									StringLib.StringFindReplace(
									StringLib.StringFindReplace(
                  StringLib.StringFindReplace(street_clean2,'TRANSIENT','')
														                               ,'TRANSNT','')
																												   ,'TRSNT','')
																													 ,'TRNSIET','')	
																													 ,'SANTO DOMINGO PUEBLO','')
																													,'(ENTRANCE IN THE ALLEY, LITTLE HOUSE IN BACK','')                                                                                      
																													,'(ALLEY ENTRANCE APT ABOVE GARAGE)','')                                                                                                   
																													,'REAR ADDRESS BY ALLEY/2 DOOR TO GAIN ACCCES','')                                                                                            
																													,'() (NEAR GLOBEVILLE PARK)','')                                                                                                     
																													,'# THE D BUILDING IS ON THE SOUTH 9TH AVE','')                                                                                            
																													,'(LIVES IN A 38 FT TRAILER ON THE PROPERTY)','')                                                                                           
																													,'; I-25-UNDER THE BRIDGE','') 

																													 ;
																													 
orig_zip_clean := map(l.orig_zip = '00000' => '',l.orig_zip); 					 

self.defendantadditionalinfo := map(reformat_work_address <> '' => reformat_work_address,
																    reformat_school_address <> '' => reformat_school_address,l.defendantadditionalinfo); 
self.street := trim(street_clean3,left,right); 
self.orig_zip := orig_zip_clean;
self := l;                                           
end;
		
def2 := PROJECT(def,tr_cleanup_defendant(left));


EXPORT File_In_SO_Defendant_CW := def2;  //dataset('thor200_144::in::sex_offender::hd::defendant_cw',
										                    //  Layout_In_SO_Defendant,
										                    //  CSV(SEPARATOR('|'), TERMINATOR(['\n', '\r\n']), QUOTE('"'), MAXLENGTH(4000)))(stringlib.StringToUpperCase(recordid[1..8])<>'RECORDID');
										