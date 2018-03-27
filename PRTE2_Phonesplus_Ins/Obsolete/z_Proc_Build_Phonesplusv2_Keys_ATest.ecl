import	_control, PRTE, PRTE2_Phonesplus_Ins, PRTE_CSV, phonesplus_v2, doxie, cellphone,RoxieKeyBuild, Address, ut, autokey, NID;

export	z_Proc_Build_Phonesplusv2_Keys_ATest (string filedate)	:=
function

	rKeyPhonesplus__did	:=
	record
		PRTE_CSV.Phonesplus.rthor_data400__key__phonesplus__did;
	end;
//--------------------------------------------------------------------------
//    Alpharetta_base_ds is managed by Alpharetta CT
	Alpharetta_base_ds := PRTE2_Phonesplus_Ins.Files.PhonesPlus_Base_SF_DS;
//--------------------------------------------------------------------------	
	ge_data := PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did_ge;
	f_phonesplus		:= 	project(Alpharetta_base_ds + ge_data + PRTE_CSV.Phonesplus.dthor_data400__key__phonesplus__did, transform(Phonesplus_v2.Layout_Phonesplus_Base, self.cellphoneidkey := [], self.did := (unsigned6) left.did,  self := left, self := []))(origname = 'orig_not scrambled');

_fphonesplus_did := sort(f_phonesplus((unsigned)did<>0, (unsigned)cellphone<>0), did);

key_phonesplus_did := index(_fphonesplus_did,
                                {unsigned6 l_did := did},{_fphonesplus_did},
                                '~prte::key::phonesplusv2_did_'+doxie.Version_SuperKey);
key_phonesplus_did_roy := index(choosen(_fphonesplus_did, 0),
                                {unsigned6 l_did := did},{_fphonesplus_did},
                                '~prte::key::phonesplusv2_royalty::@version::did');

/////////////////////////////////////////////////////////////////////////////////
// -- Build AutoKeys
/////////////////////////////////////////////////////////////////////////////////
phonesplusd   := f_phonesplus;
Address.MAC_Multi_City(phonesplusd,p_city_name,zip5,multiCityPhonesplus);

xl_phonesplus := RECORD
	Phonesplus_v2.File_Phonesplus_Base;
	unsigned6 fdid;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_phonesplus xpand_phonesplus(multiCityPhonesplus le,integer phonesplus_cntr) :=  TRANSFORM 
	SELF.fdid := phonesplus_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;
DS_phonesplus := PROJECT(multiCityPhonesplus,xpand_phonesplus(LEFT,COUNTER));

// ut.mac_suppress_by_phonetype(DS_phonesplus,cellphone,state,phones1,true,did);
// ut.mac_suppress_by_phonetype(phones1,homephone,state,phones2,true,did);

dist_DSphonesplus := distribute(DS_phonesplus,random());
dist_DSphonesplus_roy := choosen(DS_phonesplus,0);

AutoKey.Keys  (dist_DSphonesplus,fname,mname,lname,
					zero,
					zero,
					cellphone,
					prim_name,prim_range,state,p_city_name,zip5,sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					lookups,
					fdid,
					'~prte::key::phonesplusv2_',
				  Address_Key,CityStName_Key,Name_Key,Phone_Key,Phone_Key2,SSN_Key,SSN_Key2,StName_Key,Zip_Key,ZipPRLname_Key
					,4,true,0,Phonesplus_v2)
					
					
					
AutoKey.Keys  (dist_DSphonesplus_roy,fname,mname,lname,
					zero,
					zero,
					cellphone,
					prim_name,prim_range,state,p_city_name,zip5,sec_range,
					zero,
					zero,zero,zero,
					zero,zero,zero,
					zero,zero,zero,
					lookups,
					fdid,
					'~prte::key::phonesplusv2_',
				  roy_Address_Key,roy_CityStName_Key,roy_Name_Key,roy_Phone_Key,roy_Phone_Key2,roy_SSN_Key,roy_SSN_Key2,roy_StName_Key,roy_Zip_Key,roy_ZipPRLname_Key
					,4,true,0,Phonesplus_v2)

				
dist_DSphonesplus_rec := record
	unsigned6 fdid;
	Phonesplus_v2.Layout_Phonesplus_Base;
	
end;

dist_DSphonesplus_rec slim_it(dist_DSphonesplus l) := transform
	self := l;
end;

_dist_DSphonesplus_slim := sort(project(dist_DSphonesplus, slim_it(left)),fdid,skew(1));

phonesplus_fdids_key := index(_dist_DSphonesplus_slim,{fdid},{_dist_DSphonesplus_slim},
                        '~prte::key::phonesplusv2_fdids');
												
phonesplus_fdids_key_roy := index(choosen(_dist_DSphonesplus_slim,0),{fdid},{_dist_DSphonesplus_slim},
                        '~prte::key::phonesplusv2_royalty::@version::fdids');
						
