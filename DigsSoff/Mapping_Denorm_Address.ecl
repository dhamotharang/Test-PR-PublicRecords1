/*
**********************************************************************************
Created by    Comments
Vani 					This attribute denormalizes the records in Address file based on the 
              address type information. The first reg, other, temp, school and Emp 
							address gets mapped to respective slots in the OKC Layout. The rest 
							are concatinated along appropriate labels to be used as Additional 
							Information. 
***********************************************************************************
*/
import lib_stringlib;

StandarAddressType(string InputAddressType) := FUNCTION

	RETURN MAP(InputAddressType ='' => 'REG',
	InputAddressType ='ABSCONDER' => 'SCH',
	InputAddressType ='COLLEGE' => 'SCH',
	InputAddressType ='EMPLOYER' => 'EMP',
	InputAddressType ='WORK' => 'EMP',
	InputAddressType ='EMPLOYMENT' => 'EMP',
	InputAddressType ='HOME' => 'REG',
	InputAddressType ='INCARCERATED' => 'OTH',
	InputAddressType ='INCARCERATED BY' => 'OTH',
	InputAddressType ='INSTITUTION' => 'OTH',
	InputAddressType ='LIVE' => 'REG',
	InputAddressType ='MAIL' => 'REG',
	InputAddressType ='MAILING' => 'REG',
	InputAddressType ='OTHER' => 'OTH',
	InputAddressType ='OTHER RESIDENTIAL' => 'OTH',
	InputAddressType ='OUT OF STATE' => 'TEMP',
	InputAddressType ='TEMP_LODGE' => 'TEMP',
	InputAddressType ='PERMANENT' => 'REG',
	InputAddressType ='PRIMARY' => 'REG',
	InputAddressType ='REGISTERED' => 'REG',
	InputAddressType ='REGISTRATION' => 'REG',
	InputAddressType ='REGISTRATION ADDRESS' => 'REG',
	InputAddressType ='RESIDENCE' => 'REG',
	InputAddressType ='RESIDENTIAL' => 'REG',
	InputAddressType ='RESIDENTIAL ADDRESS' => 'REG',
	InputAddressType ='SCHOOL' => 'SCH',
	InputAddressType ='EMAIL' => 'EMAIL',
	InputAddressType ='INSTANT_MSG' => 'IMSG',
	InputAddressType ='INT_USER_NAME' => 'IUNAME',
	InputAddressType ='INT_URL' => 'IURL','');
