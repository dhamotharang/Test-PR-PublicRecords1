import Address,doxie_files, ut, doxie, autokey,Cellphone,RoxieKeyBuild,Phonesplus,Phonesplus_v2,NID;

export proc_build_phonesplus_keys(string filedate) := 
function

sfShuffle := sequential(
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('~thor_data400::base::phonesplus_grandfather'),
	fileservices.addsuperfile('~thor_data400::base::phonesplus_grandfather','~thor_data400::base::phonesplus_father',0,true),
	fileservices.clearsuperfile('~thor_data400::base::phonesplus_father'),
	fileservices.addsuperfile('~thor_data400::base::phonesplus_father','~thor_data400::base::phonesplus',0,true),
	fileservices.clearsuperfile('~thor_data400::base::phonesplus'),
	fileservices.addsuperfile('~thor_data400::base::phonesplus','~thor_data400::out::phonesplus_did_' + Phonesplus.version),
	fileservices.finishsuperfiletransaction());

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////

knp := CellPhone.key_neustar_phone;
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(knp
                                          ,'~thor_data400::key::neustar_phone'
										  ,'~thor_data400::key::neustar::'+filedate+'::phone'
										  ,bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Phonesplus.key_phonesplus_did
										  ,'~thor_data400::key::phonesplus_did'
										  ,'~thor_data400::key::phonesplus::' +filedate+ '::did'
										  ,bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Phonesplus.key_phonesplus_companyname
										  ,'~thor_data400::key::phonesplus_companyname'
										  ,'~thor_data400::key::phonesplus::' +filedate+ '::companyname'
										  ,bk_pcname);

/////////////////////////////////////////////////////////////////////////////////
// -- Build AutoKeys
/////////////////////////////////////////////////////////////////////////////////
phonesplusd   := phonesplus._keybuild_phonesplus_base;
Address.MAC_Multi_City(phonesplusd,p_city_name,zip5,multiCityPhonesplus);

xl_phonesplus := RECORD
	Phonesplus.layoutCommonKeys;
	unsigned6 fdid;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_phonesplus xpand_phonesplus(multiCityPhonesplus le,integer phonesplus_cntr) :=  TRANSFORM 
	SELF.fdid := phonesplus_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;
DS_phonesplus := PROJECT(multiCityPhonesplus,xpand_phonesplus(LEFT,COUNTER)) : PERSIST('~thor_data400::persist::phonesplus_fdids');

//ut.mac_suppress_by_phonetype(DS_phonesplus,cellphone,state,phones1,true,did);
//ut.mac_suppress_by_phonetype(phones1,homephone,state,phones2,true,did);

dist_DSphonesplus := distribute(DS_phonesplus,random());

Phonesplus.MAC_Build(dist_DSphonesplus,fname,mname,lname,
				 blk,
				 Dob,
				 CellPhone,
				 prim_name, prim_range, state, p_city_name, zip5, sec_range,
				 zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 lookups,
				 fdid,
				 '~thor_data400::key::phonesplus_',bld_phonesplus_auto,false)

						
dist_DSphonesplus_rec := record
	unsigned6 fdid;
	Phonesplus.layoutCommonKeys;
end;

dist_DSphonesplus_rec slim_it(dist_DSphonesplus l) := transform
	self := l;
end;

_dist_DSphonesplus_slim := project(dist_DSphonesplus, slim_it(left));

phonesplus_fdids_key := index(_dist_DSphonesplus_slim,{fdid},{_dist_DSphonesplus_slim},
                        '~thor_data400::key::phonesplus_fdids');
						
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(phonesplus_fdids_key
										  ,'~thor_data400::key::phonesplus_fdids'
										  ,'~thor_data400::key::phonesplus::' + filedate + '::fdids'
										  ,bld_fdids);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::neustar_phone'
								     ,'~thor_data400::key::neustar::'+filedate+'::phone'
									 ,mv2blt_phone);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesplus_did'
								     ,'~thor_data400::key::phonesplus::'+filedate+'::did'
									 ,mv2blt_did);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesplus_fdids'
								     ,'~thor_data400::key::phonesplus::'+filedate+'::fdids'
									 ,mv2blt_fdids);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesplus_companyname'
								     ,'~thor_data400::key::phonesplus::'+filedate+'::companyname'
									 ,mv2blt_pcname);


/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

ut.mac_sk_move('~thor_data400::key::neustar_phone' ,'Q',mv2qa_phone);
ut.mac_sk_move('~thor_data400::key::phonesplus_did','Q',mv2qa_did);
ut.mac_sk_move('~thor_data400::key::phonesplus_fdids','Q',mv2qa_fdids);
ut.mac_sk_move('~thor_data400::key::phonesplus_companyname','Q',mv2qa_pcname);
CellPhone.MAC_AcceptSK_to_QA('~thor_data400::key::phonesplus_' ,mv_autokey,false);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

email := fileservices.sendemail('RoxieBuilds@seisint.com ; vniemela@seisint.com ; jason.allerdings@lexisnexisrisk.com',
								 
								'PHONESPLUS: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::phonesplus_address_qa(thor_data400::key::phonesplus::'+ filedate +'::address),\n' +
								'      2) thor_data400::key::phonesplus_citystname_qa(thor_data400::key::phonesplus::'+ filedate +'::citystname),\n' +
								'      3) thor_data400::key::phonesplus_did_qa(thor_data400::key::phonesplus::'+ filedate +'::did),\n' +
								'      4) thor_data400::key::phonesplus_fdids_qa(thor_data400::key::phonesplus::'+ filedate +'::fdids),\n' +
								'      5) thor_data400::key::phonesplus_name_qa(thor_data400::key::phonesplus::'+ filedate +'::name),\n' +
								'      6) thor_data400::key::phonesplus_phone_qa(thor_data400::key::phonesplus::'+ filedate +'::phone),\n' +
								'      7) thor_data400::key::phonesplus_ssn_qa(thor_data400::key::phonesplus::'+ filedate +'::ssn),\n' +
								'      8) thor_data400::key::phonesplus_stname_qa(thor_data400::key::phonesplus::'+ filedate +'::stname),\n' +
								'      9) thor_data400::key::phonesplus_zip_qa(thor_data400::key::phonesplus::'+ filedate +'::zip),\n' +
								'     10) thor_data400::key::neustar_phone(thor_data400::key::neustar::'+ filedate +'::phone),\n' +
								'     11) thor_data400::key::phonesplus_companyname_qa(thor_data400::key::phonesplus::'+ filedate +'::companyname),\n' +
						        '         have been built and ready to be deployed to QA.'); 
			
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := 

sequential(sfshuffle,
	parallel(
			  bk_did
			 ,bld_fdids
			 ,bk_phone
			 ,bk_pcname
			 ,bld_phonesplus_auto
			),
	parallel(
			 mv2blt_did
			,mv2blt_fdids
			,mv2blt_phone
			,mv2blt_pcname
			),
	parallel(
			mv2qa_did
		   ,mv2qa_fdids
		   ,mv2qa_phone
		   ,mv2qa_pcname
		   ,mv_autokey
			 )
 
   
);


return sequential(build_keys
				//,email
				);

end;


 
 
 
 