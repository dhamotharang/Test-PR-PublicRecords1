
import ut; 

export ConcatInput := function
ECrash_incident := FLAccidents_Ecrash.Infiles.incident; 
ECrash_citation := FLAccidents_Ecrash.Infiles.citation;
ECrash_commercl := FLAccidents_Ecrash.Infiles.commercl;
ECrash_persn := FLAccidents_Ecrash.Infiles.persn;
ECrash_vehicl := FLAccidents_Ecrash.Infiles.vehicl;
ECrash_Property_damage := FLAccidents_Ecrash.Infiles.Property_damage;
photo := DATASET('~thor_data400::in::ecrash::document_raw'
																	,FLAccidents_Ecrash.Layouts.PhotoLayout
																	,CSV(TERMINATOR('\n'), SEPARATOR(','),QUOTE('"')),OPT);

time := ut.gettime() : independent; 
date := ut.GetDate : independent; 


outrec := record 

string filedate;
string flag;
string del_incident_id;
string add_incident_id;
end;

ds := dataset('~thor_data400::out::ecrash::dupes',outrec, csv(terminator('\n')
												 ,separator(','))) ( filedate <> 'filedate');
												 

create_logical:= sequential(
output(ECrash_commercl,,'~thor_data400::in::ecrash::commercl_patch_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'))),
output(ECrash_Property_damage,,'~thor_data400::in::ecrash::Property_damage_patch_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000))),
output(ECrash_citation,,'~thor_data400::in::ecrash::citation_patch_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'))),
output(ECrash_vehicl,,'~thor_data400::in::ecrash::vehicl_patch_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'),maxlength(50000))),
output(ECrash_persn,,'~thor_data400::in::ecrash::persn_patch_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'))),
output(ECrash_incident,,'~thor_data400::in::ecrash::incident_patch_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'),maxlength(60000))),
output(ds,,'~thor_data400::out::ecrash::extract::caseDupes::thru_'+date+'_'+time,compressed,csv(heading('filedate,flag,del_incident_id,add_incident_id\n'),terminator('\n')
												 ,separator(','))), 
output(photo,,'~thor_data400::in::ecrash::document_raw_'+date+'_'+time,compressed,csv(terminator('\n'), separator(','),quote('"'))));

/*output(FLAccidents_Ecrash.File_Accident_Watch_Full ,,'~thor_data::base::AccidentWatch_full_thru_'+date+'_'+time,csv(
    HEADING('orig_accnbr|vehicle_incident_id|vehicle_status|accident_date|did|title|fname|mname|lname|name_suffix|dob|b_did|cname|prim_range|predir|prim_name|addr_suffix|postdir|unit_desig|sec_range|v_city_name|st|zip|zip4|record_type|report_code|report_code_desc|report_category|vin|driver_license_nbr|dlnbr_st|tag_nbr|tagnbr_st|accident_location|accident_street|accident_cross_street|jurisdiction|jurisdiction_state|vehicle_unit_number|vehicle_incident_city|vehicle_incident_st|carrier_name|Policy_num|Policy_Effective_Date|process_date_time|report_type|addl_report_number|agency_id|agency_ori|Insurance_Company_Standardized|source_id|hash_key|work_type_id|CRU_order_id|CRU_Seq_number|carrier_id_carriername|update_flag|Report_Type_ID|carrier_id_carrierSource\n','',SINGLE)
      ,SEPARATOR('|'), TERMINATOR('\n')),OVERWRITE)
*/

//please verify the logical files before clearing the super files

clear_super := sequential(fileservices.clearsuperfile('~thor_data400::in::ecrash::commercl_raw'), 
fileservices.clearsuperfile('~thor_data400::in::ecrash::citatn_raw'),
fileservices.clearsuperfile('~thor_data400::in::ecrash::incidnt_raw_new'),
fileservices.clearsuperfile('~thor_data400::in::ecrash::persn_raw'), 
fileservices.clearsuperfile('~thor_data400::in::ecrash::vehicl_raw'), 
fileservices.clearsuperfile('~thor_data400::in::ecrash::propertydamage_raw'),
fileservices.clearsuperfile( '~thor_data400::out::ecrash::dupes'),
fileservices.clearsuperfile( '~thor_data400::in::ecrash::document_raw')	);
//fileservices.clearsuperfile( '~thor_data::base::AccidentWatch_full')); 