phonesplus_iverification := phonesplus_v2.File_Iverification.base(phone = '');
key_iverification_phone := index(phonesplus_iverification,{phone},{phonesplus_iverification},
                        '~prte::key::iverification::@version@::phone');
key_iverification_did_phone := index(phonesplus_iverification,{did, phone},{phonesplus_iverification},
                        '~prte::key::iverification::@version@::did_phone');


company_name := choosen(pull(Phonesplus_v2.Key_Phonesplus_Companyname), 0);


key_phonesplus_companyname := index(company_name,{Company},{fdid},
              '~prte::key::phonesplusv2::@version::companyname');

f_neustar := choosen(pull(CellPhone.key_neustar_phone), 0);

key_neustar_phone := index(f_neustar,{cellphone},{cellphone}
													,'~prte::key::neustar::@version::phone');

neustar_history := dataset([], recordof(phonesplus_v2.File_Neustar_History));
key_neustar_hist := index(neustar_history,{phone},{neustar_history} ,
												'~prte::key::neustar::@version::phone_history');
												
scoring_address := choosen(pull(Phonesplus_v2.Keys_Scoring().address.qa), 0);

key_scoring_address := index(scoring_address ,{prim_name, zip5, prim_range, sec_range,predir, addr_suffix},{scoring_address}
													,'~prte::key::phonesplus_scoring::@version::address');												

scoring_phone := choosen(pull(Phonesplus_v2.Keys_Scoring().phone.qa), 0);

key_scoring_phone := index(scoring_phone ,{cellphone},{scoring_phone}
													,'~prte::key::phonesplus_scoring::@version::phone');												
						
						
return sequential(
			parallel(
			build(key_phonesplus_did,'~prte::key::phonesplusv2::' + filedate+ '::did', sorted )
			,build(phonesplus_fdids_key,'~prte::key::phonesplusv2::' + filedate+'::fdids',sorted)
			,build(Address_Key, '~prte::key::phonesplusv2::' + filedate+ '::address',sorted)
			,build(CityStName_Key, '~prte::key::phonesplusv2::' + filedate+ '::citystname',sorted)			
			,build(Name_Key, '~prte::key::phonesplusv2::' + filedate+ '::name',sorted)	
			,build(Phone_Key, '~prte::key::phonesplusv2::' + filedate+ '::phone',sorted)				
			,build(SSN_Key, '~prte::key::phonesplusv2::' + filedate+ '::ssn',sorted)	
			,build(Stname_Key, '~prte::key::phonesplusv2::' + filedate+ '::stname',sorted)	
			,build(Zip_Key, '~prte::key::phonesplusv2::' + filedate+ '::zip',sorted)	
			,build(key_phonesplus_companyname, '~prte::key::phonesplusv2::' + filedate+ '::companyname',sorted)	
		  ,build(key_iverification_phone, '~prte::key::iverification::' + filedate+ '::phone',sorted)	
			,build(key_iverification_did_phone, '~prte::key::iverification::' + filedate+ '::did_phone',sorted)	
			//Royalty
		  ,build(key_phonesplus_did_roy,'~prte::key::phonesplusv2_royalty::' + filedate+ '::did', sorted )
			,build(phonesplus_fdids_key_roy,'~prte::key::phonesplusv2_royalty::' + filedate+'::fdids',sorted)
			,build(roy_Address_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::address',sorted)
			,build(roy_CityStName_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::citystname',sorted)			
			,build(roy_Name_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::name',sorted)	
			,build(roy_Phone_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::phone',sorted)				
			,build(roy_SSN_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::ssn',sorted)	
			,build(roy_Stname_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::stname',sorted)	
			,build(roy_Zip_Key, '~prte::key::phonesplusv2_royalty::' + filedate+ '::zip',sorted)	
			,build(key_phonesplus_companyname, '~prte::key::phonesplusv2_royalty::' + filedate+ '::companyname',sorted)	
      //neustar
			,build(key_neustar_phone, '~prte::key::neustar::' + filedate+ '::phone',sorted)	
			,build(key_neustar_hist, '~prte::key::neustar::'+ filedate+ '::phone_history', sorted)
			,build(key_scoring_address, '~prte::key::phonesplus_scoring::'+ filedate+ '::address', sorted)
			,build(key_scoring_phone, '~prte::key::phonesplus_scoring::'+ filedate+ '::phone', sorted)
			),
		PRTE.UpdateVersion('PhonesPlusV2Keys',										//	Package name
																				 filedate,												//	Package version
																				 _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
																				 'B',																	//	B = Boca, A = Alpharetta
																				 'N',																	//	N = Non-FCRA, F = FCRA
																				 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
																				)
										 );

end;
