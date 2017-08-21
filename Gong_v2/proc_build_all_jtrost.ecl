import Address, did_add, ut, header_slimsort, business_header_ss,Lib_FileServices,Gong_v2,Gong,business_header, lib_thorlib;

#workunit('priority','high');
#workunit('priority',09);
#workunit('name','Yogurt:Gong Spray & Base File Build');

export proc_build_all_jtrost := function

lstUpdateNo   := fileservices.GetSuperFileSubCount(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2') : global; 
lstUpdateName := fileservices.GetSuperFileSubName(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2',lstUpdateNo) : global;
update_date   := stringlib.stringfilter(lstUpdateName,'0123456789')[4..11] : global;

build_it_all :=

/* Check to see if base is already available. If not then build base and master */

sequential(
		if(fileservices.GetSuperFileSubName('~thor_data400::base::gong', 1) = Gong_v2.thor_cluster+'base::lss_gong'+ update_date,
		/* EXISTS */		output(fileservices.GetSuperFileSubName('~thor_data400::base::gong', 1) + ' file created. Proceeding to moxie keybuild.'),
		/* NOT EXIST */		sequential(
								gong_v2.proc_build_lss_master_jtrost(update_date) //builds the master file
								,gong_v2.proc_build_lss_gong_jtrost(update_date)   //builds the base file
								))

/* Prepare for Moxie Build. Despray, layout change, and superfile swap */
 
  ,notify('Yogurt:GONG BASE FILE COMPLETE','*') //Begin GongKeys - Builds Roxie Keys
  ,FileServices.SendEmail('christopher.brodeur@lexisnexis.com, cguyton@seisint.com', 'GONG - Notify Sent', thorlib.wuid() + ': v1 Base, v2 Base, and ClickData files are complete.  v1 Base also desprayed')

/* Send stats for base file and prepare clickdata */
	,output('Count Vendor Connect/Disconnect')
	,Gong.File_GongVendorIDs.fn_master_vendor_counts(gong_v2.File_GongMaster)
	// ,output('Count Vendor Connect/Disconnect - Unique Vendor/Phone/CurrentFlag')
	// ,Gong.File_GongVendorIDs.fn_master_vendor_counts(dedup(sort(gong_v2.File_GongMaster, vendor, npa, telno, -current_record_flag), vendor, npa, telno))
  ,Gong.out_STRATA_population_stats(update_date) //STRATA
  ,Gong_v2.proc_build_gongAsClickdata //Clickdata
  
      
	 
  ) : SUCCESS(FileServices.SendEmail('intel357@bellsouth.net', 'GONG - Base File Build Complete', thorlib.wuid() + ' Version: ' + update_date)),
      Failure(FileServices.SendEmail('afterhourssupport@seisint.com, christopher.brodeur@lexisnexis.com, cguyton@seisint.com, cnguyton@gmail.com, intel357@bellsouth.net, chuck.salvo@gmail.com', 'GONG-EDA Base Failure', thorlib.wuid() + '\n' + FAILMESSAGE))
;

return build_it_all;
 
end;