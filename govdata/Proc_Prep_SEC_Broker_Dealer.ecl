IMPORT lib_fileservices, _control, NID, ut, Address, Scrubs, Scrubs_Govdata;
EXPORT Proc_Prep_SEC_Broker_Dealer(string filedate) := module

	//Spray SEC Raw file
	string					CSVSeparator				:= '\t';
	string					CSVQuote						:= '"';
	string          CSVTerminator       := '\n';
	string					SECLF								:= '~thor_data400::in::sec_broker_dealer::raw_'+filedate;	
	string          sourceLZ            := '/data/data_lib_2_hus2/SEC_Broker_Dealer_Information/data/'+filedate+'/';
	string					SECSF								:= '~thor_data400::in::sec_broker_dealer::raw';

	spraySECFile	:=	if(	EXISTS(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata11,sourceLZ,'bd*.txt')) and fileservices.FindSuperFileSubName(SECSF,SECLF) = 0  ,
												Sequential(if(fileservices.SuperFileExists(SECSF),fileservices.ClearSuperfile(SECSF) ),
																	 fileservices.sprayvariable(_control.IPAddress.bctlpedata11,
																															sourceLZ + 'bd*.txt',
																															,
																															CSVSeparator,
																															CSVTerminator ,
																															CSVQuote,
																															_control.TargetGroup.Thor400_44,
																															//	'thor400_dev01',
																															SECLF,
																															,,,true,false,false
																															), 
																	 output('No SEC BD files recieved or SEC BD were already Sprayed')
																	)
												); 
																	
	addSECSuper   := Sequential (  fileservices.StartSuperFileTransaction( ),
																 if ( NOT fileservices.SuperFileExists( SECSF),fileservices.CreateSuperfile(SECSF)),
																 if (  fileservices.SuperFileExists( SECSF),fileservices.ClearSuperfile( SECSF)),
																 fileservices.AddSuperfile( SECSF,SECLF),
																 fileservices.FinishSuperFileTransaction( )
																 );						

	spraySECRaw	  :=	Sequential(spraySECFile,addSECSuper);

		//Map SEC Raw file	
	fixedlayout := record
		 string20  process_date;
		 string10  CIK_NUMBER;
		 string60  COMPANY_NAME;
		 string8   REPORTING_FILE_NUMBER;
		 string40  ADDRESS1;
		 string40  ADDRESS2;
		 string30  CITY;
		 string2   STATE_CODE;
		 string10  ZIP_CODE;
		 string9   IRS_TAXPAYER_ID;
		 string182 clean_address;
		 string73  pname;
		 string60  cname;
		 data2     is_company_flag;
		 string1   lf;
	end;

	fixedlayout	map2clean ( File_SEC_Broker_Dealer_Raw l ) := transform

		line1 										 := map (l.ADDRESS1 <> '' and  l.ADDRESS2 <> '' =>   trim(l.ADDRESS1) + ' '+ trim(l.ADDRESS2),
																		   l.ADDRESS1 <> '' and  l.ADDRESS2 = ''  =>   trim(l.ADDRESS1),trim(l.ADDRESS2) );									
		line2 										 := trim(l.CITY) + ' '+ trim(l.STATE) + ' '+ trim(l.ZIP);
		self.process_date          := filedate;
		self.CIK_NUMBER            := l.cie_number;
		self.COMPANY_NAME          := l.name;
		self.REPORTING_FILE_NUMBER := l.reporting_filing_number;
		self.ADDRESS1              := l.address1;
		self.ADDRESS2              := l.address2;
		self.CITY                  := l.city;
		self.STATE_CODE            := l.state;
		self.ZIP_CODE              := trim(l.zip)[1..10];
		self.IRS_TAXPAYER_ID       := '';
		self.lf                    := '\n';
		self.pname                 := if(NID.GetNameType ( l.name) <> 'B' , Address.CleanPerson73 ( l.name),'');
		self.cname                 := if(NID.GetNameType ( l.name) = 'B' , l.name,'');
		self.is_company_flag       := if(NID.GetNameType ( l.name) = 'B',(data)1,(data)0);
		self.clean_address         := Address.CleanAddress182( line1,line2);

	end;
		
	dWithClean  := project( File_SEC_Broker_Dealer_Raw ,map2clean (left));

	Layout_SEC_Broker_Dealer_In  map2cleanff (dWithClean l) := transform
		self.dt_first_reported   := filedate;
		self.dt_last_reported    := filedate;
		self.title				       :=	l.pname[1..5];
		self.fname               :=	l.pname[6..25];    
		self.mname               :=	l.pname[26..45];   
		self.lname               :=	l.pname[46..65];   
		self.name_suffix         :=	l.pname[66..70];   
		self.name_score          :=	l.pname[71..73]; 
		self.prim_range		       :=	l.clean_address[1..10];   
		self.predir				       :=	l.clean_address[11..12];  
		self.prim_name		       :=	l.clean_address[13..40];    
		self.addr_suffix	       := l.clean_address[41..44];    
		self.postdir			       :=	l.clean_address[45..46];    
		self.unit_desig		       :=	l.clean_address[47..56];  
		self.sec_range		       :=	l.clean_address[57..64];    
		self.p_city_name	       :=	l.clean_address[65..89];    
		self.v_city_name	       := l.clean_address[90..114];   
		self.st						       :=	l.clean_address[115..116];
		self.zip					       :=	l.clean_address[117..121];  
		self.zip4					       :=	l.clean_address[122..125];
		self.cart					       :=	l.clean_address[126..129];
		self.cr_sort_sz		       :=	l.clean_address[130];     
		self.lot					       :=	l.clean_address[131..134];  
		self.lot_order		       :=	l.clean_address[135];       
		self.dpbc					       :=	l.clean_address[136..137];
		self.chk_digit		       :=	l.clean_address[138];       
		self.record_type	       :=	l.clean_address[139..140];
		self.ace_fips_st	       :=	l.clean_address[141..142];
		self.county     	       :=	l.clean_address[143..145];  
		self.geo_lat			       :=	l.clean_address[146..155];  
		self.geo_long			       :=	l.clean_address[156..166];
		self.msa					       :=	l.clean_address[167..170];  
		self.geo_blk			       :=	l.clean_address[171..177];  
		self.geo_match		       :=	l.clean_address[178];       
		self.err_stat			       :=	l.clean_address[179..182];
		self                     := l;  
	end;

	d_Clean_new     := project( dWithClean,map2cleanff(left)) : persist('~thor_data400::persist::sec_bd_clean');

	dprev 			    := govdata.File_SEC_Broker_Dealer_In;
	
	dfinal 			    := d_Clean_new + dprev ;
	
  scrub_base      := scrubs.ScrubsPlus('SEC_BrokerDealer','Scrubs_Govdata','Scrubs_Govdata_SEC_BrokerDealer_Base', 'Base', filedate, Email_Notification_Lists().Stats, false);
																
	export buildall := Sequential ( spraySECRaw,
																	if(fileServices.FindSuperFileSubName('~thor_data400::base::sec_bd_info','~thor_data400::in::sec_bd_info_'+filedate) <> 0 ,
																		 fileServices.ClearSuperfile('~thor_data400::base::sec_bd_info')
																		 ),
																	output( sort ( dfinal, CIK_NUMBER ) ,,'~thor_data400::in::sec_bd_info_'+filedate,overwrite) ,
																	fileServices.StartSuperfiletransaction(),
																	fileservices.clearsuperfile('~thor_data400::base::sec_bd_info'),
																	fileservices.addsuperfile('~thor_data400::base::sec_bd_info','~thor_data400::in::sec_bd_info_'+filedate),
																	fileServices.FinishSuperfiletransaction(),
																  scrub_base
																 );
end;





	