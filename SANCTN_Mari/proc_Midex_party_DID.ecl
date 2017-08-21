IMPORT SANCTN_Mari,ut,Lib_FileServices,lib_stringlib,Lib_date,standard,address,AID,BIPV2,DID_Add,Business_Header_SS,Business_Header,
	   Header_SlimSort,Watchdog,mdr,Prof_License_Mari,header,PromoteSupers, std, NID;

export proc_Midex_party_DID(string filedate) := function

dsPartyBase	:= SANCTN_Mari.files_SANCTN_did.party_aid;

//NameCleaning
NID.Mac_CleanParsedNames(dsPartyBase, PartyBaseCleaned
													, firstname := name_first
													, middlename:= name_middle
													, lastname  := name_last
													, namesuffix := suffix
													, includeInRepository:=false
													, normalizeDualNames:=false
												);


tmpLayout_party := record
SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did;
string10 clean_phone;
end;

SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did cln_Midexparty(PartyBaseCleaned input)	:= TRANSFORM
// DF-15275 Modified logic to ensure the names are being parsed corrctly.  Recleaning will occur when the name initially
// do not clean as expect.  Then the old name cleaner will be used.
// Clean names-- 
	 suffix			:= ['JR.','SR.','JUNIOR','W. JR.'];
	 name_party := std.str.cleanspaces(input.NAME_LAST+', '+input.NAME_FIRST+' '+input.NAME_MIDDLE+' '+input.SUFFIX);
	 is_company   := SANCTN_Mari.func_is_company(input.fullname);
	 
   is_ExceptionNames := 	trim(input.name_last) <> trim(input.cln_lname) 
															 and (std.str.find(input.name_last,'\'',1)> 0
															 or std.str.find(input.name_last,' JR.',1) > 0
															 or std.str.find(input.name_last,'ST. ',1) > 0
															 );
	 	is_ExceptionFirstName := trim(input.name_first) <> trim(input.cln_fname)
																and (std.str.find(input.name_first,'.',1) > 0 or std.str.find(trim(input.name_first),' ',1) > 0)
																and input.name_middle = '';
																
		tempPName    := if(not is_ExceptionNames and input.name_last <> input.cln_lname, Address.CleanPersonLFM73(name_party),
												if(trim(input.name_middle) in suffix, Address.CleanPersonLFM73(name_party), ''));
												
	  title				:=	tempPName[1..5];
		fname				:=	tempPName[6..25];
		mname				:=	tempPName[26..45];
		lname				:=	tempPName[46..65];
		name_suffix	:=	tempPName[66..70];
		name_score	:=	tempPName[71..73];
   
		//Assigning Cleaning Fields
	 self.title  := input.cln_title;
	 self.fname	 := if(is_ExceptionFirstName, input.cln_fname,
										if(STD.Str.FilterOut(input.name_first,'.') = input.cln_fname, input.cln_fname, 
										  if(STD.Str.FilterOut(input.name_first,'\'') = input.cln_fname, input.cln_fname,
												if(STD.Str.FilterOut(input.name_first,'.') = fname, fname, 
													STD.Str.FilterOut(input.name_first,'.')))));
													
	 self.mname  := if(is_ExceptionFirstName, input.cln_mname,
											if(trim(input.name_middle) in suffix, mname,
												if(STD.Str.FilterOut(input.name_middle,'.') = input.cln_mname, input.cln_mname,
													if(STD.Str.FilterOut(input.name_middle,'.') = mname, mname, 
														STD.Str.FilterOut(input.name_middle,'.')))));
	 
	 self.lname  := if(input.name_last = input.cln_lname, input.cln_lname,
											if(input.name_last = lname, lname,
													if(is_ExceptionNames and input.cln_lname <> '',	input.cln_lname, 
																if(is_ExceptionNames and input.cln_lname = '' and lname <> '', 
																			lname, 
																				input.name_last
															))));
																			
		self.name_suffix := if(input.name_first = input.cln_suffix,'',
														if(input.cln_suffix <> '', input.cln_suffix, 
															if(name_suffix <> '', name_suffix, STD.Str.FilterOut(input.suffix,'.')
																)));
  
	 self.ename	:= std.str.ToUpperCase(trim(input.PARTY_EMPLOYER));
   self.cname := std.str.ToUpperCase(trim(input.PARTY_FIRM));
	 self.phone := std.str.filterout(input.PHONE,'-');
   self  := input;
