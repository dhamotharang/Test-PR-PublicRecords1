import _control,RoxieKeybuild,Appriss_Image,ut;
					
export FN_build_and_despray_to_promonitor(String proc_date):= FUNCTION

espserver:='http://'+_control.ThisEnvironment.ESP_IPAddress+':'+_control.PortAddress.esp_html+'/FileSpray';

booking_for_promonitor_file_name := appriss.cluster_name+'::out::appriss_bookings_for_promonitor_'+proc_date; 
charges_for_promonitor_file_name := appriss.cluster_name+'::out::appriss_charges_for_promonitor_'+proc_date;

bookings_for_promonitor := 
				dedup(
						sort(
							distribute(appriss.file_bookings_prepa(stringlib.StringToUpperCase(action) not in ['DELETE']),hash(booking_sid))
						 ,primarykey,agencykey,booking_sid,site_id,maxqueuesid,local)
					   ,primarykey,agencykey,booking_sid,site_id,						 local,right);
charges_for_promonitor :=   
				dedup(
						sort(
							distribute(appriss.file_charges_prepa,hash(booking_sid))
						,agencykey,booking_sid,site_id,charge_seq,charge,description,charge_dt,court_dt,key_severity,bond_amt,disposition_dt,disposition_text,ncic_offense_class_txt,ncic_offense_cd,bond_type_txt,maxqueuesid,local)
						,agencykey,booking_sid,site_id,charge_seq,charge,description,charge_dt,court_dt,key_severity,bond_amt,disposition_dt,disposition_text,ncic_offense_class_txt,ncic_offense_cd,bond_type_txt						,local,right);

//**    ---------  BUILD ALL ------------------
build_all := proc_build_all_files;

//**    ---------- Apply the updates -----------------
apply_updates := sequential(Appriss.proc_update_base_files,
                            Appriss.proc_build_all_keys(proc_date));


//**    ---------- Image Processing  -----------------
image_proc   := if(fn_exist_agencyDeletes() or Appriss_Image.fn_exists_Images(), 
                 sequential( //Appriss_Image.Prod_build_base_Firsttimeuse(proc_date),
								             Appriss_Image.proc_build_base(proc_date),
								             Appriss_Image.proc_build_keys(proc_date),
														 Appriss_Image.proc_build_all(proc_date)
													 ),
                 output('No Deletes to apply and no new images to process')
								);
update_image_dops := if(fn_exist_agencyDeletes() or Appriss_Image.fn_exists_Images(),
									      RoxieKeybuild.updateversion('ApprissImageKeys',proc_date,'vani.chikte@lexisnexis.com'),
												output('No Deletes to apply and no new images to process')
												);
//**    ---------  OUTPUT THE FILES as CSV -----------
o1:=output(bookings_for_promonitor,,	booking_for_promonitor_file_name, 	CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE);
o2:=output(charges_for_promonitor ,,	charges_for_promonitor_file_name, 	CSV(HEADING(1),SEPARATOR('|'),TERMINATOR('\n')),OVERWRITE);

//**   ------      DESPRAY FOR PROMONITOR ------------
d1 :=FileServices.DeSpray
   (booking_for_promonitor_file_name,//logicalname
    _control.IPAddress.edata12,//desination IP
		//'/hds_180/appriss/promonitor/appriss_bookings_'+proc_date,		// destinationpath
		'/hds_3/appriss/build/'+'appriss_bookings_'+proc_date+'.csv', // destinationpath

		-1,// timeout
		espserver,//espserver IP Port
		1,//Max connections
		true// OVERWRITE
		);
		
d2 :=FileServices.DeSpray
   (charges_for_promonitor_file_name,//logicalname
    _control.IPAddress.edata12,//desination IP
		//'/hds_180/appriss/promonitor/appriss_charges_'+proc_date,// destinationpath
		'/hds_3/appriss/build/'+'appriss_charges_'+proc_date+'.csv', // destinationpath
		-1,// timeout
		espserver,//espserver IP Port
		1,//Max connections
		true// OVERWRITE
		);
//CONSOLIDATE RAW FILES BEFORE CLEANUP
c1:=output(file_in_bookings_raw_xml,,cluster_name+'::in::appriss_booking_charges_raw_xml_'+thorlib.WUID(),XML);
c2:=if (fn_exist_agencyDeletes(),
      output(file_in_agency_deletes_raw_xml,,cluster_name+'::in::appriss_agency_delete_raw_xml_'+thorlib.WUID(),XML),

      output('NO AGENCY DELETE FILES FOR '+thorlib.WUID()));
      
//CLEANUP
cleanup:=_clear_raw_xml_SF;

//--------------get the sample----------------
ds := appriss.file_bookings_base;
ds_image := appriss_image.File_Appriss_image_base;

dsample := sample(ds(load_date=ut.GetDate),100000,1);
imagesample := sample(ds_image(date=ut.GetDate),100000,1);

data_sample := output(choosen(dsample,1000));
image_sample := output(choosen(imagesample,1000),{did , state,rtype,Booking_sid,agencyKey,maxQueueSid,seq,date,num,image_link;});

all_samp := parallel(data_sample, image_sample);

emailqa := FileServices.sendemail('qualityassurance@seisint.com','DAILY APRRISS SAMPLES READY','at ' + thorlib.WUID());
//------------------------------------------------------------------------------------------------------------------------
//strata counts
Out_File_Booking_stats_Population(appriss.file_bookings_base,appriss.file_charges_base,proc_date,strata_output);

//DOIT
do_it:=sequential(build_all,
                  apply_updates,image_proc,update_image_dops,
                  parallel(o1,o2),parallel(d1,d2),c1,c2,cleanup,strata_output,
									RoxieKeybuild.updateversion('ApprissKeys',proc_date,'vani.chikte@lexisnexis.com'),
									all_samp): success(emailqa);
//do_it:=sequential(build_all,c1,c2,cleanup);

//
return do_it;
END;