add_super := sequential(fileservices.addsuperfile('~thor_data400::in::ecrash::commercl_raw','~thor_data400::in::ecrash::commercl_patch_'+date+'_'+time), 
fileservices.addsuperfile('~thor_data400::in::ecrash::citatn_raw','~thor_data400::in::ecrash::citation_patch_'+date+'_'+time), 
fileservices.addsuperfile('~thor_data400::in::ecrash::incidnt_raw_new','~thor_data400::in::ecrash::incident_patch_'+date+'_'+time), 
fileservices.addsuperfile('~thor_data400::in::ecrash::persn_raw','~thor_data400::in::ecrash::persn_patch_'+date+'_'+time), 
fileservices.addsuperfile('~thor_data400::in::ecrash::vehicl_raw','~thor_data400::in::ecrash::vehicl_patch_'+date+'_'+time), 
fileservices.addsuperfile('~thor_data400::in::ecrash::propertydamage_raw','~thor_data400::in::ecrash::Property_damage_patch_'+date+'_'+time),
fileservices.addsuperfile('~thor_data400::out::ecrash::dupes', '~thor_data400::out::ecrash::extract::caseDupes::thru_'+date+'_'+time),
FileServices.AddSuperfile('~thor_data400::in::ecrash::document_raw','~thor_data400::in::ecrash::document_raw_'+date+'_'+time));
//fileservices.addsuperfile('~thor_data::base::AccidentWatch_full', '~thor_data::base::AccidentWatch_full_thru_'+date+'_'+time 

validate_counts := map ( count(FLAccidents_Ecrash.Infiles.incident) <> count(ECrash_incident) => FAIL('ECrash_Incident_counts_mismatch'),
                     count(FLAccidents_Ecrash.Infiles.persn) <> count(ECrash_persn) => FAIL('ECrash_Person_counts_mismatch'),
										 count(FLAccidents_Ecrash.Infiles.vehicl) <> count(ECrash_vehicl) => FAIL('ECrash_Vehicle_counts_mismatch'),
										 count(FLAccidents_Ecrash.Infiles.citation) <> count(ECrash_citation) => FAIL('ECrash_Citation_counts_mismatch'),
										 count(FLAccidents_Ecrash.Infiles.Property_damage) <> count(ECrash_Property_damage) => FAIL('ECrash_Ptydamage_counts_mismatch'),
										 count(FLAccidents_Ecrash.Infiles.commercl) <> count(ECrash_commercl) => FAIL('ECrash_Commercial_counts_mismatch'),
										 Output('All_ECrash_Concat_filecnt_looks_good')
										 );

return sequential(output(count(FLAccidents_Ecrash.Infiles.incident),named('raw_incident')),
            output(count(ECrash_incident),named('outputraw_incident')),
				    output(count(FLAccidents_Ecrash.Infiles.persn),named('raw_person')),
            output(count(ECrash_persn),named('outputraw_person')),
            output(count(FLAccidents_Ecrash.Infiles.vehicl),named('raw_vehicle')), 
            output(count(ECrash_vehicl),named('outputraw_vehicle')),
            output(count(FLAccidents_Ecrash.Infiles.citation),named('raw_citation')),
           output(count(ECrash_citation),named('outputraw_citation')),
           output(count(FLAccidents_Ecrash.Infiles.Property_damage),named('raw_property')),
           output(count(ECrash_Property_damage),named('outputraw_property')),
           output(count(FLAccidents_Ecrash.Infiles.commercl),named('raw_commercl')),
           output(count(ECrash_commercl),named('outputraw_commercl')),validate_counts,
           create_logical , clear_super, add_super
					 ); 
end;