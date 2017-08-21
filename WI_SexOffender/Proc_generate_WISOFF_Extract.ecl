import soff_resolt_integration, _control,ut,address,DID_Add,lib_stringlib,header_slimsort, watchdog;

DestinationIP := _control.IPAddress.bctlpedata11; 
p_filedate    := ut.GetDate;
ofnd := distribute(wi_sexoffender.File_CP_OFND,hash(doc_num));
oadd := distribute(wi_sexoffender.File_CP_OFND_res,hash(doc_num));

wi_soff_temprec := record
wi_sexoffender.File_CP_OFND;
string40	COR_L1_ADR;
string40	COR_L2_ADR;
string28	COR_CITY_NAM;
string2	  COR_CNTY_CD;
string20	COR_CNTY_NAM;
string2	  COR_ST_CD;
string5	  COR_ZIP_CD;
address.Layout_Clean_Name;
address.Layout_Clean182.prim_range ;	
address.Layout_Clean182.predir;		// [11..12]
address.Layout_Clean182.prim_name;
address.Layout_Clean182.addr_suffix;  // [41..44]
address.Layout_Clean182.postdir;		// [45..46]
address.Layout_Clean182.unit_desig;	// [47..56]
address.Layout_Clean182.sec_range;	// [57..64]
address.Layout_Clean182.v_city_name;  // [90..114]
address.Layout_Clean182.st;			// [115..116]
address.Layout_Clean182.zip;		// [117..121]
address.Layout_Clean182.geo_match;	// [178]
end; 
	
wi_soff_temprec OA(ofnd L, oadd R) := TRANSFORM
  
	concatnamLFMS := stringlib.stringfindreplace(stringlib.stringfindreplace(trim(L.LST_NAM)+ ' '+ trim(L.FST_NAM) + ' '+ trim(L.MID_NAM) +' '+ trim(L.SFX_NAM), '  ',' '), '  ',' ');
	concatnamFMLS := stringlib.stringfindreplace(stringlib.stringfindreplace(trim(L.FST_NAM) + ' '+ trim(L.MID_NAM) +' '+ trim(L.LST_NAM)+ ' '+ trim(L.SFX_NAM), '  ',' '), '  ',' ');
	
  tempName   := MAP (L.MID_NAM <> '' => Address.CleanPersonFML73(concatnamFMLS),
										                    Address.CleanPersonLFM73(concatnamLFMS )) ;
	self.title := trim(tempName[1..5]);
	self.fname := trim(tempName[6..25]);
	self.mname := if(L.MID_NAM = '' and trim(tempName[26..45]) in ['SR','JR'] , '', trim(tempName[26..45]));
	self.lname := if(trim(tempName[46..48]) in ['JR ','SR '],trim(tempName[49..65]),trim(tempName[46..65]));
	self.name_suffix := map(trim(tempName[46..48]) in ['JR ','SR '] => trim(tempName[46..48]),
	                        L.MID_NAM = '' and trim(tempName[26..45]) in ['SR','JR'] =>trim(tempName[26..45]),
													trim(tempName[66..70]));
	self.name_score	 := trim(tempName[71..73]);
	
	street := trim( IF (R.COR_L1_ADR <> '',      trim(R.COR_L1_ADR),'')+
		              IF (R.COR_L2_ADR   <> '',' '+trim(R.COR_L2_ADR),''),LEFT);
  
	
  string182 tempAddressReturn := stringlib.StringToUpperCase(
										if(street <> '' or
										   R.COR_CITY_NAM <> '' or
										   R.COR_ST_CD <> '' or
										   R.COR_ZIP_CD <> '',
										   Address.CleanAddress182(
										   trim(street,left,right),
										   trim(trim(R.COR_CITY_NAM,left,right) + ', ' +
										   trim(R.COR_ST_CD) + ' ' +
										   trim(R.COR_ZIP_CD,left,right),left,right)),''));
											 
	self.prim_range   := tempAddressReturn[1..10];
	self.predir 	    := tempAddressReturn[11..12];
	self.prim_name 		:= tempAddressReturn[13..40];
	self.addr_suffix  := tempAddressReturn[41..44];
	self.postdir 		  := tempAddressReturn[45..46];
	self.unit_desig 	:= tempAddressReturn[47..56];
	self.sec_range 		:= tempAddressReturn[57..64];
	self.v_city_name	:= tempAddressReturn[90..114];
	self.st 			    := tempAddressReturn[115..116];
	self.zip 			    := tempAddressReturn[117..121];
	self.geo_match 		:= tempAddressReturn[178];
	self.BRTH_DT      := L.BRTH_DT[7..10]+L.BRTH_DT[1..2]+L.BRTH_DT[4..5];
	self := L;
  self := R;
 
end;

