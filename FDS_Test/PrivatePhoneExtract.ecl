import header,address,ut,versioncontrol,watchdog,phonesplus, yellowpages, cellphone,risk_indicators , gong, doxie, doxie_raw, _validate;

layp := phonesplus.layoutCommonOut;

pplus := phonesplus.file_phonesplus_base;

export PrivatePhoneExtract(
	 string					pversion
	,dataset(layp)  		pPhonesPlus   	= pplus
	,set of string			pZipCodes		= ZipcodeSet		
	,boolean				pOverwrite		= true
	,boolean				pCsvout			= true
	,string					pSeparator		= '|'	

) :=
function

	temp_layout := record
	 unsigned did;
	 string fname;
	 string mname;
	 string lname;
	 string prim_range;
   	 string predir;
   	 string prim_name;
   	 string addr_suffix;
   	 string postdir;
	 string unit_desig;
   	 string sec_range;
	 string p_city_name;
	 string v_city_name;
	 string state;
	 string zip5;
	 string zip4;
	 unsigned datevendorfirstreported;
	 unsigned datefirstseen;
	 string phone_number;
	 unsigned confidencescore;
	end;

	phones_t := project(pPhonesPlus, transform(temp_layout, self.phone_number := left.cellphone, self := left));
	yellowpages.NPA_PhoneType(phones_t, phone_number, phonetype, pPhonesPlusPhType);
	
	
	//--------select pplus records that match zipcode file and are above threhold
	phones_filter := pPhonesPlusPhType(zip5 in pZipCodes and confidencescore > 10);
	
	temp_layout2 := record
	recordof(phones_filter);
	string ocn;
	end;
	
	//--------Append Telcordia data
	g2 := join(phones_filter, risk_indicators.Key_Telcordia_tpm, keyed(left.phone_number[1..3] = right.npa) and keyed(left.phone_number[4..6] = right.nxx) and left.phone_number[7] = right.tb, transform(temp_layout2, self.ocn := right.ocn, self := left),left outer, keep(1));
	    
	//------Dedup records and filter blank addresses where there is another record for the same individual and phone with an address  
		//---Split record with blank addresses
			no_address := g2(trim(prim_range + prim_name + sec_range, all) = '');
			no_address_with_did_dedp := dedup(sort(distribute(no_address(did > 0),  hash(phone_number)),phone_number, did, datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name,-lname, -fname, -sec_range,local), phone_number, did, prim_range,prim_name, zip5, local);
			no_address_no_did_dedp := dedup(sort(distribute(no_address(did = 0),  hash(phone_number)),phone_number,  datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name, -lname, -fname, -sec_range,local), phone_number, prim_range,prim_name, zip5, lname, local);

			with_address := g2(trim(prim_range + prim_name + sec_range, all) <> '');

		//-----Dedup records by phone, did and address
			pplus_with_address_did := dedup(sort(distribute(with_address(did > 0),  hash(phone_number)),phone_number, did, datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name,-lname, -fname, -sec_range, local), phone_number, did, prim_range,prim_name, zip5, lname, fname, local);

		//-----Dedup records by phone, name and address
			pplus_with_address_no_did := dedup(sort(distribute(with_address(did = 0),  hash(phone_number)),phone_number,datefirstseen <> 0, -zip5, -zip4, -prim_range, -prim_name, -lname, -fname, -sec_range, local), phone_number, prim_range,prim_name, zip5, lname, fname, local);

		//----Concatenate all records to be included with address
			pplus_all_with_address  := pplus_with_address_did + pplus_with_address_no_did;

		//---Filter records with no address where that records is the only one available for the phone and individual
			no_address_only_one := join(distribute(no_address_with_did_dedp + no_address_no_did_dedp, hash(phone_number)),
										distribute(pplus_all_with_address, hash(phone_number)),
										left.phone_number = right.phone_number and
										 (left.did = right.did or
										  (left.did = 0 and
										  left.lname = right.lname and
										  left.fname = right.fname)),
										  transform(recordof(g2), self := left),
										  left only,
										  local);

		//----Concatenate all records to be included in final base file
			pplus_all_a := pplus_all_with_address + no_address_only_one;
	
	//----Filter records without first-last name where there is another record with the same phone but with names 
		   pplus_no_names    := pplus_all_a(fname+lname = ''); 
		   ppplus_with_names := pplus_all_a(fname+lname <> ''); 
		   
	   // Filter records with no names where another rec with same phone has a name
	      no_name_only_one   := join(distribute(pplus_no_names, hash(phone_number)),
		                             distribute(ppplus_with_names , hash(phone_number)),
									 left.phone_number = right.phone_number and
									 left.prim_range = right.prim_range and
									 left.prim_name = right.prim_name and
									 left.sec_range = right.sec_range,
									 transform(recordof(g2), self := left),
										  left only,
										  local);
										  
		//----Concatenate all records to be included in final base file
		pplus_all_b := ppplus_with_names + no_name_only_one;
	
    //transform to extract response layout
   	layout_phone.Response.PrivatePhone_Extract tConvert2Response(pplus_all_b l,unsigned8 cnt) :=
   	transform
	
	//--------code from doxie.phone_noreconn_search to determine phone type
	 	
		datefirstseen_yr := if(l.datefirstseen > 0, (string)l.datefirstseen[..4], '');
		datefirstseen_mm := if( (unsigned)(string) l.datefirstseen[5..6] > 0, (string)l.datefirstseen[5..6], '00');
   		
		self.Record_ID		 	 := if(l.did > 0, (string)l.did, '00'+(string)cnt);
   		self.first_Name			 := l.fname;
   		self.middle_Name		 := l.mname;
   		self.last_Name			 := l.lname;
   		self.Street_Address		 := trim(Address.Addr1FromComponents(
   																 l.prim_range
   																,l.predir
   																,l.prim_name
   																,l.addr_suffix
   																,l.postdir
   																,'',''
   															),left,right);
   		self.Secondary_Address := trim(Address.Addr1FromComponents(
   																 l.unit_desig
   																,l.sec_range
   																,''
   																,''
   																,''
   																,''
   																,''
   															),left,right);
   		self.City				:= if(l.p_city_name <> '', l.p_city_name, l.v_city_name);
   		self.State				:= l.state;
   		self.Zip_Code			:= if(l.zip5 != '',l.zip5,'');
   		self.Phone_Number		:= if(l.phone_number != '',l.phone_number,'');
		self.Line_Type			:= map(l.PhoneType[..4] in ['CELL', 'LNDL'] => 'Wireless',
		                               l.PhoneType = 'POTS' => 'Landline',
									   l.PhoneType = 'PAGE' => 'Paging',
									   'Landline');
		self.original_carrier   := l.ocn;
		self.first_reported     := if(l.datefirstseen > 0  and (unsigned) _validate.date.fCorrectedDateString((string)l.datefirstseen) <> 0  , intformat(ut.Date_MMDDYYYY_i2(datefirstseen_yr + datefirstseen_mm +'00'),8,1), '');
		self := []
   	end;
  
   	dresponse_p := project(pplus_all_b,tConvert2Response(left,counter)) : persist('~thor_200::persist::fds::privatephone') ; 
    dresponse_s := sort(distribute(dresponse_p, hash64(Phone_Number)), Phone_Number, last_Name ,first_Name,middle_Name, Street_Address, Secondary_Address, City, State,Zip_Code, -Record_ID, first_reported <> '', local) ;
    dresponse_ded := dedup(dresponse_s, Phone_Number, last_Name ,first_Name,middle_Name, Street_Address, Secondary_Address, City, State,Zip_Code,local) ; 

    top5_results := dedup(sort(dresponse_ded, Record_ID, -first_reported), Record_ID, keep(5));
 
    dresponse := sort(top5_results(last_name <> ''), Zip_Code);
   	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.PrivatePhone_Extract.new	,dresponse	,BuildResponseFile,,,pOverwrite);
	VersionControl.macBuildNewLogicalFile(Filenames(pversion).out.PrivatePhone_Extract.new	 + 'PipeDelimited',dresponse	,BuildResponseFilePipe,,pCsvout,pOverwrite,pSeparator);
   
   	dresponse_forstats := project(dresponse,transform({Layout_phone.Response.PrivatePhone_Extract,string stuff}, self := left;self.stuff := 'G'));
   	
   	layout_stat := 
   	record
       integer countGroup := count(group);
   		dresponse_forstats.stuff  ;
   		Record_ID_CountNonBlank          := sum(group,if(dresponse_forstats.Record_ID			<>'',1,0));
   		First_Name_CountNonBlank	     := sum(group,if(dresponse_forstats.first_Name			<>'',1,0));
   		Middle_Name_CountNonBlank    	 := sum(group,if(dresponse_forstats.middle_Name			<>'',1,0));
   		Last_Name_CountNonBlank     	 := sum(group,if(dresponse_forstats.last_Name			<>'',1,0));
   		Street_Address_CountNonBlank     := sum(group,if(dresponse_forstats.Street_Address		<>'',1,0));
   		Secondary_Address_CountNonBlank  := sum(group,if(dresponse_forstats.Secondary_Address	<>'',1,0));
   		City_CountNonBlank               := sum(group,if(dresponse_forstats.City				<>'',1,0));
   		State_CountNonBlank              := sum(group,if(dresponse_forstats.State				<>'',1,0));
   		Zip_Code_CountNonBlank           := sum(group,if(dresponse_forstats.Zip_Code			<>'',1,0));
   		Phone_Number_CountNonBlank       := sum(group,if(dresponse_forstats.Phone_Number		<>'',1,0));
    	Line_Type_CountNonBlank       	 := sum(group,if(dresponse_forstats.Line_Type			<>'',1,0));  
    	Original_Carrier_CountNonBlank   := sum(group,if(dresponse_forstats.Original_Carrier	<>'',1,0)); 
 		First_Reported_CountNonBlank     := sum(group,if(dresponse_forstats.First_Reported		<>'',1,0));  		
		end;
   	
   	dresponse_stats := table(dresponse_forstats, layout_stat, stuff,few);

	return sequential(
		 output('FDS Extract Results Follow'	,named('__'							))
		,output(choosen(dresponse_forstats,100))
		,BuildResponseFile
		,BuildResponseFilePipe
		,output(dresponse_stats								,named('PrivatePhone_Extract_Fill_Rates'))
	);
end;
     
