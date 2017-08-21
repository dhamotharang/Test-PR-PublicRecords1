//Copied from Map_Experian_Update
IMPORT AID,Address,ut,VehicleV2,VehicleCodes,Codes,NID;

	Infutor_Vin_Vehicle_In	:= VehicleV2.Files.In.Infutor_Vin.PreppedBldg;
	//Infutor_Vin_Vehicle_In	:= sample(VehicleV2.Files.In.Infutor_Vin.PreppedBldg,100,1);
	
	// Clean all fields to make sure we keep only the printable characters
	ut.CleanFields(Infutor_Vin_Vehicle_In,Infutor_Vin_Vehicle_Clean);

	rCleanAddressPlus_layout	:=
	RECORD
		VehicleV2.Layout_Infutor_VIN.Prepped;
		STRING100	Append_PrepAddr1;
		STRING50	Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	END;

	rCleanAddressPlus_layout t_CleanAddress(Infutor_Vin_Vehicle_Clean	L)	:=
	TRANSFORM

		//Append_PreAddr1 - street #, street name, and apartment # for regular address
		//                - street name, street #, apartment for PO BOX
		//Remove comma between street address and unit # per T Kirk
		SELF.Append_PrepAddr1 := MAP(REGEXFIND('PO BOX', L.STREET, NOCASE)
		                               => stringlib.stringCleanSpaces(
																	           		stringlib.stringtouppercase(L.PREDIR) + ' ' +																								
																								stringlib.stringtouppercase(L.STREET) + ' ' +
																								stringlib.stringtouppercase(L.STRTYPE) + ' ' +
																								stringlib.stringtouppercase(L.POSTDIR) + ' ' +
                                                stringlib.stringtouppercase(L.HOUSE) + ' ' +
																								stringlib.stringtouppercase(L.APTTYPE) + ' ' +
																								stringlib.stringtouppercase(L.APTNBR))
																	 , stringlib.stringCleanSpaces(
																	           		stringlib.stringtouppercase(L.HOUSE) + ' ' +
																								stringlib.stringtouppercase(L.PREDIR) + ' ' +
																								stringlib.stringtouppercase(L.STREET) + ' ' +
																								stringlib.stringtouppercase(L.STRTYPE) + ' ' +
																								stringlib.stringtouppercase(L.POSTDIR) + ' ' +
																								stringlib.stringtouppercase(L.APTTYPE) + ' ' +
																								stringlib.stringtouppercase(L.APTNBR)));
		//City, State ZIP (ZIP 5 only)
		SELF.Append_PrepAddr2	:= stringlib.stringCleanSpaces(TRIM(stringlib.stringtouppercase(L.CITY)) + ', ' +
		                                                     stringlib.stringtouppercase(L.STATE) + ' ' +
																												 stringlib.stringtouppercase(L.ZIP));

		SELF.Append_RawAID		:=	0;
		SELF									:=	L;
	END;

	addr_prep	:=	PROJECT(Infutor_Vin_Vehicle_Clean,t_CleanAddress(LEFT));

	bad_primname_srch_ptrn	:=	'^NONE| NONE|^UNKNOWN| UNKNOWN|GENERAL DELIVERY';

	addr_prep_addr_populated			:=	addr_prep(Append_PrepAddr2	!=	''	and	~(regexfind(bad_primname_srch_ptrn,Append_PrepAddr1,nocase)));
	addr_prep_addr_not_populated	:=	addr_prep(~(Append_PrepAddr2	!=	''	and	~(regexfind(bad_primname_srch_ptrn,Append_PrepAddr1,nocase))));

	//Clean address, and populate AID
	 AID.MacAppendFromRaw_2Line(addr_prep_addr_populated,
																Append_PrepAddr1,
																Append_PrepAddr2,
																Append_RawAID,
																addr_clean_AppendAID,
																AID.Common.eReturnValues.RawAID
															);

	rCleanAddressPlus_layout	tReformatAID(addr_clean_appendAID	L)	:=
	transform
		self.Append_RawAID	:=	L.AIDWork_RawAID;
		self								:=	L;
	end;

	addr_clean	:=	project(addr_clean_AppendAID,tReformatAID(left))	+	addr_prep_addr_not_populated : INDEPENDENT;
	//addr_clean := addr_prep;

	rTempCleanName_layout	:=
	record
		VehicleV2.Layout_Infutor_VIN.Clean_Main;
		string73	CleanName
	end;

	VehicleV2.Layout_Infutor_VIN.Clean_Main	preProcessGetNames(addr_clean	L)	:=
	TRANSFORM
		//Get invalid names with patterns like REPLACED BY [PlateNumber] OR EXCHANGED FOR [PlateNumber]
		tempOwnerName 								:= stringlib.stringCleanSpaces(L.FNAME + ' ' + L.MI + ' ' + L.LNAME);
		// BOOLEAN v_is_name1_invalid  	:=	IF(StringLib.StringFind(tempOwnerName,'EXCHANGED ',1) > 0 OR StringLib.StringFind(tempOwnerName,'REPLACED ',1) > 0,TRUE,FALSE);
   	// STRING8 v_name1_invalid   		:=	IF(v_is_name1_invalid,StringLib.StringFindReplace(StringLib.StringFindReplace(tempOwnerName,'EXCHANGED FOR ',''),'REPLACED BY ',''),'');
   	
   	//Save the original name fields
   	SELF.RAW_FNAME       					:= L.FNAME;
   	SELF.RAW_MI             			:= L.MI;
   	SELF.RAW_LNAME             		:= L.LNAME;
   	SELF.RAW_SUFFIX             	:= L.SUFFIX;
		SELF.Append_OwnerName  				:=	tempOwnerName;
   	//company names	
   	SELF.company_name1 						:=	 IF(L.Append_OwnerNameTypeInd	=	'B',tempOwnerName,'');

		SELF													:=	L;
		SELF := [];
	END;

	address_done := PROJECT(addr_clean,preProcessGetNames(LEFT));
	
	NID.Mac_CleanParsedNames(address_done, get_names,
															, firstname:=RAW_FNAME,middlename:=RAW_MI,lastname:=RAW_LNAME,namesuffix:=RAW_SUFFIX
															, includeInRepository:=true, normalizeDualNames:=true
														);
	
	VehicleV2.Layout_Infutor_Vin.Clean_Main tr(get_names l) := TRANSFORM
		self.title := l.cln_title;
		self.fname := l.cln_fname;
		self.mname := l.cln_mname;
		self.lname := l.cln_lname;
		self.name_suffix := l.cln_suffix;
		SELF := l;
		SELF := [];
	END;
	dsCleanedNames := PROJECT(get_names, tr(LEFT));

	// Distribute records evenly on all the nodes
	dsDistCleanedNames :=	DISTRIBUTE(dsCleanedNames((trim(Append_OwnerName,left,right)<>'') AND (~REGEXFIND('REPLACED |EXCHANGED ',Append_OwnerName,nocase))),random());

	//-----------------------------------------------------------------------------------
	//-------REFORMAT INFUTOR VIN SOURCE TO VEHICLEV2 FORMAT AND APPEND AND VALIDATE VINA 
	//-----------------------------------------------------------------------------------
	VehicleV2.Layout_Infutor_VIN.Infutor_Vin_as_VehicleV2	InfutorToCommon(dsDistCleanedNames	pLEFT)	:=
	TRANSFORM
		SELF.dt_first_seen 									:=	0;
		SELF.dt_last_seen 									:=	0;
		SELF.dt_vendor_first_reported				:=	(UNSIGNED4) pLEFT.ProcessDate;
		SELF.dt_vendor_last_reported				:=	(UNSIGNED4) pLEFT.ProcessDate;
		SELF.STATE_ORIGIN										:= 	pLEFT.State_Origin;
		SELF.VINA_VINFLAG										:=	'';
		SELF.HISTORY												:=	'U';
		SELF.SOURCE_CODE										:=	pLEFT.Source_Code;
		SELF.RAW_VIN												:=	pLEFT.INTERNAL1;				//What do we do with the orig VIN
		SELF.ORIG_VIN 											:=	pLEFT.INTERNAL1;
		SELF.RAW_YEAR_MAKE									:=	pLEFT.YEAR;
		SELF.YEAR_MAKE 											:=	IF((UNSIGNED)pLEFT.YEAR<>0,pLEFT.YEAR,'');
		SELF.RAW_CLASS_CODE									:=	pLEFT.CLASS_CODE;				//SMALL CAR/MID SIZE CAR/FULL SIZE CAR...
		SELF.RAW_MAKE_CODE									:=	pLEFT.MAKE;							//FORD/TOYOTA/CHEVROLET...
		//Map it to the code supported by VehicleCodes.getMake
		SELF.MAKE_CODE											:=	CASE(TRIM(pLEFT.MAKE), 'FERRARI'					=> 'FERRI',
																																	 'ISUZU'						=> 'ISU',
																																	 'JAGUAR'						=> 'JAG',
																																	 'LAMBORGHINI'			=> 'LAMO',
																																	 'LANCIA'						=> 'LNCI',
																																	 'LAND ROVER'				=> 'LNDR',
																																	 'LEXUS'						=> 'LEXS',
																																	 'MERCEDES-BENZ'		=> 'MERZ',
																																	 'MINI'							=> 'MNNI',		
																																	 'RAM'							=> 'DODG',			//In the existing DB, RAM make has DODG as vina_ncic_make
																																	 'RANGE ROVER'			=> 'RROV',
																																	 'ROLLS-ROYCE'			=> 'ROL',
																																	 'SATURN'						=> 'STRN',
																																	 'SCION'						=> 'TOYT',			//In the existing DB, SCION make has TOYT as vina_ncic_make
																																	 'SMART'						=> 'SMRT',
																																	 'SUZUKI'						=> 'SUZI',
																																	 'TOYOTA'						=> 'TOYT',
																																	 pLEFT.MAKE[1..4]);
		SELF.RAW_MODEL											:=	pLEFT.MODEL;						//CAMRY/ACCORD/COROLLA
		SELF.MODEL													:=	pLEFT.MODEL;	
		SELF.orig_model_desc								:= 	pLEFT.MODEL;
		SELF.RAW_BODY_CODE									:=	pLEFT.STYLE_CODE;				//CPE 2DR/UTIL/PICKUP/SED 4DR/VAN/LUXURY...
		//Map it to the code supported by VehicleCodes.getBodyType
		SELF.BODY_CODE											:=	CASE(TRIM(pLEFT.STYLE_CODE), 'CPE 2DR' 		=> '2DCPE',
																																				 'CPE 4DR'		=> '4C',
																																				 'CONV'				=> 'CONV',
																																				 'CUV'				=> 'CUV',
																																				 'HCHBK 2DR'	=> '2HBK',
																																				 'HCHBK 3DR'	=> '3HBK',
																																				 'HCHBK 4DR'	=> '4HBK',
																																				 'HDTP 2DR'		=> '2DRH',
																																				 'HDTP 4DR'		=> '4D HRD',																																				 
																																				 'LFTBK 2DR'	=> '2L',
																																				 'LFTBK 3DR'	=> '3L',
																																				 'LFTBK 4DR'	=> '4L',
																																				 'LUXURY'			=> 'LUXURY',
		                                                                     'PICKUP'			=> 'PICKU',
																																				 'SED 2DR'		=> '2DRSDN',
																																				 'SED 4DR'		=> '4D SED',
																																				 'SPORT'			=> 'SPORT',				//SPORT is not defined
																																				 'UTIL'				=> 'UTIL',
																																				 'VAN'				=> 'VN',
																																				 'WAGON'			=> 'WG',
																																				 TRIM(pLEFT.STYLE_CODE));

																								 
		SELF.RAW_FUEL_TYPE_CODE							:=	pLEFT.FUEL_TYPE_CODE;		//G/F/D/Y/N/...
		SELF.FUEL_TYPE_CODE									:=	pLEFT.FUEL_TYPE_CODE;

		//Vendor data that are not used
		SELF.RAW_IID												:=  pLEFT.IID;
		SELF.RAW_PID												:=  pLEFT.PID;
		SELF.RAW_IDATE											:=  pLEFT.IDATE;
		SELF.RAW_ODATE											:=	pLEFT.ODATE;
		SELF.RAW_VIN_MASKED									:=  pLEFT.VIN;							//VIN is 10 char long and masked
		SELF.RAW_MFG_CODE										:=	pLEFT.MFG_CODE;
		SELF.RAW_MILEAGECD									:=	pLEFT.MILEAGECD;
		SELF.RAW_NBR_VEHICLES								:=	pLEFT.NBR_VEHICLES;
		SELF.RAW_GENDER											:=	pLEFT.GENDER;
		SELF.RAW_HOUSE											:=  pLEFT.HOUSE;
		SELF.RAW_PREDIR											:=  pLEFT.PREDIR;
		SELF.RAW_STREET											:=  pLEFT.STREET;
		SELF.RAW_STRTYPE										:=  pLEFT.STRTYPE;
		SELF.RAW_POSTDIR										:=  pLEFT.POSTDIR;	
		SELF.RAW_APTTYPE										:=  pLEFT.APTTYPE;
		SELF.RAW_APTNBR											:=  pLEFT.APTNBR;
		SELF.RAW_CITY												:=  pLEFT.CITY;
		SELF.RAW_STATE											:=  pLEFT.STATE;		
		SELF.RAW_ZIP												:=  pLEFT.ZIP;			
		SELF.RAW_Z4													:=  pLEFT.Z4;
		SELF.RAW_DPC												:=  pLEFT.Z4;
		SELF.RAW_CRTE												:=  pLEFT.CRTE;
		SELF.RAW_CNTY												:=  pLEFT.CNTY;
		SELF.RAW_Z4TYPE											:=  pLEFT.Z4TYPE;
		SELF.RAW_DPV												:=  pLEFT.DPV;
		SELF.RAW_VACANT											:=  pLEFT.VACANT;
		SELF.RAW_PHONE											:=  pLEFT.PHONE;
		SELF.RAW_DNC												:=  pLEFT.DNC;
		SELF.RAW_INTERNAL1									:=  pLEFT.INTERNAL1;
		SELF.RAW_INTERNAL2									:=  pLEFT.INTERNAL2;
		SELF.RAW_INTERNAL3									:=  pLEFT.INTERNAL3;
		SELF.RAW_COUNTY											:=  pLEFT.COUNTY;
		SELF.RAW_MSA												:=  pLEFT.MSA;	
		SELF.RAW_CBSA												:=  pLEFT.CBSA;	
		SELF.RAW_EHI												:=  pLEFT.EHI;
		SELF.RAW_CHILD											:=  pLEFT.CHILD;
		SELF.RAW_HOMEOWNER									:=  pLEFT.HOMEOWNER;
		SELF.RAW_PCTW												:=  pLEFT.PCTW;
		SELF.RAW_PCTB												:=  pLEFT.PCTB;
		SELF.RAW_PCTA												:=  pLEFT.PCTA;
		SELF.RAW_PCTH												:=  pLEFT.PCTH;
		SELF.RAW_PCTSPE											:=  pLEFT.PCTSPE;
		SELF.RAW_PCTSPS											:=  pLEFT.PCTSPS;
		SELF.RAW_PCTSPA											:=  pLEFT.PCTSPA;
		SELF.RAW_MHV												:=  pLEFT.MHV;
		SELF.RAW_MOR												:=  pLEFT.MOR;
		SELF.RAW_PCTOCCW										:=  pLEFT.PCTOCCW;	
		SELF.RAW_PCTOCCB										:=  pLEFT.PCTOCCB;
		SELF.RAW_PCTOCCO										:=  pLEFT.PCTOCCO;	
		SELF.RAW_LOR												:=  pLEFT.LOR;
		SELF.RAW_SFDU												:=  pLEFT.SFDU;
		SELF.RAW_MFDU												:=  pLEFT.MFDU;
		
		//Setup fields used by party
		SELF.CUSTOMER_TYPE									:= 	MAP(pLEFT.Append_OwnerNameTypeInd	in	['D','P']	=>	'I',
																								pLEFT.Append_OwnerNameTypeInd	=		'I'				=>	'W',
																								pLEFT.Append_OwnerNameTypeInd
																							);
		

		SELF																:=	pLEFT;
		SELF																:=  [];
		
	END;

	veh_Infutor_Vin	:=	project(dsDistCleanedNames,InfutorToCommon(LEFT));

	export	Map_Infutor_Vin_Update	:=	veh_Infutor_Vin : persist('~thor_data400::persist::vehiclev2::inf_nondppa_vin_update');