END;
/*
temp_file_soff_address := dataset([
 {1, 'KY171684444','','','','','','','','Email'                                                                    ,'','','','','INT ADD1','','','','7',''},
 {2, 'KY171684444','','','','','','','','Email'                                                                    ,'','','','','INT ADD2','','','','8',''},
 {3, 'KY171684444','','','','','','','','Email'                                                                    ,'','','','','INT ADD3','','','','9',''},
 {4, 'KY171684444','','','','','','','','Email'                                                                    ,'','','','','INT ADD4','','','','10',''},
 {5, 'KY171684444','','','','','','','','Email'                                                                    ,'','','','','INT ADD5','','','','11',''},
 {5, 'KY171684444','','','','','','','','Email'                                                                    ,'','','','','INT ADD5','','','','11',''},
 {6, 'KY171684444','','','','','','','','INSTANT_MSG'                                                              ,'','','','','','INSTANT_MSG1','','','12',''},
 {7, 'KY171684444','','','','','','','','INSTANT_MSG'                                                              ,'','','','','','INSTANT_MSG2','','','13',''},
 {8, 'KY171684444','','','','','','','','INSTANT_MSG'                                                              ,'','','','','','INSTANT_MSG3','','','14',''},
 {9, 'KY171684444','','','','','','','','INSTANT_MSG'                                                              ,'','','','','','INSTANT_MSG4','','','15',''},
 {10,'KY171684444','','','','','','','','INSTANT_MSG'                                                              ,'','','','','','INSTANT_MSg5','','','16',''},
 {10,'KY171684444','','','','','','','','INSTANT_MSG'                                                              ,'','','','','','INSTANT_MSG6','','','16',''},
 {24,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME1','','17',''},
 {11,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME2','','18',''},
 {12,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME3','','19',''},
 {13,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME4','','20',''},
 {14,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME5','','21',''},
 {15,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME6','','22',''},
 {16,'KY171684444','','','','','','','','INT_USER_NAME'                                                            ,'','','','','','','INT_USER_NAME7','','23',''},
 {17,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url1','24',''},
 {18,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url2','25',''},
 {19,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url3','26',''},
 {20,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url4','27',''},
 {21,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url5','28',''},
 {22,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url6','29',''},
 {23,'KY171684444','','','','','','','','INT_URL'                                                                  ,'','','','','','','','url7','30',''},
 {31,'FL178134942','Street','City','NV','county7','12-05-2008','zip','','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {31,'FL178134942','Street123','City','NV','county7','12-05-2008','zip','','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},

 {32,'FL178138289','Street1;Street2;Street3','','','county7','','','','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178142666','Street1;Street2;Street3','City','NV','county7','12-05-2008','Zip','Name','REGISTRATION'   ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178144772','Street1;Street2;','City','NV','county7','12-05-2008','Zip','Name','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 
 {32,'FL178146787','Street1;','City','NV','county7','12-05-2008','Zip','Name','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178147737','','City','NV','county7','12-05-2008','Zip','','REGISTRATION' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 
 {32,'FL178138289','Street1;Street2;Street3','','','county7','','','','OTHER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {31,'FL178134942','Street','City','NV','county7','12-05-2008','zip','','OTHER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'KS180443651','Street1;Street2;Street3','City','NV','county7','','Zip','','OTHER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178142666','Street1;Street2;Street3','City','NV','county7','12-05-2008','Zip','Name','OTHER'   ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178144772','Street1;Street2;','City','NV','county7','12-05-2008','Zip','Name','OTHER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178146787','Street1;','City','NV','county7','12-05-2008','Zip','Name','OTHER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 
 {32,'KS180443651','Street1;Street2;Street3','City','NV','county7','','Zip','','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','1',''},
 {32,'KS180443651','Street4;Street5;Street6','City','NV','county7','','Zip','','REGISTRATION','DOC','779-234-2345','998-234-2345','COM17','','','','','2',''},
 {32,'KS180443651','','City','NV','county7','12-05-2008','Zip','','OTHER' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'KS180443651','','City1','NV1','county71','12-05-2008','Zip','','OTHER' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','4',''},
  {32,'KS180443651','','empCity','NV','county7','12-05-2008','Zip','','EMPLOYER' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','5',''},
 {32,'KS180443651','','empCity1','NV1','county71','12-05-2008','Zip','','EMPLOYER' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','6',''},
 
 {32,'FL178138289','Street1;Street2;Street3','','','county7','','','','TEMP_LODGE','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {31,'FL178134942','Street','City','NV','county7','12-05-2008','zip','','TEMP_LODGE','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'KS180443651','Street1;Street2;Street3','City','NV','county7','','Zip','','TEMP_LODGE','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178142666','Street1;Street2;Street3','City','NV','county7','12-05-2008','Zip','Name','TEMP_LODGE','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178144772','Street1;Street2;','City','NV','county7','12-05-2008','Zip','Name','TEMP_LODGE','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178146787','Street1;','City','NV','county7','12-05-2008','Zip','Name','TEMP_LODGE','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178147737','','City','NV','county7','12-05-2008','Zip','','TEMP_LODGE' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178138289','Street1;Street2;Street3','','','county7','','','','SCHOOL','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {31,'FL178134942','Street','City','NV','county7','12-05-2008','zip','','SCHOOL','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'KS180443651','Street1;Street2;Street3','City','NV','county7','','Zip','','SCHOOL','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178142666','Street1;Street2;Street3','City','NV','county7','12-05-2008','Zip','Name','SCHOOL','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178144772','Street1;Street2;','City','NV','county7','12-05-2008','Zip','Name','SCHOOL','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178146787','Street1;','City','NV','county7','12-05-2008','Zip','Name','SCHOOL','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178147737','','City','NV','county7','12-05-2008','Zip','','SCHOOL' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178138289','Street1;Street2;Street3','','','county7','','','','EMPLOYER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {31,'FL178134942','Street','City','NV','county7','12-05-2008','zip','','EMPLOYER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'KS180443651','Street1;Street2;Street3','City','NV','county7','','Zip','','EMPLOYER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178142666','Street1;Street2;Street3','City','NV','county7','12-05-2008','Zip','Name','EMPLOYER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178144772','Street1;Street2;','City','NV','county7','12-05-2008','Zip','Name','EMPLOYER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178146787','Street1;','City','NV','county7','12-05-2008','Zip','Name','EMPLOYER','DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
 {32,'FL178147737','','City','NV','county7','12-05-2008','Zip','','EMPLOYER' ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},

 {3,'KY171684444','2607 BURTON AVE','LAS VEGAS','NV','county7','12-05-2008','89102',''             ,'RESIDENCE'   ,'DOC','779-234-2345','998-234-2345','COM17','','','','','3',''},
// {4,'KY171684444','4900 BLOCK OF S','LAS VEGAS','NV','county2','12-04-2008','89081','Employer Name','WORK'      ,'','578-234-2345','121-234-2345','COM18','','','','','2',''},
 {5,'KY171684444','5468 GREEN PALM','LAS VEGAS','NV','county3','12-04-2010','89130','Live name'    ,'LIVE'        ,'','678-234-2345','234-234-2345','COM19','','','','','1',''},
 {6,'KY171684444','2607 BURTON AVE','LAS VEGAS','NV','county4','12-07-2009','89102','temp name'    ,'OUT OF STATE','','778-234-2345','234-234-5345','COM17','','','','','4',''},
 {7,'KY171684444','4900 BLOCK OF S','LAS VEGAS','NV','county5','12-03-2009','89081','sch name'     ,'COLLEGE'     ,'','978-234-2345','834-234-5000','COM16','','','','','5',''},
 {8,'KY171684444','5469 GREEN PALM','LAS VEGAS','NV','county6','12-07-2008','89130','Whatever'     ,'INCARCERATED','','404-234-2345','784-234-5000','COM15','','','','','6',''}],Layout_soff_address);

DAddress := temp_file_soff_address;

DAddressSorted:= SORT(DAddress,id,
                               StandarAddressType(stringlib.StringToUpperCase(address_type)),
															 address_serial_number); //sort it first
														 
IdTable       := table(file_soff_address,Layout_Denorm_Address,id) ;

*/

DAddress   	  := DISTRIBUTE(File_soff_Address,  HASH32(File_soff_Address.id));

DAddressSorted:= SORT(DAddress,id,
                               StandarAddressType(stringlib.StringToUpperCase(address_type)),
															 address_serial_number,LOCAL); //sort it first
//output(DAddressSorted(id ='KS180443651'))	;															 
IdTable       := table(DAddressSorted,Layout_Denorm_Address,id,LOCAL) ;
//output(IdTable(id ='KS180443651'))	;	

