import tools;

export Keynames(const string pversion = '') :=
module

	shared CorpRoot			:= Thor_cluster + 'key::' + DatasetName + '::@version@::corp::'			;
	shared ContRoot			:= Thor_cluster + 'key::' + DatasetName + '::@version@::cont::'			;
	shared EventRoot		:= Thor_cluster + 'key::' + DatasetName + '::@version@::event::'		;
	shared StockRoot		:= Thor_cluster + 'key::' + DatasetName + '::@version@::stock::'		;
	shared ARRoot				:= Thor_cluster + 'key::' + DatasetName + '::@version@::ar::'				;
	export AutokeyRoot	:= Thor_cluster + 'key::' + DatasetName + '::@version@::autokey::'	;
	shared BooleanRoot	:= Thor_cluster + 'key::' + DatasetName + '::@version@::'						;

	export Corp :=
	module

		shared lbdid			:= 'bdid';
		shared lbdidpl		:= 'bdid.pl';
		shared lcorpkey		:= 'corp_key.record_type';
		shared lnameaddr	:= 'name.z5.prim_name.prim_range';
		shared lstcharter	:= 'st.charter_number';

		shared llinkIDs			:= 'linkIds';

		export Bdid				:= tools.mod_FilenamesBuild(CorpRoot + lbdid				,pversion);
		export BdidPl			:= tools.mod_FilenamesBuild(CorpRoot + lbdidpl			,pversion);
		export CorpKey		:= tools.mod_FilenamesBuild(CorpRoot + lcorpkey		,pversion);
		export NameAddr		:= tools.mod_FilenamesBuild(CorpRoot + lnameaddr		,pversion);
		export StCharter	:= tools.mod_FilenamesBuild(CorpRoot + lstcharter	,pversion);

		export LinkIds			:= tools.mod_FilenamesBuild(CorpRoot + llinkIDs		,pversion);		


		export dall_filenames := 
			  Bdid.dall_filenames
			+ BdidPl.dall_filenames
			+ CorpKey.dall_filenames
			+ NameAddr.dall_filenames
			+ StCharter.dall_filenames
			+ LinkIds.dall_filenames
			; 

	end;
	
	export Cont :=
	module
		shared ldid     	:= 'did';
		shared lbdid			:= 'bdid';
		shared lcorpkey		:= 'corp_key.record_type';
		shared lnameaddr	:= 'lname.fname.st';
		shared llinkIDs		:= 'linkIds';		
		
		export Did      	:= tools.mod_FilenamesBuild(contRoot + ldid			,pversion);
		export Bdid				:= tools.mod_FilenamesBuild(ContRoot + lbdid			,pversion);
		export CorpKey		:= tools.mod_FilenamesBuild(ContRoot + lcorpkey	,pversion);
		export NameAddr		:= tools.mod_FilenamesBuild(ContRoot + lnameaddr	,pversion);

		export LinkIds			:= tools.mod_FilenamesBuild(ContRoot + llinkIDs			,pversion);	

		export dall_filenames := 
			  Bdid.dall_filenames
			+ did.dall_filenames
			+ CorpKey.dall_filenames
			+ NameAddr.dall_filenames
			+ LinkIds.dall_filenames			
			; 

	end;

	export Events :=
	module

		shared lbdid			:= 'bdid';
		shared lcorpkey		:= 'corp_key.record_type';

		export Bdid				:= tools.mod_FilenamesBuild(EventRoot + lbdid		,pversion);
		export CorpKey		:= tools.mod_FilenamesBuild(EventRoot + lcorpkey	,pversion);

		export dall_filenames := 
			  Bdid.dall_filenames
			+ CorpKey.dall_filenames
			; 

	end;

	export Stock :=
	module

		shared lbdid			:= 'bdid';
		shared lcorpkey		:= 'corp_key.record_type';

		export Bdid				:= tools.mod_FilenamesBuild(StockRoot + lbdid		,pversion);
		export CorpKey		:= tools.mod_FilenamesBuild(StockRoot + lcorpkey	,pversion);

		export dall_filenames := 
			  Bdid.dall_filenames
			+ CorpKey.dall_filenames
			; 

	end;

	export AR :=
	module

		shared lbdid			:= 'bdid';
		shared lcorpkey		:= 'corp_key.record_type';

		export Bdid				:= tools.mod_FilenamesBuild(ARRoot + lbdid		,		pversion);
		export CorpKey		:= tools.mod_FilenamesBuild(ARRoot + lcorpkey,		pversion);

		export dall_filenames := 
			  Bdid.dall_filenames
			+ CorpKey.dall_filenames
			; 

	end;
	
	export Autokeys :=
	module
	
		shared lAddress			:= 'Address'		;		
		shared lCityStName	:= 'CityStName'	;	
		shared lName				:= 'Name'				;	
		shared lPhone2			:= 'Phone2'			;
		shared lSSN2				:= 'SSN2'				;	
		shared lStName			:= 'StName'			;
		shared lZip					:= 'Zip'				;	
		shared lPayload			:= 'Payload'		;	
		shared lAddressB2		:= 'AddressB2'	;	
		shared lCityStNameB2:= 'CityStNameB2';	
		shared lNameB2			:= 'NameB2'			;
		shared lNameWords2	:= 'NameWords2'	;
		shared lPhoneB2			:= 'PhoneB2'		;
		shared lFEIN2				:= 'FEIN2'			;	
		shared lStNameB2		:= 'StNameB2'		;	
		shared lZipB2				:= 'ZipB2'			;	
					
		export Root					:= tools.mod_FilenamesBuild(AutokeyRoot								,pversion);
		export Address			:= tools.mod_FilenamesBuild(AutokeyRoot + lAddress			,pversion);
		export CityStName		:= tools.mod_FilenamesBuild(AutokeyRoot + lCityStName	,pversion);
		export Name					:= tools.mod_FilenamesBuild(AutokeyRoot + lName				,pversion);
		export Phone2				:= tools.mod_FilenamesBuild(AutokeyRoot + lPhone2			,pversion);
		export SSN2					:= tools.mod_FilenamesBuild(AutokeyRoot + lSSN2				,pversion);
		export StName				:= tools.mod_FilenamesBuild(AutokeyRoot + lStName			,pversion);
		export Zip					:= tools.mod_FilenamesBuild(AutokeyRoot + lZip					,pversion);
		export Payload			:= tools.mod_FilenamesBuild(AutokeyRoot + lPayload			,pversion);
		export AddressB2		:= tools.mod_FilenamesBuild(AutokeyRoot + lAddressB2		,pversion);
		export CityStNameB2	:= tools.mod_FilenamesBuild(AutokeyRoot + lCityStNameB2,pversion);
		export NameB2				:= tools.mod_FilenamesBuild(AutokeyRoot + lNameB2			,pversion);
		export NameWords2		:= tools.mod_FilenamesBuild(AutokeyRoot + lNameWords2	,pversion);
		export PhoneB2			:= tools.mod_FilenamesBuild(AutokeyRoot + lPhoneB2			,pversion);
		export FEIN2				:= tools.mod_FilenamesBuild(AutokeyRoot + lFEIN2				,pversion);
		export StNameB2			:= tools.mod_FilenamesBuild(AutokeyRoot + lStNameB2		,pversion);
		export ZipB2				:= tools.mod_FilenamesBuild(AutokeyRoot + lZipB2				,pversion);
                                                                               
		export dall_filenames := 
			  Address.dall_filenames		
			+ CityStName.dall_filenames	
			+ Name.dall_filenames			
			+ Phone2.dall_filenames	
			+ SSN2.dall_filenames			
			+ StName.dall_filenames		
			+ Zip.dall_filenames			
			+ Payload.dall_filenames		
			+ AddressB2.dall_filenames		
			+ CityStNameB2.dall_filenames	
			+ NameB2.dall_filenames		
			+ NameWords2.dall_filenames	
			+ PhoneB2.dall_filenames		
			+ FEIN2.dall_filenames			
			+ StNameB2.dall_filenames		
			+ ZipB2.dall_filenames
			;
	
	end;

	export Booleans :=
	module

		shared lxdstat2		:= 'xdstat2'				;
		shared ldictindx3	:= 'dictindx3'			;
		shared ldtldictx	:= 'dtldictx'			;
		shared lnidx3 		:= 'nidx3'					;
		shared lxseglist	:= 'xseglist'				;
		shared ldocref		:= 'docref.docref'	;
                        
		export xdstat2		:= tools.mod_FilenamesBuild(BooleanRoot + lxdstat2			,pversion);
		export dictindx3	:= tools.mod_FilenamesBuild(BooleanRoot + ldictindx3		,pversion);
		export dtldictx		:= tools.mod_FilenamesBuild(BooleanRoot + ldtldictx		,pversion);
		export nidx3 			:= tools.mod_FilenamesBuild(BooleanRoot + lnidx3 			,pversion);
		export xseglist		:= tools.mod_FilenamesBuild(BooleanRoot + lxseglist		,pversion);
		export docref			:= tools.mod_FilenamesBuild(BooleanRoot + ldocref			,pversion);
                                                                            
		export dall_filenames := 
			  xdstat2.dall_filenames
			+ dictindx3.dall_filenames
			+ dtldictx.dall_filenames
			+ nidx3.dall_filenames
			+ xseglist.dall_filenames
			+ docref.dall_filenames
			; 

	end;

	export dall_filenames := 
		  Corp.dall_filenames
		+ Cont.dall_filenames
		+ Events.dall_filenames
		+ Stock.dall_filenames
		+ AR.dall_filenames
		+ Autokeys.dall_filenames
		+ Booleans.dall_filenames
		; 

end;