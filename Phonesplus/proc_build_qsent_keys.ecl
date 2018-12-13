import Address,doxie_files, ut, doxie, autokey,Cellphone,RoxieKeyBuild,Phonesplus_v2,NID;

export proc_build_qsent_keys(string filedate) := 
function

sfShuffle := sequential(
	fileservices.startsuperfiletransaction(),
	//fileservices.clearsuperfile('~thor_data400::base::qsent_grandfather', true),
	//fileservices.addsuperfile('~thor_data400::base::qsent_grandfather','~thor_data400::base::qsent_father',0,true),
	//fileservices.clearsuperfile('~thor_data400::base::qsent_father'),
	//fileservices.addsuperfile('~thor_data400::base::qsent_father','~thor_data400::base::qsent',0,true),
	fileservices.clearsuperfile('~thor_data400::base::qsent', true),
	fileservices.addsuperfile('~thor_data400::base::qsent','~thor_data400::out::qsent_did_' + filedate),
	fileservices.finishsuperfiletransaction()
	);
	
Cellphone.MAC_SK_BuildProcess_v2(Phonesplus.key_qsent_did,
                          '~thor_data400::key::qsent::' +filedate+ '::did',
                          '~thor_data400::key::qsent_did', bld_did_key);
						  
						  
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Phonesplus.key_qsent_companyname
										  ,'~thor_data400::key::qsent_companyname'
										  ,'~thor_data400::key::qsent::' +filedate+ '::companyname'
										  ,bk_qcname);
											
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::qsent_companyname'
										  ,'~thor_data400::key::qsent::' +filedate+ '::companyname'
										  ,mv_comp_built);

/* ***********************start cellphones autokeys ****************************** */
dist_DSqsent := Phonesplus.File_qsent_fdid;

Phonesplus.MAC_Build_qsent(dist_DSqsent, filedate, fname,mname,lname,
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
				 '~thor_data400::key::qsent_',bld_qsent_auto,false)

						
DS_qsent_rec := record
	unsigned6 fdid;
	Phonesplus.layoutCommonKeys;
end;

DS_qsent_rec slim_it(dist_DSqsent  l) := transform
	self := l;
end;

dist_DSqsent_slim := project(dist_DSqsent, slim_it(left));

//ut.mac_suppress_by_phonetype(dist_DSqsent_slim,homephone,state,ph_out1,true,did);
//ut.mac_suppress_by_phonetype(ph_out1,cellphone,state,ph_out2,true,did);

qsent_fdids_key := index(dist_DSqsent_slim,{fdid},{dist_DSqsent_slim},
                        '~thor_data400::key::qsent_fdids');

Cellphone.MAC_SK_BuildProcess_v2(qsent_fdids_key,
                          '~thor_data400::key::qsent::' + filedate + '::fdids',
						  '~thor_data400::key::qsent_fdids',
							bld_fdids_key); 
					 
/* ***********************end providers autokeys ******************************************* */ 

ut.MAC_SK_Move_v2('~thor_data400::key::qsent_did', 'Q', mv_did_key);
CellPhone.MAC_AcceptSK_to_QA('~thor_data400::key::qsent_' ,mv_autokey,false);
ut.MAC_SK_Move_v2('~thor_data400::key::qsent_fdids', 'Q', mv_fdids_key);
ut.mac_sk_move_v2('~thor_data400::key::qsent_companyname','Q',mv2qa_qcname);

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	
email := fileservices.sendemail('RoxieBuilds@seisint.com ; vniemela@seisint.com ; tgibson@seisint.com ; fhumayun@seisint.com',
								 
								'qsent: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::qsent_address_qa(thor_data400::key::qsent::'+ filedate +'::address),\n' +
								'      2) thor_data400::key::qsent_citystname_qa(thor_data400::key::qsent::'+ filedate +'::citystname),\n' +
								'      3) thor_data400::key::qsent_did_qa(thor_data400::key::qsent::'+ filedate +'::did),\n' +
								'      4) thor_data400::key::qsent_fdids_qa(thor_data400::key::qsent::'+ filedate +'::fdids),\n' +
								'      5) thor_data400::key::qsent_name_qa(thor_data400::key::qsent::'+ filedate +'::name),\n' +
								'      6) thor_data400::key::qsent_phone_qa(thor_data400::key::qsent::'+ filedate +'::phone),\n' +
								'      7) thor_data400::key::qsent_ssn_qa(thor_data400::key::qsent::'+ filedate +'::ssn),\n' +
								'      8) thor_data400::key::qsent_stname_qa(thor_data400::key::qsent::'+ filedate +'::stname),\n' +
								'      9) thor_data400::key::qsent_zip_qa(thor_data400::key::qsent::'+ filedate +'::zip),\n' +
								'     10) thor_data400::key::qsent_companyname_qa(thor_data400::key::qsent::'+ filedate +'::companyname),\n' +
						        '         have been built and ready to be deployed to QA.'); 
			

/* ***************************************************************************************************************************************** */

return sequential(sfShuffle,
parallel(bld_did_key, 
		  bld_qsent_auto, 
		  bld_fdids_key,
		  bk_qcname),
			mv_comp_built,
parallel(mv_did_key, 
		  mv_autokey,
		  mv_fdids_key,
		  mv2qa_qcname
		  /*, 
		  email*/
		  )); 
end;