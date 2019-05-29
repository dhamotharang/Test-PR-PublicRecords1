import Address,doxie_files, ut, doxie, autokey,Cellphone,RoxieKeyBuild,Phonesplus, NID;

export Proc_Build_Royalty_Keys(string filedate) := 
function

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_royalty_did
										  ,'~thor_data400::key::phonesplusv2_royalty_did'
										  ,'~thor_data400::key::phonesplusv2_royalty::' +filedate+ '::did'
										  ,bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(key_royalty_companyname
										  ,'~thor_data400::key::phonesplusv2_royalty_companyname'
										  ,'~thor_data400::key::phonesplusv2_royalty::' +filedate+ '::companyname'
										  ,bk_pcname);

/////////////////////////////////////////////////////////////////////////////////
// -- Build AutoKeys
/////////////////////////////////////////////////////////////////////////////////
phonesplusd   := phonesplus_v2._keybuild_royalty_base;
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
DS_phonesplus := PROJECT(multiCityPhonesplus,xpand_phonesplus(LEFT,COUNTER)) : PERSIST('~thor_data400::persist::phonesplusv2_royalty_fdids');

//ut.mac_suppress_by_phonetype(DS_phonesplus,cellphone,state,phones1,true,did);
//ut.mac_suppress_by_phonetype(phones1,homephone,state,phones2,true,did);

dist_DSphonesplus := distribute(DS_phonesplus,random());

Phonesplus_v2.MAC_Build('Phonesplusv2_royalty', filedate, dist_DSphonesplus,fname,mname,lname,
				 blk,
				 zero,
				 cellphone,
				 prim_name, prim_range, state, p_city_name, zip5, sec_range,
				 zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 zero,zero,zero,
				 lookups,
				 fdid,
				 '~thor_data400::key::phonesplusv2_royalty_',bld_phonesplus_auto,false, ['C','Z','T','N','S'])

						
dist_DSphonesplus_rec := record
	unsigned6 fdid;
	Phonesplus_v2.File_Phonesplus_Base;
	
end;

dist_DSphonesplus_rec slim_it(dist_DSphonesplus l) := transform
	self := l;
end;

_dist_DSphonesplus_slim := project(dist_DSphonesplus, slim_it(left));

phonesplus_fdids_key := index(_dist_DSphonesplus_slim,{fdid},{_dist_DSphonesplus_slim},
                        '~thor_data400::key::phonesplusv2_royalty_fdids');
						
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(phonesplus_fdids_key
										  ,'~thor_data400::key::phonesplusv2_royalty_fdids'
										  ,'~thor_data400::key::phonesplusv2_royalty::' + filedate + '::fdids'
										  ,bld_fdids);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesplusv2_royalty_did'
								     ,'~thor_data400::key::phonesplusv2_royalty::'+filedate+'::did'
									 ,mv2blt_did);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesplusv2_royalty_fdids'
								     ,'~thor_data400::key::phonesplusv2_royalty::'+filedate+'::fdids'
									 ,mv2blt_fdids);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::phonesplusv2_royalty_companyname'
								     ,'~thor_data400::key::phonesplusv2_royalty::'+filedate+'::companyname'
									 ,mv2blt_pcname);


/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////
//Jira DF-24336 change from ut.mac_sk_move to ut.mac_sk_move_v2 because files were not being promoted correctly.  Prior version was getting deleted on rebuild.
ut.mac_sk_move_v2('~thor_data400::key::phonesplusv2_royalty_did','Q',mv2qa_did);
ut.mac_sk_move_v2('~thor_data400::key::phonesplusv2_royalty_fdids','Q',mv2qa_fdids);
ut.mac_sk_move_v2('~thor_data400::key::phonesplusv2_royalty_companyname','Q',mv2qa_pcname);
CellPhone.MAC_AcceptSK_to_QA('~thor_data400::key::phonesplusv2_royalty_' ,mv_autokey,false);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

email := fileservices.sendemail('RoxieBuilds@seisint.com ; angela.herzberg@lexisnexis.com ;',
								 
								'PHONESPLUS: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::phonesplus_address_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::address),\n' +
								'      2) thor_data400::key::phonesplus_citystname_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::citystname),\n' +
								'      3) thor_data400::key::phonesplus_did_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::did),\n' +
								'      4) thor_data400::key::phonesplus_fdids_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::fdids),\n' +
								'      5) thor_data400::key::phonesplus_name_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::name),\n' +
								'      6) thor_data400::key::phonesplus_phone_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::phone),\n' +
								'      7) thor_data400::key::phonesplus_ssn_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::ssn),\n' +
								'      8) thor_data400::key::phonesplus_stname_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::stname),\n' +
								'      9) thor_data400::key::phonesplus_zip_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::zip),\n' +
								'     10) thor_data400::key::phonesplus_companyname_qa(thor_data400::key::phonesplusv2_royalty::'+ filedate +'::companyname),\n' +
						        '         have been built and ready to be deployed to QA.'); 
			
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := 

sequential(
	parallel(
			  bk_did
			 ,bld_fdids
			 //,bk_pcname
			 ,bld_phonesplus_auto
			),
	parallel(
			 mv2blt_did
			,mv2blt_fdids
			//,mv2blt_pcname
			),
	parallel(
			mv2qa_did
		   ,mv2qa_fdids
		   //,mv2qa_pcname
		   ,mv_autokey
			 )
 
   
);


return sequential(build_keys
				//,email
				);

end;