WI_Offnd_address:= JOIN(ofnd,oadd,
                        Left.doc_num = right.doc_num,
						            OA(left,right),
						            left outer,local);

Lay_WISOFF_WithSSNDID := record
		wi_soff_temprec;
		string SSN                := '';
		unsigned6 DID             := 0;
		unsigned6 DID_Score_field := 0;
end;

#stored('did_add_force','thor'); // remove or set to 'thor' to put recs through thor

matchSet := ['A','D'];

//DID_Add.MAC_Match_Flex_Sensitive    // NOTE <- senstitive macro
 DID_Add.MAC_Match_Flex                // regular did macro
				(WI_Offnd_address
				,matchSet
				,SSN, BRTH_DT
				//,FST_NAM, MID_NAM,LST_NAM,SFX_NAM 
				,fname,mname,lname,name_suffix
				,prim_range, prim_name, sec_range, zip, st
				,''
				,DID
				,Lay_WISOFF_WithSSNDID, true, DID_Score_field
				,75                   // DIDs with a score below here will be dropped
				,Ds_WISOFF_WithDID					
				);

did_add.MAC_Add_SSN_By_DID(Ds_WISOFF_WithDID, did, ssn, Out_OKC_Sex_Off_WithDidSsn)
//ds := Out_OKC_Sex_Off_WithDidSsn;// : persist ('persist::Promonitor::WISOFFwithDID');
//output(ds);
soff_resolt_integration.Layout_Promonitor_extract WISOFFToPromonitor(Lay_WISOFF_WithSSNDID L) := TRANSFORM

    SELF.EXTERNAL_ID 		:= L.doc_num;
		SELF.SSN						:= IF (L.ssn ='0','',L.ssn);
    SELF.DOB_MONTH			:= L.BRTH_DT[5..6];
    SELF.DOB_DAY				:= L.BRTH_DT[7..8];
		SELF.DOB_YEAR			  := L.BRTH_DT[1..4];
		SELF.FIRST_NAME			:= L.FST_NAM;
		SELF.MIDDLE_NAME		:= L.MID_NAM;
		SELF.LAST_NAME			:= L.LST_NAM;
		// SELF.FIRST_NAME		  := L.Fname;
		// SELF.MIDDLE_NAME		:= L.Mname;
		// SELF.LAST_NAME			:= L.Lname;
		SELF.STREET_1				:= trim(trim(trim(trim(
		                            IF (L.prim_range <> '',    trim(L.prim_range),'')+
		                            IF (L.predir     <> '',' '+trim(L.predir),''),LEFT)+
																IF (L.prim_name  <> '',' '+trim(L.prim_name),''),LEFT)+
																IF (L.addr_suffix<> '',' '+trim(L.addr_suffix),''),LEFT)+
																IF (L.postdir    <> '',' '+L.postdir,''),LEFT,RIGHT);
																
		SELF.STREET_2				:= trim(trim(L.unit_desig)+' '+L.sec_range);
		SELF.STREET_3				:= '';
		SELF.CITY						:= If(trim(L.v_city_name) ='0','',L.v_city_name);
		SELF.STATE					:= L.st;
		SELF.POSTAL_CODE		:= L.zip;
		SELF.ACCOUNT_ID			:= '209';
		SELF.USERNAME				:= 'sexoffender';
		SELF.OPERATION_TYPE	:= '';
		SELF.REFERENCE_ID		:= '';
		SELF.DL_NUM					:= '';
		SELF.DL_STATE				:= '';
		SELF.LINK_ID        := L.did;
		SELF := L;

 END;
 
PromonitorExt_Recs 		:= PROJECT(Out_OKC_Sex_Off_WithDidSsn, WISOFFToPromonitor(LEFT)) ;//: persist ('persist::Promonitor::WISOFFwithDID');


outputExtract   := output(PromonitorExt_Recs,,
	                   '~thor_Data400::out::promonitor::WI_SOFF_Extract'+p_filedate,CSV(HEADING('EXTERNAL_ID|SSN|DOB_MONTH|DOB_DAY|DOB_YEAR|FIRST_NAME|MIDDLE_NAME|LAST_NAME|STREET_1|STREET_2|STREET_3|CITY|STATE|POSTAL_CODE|ACCOUNT_ID|USERNAME|OPERATION_TYPE|REFERENCE_ID|DL_NUM|DL_STATE|LINK_ID\n',SINGLE), 
										                                                             SEPARATOR('|'), TERMINATOR('\n')),overwrite);	
																																								 
DesprayExtract  := fileservices.despray('~thor_Data400::out::promonitor::WI_SOFF_Extract'+p_filedate, DestinationIP, '/data/hds_180/pro_monitor/build/wi_sof/'+'WI_promonitor_'+p_filedate+'.txt',,,,TRUE); 

																																								 
export Proc_generate_WISOFF_Extract := sequential(outputExtract,DesprayExtract);	