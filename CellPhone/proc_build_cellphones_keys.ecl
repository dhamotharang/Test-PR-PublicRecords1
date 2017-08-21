import doxie_files, ut, doxie, autokey,Cellphone;

export proc_build_cellphones_keys(string filedate) := 
function

sfShuffle := sequential(
	fileservices.startsuperfiletransaction(),
	fileservices.clearsuperfile('~thor_data400::base::cellphones_grandfather'),
	fileservices.addsuperfile('~thor_data400::base::cellphones_grandfather','~thor_data400::base::cellphones_father',0,true),
	fileservices.clearsuperfile('~thor_data400::base::cellphones_father'),
	fileservices.addsuperfile('~thor_data400::base::cellphones_father','~thor_data400::base::cellphones',0,true),
	fileservices.clearsuperfile('~thor_data400::base::cellphones'),
	fileservices.addsuperfile('~~thor_data400::base::cellphones','~thor_data400::out::cellphones_did_' + CellPhone.version),
	fileservices.finishsuperfiletransaction()
	);


Cellphone.MAC_SK_BuildProcess_v2(Cellphone.key_cellphones_did,
                          '~thor_data400::key::cellphones::' +filedate+ '::did',
                          '~thor_data400::key::cellphones_did', bld_did_key);
						  
/* ***********************start cellphones autokeys ****************************** */

f_cellphones := Cellphone.file_cellphones_base;

xl_cellphones := RECORD
	f_cellphones;
	unsigned6 fdid;
	zero := 0;
	blk := '';
	unsigned4 lookups := ut.bit_set(0,doxie.lookup_bit('NXTO'))| ut.bit_set(0,0);
END;

xl_cellphones xpand_cellpho(f_cellphones le,integer cellpho_cntr) :=  TRANSFORM 
	SELF.fdid := cellpho_cntr + autokey.did_adder('NXTO'); 
	SELF := le; 
END;
DS_cellpho := PROJECT(f_cellphones,xpand_cellpho(LEFT,COUNTER)) : PERSIST('~thor_data400::persist::cellphone_fdids');

Cellphone.MAC_Build(DS_cellpho,fname,mname,lname,
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
				 '~thor_data400::key::cellphones_',bld_cellpho_auto,false)

						
DS_cellpho_rec := record
	unsigned6 fdid;
	f_cellphones;
end;

DS_cellpho_rec slim_it(DS_cellpho  l) := transform
	self := l;
end;

DS_cellpho_slim := project(DS_cellpho, slim_it(left));

cellpho_fdids_key := index(DS_cellpho_slim,{fdid},{DS_cellpho_slim},
                        '~thor_data400::key::cellphones_fdids');

Cellphone.MAC_SK_BuildProcess_v2(cellpho_fdids_key,
                          '~thor_data400::key::cellphones::' + filedate + '::fdids',
						  '~thor_data400::key::cellphones_fdids',
							bld_fdids_key); 
					 
/* ***********************end providers autokeys ******************************************* */ 

ut.MAC_SK_Move_v2('~thor_data400::key::cellphones_did', 'Q', mv_did_key);
CellPhone.MAC_AcceptSK_to_QA('~thor_data400::key::cellphones_' ,mv_autokey,false);
ut.MAC_SK_Move_v2('~thor_data400::key::cellphones_fdids', 'Q', mv_fdids_key);

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	
email := fileservices.sendemail('RoxieBuilds@seisint.com ; vniemela@seisint.com ; tgibson@seisint.com',
								 
								'CELLPHONES: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::cellphones_address_qa(thor_data400::key::cellphones::'+ filedate +'::address),\n' +
								'      2) thor_data400::key::cellphones_citystname_qa(thor_data400::key::cellphones::'+ filedate +'::citystname),\n' +
								'      3) thor_data400::key::cellphones_did_qa(thor_data400::key::cellphones::'+ filedate +'::did),\n' +
								'      4) thor_data400::key::cellphones_fdids_qa(thor_data400::key::cellphones::'+ filedate +'::fdids),\n' +
								'      5) thor_data400::key::cellphones_name_qa(thor_data400::key::cellphones::'+ filedate +'::name),\n' +
								'      6) thor_data400::key::cellphones_phone_qa(thor_data400::key::cellphones::'+ filedate +'::phone),\n' +
								'      7) thor_data400::key::cellphones_ssn_qa(thor_data400::key::cellphones::'+ filedate +'::ssn),\n' +
								'      8) thor_data400::key::cellphones_stname_qa(thor_data400::key::cellphones::'+ filedate +'::stname),\n' +
								'      9) thor_data400::key::cellphones_zip_qa(thor_data400::key::cellphones::'+ filedate +'::zip),\n' +
						        '         have been built and ready to be deployed to QA.'); 
			

/* ***************************************************************************************************************************************** */

return sequential(sfShuffle,parallel(bld_did_key, 
			bld_cellpho_auto, 
			bld_fdids_key),
    parallel(mv_did_key, 
			mv_autokey,
			mv_fdids_key, 
			email));

  
											 

end;