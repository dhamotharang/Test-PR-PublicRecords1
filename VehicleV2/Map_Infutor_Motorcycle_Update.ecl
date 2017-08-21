//Copied from Map_Infutor_Vin_Update
IMPORT AID,Address,ut,VehicleV2,VehicleCodes,Codes,NID;

	Infutor_Motorcycle_Vehicle_In	:= VehicleV2.Files.In.Infutor_Motorcycle.PreppedBldg;
	//output(choosen(Infutor_Motorcycle_Vehicle_In,1000),,named('Infutor_Motorcycle_Vehicle_In'));
	
	// Clean all fields to make sure we keep only the printable characters
	ut.CleanFields(Infutor_Motorcycle_Vehicle_In,Infutor_Motorcycle_Vehicle_Clean);

	//-----------------------------------------------------------------
	//STANDARDIZE ADDRESS: Clean address
	//-----------------------------------------------------------------

	rCleanAddressPlus_layout	:=
	RECORD
		VehicleV2.Layout_Infutor_Motorcycle.Prepped;
		STRING100	Append_PrepAddr1;
		STRING50	Append_PrepAddr2;
		AID.Common.xAID	Append_RawAID;
	END;
	

	rCleanAddressPlus_layout t_CleanAddress(Infutor_Motorcycle_Vehicle_Clean	L)	:=
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

	addr_prep	:=	PROJECT(Infutor_Motorcycle_Vehicle_Clean,t_CleanAddress(LEFT));
	
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

	// Combine the blank or invalid address records after passing to the AID macro
	rCleanAddressPlus_layout	tReformatAID(addr_clean_appendAID	L)	:=
	transform
		self.Append_RawAID	:=	L.AIDWork_RawAID;
		self								:=	L;
	end;

	addr_clean	:=	project(addr_clean_AppendAID,tReformatAID(left))	+	addr_prep_addr_not_populated : INDEPENDENT;
	//addr_clean := addr_prep;	

	VehicleV2.Layout_Infutor_Motorcycle.Clean_Main	preProcessGetNames(addr_clean	L)	:=
	TRANSFORM
		//Get invalid names with patterns like REPLACED BY [PlateNumber] OR EXCHANGED FOR [PlateNumber]
		tempOwnerName 								:= stringlib.stringCleanSpaces(L.FNAME + ' ' + L.MI + ' ' + L.LNAME);
   	//Save the original name fields
   	SELF.RAW_FNAME       					:= L.FNAME;
   	SELF.RAW_MI             			:= L.MI;
   	SELF.RAW_LNAME             		:= L.LNAME;
   	SELF.RAW_SUFFIX             	:= L.SUFFIX;
		SELF.Append_OwnerName  				:= tempOwnerName;
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

	
	VehicleV2.Layout_Infutor_Motorcycle.Clean_Main tr(get_names l) := TRANSFORM
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
	output(choosen(dsDistCleanedNames,100),,named('dsDistCleanedNames'));

	//-----------------------------------------------------------------------------------
	//-------REFORMAT INFUTOR MOTORCYCLE SOURCE TO VEHICLEV2 FORMAT AND APPEND AND VALIDATE VINA 
	//-----------------------------------------------------------------------------------
	VehicleV2.Layout_Infutor_Motorcycle.Infutor_Motorcycle_as_VehicleV2	InfutorToCommon(dsDistCleanedNames	pLEFT)	:=
	TRANSFORM
		SELF.dt_first_seen 									:=	0;           //(UNSIGNED4) pLEFT.IDATE;
		SELF.dt_last_seen 									:=	0;           //(UNSIGNED4) pLEFT.ODATE;
		
		SELF.dt_vendor_first_reported				:=	(UNSIGNED4) pLEFT.ProcessDate;
		SELF.dt_vendor_last_reported				:=	(UNSIGNED4) pLEFT.ProcessDate;
		SELF.STATE_ORIGIN										:= 	pLEFT.State_Origin;
		SELF.VINA_VINFLAG										:=	'';
		SELF.HISTORY												:=	'U';
		SELF.SOURCE_CODE										:=	pLEFT.Source_Code;
		SELF.RAW_VIN												:=	pLEFT.VIN;					//internal1 is blank for motorcycle
		SELF.ORIG_VIN 											:=	pLEFT.INTERNAL1;
		SELF.RAW_YEAR_MAKE									:=	pLEFT.YEAR;
		SELF.YEAR_MAKE 											:=	IF((UNSIGNED)pLEFT.YEAR<>0,pLEFT.YEAR,'');
		SELF.RAW_CLASS_CODE									:=	pLEFT.CLASS_CODE;				//SMALL CAR/MID SIZE CAR/FULL SIZE CAR...
		SELF.RAW_MAKE_CODE									:=	pLEFT.MAKE;							//HARLEY DAVIDSON, YAMAHA
		//Map it to the code supported by VehicleCodes.getMake
		SELF.MAKE_CODE											:=	CASE(TRIM(pLEFT.MAKE), 'HARLEY DAVIDSON'	=> 'HD',
																																	 'HONDA'						=> 'HOND',
																																	 'YAMAHA'						=> 'YAMA',
																																	 'SUZUKI'						=> 'SUZI',
																																	 'KAWASAKI'					=> 'KAWK',
																																	 IF(LENGTH(TRIM(pLEFT.MAKE))>4,
																																	    '',
																																      TRIM(pLEFT.MAKE[1..4])));
		SELF.RAW_MODEL											:=	pLEFT.MODEL;						//CAMRY/ACCORD/COROLLA
		SELF.MODEL													:=	pLEFT.MODEL;	
		SELF.orig_model_desc								:= 	pLEFT.MODEL;
		SELF.RAW_BODY_CODE									:=	pLEFT.STYLE_CODE;				//CPE 2DR/UTIL/PICKUP/SED 4DR/VAN/LUXURY...
		//Map it to the code supported by VehicleCodes.getBodyType
		SELF.BODY_CODE											:=	pLEFT.STYLE_CODE;
																								 
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

	veh_Infutor_Motorcycle	:=	project(dsDistCleanedNames,InfutorToCommon(LEFT));
	
EXPORT	Map_Infutor_Motorcycle_Update	:=	veh_Infutor_Motorcycle : persist('~thor_data400::persist::vehicleV2::inf_nondppa_motorcycle_update');
