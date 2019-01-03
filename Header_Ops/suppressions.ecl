IMPORT STD;
EXPORT suppressions := MODULE

    SHARED base_name := '~thor_data400::key::pre_file_header_building::';

    hdr_base_prod := '~thor_data400::base::header_prod';

    ver_in_bldg_qa:=regexfind('[0-9]{8}',STD.File.SuperFileContents(base_name+'qa')[1].name,0);
    ver_in_base_qa:=regexfind('[0-9]{8}',STD.File.SuperFileContents(hdr_base_prod)[1].name,0);

    report := sequential(output(ver_in_bldg_qa,named('ver_in_bldg_qa')),output(ver_in_base_qa,named('ver_in_base_qa')));
    is_qa_same_as_prod := when(ver_in_bldg_qa = ver_in_base_qa,report,before);

    EXPORT promote_pre_building_reference_file :=  nothor(if(~is_qa_same_as_prod, // we do not want to promote twice!
    
        sequential(
                    fileservices.createsuperfile    (base_name+'qa'                         ,,true),
                    fileservices.createsuperfile    (base_name+'father'                     ,,true),
                    fileservices.createsuperfile    (base_name+'delete'                     ,,true),
                    fileservices.addsuperfile       (base_name+'delete',base_name+'father'  ,,true),
                    fileservices.clearsuperfile     (base_name+'father'                           ),
                    fileservices.addsuperfile       (base_name+'father',base_name+'qa'      ,,true),
                    fileservices.clearsuperfile     (base_name+'qa'                               ),
                    fileservices.addsuperfile       (base_name+'qa'    ,base_name+'built'   ,,true),
                    fileservices.clearsuperfile     (base_name+'built'                            ),
                    fileservices.RemoveOwnedSubFiles(base_name+'delete'                     ,true ),
        ),
        output('pre_building qa and base prod are already the same. Skipping superfile movement')
    ));

END;