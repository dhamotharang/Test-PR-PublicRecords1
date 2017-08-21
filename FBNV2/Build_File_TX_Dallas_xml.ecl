import Address,_control,VersionControl;
#option('maxLength', 1000000);
export Build_File_TX_Dallas_xml(STRING pFileName,
                                STRING pProcessDate,
								BOOLEAN pSpray = TRUE) := 
module

//Spray Input Files Section
ISFName := '~thor_data400::in::fbnv2::tx_dallas_raw';
ILFName := '~thor_data400::in::fbnv2::tx_dallas_' + pPRocessDate + '_' + pFileName;

FilesToSpray := DATASET([{_control.IPAddress.edata10,
                         '/data_build_4/fbn/sources/tx/dallas/' + pPRocessDate,												
                         pFileName,                         
   	 	                 0, //Because it's delimited                                                            
 	 	                 ILFName,
                         [{ISFName}],    
						 /*'thor_200',*/
						 'thor400_30',
						 pProcessDate,
					 	 '',
					     'VARIABLE',
					     '',
					     1000000,
						 '',
						 '\\r\\n'}],VersionControl.Layout_Sprays.Info); 
											  			 
SprayedFile := VersionControl.fSprayInputFiles(FilesToSpray,,,TRUE,,,,,,);


//XML Parse Section
Layout_Business_Address := RECORD, maxlength(1000000)
 STRING StrAddr;
 STRING City;
 STRING State;
 STRING Zip;	
end;

Layout_Owner := RECORD, maxlength(1000000)
 STRING FullName;
 STRING StrAddr;
 STRING City;
 STRING State;
 STRING Zip;
end; 


Layout_Doc := RECORD, maxlength(1000000)
 STRING Doc ;
 STRING DateLastTrans ;
 STRING Legend;
 STRING Publication;
 STRING DBAName; 
 STRING FilingType; 
 STRING FilingDate; 
 STRING FilingNumber; 
 STRING LNDocServ; 
 STRING FileId; 
 STRING CiteId;  
 DATASET(Layout_Business_Address) Bus_Addr;  
 DATASET(Layout_Owner) Owner;             
 STRING NameSeq;    
 STRING VendorDocId;
end;
  


Layout_Doc t1 := TRANSFORM 
 SELF.Doc := XMLTEXT('@doc');
 SELF.DateLastTrans := XMLTEXT('TD');
 SELF.Legend           := XMLTEXT('LG2');
 SELF.Publication      := XMLTEXT('PU');
 SELF.DBAName          := XMLTEXT('DN'); 
 SELF.FilingType       := XMLTEXT('TYP'); 
 SELF.FilingDate       := XMLTEXT('FD'); 
 SELF.FilingNumber     := XMLTEXT('FN'); 
 SELF.LNDocServ        := XMLTEXT('LXD'); 
 SELF.FileId           := XMLTEXT('FI'); 
 SELF.CiteId           := XMLTEXT('CI');  
 SELF.Bus_Addr :=      XMLPROJECT('BA',
                                  TRANSFORM(Layout_Business_Address,
								            SELF.StrAddr    := XMLTEXT('S1'),
											SELF.City       := XMLTEXT('CY'),
                                            SELF.State      := XMLTEXT('ST'),
                                            SELF.Zip	    := XMLTEXT('ZP') )); 
 SELF.Owner := XMLPROJECT('OW',
                          TRANSFORM(Layout_Owner,
								    SELF.FullName  := XMLTEXT('FL');
                                    SELF.StrAddr   := XMLTEXT('S1');
                                    SELF.City      := XMLTEXT('CY');
                                    SELF.State     := XMLTEXT('ST');
                                    SELF.Zip	   := XMLTEXT('ZP'); )); 
  
 SELF.NameSeq          := XMLTEXT('NS');    
 SELF.VendorDocId      := XMLTEXT('VI');
end;


generic := record, maxlength(1000000)
STRING line;
end;
 
a := DATASET(ISFName,generic,csv(maxlength(1000000),
                                 separator(['']),
                                 terminator(['\r\n'])) );


b := PARSE(a,line,t1,XML('doc'));

//--Normalize out Business Addr and Owner child sets

BA_XactTbl := TABLE(b,{INTEGER XactCount := COUNT(Bus_Addr),b});
OW_XactTbl := TABLE(b,{INTEGER XactCount := COUNT(Owner),b});



Layout_BA_Norm := RECORD, maxlength(1000000)
 STRING FilingNumber;
 Layout_Business_Address ;
end;

Layout_OW_Norm := RECORD, maxlength(1000000)
 STRING FilingNumber;
 Layout_Owner ;
end;

