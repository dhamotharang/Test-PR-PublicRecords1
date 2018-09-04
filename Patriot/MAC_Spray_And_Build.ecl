//export MAC_Spray_And_Build(sourceIP,sourceFile,filedate,recsize = '4235',doscore = 'false', group_name='\'thor400_60\'') := macro

export MAC_Spray_And_Build(filedate,recsize = '4235',doscore = 'false', group_name='\'thor400_44\'') := macro

#uniquename(pre)
#uniquename(serverIP)
// %serverIP% := map(
												// sourceIP = 'edata10' => _control.IPAddress.edata10,
												// sourceIP = 'edata12' => _control.IPAddress.edata12,
												// sourceIP
												// );
												
//patriot.mac_file_spray_and_build(%serverIP%,sourceFile,recsize,filedate,'patriot_file',%pre%,group_name);
patriot.mac_file_spray_and_build(recsize,filedate,'patriot_file',%pre%,group_name);
							
#uniquename(stats)
#uniquename(inf)
%inf% := patriot.file_patriot_keybuild;
fieldstats.mac_stat_file(%inf%,%stats%,'patriot',50,6,false,
						orig_pty_name,'string','M',
						orig_vessel_name,'string','M',
						addr_1,'string','M',
						remarks_1,'string','M',
						lname,'string','M',
						prim_name,'string','M')

#uniquename(do1)
#uniquename(do2)
#uniquename(do3)
#uniquename(do4)
#uniquename(do5)
#uniquename(do6)
#uniquename(do6half)
#uniquename(do7)
#uniquename(do8)
#uniquename(do9)
#uniquename(do10)


%do1% := output(count(Patriot.ScoreNames));
%do2% := patriot.Proc_BuildDidKeys(filedate);
//%do3% := patriot.Proc_BuildWordKeys(filedate);
%do4% := patriot.Proc_Build_Patriot_Keys(filedate);
//%do5% := patriot.Proc_Patriot_Key_Diff(filedate);
%do6% := patriot.Proc_Patriot_Keys_to_Built(filedate);
%do8% := patriot.proc_accept_sk_to_qa;

#uniquename(e_mail_success)
#uniquename(e_mail_fail)

%e_mail_success% := fileservices.sendemail(
											'roxiebuilds@seisint.com;kgummadi@seisint.com',
											'Patriot Build Succeeded ' + filedate,
											'keys: 1) thor_data400::key::baddids_qa(thor_data400::key::patriot::'+filedate+'::baddids),\n' + 
											'	     2) thor_data400::key::patriot_did_file_qa(thor_data400::key::patriot::'+filedate+'::did_file),\n' + 
											'      3) thor_data400::key::patriot_bdid_file_qa(thor_data400::key::patriot::'+filedate+'::bdid_file),\n' + 
											'	     4) thor_data400::key::patriot_key_qa(thor_data400::key::patriot::'+filedate+'::patriot_key),\n' +
											'	     5) thor_data400::key::patriot_phoneticnames_qa(thor_data400::key::patriot::'+filedate+'::phoneticnames),\n' +
											'	     6) thor_data400::key::annotated_names_qa(thor_data400::key::patriot::'+filedate+'::annotated_names),\n' +
											'	     7) thor_data400::key::patriot::baddies_with_name_qa(thor_data400::key::patriot::'+filedate+'::baddies_with_name), \n' +
											'	     8) thor_data400::key::patriot_file_full_qa(thor_data400::key::patriot::'+filedate+'::file_full),\n' + 
											'      have been built and ready to be deployed to QA.');
					
%e_mail_fail% := fileservices.sendemail(
										'kgummadi@seisint.com',
										'Patriot Build FAILED ' + filedate,
										'');


// Do STRATA stats work
Patriot.Out_Patriot_File_Stats_Population(filedate,strata_output)

// Update DOPS page
%do9% := dops.updateversion('PatriotKeys',filedate,'kgummadi@seisint.com',,'N');

//Create Orbit Entry
%do10% := Orbit3.proc_Orbit3_CreateBuild_AddItem ('Patriot Act',filedate);

#if(doscore)
	sequential(%pre%, /*%stats%,*/ %do1%, %do2%,/*%do3%,*/%do4%,%do6%,%do8%,%do9%,%do10%,strata_output) : 
	success(%e_mail_success%),
	failure(%e_mail_fail%);
#else
	sequential(%pre%, /*%stats%,*/ %do2%,/*%do3%,*/%do4%,%do6%,%do8%,%do9%,%do10%,strata_output) :
	success(%e_mail_success%),
	failure(%e_mail_fail%);
#end

endmacro;