Layout_Denorm_Address Denormaddress(Layout_Denorm_Address L, Layout_soff_address R, INTEGER C) := TRANSFORM

    //the temporary variable "temp_addrtype" holds the address type of the current record. current_address_type has the address of the 
		//previous record. If they are the same the record will be skipped. Otherwise, the appropriate set of fields 
		//will be populated based the type of address
		
		Varstring temp_addrtype         := 	StandarAddressType(stringlib.StringToUpperCase(trim(R.address_type)));
    // Concatinate Citystatezip
		Varstring Citystatezip_temp     :=  IF(trim(R.city) <>'' ,trim(R.city),'')+
                                            IF(trim(r.state) <>'',', '+trim(r.state),'')+
                                            TRIM(IF(trim(r.zip) <>'',' '+trim(r.zip),''),RIGHT);
																						
		Varstring Citystatezip          :=  IF(Citystatezip_temp[1..2] = ', ', Citystatezip_temp[3..], Citystatezip_temp);
		
		// Parse the Street		
		integer street1_pos							:=  StringLib.StringFind(R.street,';',1);
		integer street2_pos							:=  StringLib.StringFind(R.street,';',2);
		integer street3_pos							:=  StringLib.StringFind(R.street,';',3);
		
		Varstring street1_temp          :=  IF (street1_pos>0 , trim(R.street[1..street1_pos-1]),trim(R.street)); 
		Varstring street2_temp          :=  IF (street1_pos>0 , 
		                                                     IF(street2_pos>0, trim(R.street[street1_pos+1..street2_pos-1],left,right),
																													                 trim(R.street[street1_pos+1..]))
																												,''); 
		Varstring street3_temp          :=  IF (street2_pos>0 , trim(R.street[street2_pos+1..]),''
																																		);  
    // Parse comments	and pick the necessary information
		integer comm_semicolon_1  			:=  StringLib.StringFind(R.comments,';',1);
		integer comm_semicolon_2				:=  StringLib.StringFind(R.comments,';',2);
		integer comm_semicolon_3				:=  StringLib.StringFind(R.comments,';',3);																																
		
		varstring comment_part1         :=  IF (comm_semicolon_1 >0 ,R.comments[1..comm_semicolon_1-1], '');
		varstring comment_part2         :=  IF (comm_semicolon_1 >0 ,
		                                                    IF (comm_semicolon_2 >0 , R.comments[comm_semicolon_1+1..comm_semicolon_2 -1], 
																												                          R.comments[comm_semicolon_1+1..]),
																												'');
		varstring comment_part3         :=  IF (comm_semicolon_2 >0 ,
		                                                    IF (comm_semicolon_3 >0 , R.comments[comm_semicolon_2+1..comm_semicolon_3 -1], 
																												                          R.comments[comm_semicolon_2+1..]),
																												'');
		

    Varstring Address_status        :=  MAP (    StringLib.StringFind(comment_part1,'Address Status:',1) > 0 
		                                         and length(trim(comment_part1)) > 15 => comment_part1,
																						 
						                                     StringLib.StringFind(comment_part2,'Address Status:',1) > 0 
																						 and length(trim(comment_part2)) > 15 => comment_part2,
																						 
																						     StringLib.StringFind(comment_part3,'Address Status:',1) > 0 
																						 and length(trim(comment_part3)) > 15 => comment_part3,
																						 
																						     StringLib.StringFind(comment_part1,'TYPE:',1) > 0 
		                                         and length(trim(comment_part1)) > 5 => comment_part1,
																						 
						                                     StringLib.StringFind(comment_part2,'TYPE:',1) > 0 
																						 and length(trim(comment_part2)) > 5 => comment_part2,
																						 
																						     StringLib.StringFind(comment_part3,'TYPE:',1) > 0 
																						 and length(trim(comment_part3)) > 5 => comment_part3,
																						 '');
		//Extract As_of date from comments
		Varstring Addr_st_date          :=  MAP (    StringLib.StringFind(comment_part1,'Address Start Date:',1) > 0 
		                                         and length(trim(comment_part1)) > 19 => comment_part1,
																							
						                                     StringLib.StringFind(comment_part2,'Address Start Date:',1) > 0 
																						 and length(trim(comment_part2)) > 19 => comment_part2,
																						  
																							   StringLib.StringFind(comment_part3,'Address Start Date:',1) > 0 
																						 and length(trim(comment_part3)) > 19 => comment_part3,
																						 ''); 
																						 
 																						 
    Varstring V_asofdate_temp       :=  IF (R.asod_date <> '' and trim(R.asod_date) not in invalid_values, 'Address As Of: '+trim(R.asod_date) ,
		                                        IF (Addr_st_date <> '' and Addr_st_date not in invalid_values,Addr_st_date,'' ));
																						
    Varstring V_Misc_address_info   := 	IF (R.address_Verified <> '' and trim(R.address_Verified) not in invalid_values , 'Source/Address Verified: '+trim(R.address_Verified),
//---------------------------------------------------------------------------------------------------------------------------------------------
		                                        '');
		// Pick the first EMP address																				
	  SELF.intnet_email_address_1     :=  IF(temp_addrtype = 'EMAIL', 
                                           IF(C=1, trim(R.intnet_email_addr), 
		                                            IF (temp_addrtype <> L.current_address_type, trim(R.intnet_email_addr),
																				                                                     L.intnet_email_address_1)),
																				      L.intnet_email_address_1);
		                                      
		SELF.intnet_email_address_2     :=  IF(temp_addrtype = 'EMAIL', 
                                           IF(    L.intnet_email_address_2 ='' 
																						  AND L.intnet_email_address_1 <>''
																							and L.intnet_email_address_1 <> trim(R.intnet_email_addr), trim(R.intnet_email_addr),
																																				        L.intnet_email_address_2),
																				      L.intnet_email_address_2);
		SELF.intnet_email_address_3     :=  IF(temp_addrtype = 'EMAIL', 
                                           IF(    L.intnet_email_address_3 ='' 
																						  AND L.intnet_email_address_2 <>''
																						  AND L.intnet_email_address_2 <> trim(R.intnet_email_addr), trim(R.intnet_email_addr),
																																				        L.intnet_email_address_3),
																				      L.intnet_email_address_3);
		SELF.intnet_email_address_4     :=  IF(temp_addrtype = 'EMAIL',  
		                                      IF(    L.intnet_email_address_4 ='' 
																				     AND L.intnet_email_address_3 <>'' 
																						 AND L.intnet_email_address_3 <> trim(R.intnet_email_addr), trim(R.intnet_email_addr),
																																		            L.intnet_email_address_4),
																				     L.intnet_email_address_4);
		SELF.intnet_email_address_5     :=  IF(temp_addrtype = 'EMAIL', 
                                           IF(    L.intnet_email_address_4 <>'' 
																				      and L.intnet_email_address_4 <> trim(R.intnet_email_addr) , 
																						     IF (L.intnet_email_address_5 ='', trim(R.intnet_email_addr),
																						                                  L.intnet_email_address_5+';'+trim(R.intnet_email_addr)),
																						         L.intnet_email_address_5),
																				      L.intnet_email_address_5);