Layout_BA_Norm GetAddresses(BA_XactTbl L, INTEGER C) := TRANSFORM
  SELF.FilingNumber := L.FilingNumber;
	SELF := L.Bus_Addr[C];
end;

Layout_OW_Norm GetOwners(OW_XactTbl L, INTEGER C) := TRANSFORM
  SELF.FilingNumber := L.FilingNumber;
	SELF := L.Owner[C];
end;

Addresses := NORMALIZE(BA_XactTbl,LEFT.XactCount,GetAddresses(LEFT,COUNTER));
Owners := NORMALIZE(OW_XactTbl,LEFT.XactCount,GetOwners(LEFT,COUNTER));

//---------------------------
ConvDates(STRING pDate) := FUNCTION
 _dt := pDate; 
 _mm := _dt[1..StringLib.StringFind(_dt,'/',1) - 1];
 _dd := _dt[StringLib.StringFind(_dt,'/',1) + 1 .. 
            StringLib.StringFind(_dt,'/',2) - 1 ];
 _yyyy := _dt[	StringLib.StringFind(_dt,'/',2) + 1	.. ];
 RETURN _yyyy + 
        if((INTEGER)_mm < 10, '0' + _mm, _mm) + 
        if((INTEGER)_dd < 10, '0' + _dd, _dd);
end;
 

MainDoc := PROJECT(b,TRANSFORM(Fbnv2.Layout_xml.txd,SELF.DBAName := LEFT.DBAName ;
                                                  	SELF.FilingDate := ConvDates(LEFT.FilingDate);
                                                    SELF.FileId := LEFT.FileId;
																								    SELF.FilingNumber := LEFT.FilingNumber;
																								    SELF.DateLastTrans := ConvDates(LEFT.DateLastTrans);
																								    SELF.FilingType := LEFT.FilingType;
																								    SELF := [];));
																							
DocBusAddr := JOIN(MainDoc,Addresses,
                   TRIM(LEFT.FilingNUmber,LEFT,RIGHT) = 
									 TRIM(RIGHT.FilingNUmber,LEFT,RIGHT),
									 TRANSFORM(Fbnv2.Layout_xml.txd,SELF.BusAddress := RIGHT.StrAddr;
                                                  SELF.BusCity := RIGHT.City;
                                                  SELF.BusState := RIGHT.State;
                                                  SELF.BusZip := RIGHT.Zip;
																									SELF := LEFT;
																									SELF := []),
									 LEFT OUTER,
									 HASH);

DocOwner := JOIN(DocBusAddr,Owners,
                   TRIM(LEFT.FilingNUmber,LEFT,RIGHT) = 
									 TRIM(RIGHT.FilingNUmber,LEFT,RIGHT),
									 TRANSFORM(Fbnv2.Layout_xml.txd, SELF.Ownerflname := RIGHT.FullName;
		                                               SELF.Owneraddress := RIGHT.StrAddr;	
		                                               SELF.OwnerCity := RIGHT.City;	
		                                               SELF.OwnerState := RIGHT.State;	
		                                               SELF.OwnerZIP := RIGHT.Zip ; 	
		                                               SELF := LEFT;
																									 SELF := []),
									 LEFT OUTER,
									 HASH);

 _File_TX_Dallas_xml := PROJECT(DocOwner,TRANSFORM(Fbnv2.Layout_xml.txd,SELF.clean_address := 
                                                            Address.CleanAddress182(LEFT.BusAddress,
                                                                                         LEFT.BusCity + ' ' + LEFT.BusState + ' ' + LEFT.BusZip);
																														SELF.clean_own_addres := 
																														Address.CleanAddress182(LEFT.OwnerAddress,
                                                                                         LEFT.OwnerCity + ' ' + LEFT.OwnerState + ' ' + LEFT.OwnerZip);
																														
																														_pname := Address.Clean_n_Validate_Name(LEFT.Ownerflname, 'L').CleanNameRecord;
																														SELF.pname := _pname.title + ' ' +
																														              _pname.fname + ' ' +
																																					_pname.mname + ' ' +
																																					_pname.lname + ' ' +
																																					_pname.name_suffix + ' ' +
																																					_pname.name_score;
													 							SELF := LEFT;));

//MAIN

STRING fname := regexreplace('raw',ILFName,'converted');

_spray := IF(pSpray,sequential( FileServices.ClearSuperFile(ISFName,false)
		                       ,SprayedFile)
							   );
_write := OUTPUT(_File_TX_Dallas_xml,,fname,__COMPRESSED__,OVERWRITE);
_add := FileServices.AddSuperFile('~thor_data400::in::fbnv2::tx_dallas_converted',fname);
EXPORT main := SEQUENTIAL(_spray,_write,_add);










end;