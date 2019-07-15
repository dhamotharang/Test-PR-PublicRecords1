fs := fileservices;

Inputs := dataset([
       {'~thor_data400::base::ln_propv2assessquickheader_building','~thor_data400::base::ln_propv2assessheader_building'},
       {'~thor_data400::base::ln_propv2addlassessquickheader_building','~thor_data400::base::ln_propv2addlassessheader_building'},
       {'~thor_data400::base::ln_propv2deedquickheader_building','~thor_data400::base::ln_propv2deedheader_building'},
       {'~thor_data400::base::ln_propv2addldeedquickheader_building','~thor_data400::base::ln_propv2addldeedheader_building'},
       {'~thor_data400::base::bksrcquickheader_building','~thor_data400::base::bksrcheader_building'},
       {'~thor_data400::base::bkmnquickheader_building',  '~thor_data400::base::bkmnheader_building'},
       {'~thor_data400::base::vehicles_v2_party_quickheader_building', '~thor_data400::base::vehicles_v2_party_header_building'},
       {'~thor_data400::base::vehicles_v2_main_quickheader_building', '~thor_data400::base::vehicles_v2_main_header_building'},
       {'~thor_data400::base::liensv2_mainquickheader_building', '~thor_data400::base::liensv2_mainheader_building'},
       {'~thor_data400::base::liensv2_partyquickheader_building', '~thor_data400::base::liensv2_partyheader_building'},
       {'~thor_data400::base::dl2::dlquickheader_building', '~thor_data400::base::dl2::dlheader_building'},   
       {'~thor_data400::base::ln_propv2srchquickheader_building', '~thor_data400::base::ln_propv2srchheader_building'},
       {'~thor_data400::base::experianquickheader_building', '~thor_data400::base::experianheader_building'},
       {'~thor_data400::base::transunioncredquickheader_building', '~thor_data400::base::transunioncredheader_building'}],
       {string QHInput, String IKBInput});

EXPORT fn_SetIKBInput() := function
    return sequential(
       fs.startsuperfiletransaction(),
       nothor(apply(Inputs, fs.clearsuperfile(IKBInput))),
       nothor(apply(Inputs, fs.addsuperfile(IKBInput, QHInput,,true))),
       fs.FinishSuperFileTransaction()
      );
end;