//---------------------------------------------------------------------------------------------------------------------------------------------
																				
    // Pick the first instant_message address	
	  SELF.intnet_instant_message_addr_1   := IF(temp_addrtype = 'IMSG', 
                                               IF(C=1, trim(R.intnet_instant_msngr_addr), 
		                                              IF (temp_addrtype <> L.current_address_type, trim(R.intnet_instant_msngr_addr),
																				                                                       L.intnet_instant_message_addr_1)),
																				       L.intnet_instant_message_addr_1);
		                                      
		SELF.intnet_instant_message_addr_2   := IF(temp_addrtype = 'IMSG', 
                                               IF(     L.intnet_instant_message_addr_2 ='' 
																						       AND L.intnet_instant_message_addr_1 <>'' 
																									 AND L.intnet_instant_message_addr_1 <> trim(R.intnet_instant_msngr_addr)
																									                                           , trim(R.intnet_instant_msngr_addr),
																							                                                L.intnet_instant_message_addr_2),
																							 L.intnet_instant_message_addr_2);
																							 
		SELF.intnet_instant_message_addr_3   :=IF(temp_addrtype = 'IMSG', 
                                              IF(     L.intnet_instant_message_addr_3 ='' 
																						      AND L.intnet_instant_message_addr_2 <>''
																									AND L.intnet_instant_message_addr_2 <> trim(R.intnet_instant_msngr_addr), trim(R.intnet_instant_msngr_addr),
																							                                               L.intnet_instant_message_addr_3),
																							L.intnet_instant_message_addr_3);
																							
		SELF.intnet_instant_message_addr_4   :=IF(temp_addrtype = 'IMSG',  
		                                          IF(     L.intnet_instant_message_addr_4 ='' 
																				          AND L.intnet_instant_message_addr_3 <>'' 
																									AND L.intnet_instant_message_addr_3 <>trim(R.intnet_instant_msngr_addr), trim(R.intnet_instant_msngr_addr),
																							     											                     L.intnet_instant_message_addr_4),
																				      L.intnet_instant_message_addr_4);
																							
		SELF.intnet_instant_message_addr_5   :=IF(temp_addrtype = 'IMSG', 
                                              IF(      L.intnet_instant_message_addr_4 <>'' 
																									 AND L.intnet_instant_message_addr_4 <> trim(R.intnet_instant_msngr_addr), 
																						       IF (L.intnet_instant_message_addr_5 ='', trim(R.intnet_instant_msngr_addr),
																						                                              L.intnet_instant_message_addr_5+';'+trim(R.intnet_instant_msngr_addr)),
																						       L.intnet_instant_message_addr_5),
																				      L.intnet_instant_message_addr_5);
//---------------------------------------------------------------------------------------------------------------------------------------------

    // Pick the first intnet_user name	
	  SELF.intnet_user_name_1   := IF(temp_addrtype = 'IUNAME', 
                                        IF(C=1, trim(R.intnet_user_name), 
		                                            IF (temp_addrtype <> L.current_address_type, trim(R.intnet_user_name),
																				                                                     L.intnet_user_name_1)),
																				L.intnet_user_name_1);
		                                      
		SELF.intnet_user_name_2   := IF(temp_addrtype = 'IUNAME', 
                                        IF(     L.intnet_user_name_2 ='' 
																						AND L.intnet_user_name_1 <>''
																						AND L.intnet_user_name_1 <> trim(R.intnet_user_name) , trim(R.intnet_user_name),
																																				        L.intnet_user_name_2),
																				L.intnet_user_name_2);
		SELF.intnet_user_name_3   :=IF(temp_addrtype = 'IUNAME', 
                                        IF(     L.intnet_user_name_3 ='' 
																						AND L.intnet_user_name_2 <>'' 
																						AND L.intnet_user_name_2 <> trim(R.intnet_user_name)	, trim(R.intnet_user_name),
																																				        L.intnet_user_name_3),
																				L.intnet_user_name_3);
		SELF.intnet_user_name_4   :=IF(temp_addrtype = 'IUNAME',  
		                                    IF(     L.intnet_user_name_4 ='' 
																				    AND L.intnet_user_name_3 <>'' 
																						AND L.intnet_user_name_3 <> trim(R.intnet_user_name), trim(R.intnet_user_name),
																																		            L.intnet_user_name_4),
																				L.intnet_user_name_4);
		SELF.intnet_user_name_5   :=IF(temp_addrtype = 'IUNAME', 
                                        IF(     L.intnet_user_name_4 <>''
																				    AND L.intnet_user_name_4 <> trim(R.intnet_user_name), 
																						IF (L.intnet_user_name_5 ='', trim(R.intnet_user_name),
																						                                  L.intnet_user_name_5+';'+trim(R.intnet_user_name)),
																						L.intnet_user_name_5),
																				L.intnet_user_name_5);
//---------------------------------------------------------------------------------------------------------------------------------------------
																				
	  SELF.intnet_user_name_1_url   := IF(temp_addrtype = 'IURL', 
                                        IF(C=1, trim(R.intnet_user_name_url), 
		                                            IF (temp_addrtype <> L.current_address_type, trim(R.intnet_user_name_url),
																				                                                     L.intnet_user_name_1_url)),
																				L.intnet_user_name_1_url);
		                                      
		SELF.intnet_user_name_2_url   := IF(temp_addrtype = 'IURL', 
                                        IF(     L.intnet_user_name_2_url ='' 
																						AND L.intnet_user_name_1_url <>'' 
																						AND L.intnet_user_name_1_url <> trim(R.intnet_user_name_url), trim(R.intnet_user_name_url),
																																				        L.intnet_user_name_2_url),
																				L.intnet_user_name_2_url);
		SELF.intnet_user_name_3_url  :=IF(temp_addrtype = 'IURL', 
                                        IF(     L.intnet_user_name_3_url ='' 
																						AND L.intnet_user_name_2_url <>'' 
																						AND L.intnet_user_name_2_url <> trim(R.intnet_user_name_url),trim(R.intnet_user_name_url),
																																				        L.intnet_user_name_3_url),
																				L.intnet_user_name_3_url); 
		SELF.intnet_user_name_4_url   :=IF(temp_addrtype = 'IURL',  
		                                    IF(     L.intnet_user_name_4_url ='' 
																				    AND L.intnet_user_name_3_url <>'' 
																						AND L.intnet_user_name_3_url <> trim(R.intnet_user_name_url), trim(R.intnet_user_name_url),
																																		            L.intnet_user_name_4_url),
																				L.intnet_user_name_4_url);
		SELF.intnet_user_name_5_url   :=IF(temp_addrtype = 'IURL', 
                                        IF(     L.intnet_user_name_4_url <>'' 
																				    AND L.intnet_user_name_4_url <> trim(R.intnet_user_name_url), 
																						IF (L.intnet_user_name_5_url ='', trim(R.intnet_user_name_url),
																						                                  L.intnet_user_name_5_url+';'+trim(R.intnet_user_name_url)),
																						L.intnet_user_name_5_url),
																				L.intnet_user_name_5_url);																				