END;

ds_CleanParsedGood	:= project(PartyBaseCleaned,cln_Midexparty(left));

//DID Party if name is individual and not company
// 'A'= Address, 'D' = DOB, 'S' = ssn, 'P'= Phone, 
// 'Q' = Address match excluding the fuzzy logic., 'Z' = zip code matching

pdid_matchset  := ['A','D','S','Q','Z', 'P'];
DID_Add.MAC_Match_Flex(ds_CleanParsedGood, pdid_matchset,
											ssn, dob, fname, mname, lname, name_suffix,
											prim_range, prim_name, sec_range, zip5, st,
											phone, DID, SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did, true, 
										    DID_SCORE, //these should default to zero in definition
										    75,        //dids with a score below here will be dropped
											dsPartyIndv) 

//Propagate did from SANCTN, SANCTN_Mari, and MARI base files.
dsPartyIndv_enh := Prof_license_Mari.fnMidexDid.SANCTN_Mari_Enhance_Did(dsPartyIndv);

party_did := dsPartyIndv_enh : persist('~thor_data400::persist::sanctn:np::party_did');

//BDID Incident if name is a company and not an individual
// 'A'= Address, 'P'= Phone, 'F'= FEIN

//Hash on full raw data fields to make source_rec_id persistent
SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip addSourceRecId(dsPartyIndv_enh input)	:= TRANSFORM
	 self.source_rec_id	:= (unsigned8) (hash64(
													 input.BATCH
													,input.DBCODE
													,input.INCIDENT_NUM
													,input.PARTY_NUM
													,input.SANCTIONS
													,input.ADDITIONAL_INFO
													,input.PARTY_FIRM
													,input.TIN
													,input.NAME_FIRST
													,input.NAME_LAST
													,input.NAME_MIDDLE
													,input.SUFFIX
													,input.NICKNAME
													,input.PARTY_POSITION
													,input.PARTY_EMPLOYER
													,input.SSN
													,input.DOB
													,input.ADDRESS
													,input.CITY
													,input.STATE
													,input.ZIP
													,input.PARTY_TYPE
													,input.PARTY_KEY
													,input.INT_KEY
													,input.PHONE));												
		self  						:= input;
END;   

dsPartySrcId := PROJECT(dsPartyIndv_enh, addSourceRecId(LEFT));

pbdid_matchset  := ['A','F'];
Business_Header_SS.MAC_Match_Flex(dsPartySrcId, pbdid_matchset,
																	cname, prim_range, prim_name, zip5, sec_range, st,
																	'', tin, BDID, SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_bip, true, 
																	BDID_SCORE, //these should default to zero in definition
																	dsPartyComp
																	,																			// keep count
																	,																			// default threshold
																	,																			// use prod version of superfiles
																	,																			// default is to hit prod from dataland, and on prod hit prod.		
																	,BIPV2.xlink_version_set							// create BIP keys only
																	,																			// url
																	,																			// email 
																	,v_city_name													// city
																	,fname																// fname
																	,mname																// mname
																	,lname																// lname
																	,ssn																	// contact ssn
																	,
																	,source_rec_id
																	);
											
PromoteSupers.MAC_SF_BuildProcess(dsPartyComp, SANCTN_Mari.cluster_name + 'base::SANCTN::NP::party_bip', base_party_out_bip, 3, /*csvout*/false, /*compress*/false);

dsBaseParty		:= project(dsPartyComp, TRANSFORM(SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_base, self := left));
dsCleanParty	:= project(dsPartyComp, TRANSFORM(SANCTN_Mari.layouts_SANCTN_common.SANCTN_party_did, self := left));


PromoteSupers.MAC_SF_BuildProcess(dsBaseParty, SANCTN_Mari.cluster_name+'base::SANCTN::NP::party', base_party_out, 3, /*csvout*/false, /*compress*/false);
party_did_out		:= output(dsCleanParty,,SANCTN_Mari.cluster_name+'out::SANCTN::NP::cln_party_did',overwrite);

retval	:= sequential(base_party_out_bip,base_party_out,party_did_out);
return retval;
end;