//---------------------------------------------------------------------------------------------------------------------------------------------

    // Pick the first registration_address	
    varstring registration_address_1	 := IF(temp_addrtype = 'REG', IF(   C=1 
		                                                                   OR temp_addrtype <> L.current_address_type , 
																																         //MAP(R.name <> '' => trim(r.name), 
																																		        StringLib.StringCleanSpaces(street1_temp), //), 
																																		  L.registration_address_1), 
																															L.registration_address_1);		                                      
																																				
		varstring registration_address_2   := IF(temp_addrtype = 'REG', IF(   C=1
		                                                                   OR temp_addrtype <> L.current_address_type ,
																																					MAP ( registration_address_1 = R.name and street1_temp <> '' => street1_temp,
																																								registration_address_1 = street1_temp and street2_temp <> '' => street2_temp,  
																																								citystatezip), 
																																			L.registration_address_2), 
																															L.registration_address_2);
																																      
	  varstring registration_address_3   := IF(temp_addrtype = 'REG', 
		                                                      IF(   C=1
		                                                         OR temp_addrtype <> L.current_address_type ,
																																MAP ( registration_address_2 <> '' and registration_address_2 = street1_temp and street2_temp <> '' => street2_temp, 
																																			registration_address_2 <> '' and registration_address_2 = street2_temp and street3_temp <> '' => street3_temp,
																																			registration_address_2 <> '' and registration_address_2 = street1_temp and citystatezip <> '' => citystatezip,
																																			registration_address_2 <> '' and registration_address_2 = street2_temp and citystatezip <> '' => citystatezip,
																																			V_asofdate_temp),
																													      L.registration_address_3), 
																													L.registration_address_3);
		varstring registration_address_4   := IF(temp_addrtype = 'REG', 
		                                                      IF(   C=1
																													 	 OR temp_addrtype <> L.current_address_type ,
																																MAP ( registration_address_3 <> '' and registration_address_3 = street2_temp and street3_temp <> '' => street3_temp,
																																			registration_address_3 <> '' and registration_address_3 = street2_temp and citystatezip <> '' => citystatezip,
																																			registration_address_3 <> '' and registration_address_3 = street3_temp and citystatezip <> '' => citystatezip,
																																			registration_address_3 <> '' and registration_address_3 = street3_temp and V_asofdate_temp <> '' => V_asofdate_temp,
																																			registration_address_3 <> '' and registration_address_3 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			Address_status <>'' => Address_status,
																																			''),
																														    L.registration_address_4), 
																													L.registration_address_4);
		varstring registration_address_5   := IF(temp_addrtype = 'REG', 
		                                                       IF(   C=1
																														  OR temp_addrtype <> L.current_address_type ,
																															 	 MAP ( registration_address_4 <> '' and registration_address_4 = street3_temp    and citystatezip <> ''    => citystatezip,
																																	 		 registration_address_4 <> '' and registration_address_4 = citystatezip    and V_asofdate_temp <> '' => V_asofdate_temp,
																																			 registration_address_4 <> '' and registration_address_4 = citystatezip    and Address_status <>''   => Address_status,
																																			 registration_address_4 <> '' and registration_address_4 = V_asofdate_temp and Address_status <>''   => Address_status,
																																			 V_Misc_address_info <> '' => V_Misc_address_info,
																																			 ''),
																															   L.registration_address_5), 
																													 L.registration_address_5);
		
		SELF.registration_address_1		:=registration_address_1;		                                      
	  SELF.registration_address_2   :=registration_address_2;
	  SELF.registration_address_3  	:=registration_address_3;
		SELF.registration_address_4   :=registration_address_4;
		SELF.registration_address_5   :=registration_address_5;
		
		SELF.registration_county  	  :=IF(temp_addrtype = 'REG', IF(C=1, trim(R.county), 
		                                                                 IF (temp_addrtype <> L.current_address_type, trim(R.county),
																																				                                              L.registration_county)),
																																     L.registration_county);
 	  SELF.registration_home_phone  :=IF(temp_addrtype = 'REG', IF(C=1, trim(R.home_phone), 
		                                                                 IF (temp_addrtype <> L.current_address_type, trim(R.home_phone),
																																				                                              L.registration_home_phone)),
																																     L.registration_home_phone);
    SELF.registration_cell_phone  :=IF(temp_addrtype = 'REG', IF(C=1, trim(R.cell_phone), 
		                                                                 IF (temp_addrtype <> L.current_address_type, trim(R.cell_phone),
																																				                                              L.registration_cell_phone)),
																																     L.registration_cell_phone);
//---------------------------------------------------------------------------------------------------------------------------------------------
    // Pick the first Other registration_address	
		varstring other_registration_address_1	 := IF(temp_addrtype = 'OTH', IF(   C=1 
		                                                                   OR temp_addrtype <> L.current_address_type , 
																																         MAP(R.name <> '' => trim(r.name), 
																																		         street1_temp), 
																																		  L.other_registration_address_1), 
																															L.other_registration_address_1);		                                      
																																				
		varstring other_registration_address_2   := IF(temp_addrtype = 'OTH', IF(   C=1
		                                                                   OR temp_addrtype <> L.current_address_type ,
																																					MAP ( other_registration_address_1 = R.name and street1_temp <> '' => street1_temp,
																																								other_registration_address_1 = street1_temp and street2_temp <> '' => street2_temp,  
																																								citystatezip), 
																																			L.other_registration_address_2), 
																															L.other_registration_address_2);
																																      
	  varstring other_registration_address_3   := IF(temp_addrtype = 'OTH', 
		                                                      IF(   C=1
		                                                         OR temp_addrtype <> L.current_address_type ,
																																MAP ( other_registration_address_2 <> '' and other_registration_address_2 = street1_temp and street2_temp <> '' => street2_temp, 
																																			other_registration_address_2 <> '' and other_registration_address_2 = street2_temp and street3_temp <> '' => street3_temp,
																																			other_registration_address_2 <> '' and other_registration_address_2 = street1_temp and citystatezip <> '' => citystatezip,
																																			other_registration_address_2 <> '' and other_registration_address_2 = street2_temp and citystatezip <> '' => citystatezip,
																																			V_asofdate_temp),
																													      L.other_registration_address_3), 
																													L.other_registration_address_3);
		varstring other_registration_address_4   := IF(temp_addrtype = 'OTH', 
		                                                      IF(   C=1
																													 	 OR temp_addrtype <> L.current_address_type ,
																																MAP ( other_registration_address_3 <> '' and other_registration_address_3 = street2_temp and street3_temp <> '' => street3_temp,
																																			other_registration_address_3 <> '' and other_registration_address_3 = street2_temp and citystatezip <> '' => citystatezip,
																																			other_registration_address_3 <> '' and other_registration_address_3 = street3_temp and citystatezip <> '' => citystatezip,
																																			other_registration_address_3 <> '' and other_registration_address_3 = street3_temp and V_asofdate_temp <> '' => V_asofdate_temp,
																																			other_registration_address_3 <> '' and other_registration_address_3 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			Address_status <>'' => Address_status,
																																			''),
																														    L.other_registration_address_4), 
																													L.other_registration_address_4);
		varstring other_registration_address_5   := IF(temp_addrtype = 'OTH', 
		                                                       IF(   C=1
																														  OR temp_addrtype <> L.current_address_type ,
																															 	 MAP ( other_registration_address_4 <> '' and other_registration_address_4 = street3_temp and citystatezip <> '' => citystatezip,
																																	 		 other_registration_address_4 <> '' and other_registration_address_4 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			 other_registration_address_4 <> '' and other_registration_address_4 = citystatezip and Address_status <>'' => Address_status,
																																			 other_registration_address_4 <> '' and other_registration_address_4 = V_asofdate_temp and Address_status <>'' => Address_status,
																																			 V_Misc_address_info <> '' => V_Misc_address_info, //R.address_Verified <> '' => 'Source/Address Verified: '+trim(R.address_Verified),
																																			 ''),
																															   L.other_registration_address_5), 
																													 L.other_registration_address_5);																																		 
																																		 
		SELF.other_registration_address_1  :=other_registration_address_1;
		SELF.other_registration_address_2  :=other_registration_address_2;
		SELF.other_registration_address_3  :=other_registration_address_3;
    SELF.other_registration_address_4  :=other_registration_address_4;
		SELF.other_registration_address_5  :=other_registration_address_5;
		
		SELF.other_registration_county     :=IF(temp_addrtype = 'OTH', IF(C=1, trim(R.county), 
		                                                                       IF (temp_addrtype <> L.current_address_type, trim(R.county),
																																				                                              L.other_registration_county)),
																																           L.other_registration_county);
		SELF.other_registration_phone      :=IF(temp_addrtype = 'OTH', IF(C=1, trim(R.home_phone), 
		                                                                       IF (temp_addrtype <> L.current_address_type, trim(R.home_phone),
																																				                                              L.other_registration_phone)),
																																           L.other_registration_phone);
		
//---------------------------------------------------------------------------------------------------------------------------------------------
		// Pick the first Temp address
		varstring temp_lodge_address_1	 := IF(temp_addrtype = 'TEMP', IF(   C=1 
		                                                                   OR temp_addrtype <> L.current_address_type , 
																																         MAP(R.name <> '' => trim(r.name), 
																																		         street1_temp), 
																																		  L.temp_lodge_address_1), 
																															L.temp_lodge_address_1);		                                      
																																				
		varstring temp_lodge_address_2   := IF(temp_addrtype = 'TEMP', IF(   C=1
		                                                                   OR temp_addrtype <> L.current_address_type ,
																																					MAP ( temp_lodge_address_1 = R.name and street1_temp <> '' => street1_temp,
																																								temp_lodge_address_1 = street1_temp and street2_temp <> '' => street2_temp,  
																																								citystatezip), 
																																			L.temp_lodge_address_2), 
																															L.temp_lodge_address_2);
																																      
	  varstring temp_lodge_address_3   := IF(temp_addrtype = 'TEMP', 
		                                                      IF(   C=1
		                                                         OR temp_addrtype <> L.current_address_type ,
																																MAP ( temp_lodge_address_2 <> '' and temp_lodge_address_2 = street1_temp and street2_temp <> '' => street2_temp, 
																																			temp_lodge_address_2 <> '' and temp_lodge_address_2 = street2_temp and street3_temp <> '' => street3_temp,
																																			temp_lodge_address_2 <> '' and temp_lodge_address_2 = street1_temp and citystatezip <> '' => citystatezip,
																																			temp_lodge_address_2 <> '' and temp_lodge_address_2 = street2_temp and citystatezip <> '' => citystatezip,
																																			V_asofdate_temp),
																													      L.temp_lodge_address_3), 
																													L.temp_lodge_address_3);
		varstring temp_lodge_address_4   := IF(temp_addrtype = 'TEMP', 
		                                                      IF(   C=1
																													 	 OR temp_addrtype <> L.current_address_type ,
																																MAP ( temp_lodge_address_3 <> '' and temp_lodge_address_3 = street2_temp and street3_temp <> '' => street3_temp,
																																			temp_lodge_address_3 <> '' and temp_lodge_address_3 = street2_temp and citystatezip <> '' => citystatezip,
																																			temp_lodge_address_3 <> '' and temp_lodge_address_3 = street3_temp and citystatezip <> '' => citystatezip,
																																			temp_lodge_address_3 <> '' and temp_lodge_address_3 = street3_temp and V_asofdate_temp <> '' => V_asofdate_temp,
																																			temp_lodge_address_3 <> '' and temp_lodge_address_3 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			Address_status <>'' => Address_status,
																																			''),
																														    L.temp_lodge_address_4), 
																													L.temp_lodge_address_4);
		varstring temp_lodge_address_5   := IF(temp_addrtype = 'TEMP', 
		                                                       IF(   C=1
																														  OR temp_addrtype <> L.current_address_type ,
																															 	 MAP ( temp_lodge_address_4 <> '' and temp_lodge_address_4 = street3_temp and citystatezip <> '' => citystatezip,
																																	 		 temp_lodge_address_4 <> '' and temp_lodge_address_4 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			 temp_lodge_address_4 <> '' and temp_lodge_address_4 = citystatezip and Address_status <>'' => Address_status,
																																			 temp_lodge_address_4 <> '' and temp_lodge_address_4 = V_asofdate_temp and Address_status <>'' => Address_status,
																																			 V_Misc_address_info <> '' =>V_Misc_address_info, //R.address_Verified <> '' => 'Source/Address Verified: '+trim(R.address_Verified),
																																			 ''),
																															   L.temp_lodge_address_5), 
																													 L.temp_lodge_address_5);
																													 
		SELF.temp_lodge_address_1 :=temp_lodge_address_1;
		SELF.temp_lodge_address_2 :=temp_lodge_address_2;
		SELF.temp_lodge_address_3 :=temp_lodge_address_3;
    SELF.temp_lodge_address_4 :=temp_lodge_address_4;
    SELF.temp_lodge_address_5	:=temp_lodge_address_5;
		
		SELF.temp_lodge_county  	:=IF(temp_addrtype = 'TEMP', IF(C=1, trim(R.county), 
		                                                                 IF (temp_addrtype <> L.current_address_type, trim(R.county),
																																				                                              L.temp_lodge_county)),
																																     L.temp_lodge_county);
		SELF.temp_lodge_phone  	  :=IF(temp_addrtype = 'TEMP', IF(C=1, trim(R.home_phone), 
		                                                                 IF (temp_addrtype <> L.current_address_type, trim(R.home_phone),
																																				                                              L.temp_lodge_phone)),
																																     L.temp_lodge_phone);
		//---------------------------------------------------------------------------------------------------------------------------------------------
// Pick the first employer_address
		varstring employer_address_1	 := IF(temp_addrtype = 'EMP', IF(   C=1 
		                                                               OR temp_addrtype <> L.current_address_type , 
																																         MAP(street1_temp <> '' => street1_temp, 
																																		         ''), 
																																		  L.employer_address_1), 
		   																	 L.employer_address_1);		                                      
																																				
		varstring employer_address_2   := IF(temp_addrtype = 'EMP', IF(   C=1
		                                                                   OR temp_addrtype <> L.current_address_type ,
																																					MAP ( employer_address_1 = street1_temp and street2_temp <> '' => street2_temp,
																																					      employer_address_1 = street1_temp and citystatezip <> '' => citystatezip,
																																								//employer_address_1 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																								citystatezip), 
																																			L.employer_address_2), 
																				 L.employer_address_2);
																																      
	  varstring employer_address_3   := IF(temp_addrtype = 'EMP', IF(   C=1
		                                                            OR temp_addrtype <> L.current_address_type ,
																																MAP ( employer_address_2 <> '' and employer_address_2 = street2_temp and street3_temp <> '' => street3_temp,
																																			employer_address_2 <> '' and employer_address_2 = street2_temp and citystatezip <> '' => citystatezip,
																																			employer_address_2 <> '' and employer_address_2 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			V_asofdate_temp
																																			),
																													      L.employer_address_3), 
																				 L.employer_address_3);
		
		varstring employer_address_4   := IF(temp_addrtype = 'EMP', IF(   C=1
																													 	    OR temp_addrtype <> L.current_address_type ,
																																MAP ( employer_address_3 <> '' and employer_address_3 = street3_temp and citystatezip <> '' => citystatezip,
																																      employer_address_3 <> '' and employer_address_3 = street3_temp and V_asofdate_temp <> '' => V_asofdate_temp,
																																			employer_address_3 <> '' and employer_address_3 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			Address_status <>'' => Address_status,
																																			''),
																														    L.employer_address_4), 
																				 L.employer_address_4);
		varstring employer_address_5   := IF(temp_addrtype = 'EMP', IF(   C=1
																														    OR temp_addrtype <> L.current_address_type ,
																															 	 MAP ( employer_address_4 <> '' and employer_address_4 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																       employer_address_4 <> '' and employer_address_4 = citystatezip and Address_status <>'' => Address_status,
																																			 employer_address_4 <> '' and employer_address_4 = V_asofdate_temp and Address_status <>'' => Address_status,
																																			 V_Misc_address_info <>'' => V_Misc_address_info, 
																																			 ''),
																															   L.employer_address_5), 
																				 L.employer_address_5);
		
		SELF.employer             :=IF(temp_addrtype = 'EMP', IF(C=1, trim(R.name), 
		                                                             IF (temp_addrtype <> L.current_address_type, trim(R.name),
																																				                                              L.employer)),
																																 L.employer);
		SELF.employer_address_1  :=employer_address_1;
		SELF.employer_address_2  :=employer_address_2;
		SELF.employer_address_3  :=employer_address_3;
		SELF.employer_address_4  :=employer_address_4;
		SELF.employer_address_5  :=employer_address_5;
		
		SELF.employer_county  	 :=IF(temp_addrtype = 'EMP', IF(C=1, trim(R.county), 
		                                                             IF (temp_addrtype <> L.current_address_type, trim(R.county),
																																				                                              L.employer_county)),
																																 L.employer_county);
	  SELF.employer_phone  	   :=IF(temp_addrtype = 'EMP', IF(C=1, trim(R.home_phone), 
		                                                             IF (temp_addrtype <> L.current_address_type, trim(R.home_phone),
																																				                                              L.employer_phone)),
																																 L.employer_phone);
		SELF.employer_comments   :=IF(temp_addrtype = 'EMP', IF(C=1, trim(R.comments), 
		                                                             IF (temp_addrtype <> L.current_address_type, trim(R.comments),
																																				                                              L.employer_comments)),
																																 L.employer_comments);
		//---------------------------------------------------------------------------------------------------------------------------------------------
		SELF.professional_licenses_1  :=IF(temp_addrtype = 'PLIC', IF(C=1, trim(R.street), 
		                                                                   IF (temp_addrtype <> L.current_address_type, trim(R.street),
																																				                                              L.professional_licenses_1)),
																																       L.professional_licenses_1);
		SELF.professional_licenses_2  :=IF(temp_addrtype = 'PLIC', IF(C=1, citystatezip, 
		                                                                   IF (temp_addrtype <> L.current_address_type, citystatezip,
																																				                                              L.professional_licenses_2)),
																																        L.professional_licenses_2);
		SELF.professional_licenses_3  :=IF(temp_addrtype = 'PLIC', IF(C=1, V_asofdate_temp, 
		                                                                  IF (temp_addrtype <> L.current_address_type and V_asofdate_temp <>'', V_asofdate_temp,
																																				                                              L.professional_licenses_3)),
																																       L.professional_licenses_3);	
		//SELF.professional_licenses_4  :='';
		//SELF.professional_licenses_5  :='';
		
		//---------------------------------------------------------------------------------------------------------------------------------------------
    // Pick the first employer_address		
		varstring school_address_1	 := IF(temp_addrtype = 'SCH', IF(   C=1 
		                                                               OR temp_addrtype <> L.current_address_type , 
																																         MAP(street1_temp <> '' => street1_temp, 
																																		         ''), 
																																		  L.school_address_1), 
																															L.school_address_1);		                                      
																																				
		varstring school_address_2   := IF(temp_addrtype = 'SCH', IF(   C=1
		                                                                   OR temp_addrtype <> L.current_address_type ,
																																					MAP ( school_address_1 = street1_temp and street2_temp <> '' => street2_temp,
																																					      school_address_1 = street1_temp and citystatezip <> '' => citystatezip,
																																							//	school_address_1 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																								citystatezip), 
																																			L.school_address_2), 
																															L.school_address_2);
																																      
	  varstring school_address_3   := IF(temp_addrtype = 'SCH', 
		                                                      IF(   C=1
		                                                         OR temp_addrtype <> L.current_address_type ,
																																MAP ( school_address_2 <> '' and school_address_2 = street2_temp and street3_temp <> '' => street3_temp,
																																			school_address_2 <> '' and school_address_2 = street2_temp and citystatezip <> '' => citystatezip,
																																			school_address_2 <> '' and school_address_2 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			V_asofdate_temp),
																													      L.school_address_3), 
																													L.school_address_3);
		varstring school_address_4   := IF(temp_addrtype = 'SCH', 
		                                                      IF(   C=1
																													 	 OR temp_addrtype <> L.current_address_type ,
																																MAP ( school_address_3 <> '' and school_address_3 = street3_temp and citystatezip <> '' => citystatezip,
																																      school_address_3 <> '' and school_address_3 = street3_temp and V_asofdate_temp <> '' => V_asofdate_temp,
																																			school_address_3 <> '' and school_address_3 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			Address_status
																																			),
																														    L.school_address_4), 
																													L.school_address_4);
		varstring school_address_5   := IF(temp_addrtype = 'SCH', 
		                                                       IF(   C=1
																														  OR temp_addrtype <> L.current_address_type ,
																															 	 MAP ( school_address_4 <> '' and school_address_4 = citystatezip and V_asofdate_temp <> '' => V_asofdate_temp,
																																			 school_address_4 <> '' and school_address_4 = citystatezip and Address_status <>'' => Address_status,
																																			 school_address_4 <> '' and school_address_4 = V_asofdate_temp and Address_status <>'' => Address_status,
																																			 V_Misc_address_info ),
																															   L.school_address_5), 
																													 L.school_address_5);
		
		
		SELF.school  		             :=IF(temp_addrtype = 'SCH', IF(C=1, trim(R.name), 
		                                                          IF (temp_addrtype <> L.current_address_type, trim(R.name),
																																				                                              L.school)),
																															L.school);
		SELF.school_address_1 :=school_address_1;
		SELF.school_address_2 :=school_address_2;
		SELF.school_address_3 :=school_address_3;	
		SELF.school_address_4 :=school_address_4;
		SELF.school_address_5 :=school_address_5;
		
		SELF.school_county   :=IF(temp_addrtype = 'SCH', IF(C=1, trim(R.county), 
		                                                          IF (temp_addrtype <> L.current_address_type, trim(R.county),
																																				                                              L.school_county)),
																															L.school_county);
 		SELF.school_phone    :=IF(temp_addrtype = 'SCH', IF(C=1, trim(R.home_phone), 
		                                                          IF (temp_addrtype <> L.current_address_type, trim(R.home_phone),
																																			                                                L.school_phone)),
																															L.school_phone);
 		SELF.school_comments :=IF(temp_addrtype = 'SCH', IF(C=1, trim(R.comments), 
		                                                          IF (temp_addrtype <> L.current_address_type, trim(R.comments),
																																				                                              L.school_comments)),
																														  L.school_comments);
																															
		//Concatenate the additional addresses and limit the size to be mapped to Addl comments
   	String V_addl_address_temp1    :=  IF ( C=1
																						OR temp_addrtype <> L.current_address_type , '' ,
																						    IF (street1_temp <> '',street1_temp,'') + 
																								IF (Street2_temp <> '',', '+Street2_temp,'')+
																								IF (Street3_temp <> '',', '+Street3_temp,'')+
																								IF (citystatezip <> '',', '+citystatezip,'')+
																								IF (R.county <> '',', County :'+R.county,''));
																								
		String V_addl_address_temp2    :=  IF (V_addl_address_temp1[1..2] = ', ',V_addl_address_temp1[3..], V_addl_address_temp1);
		
		String V_addl_address_temp3    :=  IF (V_addl_address_temp2 <>'',trim(R.address_type)+' ADDRESS: '+V_addl_address_temp2,
																					 '');
																								
		SELF.Additional_address_reg    :=  IF (temp_addrtype = 'REG' and V_addl_address_temp3 <> '', 
		                                           IF (L.Additional_address_reg <>'', 
																							             IF(LENGTH(L.Additional_address_reg + ';'+V_addl_address_temp3) <=2000, L.Additional_address_reg + ';'+V_addl_address_temp3,''),
																								           V_addl_address_temp3),
																							 L.Additional_address_reg
																					);
																						   
		SELF.Additional_address_Oth    :=  IF (temp_addrtype <> 'REG' and V_addl_address_temp3 <> '', 
		                                          IF (L.Additional_address_oth <>'', 
																							             IF(LENGTH(L.Additional_address_oth + ';'+V_addl_address_temp3) <=2000, L.Additional_address_oth + ';'+V_addl_address_temp3,''),
																								           V_addl_address_temp3),
																							 L.Additional_address_oth
																					);
		//Set the current records address type to be. Used to skip the next set of records with the same ID and same addresstype.   	
																					    
		SELF.current_address_type      :=  IF (C=1, temp_addrtype,
			                                          IF(temp_addrtype <> L.current_address_type, temp_addrtype,L.current_address_type)
																					);																									  
		SELF := L;
end;
		 
export Mapping_Denorm_Address := DENORMALIZE(IdTable,DAddressSorted,
                                // File_Soff_Address,
                                 LEFT.id = RIGHT.id,
                                 Denormaddress(LEFT,RIGHT,COUNTER),LOCAL);
