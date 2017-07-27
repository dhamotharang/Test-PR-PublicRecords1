import std, mprd;

EXPORT Utilities := module
    /* ==================================================================================================
    | This file is a grouping of utilities designed primarily for testing. 
    + =================================================================================================*/
    
    // --------------------------------------------------------------------------------------------------
    export CountLoggingRecord := record
        string     _LogDescription;
        string     _Count;
    end;

    export countLogMsg(string _LogDescription, string _Count, string LogName = 'Count Log Table') := 
        output(dataset([{_LogDescription, _Count}], CountLoggingRecord), named (LogName), extend);

    export GeneralLoggingRecord := record
        string     Description1;
        string     Description2;
        string     Description3;
        string     Description4;
    end;
    
    export generalLogMsg(string Description1, string Description2, string Description3 = '', string Description4 = '', string LogName = 'Generic Log Table') := 
        output(dataset([{Description1, Description2, Description3, Description4}], GeneralLoggingRecord), named (LogName), extend);
        
    // --------------------------------------------------------------------------------------------------
    // Input Super File Handling
    export ClearAllInputSuperfilesViaApply() := function
        ListOfFiles := std.file.LogicalFileList('thor_data400::in::mprd*',,true);
        // Get only the list of Superfiles        
        FilteredListOfFiles := ListOfFiles(superfile = true);
        nothor(apply(FilteredListOfFiles, FileServices.ClearSuperFile('~' + FilteredListOfFiles.name)));
        return 'Input Superfiles Cleared';
    end;
     
    export ClearAllInputSuperfiles() := nothor(sequential(
        FileServices.ClearSuperFile('~thor_data400::in::mprd::abbr_lu');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::abbr_lu::history');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::addr_name_xref');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::addr_name_xref::history');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_addr');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_addr::history');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_claims');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_claims::history');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_cp');
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_cp::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_deceased'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_deceased::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_facility_mme'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::basc_facility_mme::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::best_hospital'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::best_hospital::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::call_queue_bad'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::call_queue_bad::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::claims_addr_master'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::claims_addr_master::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::claims_by_month'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::claims_by_month::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::client_data'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::client_data::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::dea_xref'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::dea_xref::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::dir_confidence_2010_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::dir_confidence_2010_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::facility'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::facility::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::facility_name_xref'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::facility_name_xref::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::group_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::group_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::hospital_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::hospital_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::ignore_terms_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::ignore_terms_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::individual'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::individual::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::last_name_stats'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::last_name_stats::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::lic_filedate'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::lic_filedate::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::lic_xref'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::lic_xref::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::nanpa'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::nanpa::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::npi_extension'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::npi_extension::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::npi_extension_facility'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::npi_extension_facility::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::npi_tin_xref'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::npi_tin_xref::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::office_attributes'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::office_attributes::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::office_attributes_facility'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::office_attributes_facility::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::source_confidence_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::source_confidence_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::specialty_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::specialty_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::std_terms_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::std_terms_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::taxon_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::taxon_lu::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::taxonomy_equiv'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::taxonomy_equiv::history'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::taxonomy_full_lu'); 
        FileServices.ClearSuperFile('~thor_data400::in::mprd::taxonomy_full_lu::history'); 
        ));

    // Function to clear only the Input History Super Files
    export ClearInputHistorySuperfilesViaApply() := function
        // Get the list of history superfiles - history are only superfiles
        ListOfFiles := std.file.LogicalFileList('thor_data400::in::mprd*history*',,true);
        nothor(apply(ListOfFiles, FileServices.ClearSuperFile('~' + ListOfFiles.name)));
        return 'Input History Superfiles Cleared';
    end;

    export AddInputFilesToSuperfilesViaApply(string pVersion) := function
        // Get the list of all files including superfiles
        ListOfFiles := std.file.LogicalFileList('thor_data400::in::mprd*',,true);
        
        // Strip out non-superfiles and history superfiles
        FilteredListOfFiles := ListOfFiles(superfile = true and not regexfind('history', name, nocase));
        
        FileServices.StartSuperfileTransaction();
        nothor(apply(FilteredListOfFiles, FileServices.AddSuperFile('~' + FilteredListOfFiles.name, '~' + FilteredListOfFiles.name + '::' + pVersion)));
        FileServices.FinishSuperFileTransaction();
        return ('Added input file ' + pVersion + ' to Input Superfiles'); 
    end;
        
    // Input Logical File to Super File Handling
    export AddInputFilesToSuperfiles(string pVersion) := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.AddSuperFile('~thor_data400::in::mprd::abbr_lu','~thor_data400::in::mprd::abbr_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::addr_name_xref','~thor_data400::in::mprd::addr_name_xref::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::basc_addr','~thor_data400::in::mprd::basc_addr::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::basc_claims','~thor_data400::in::mprd::basc_claims::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::basc_deceased','~thor_data400::in::mprd::basc_deceased::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::basc_facility_mme','~thor_data400::in::mprd::basc_facility_mme::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::best_hospital','~thor_data400::in::mprd::best_hospital::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::call_queue_bad','~thor_data400::in::mprd::call_queue_bad::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::claims_by_month','~thor_data400::in::mprd::claims_by_month::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::claims_addr_master','~thor_data400::in::mprd::claims_addr_master::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::client_data','~thor_data400::in::mprd::client_data::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::dea_xref','~thor_data400::in::mprd::dea_xref::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::dir_confidence_2010_lu','~thor_data400::in::mprd::dir_confidence_2010_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::facility','~thor_data400::in::mprd::facility::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::facility_name_xref','~thor_data400::in::mprd::facility_name_xref::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::group_lu','~thor_data400::in::mprd::group_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::hospital_lu','~thor_data400::in::mprd::hospital_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::ignore_terms_lu','~thor_data400::in::mprd::ignore_terms_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::individual','~thor_data400::in::mprd::individual::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::last_name_stats','~thor_data400::in::mprd::last_name_stats::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::lic_filedate','~thor_data400::in::mprd::lic_filedate::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::lic_xref','~thor_data400::in::mprd::lic_xref::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::nanpa','~thor_data400::in::mprd::nanpa::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::npi_extension','~thor_data400::in::mprd::npi_extension::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::npi_extension_facility','~thor_data400::in::mprd::npi_extension_facility::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::npi_tin_xref','~thor_data400::in::mprd::npi_tin_xref::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::office_attributes_facility','~thor_data400::in::mprd::office_attributes_facility::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::office_attributes','~thor_data400::in::mprd::office_attributes::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::source_confidence_lu','~thor_data400::in::mprd::source_confidence_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::std_terms_lu','~thor_data400::in::mprd::std_terms_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::specialty_lu','~thor_data400::in::mprd::specialty_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::taxon_lu','~thor_data400::in::mprd::taxon_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::taxonomy_equiv','~thor_data400::in::mprd::taxonomy_equiv::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::taxonomy_full_lu','~thor_data400::in::mprd::taxonomy_full_lu::' + pVersion);
        FileServices.AddSuperFile('~thor_data400::in::mprd::basc_cp','~thor_data400::in::mprd::basc_cp::' + pVersion);
        FileServices.FinishSuperFileTransaction();
        ));

    // Input Logical File Handling
    export DeleteInputFilesByVersion(string pVersion) := nothor(sequential(
        if (FileServices.FileExists('~thor_data400::in::mprd::abbr_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::abbr_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::addr_name_xref' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::addr_name_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::basc_addr' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::basc_addr::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::basc_claims' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::basc_claims::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::basc_deceased' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::basc_deceased::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::basc_facility_mme' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::basc_facility_mme::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::best_hospital' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::best_hospital::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::call_queue_bad' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::call_queue_bad::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::claims_by_month' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::claims_by_month::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::claims_addr_master' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::claims_addr_master::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::client_data' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::client_data::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::dea_xref' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::dea_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::dir_confidence_2010_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::dir_confidence_2010_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::facility' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::facility::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::facility_name_xref' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::facility_name_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::group_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::group_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::hospital_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::hospital_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::ignore_terms_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::ignore_terms_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::individual' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::individual::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::last_name_stats' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::last_name_stats::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::lic_filedate' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::lic_filedate::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::lic_xref' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::lic_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::nanpa' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::nanpa::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::npi_extension' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::npi_extension::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::npi_extension_facility' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::npi_extension_facility::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::npi_tin_xref' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::npi_tin_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::office_attributes_facility' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::office_attributes_facility::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::office_attributes' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::office_attributes::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::source_confidence_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::source_confidence_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::std_terms_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::std_terms_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::specialty_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::specialty_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::taxon_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::taxon_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::taxonomy_equiv' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::taxonomy_equiv::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::taxonomy_full_lu' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::taxonomy_full_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::in::mprd::basc_cp' + pVersion), FileServices.DeleteLogicalFile('~thor_data400::in::mprd::basc_cp::' + pVersion));
        ));

    // --------------------------------------------------------------------------------------------------
    // Base Super File Handling
    export ClearBaseBuildingSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::building');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::building');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseBuiltSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::built');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::built');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseBuiltDeleteSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::builtdelete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::builtdelete');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseDeleteSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::delete');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::delete');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseFatherSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::father');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::father');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseGrandfatherSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::grandfather');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::grandfather');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseProdSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::prod');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::prod');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearBaseQASuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::base::mprd::abbr_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::addr_name_xref::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_addr::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_claims::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_cp::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_deceased::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::basc_facility_mme::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::best_hospital::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::call_queue_bad::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_addr_master::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::claims_by_month::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::client_data::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dea_xref::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::dir_confidence_2010_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::facility_name_xref::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::group_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::hospital_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::ignore_terms_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::individual::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::last_name_stats::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_filedate::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::lic_xref::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::nanpa::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_extension_facility::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::npi_tin_xref::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::office_attributes_facility::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::source_confidence_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::specialty_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::std_terms_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxon_lu::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_equiv::qa');
        FileServices.ClearSuperFile('~thor_data400::base::mprd::taxonomy_full_lu::qa');
        FileServices.FinishSuperFileTransaction();
        ));

    // Base Logical File Handling
    export DeleteBaseFilesByVersion(string pVersion) := nothor(sequential(
        if (FileServices.FileExists('~thor_data400::base::mprd::abbr_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::abbr_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::addr_name_xref::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::addr_name_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::basc_addr::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::basc_addr::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::basc_claims::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::basc_claims::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::basc_cp::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::basc_cp::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::basc_deceased::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::basc_deceased::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::basc_facility_mme::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::basc_facility_mme::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::best_hospital::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::best_hospital::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::call_queue_bad::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::call_queue_bad::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::claims_addr_master::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::claims_addr_master::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::claims_by_month::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::claims_by_month::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::client_data::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::client_data::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::dea_xref::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::dea_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::dir_confidence_2010_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::dir_confidence_2010_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::facility::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::facility::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::facility_name_xref::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::facility_name_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::group_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::group_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::hospital_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::hospital_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::ignore_terms_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::ignore_terms_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::individual::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::individual::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::last_name_stats::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::last_name_stats::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::lic_filedate::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::lic_filedate::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::lic_xref::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::lic_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::nanpa::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::nanpa::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::npi_extension::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::npi_extension::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::npi_extension_facility::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::npi_extension_facility::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::npi_tin_xref::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::npi_tin_xref::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::office_attributes::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::office_attributes::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::office_attributes_facility::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::office_attributes_facility::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::source_confidence_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::source_confidence_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::specialty_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::specialty_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::std_terms_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::std_terms_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::taxon_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::taxon_lu::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::taxonomy_equiv::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::taxonomy_equiv::' + pVersion));
        if (FileServices.FileExists('~thor_data400::base::mprd::taxonomy_full_lu::' + pVersion), Fileservices.DeleteLogicalFile('~thor_data400::base::mprd::taxonomy_full_lu::' + pVersion));
        ));

    // --------------------------------------------------------------------------------------------------
    // Key Super File Handling
    export ClearKeyBuildingSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::building::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::building::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::building::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::building::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::building::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::building::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::building::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::building::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::building::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::building::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::building::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::building::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::building::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::building::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::building::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::building::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::building::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::building::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::building::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::building::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::building::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::building::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::building::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::building::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::building::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::building::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearKeyBuiltSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::built::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::built::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::built::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::built::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::built::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::built::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::built::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::built::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::built::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::built::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::built::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::built::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::built::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::built::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::built::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::built::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::built::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::built::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::built::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::built::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::built::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::built::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::built::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::built::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::built::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::built::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));
            
    export ClearKeyBuiltdeleteSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::builtdelete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::builtdelete::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::builtdelete::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::builtdelete::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::builtdelete::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::builtdelete::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::builtdelete::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::builtdelete::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::builtdelete::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::builtdelete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::builtdelete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::builtdelete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::builtdelete::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::builtdelete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::builtdelete::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::builtdelete::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::builtdelete::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::builtdelete::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::builtdelete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::builtdelete::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::builtdelete::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::builtdelete::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::builtdelete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::builtdelete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::builtdelete::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::builtdelete::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));
            
    export ClearKeyDeleteSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::delete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::delete::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::delete::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::delete::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::delete::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::delete::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::delete::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::delete::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::delete::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::delete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::delete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::delete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::delete::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::delete::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::delete::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::delete::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::delete::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::delete::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::delete::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::delete::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::delete::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::delete::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::delete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::delete::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::delete::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::delete::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearKeyFatherSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::father::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::father::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::father::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::father::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::father::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::father::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::father::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::father::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::father::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::father::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::father::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::father::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::father::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::father::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::father::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::father::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::father::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::father::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::father::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::father::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::father::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::father::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::father::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::father::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::father::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::father::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));
            
    export ClearKeyGrandfatherSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::grandfather::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::grandfather::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::grandfather::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::grandfather::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::grandfather::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::grandfather::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::grandfather::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::grandfather::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::grandfather::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::grandfather::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::grandfather::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::grandfather::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::grandfather::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::grandfather::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::grandfather::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::grandfather::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::grandfather::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::grandfather::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::grandfather::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::grandfather::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::grandfather::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::grandfather::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::grandfather::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::grandfather::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::grandfather::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::grandfather::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));

    export ClearKeyProdSuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::prod::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::prod::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::prod::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::prod::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::prod::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::prod::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::prod::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::prod::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::prod::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::prod::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::prod::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::prod::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::prod::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::prod::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::prod::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::prod::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::prod::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::prod::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::prod::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::prod::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::prod::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::prod::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::prod::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::prod::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::prod::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::prod::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));

    // This function combines the LogicalFileList with apply to clear the keys
    export ClearKeyQASuperfilesViaApply() := function
        // Get the list of files - flag includes superfiles - only superfiles are qa type
        ListOfFiles := std.file.LogicalFileList('thor_data400::key::mprd*qa*',,true);
       
        nothor(apply(ListOfFiles, FileServices.ClearSuperFile('~' + ListOfFiles.name)));
        return 'QA Superfiles Cleared';
    end;
     
    export ClearKeyQASuperfiles() := nothor(sequential(
        FileServices.StartSuperFileTransaction();
        FileServices.ClearSuperFile('~thor_data400::key::mprd::abbr_lu::qa::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::addr_name_xref::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_addr::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_claims::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_cp::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_deceased::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::basc_facility_mme::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::best_hospital::qa::addr_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::call_queue_bad::qa::prac_phone1');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::qa::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::qa::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_addr_master::qa::rendering_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::claims_by_month::qa::bill_tin');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::client_data::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::dea_xref::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::qa::filecode_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_join::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::facility_name_xref::qa::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::group_lu::qa::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::hospital_lu::qa::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::ignore_term_lu::qa::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::individual_join::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::last_name_stats::qa::last_name');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::lic_xref::qa::group_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::nanpa::qa::npa_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension::qa::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_extension_facility::qa::npi_num');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::npi_tin_xref::qa::bill_npi');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes::qa::surrogate_key');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::office_attributes_facility::qa::surrogate_key');   
        FileServices.ClearSuperFile('~thor_data400::key::mprd::source_confidence_lu::qa::filecode');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::specialty_lu::qa::specialty');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::std_terms_lu::qa::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxon_lu::qa::code');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_equiv::qa::taxonomy');
        FileServices.ClearSuperFile('~thor_data400::key::mprd::taxonomy_full_lu::qa::taxonomy');
        FileServices.FinishSuperFileTransaction();
        ));

    export DeleteKeyFilesByVersion(string pVersion) := nothor(sequential(
        if (FileServices.FileExists('~thor_data400::key::mprd::abbr_lu::' +pVersion + '::code'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::abbr_lu::' +pVersion + '::code'));                                 
        if (FileServices.FileExists('~thor_data400::key::mprd::addr_name_xref::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::addr_name_xref::' +pVersion + '::group_key'));                     
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_addr::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_addr::' +pVersion + '::surrogate_key'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_claims::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_claims::' +pVersion + '::group_key'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_claims::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_claims::' +pVersion + '::surrogate_key'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_cp::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_cp::' +pVersion + '::group_key'));                            
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_cp::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_cp::' +pVersion + '::surrogate_key'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_deceased::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_deceased::' +pVersion + '::group_key'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_facility_mme::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::basc_facility_mme::' +pVersion + '::group_key'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::best_hospital::' +pVersion + '::addr_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::best_hospital::' +pVersion + '::addr_key'));                       
        if (FileServices.FileExists('~thor_data400::key::mprd::call_queue_bad::' +pVersion + '::prac_phone1'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::call_queue_bad::' +pVersion + '::prac_phone1'));                   
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_addr_master::' +pVersion + '::bill_npi'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::claims_addr_master::' +pVersion + '::bill_npi'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_addr_master::' +pVersion + '::bill_tin'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::claims_addr_master::' +pVersion + '::bill_tin'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_addr_master::' +pVersion + '::rendering_npi'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::claims_addr_master::' +pVersion + '::rendering_npi'));             
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_by_month::' +pVersion + '::bill_tin'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::claims_by_month::' +pVersion + '::bill_tin'));                     
        if (FileServices.FileExists('~thor_data400::key::mprd::client_data::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::client_data::' +pVersion + '::surrogate_key'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::dea_xref::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::dea_xref::' +pVersion + '::group_key'));                           
        if (FileServices.FileExists('~thor_data400::key::mprd::facility::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::facility::' +pVersion + '::group_key'));                           
        if (FileServices.FileExists('~thor_data400::key::mprd::facility::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::facility::' +pVersion + '::surrogate_key'));                       
        if (FileServices.FileExists('~thor_data400::key::mprd::facility_join::' +pVersion + '::filecode_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::facility_join::' +pVersion + '::filecode_key'));                   
        if (FileServices.FileExists('~thor_data400::key::mprd::facility_join::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::facility_join::' +pVersion + '::group_key'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::facility_name_xref::' +pVersion + '::taxonomy'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::facility_name_xref::' +pVersion + '::taxonomy'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::group_lu::' +pVersion + '::code'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::group_lu::' +pVersion + '::code'));                                
        if (FileServices.FileExists('~thor_data400::key::mprd::hospital_lu::' +pVersion + '::code'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::hospital_lu::' +pVersion + '::code'));                             
        if (FileServices.FileExists('~thor_data400::key::mprd::ignore_term_lu::' +pVersion + '::code'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::ignore_term_lu::' +pVersion + '::code'));                          
        if (FileServices.FileExists('~thor_data400::key::mprd::individual::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::individual::' +pVersion + '::group_key'));                         
        if (FileServices.FileExists('~thor_data400::key::mprd::individual::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::individual::' +pVersion + '::surrogate_key'));                     
        if (FileServices.FileExists('~thor_data400::key::mprd::individual_join::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::individual_join::' +pVersion + '::group_key'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::last_name_stats::' +pVersion + '::last_name'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::last_name_stats::' +pVersion + '::last_name'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::lic_xref::' +pVersion + '::group_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::lic_xref::' +pVersion + '::group_key'));                           
        if (FileServices.FileExists('~thor_data400::key::mprd::nanpa::' +pVersion + '::npa_num'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::nanpa::' +pVersion + '::npa_num'));                                
        if (FileServices.FileExists('~thor_data400::key::mprd::npi_extension::' +pVersion + '::npi_num'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::npi_extension::' +pVersion + '::npi_num'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::npi_extension_facility::' +pVersion + '::npi_num'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::npi_extension_facility::' +pVersion + '::npi_num'));               
        if (FileServices.FileExists('~thor_data400::key::mprd::npi_tin_xref::' +pVersion + '::bill_npi'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::npi_tin_xref::' +pVersion + '::bill_npi'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::office_attributes::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::office_attributes::' +pVersion + '::surrogate_key'));              
        if (FileServices.FileExists('~thor_data400::key::mprd::office_attributes_facility::' +pVersion + '::surrogate_key'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::office_attributes_facility::' +pVersion + '::surrogate_key'));     
        if (FileServices.FileExists('~thor_data400::key::mprd::source_confidence_lu::' +pVersion + '::filecode'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::source_confidence_lu::' +pVersion + '::filecode'));                
        if (FileServices.FileExists('~thor_data400::key::mprd::specialty_lu::' +pVersion + '::specialty'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::specialty_lu::' +pVersion + '::specialty'));                       
        if (FileServices.FileExists('~thor_data400::key::mprd::std_terms_lu::' +pVersion + '::code'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::std_terms_lu::' +pVersion + '::code'));                            
        if (FileServices.FileExists('~thor_data400::key::mprd::taxon_lu::' +pVersion + '::code'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::taxon_lu::' +pVersion + '::code'));                                
        if (FileServices.FileExists('~thor_data400::key::mprd::taxonomy_equiv::' +pVersion + '::taxonomy'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::taxonomy_equiv::' +pVersion + '::taxonomy'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::taxonomy_full_lu::' +pVersion + '::taxonomy'), FileServices.DeleteLogicalFile('~thor_data400::key::mprd::taxonomy_full_lu::' +pVersion + '::taxonomy'));                    
        ));
        
  export RenameKeyFilesVersion(string pFromVersion, string pToVersion) := nothor(sequential(
        if (FileServices.FileExists('~thor_data400::key::mprd::abbr_lu::' + pFromVersion + '::code'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::abbr_lu::' + pFromVersion + '::code', '~thor_data400::key::mprd::abbr_lu::' + pToVersion + '::code'));                                 
        if (FileServices.FileExists('~thor_data400::key::mprd::addr_name_xref::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::addr_name_xref::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::addr_name_xref::' + pToVersion + '::group_key'));                     
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_addr::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_addr::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::basc_addr::' + pToVersion + '::surrogate_key'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_claims::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_claims::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::basc_claims::' + pToVersion + '::group_key'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_claims::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_claims::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::basc_claims::' + pToVersion + '::surrogate_key'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_cp::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_cp::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::basc_cp::' + pToVersion + '::group_key'));                            
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_cp::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_cp::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::basc_cp::' + pToVersion + '::surrogate_key'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_deceased::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_deceased::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::basc_deceased::' + pToVersion + '::group_key'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::basc_facility_mme::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::basc_facility_mme::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::basc_facility_mme::' + pToVersion + '::group_key'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::best_hospital::' + pFromVersion + '::addr_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::best_hospital::' + pFromVersion + '::addr_key', '~thor_data400::key::mprd::best_hospital::' + pToVersion + '::addr_key'));                       
        if (FileServices.FileExists('~thor_data400::key::mprd::call_queue_bad::' + pFromVersion + '::prac_phone1'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::call_queue_bad::' + pFromVersion + '::prac_phone1', '~thor_data400::key::mprd::call_queue_bad::' + pToVersion + '::prac_phone1'));                   
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_addr_master::' + pFromVersion + '::bill_npi'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::claims_addr_master::' + pFromVersion + '::bill_npi', '~thor_data400::key::mprd::claims_addr_master::' + pToVersion + '::bill_npi'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_addr_master::' + pFromVersion + '::bill_tin'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::claims_addr_master::' + pFromVersion + '::bill_tin', '~thor_data400::key::mprd::claims_addr_master::' + pToVersion + '::bill_tin'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_addr_master::' + pFromVersion + '::rendering_npi'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::claims_addr_master::' + pFromVersion + '::rendering_npi', '~thor_data400::key::mprd::claims_addr_master::' + pToVersion + '::rendering_npi'));             
        if (FileServices.FileExists('~thor_data400::key::mprd::claims_by_month::' + pFromVersion + '::bill_tin'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::claims_by_month::' + pFromVersion + '::bill_tin', '~thor_data400::key::mprd::claims_by_month::' + pToVersion + '::bill_tin'));                     
        if (FileServices.FileExists('~thor_data400::key::mprd::client_data::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::client_data::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::client_data::' + pToVersion + '::surrogate_key'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::dea_xref::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::dea_xref::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::dea_xref::' + pToVersion + '::group_key'));                           
        if (FileServices.FileExists('~thor_data400::key::mprd::facility::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::facility::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::facility::' + pToVersion + '::group_key'));                           
        if (FileServices.FileExists('~thor_data400::key::mprd::facility::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::facility::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::facility::' + pToVersion + '::surrogate_key'));                       
        if (FileServices.FileExists('~thor_data400::key::mprd::facility_join::' + pFromVersion + '::filecode_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::facility_join::' + pFromVersion + '::filecode_key', '~thor_data400::key::mprd::facility_join::' + pToVersion + '::filecode_key'));                   
        if (FileServices.FileExists('~thor_data400::key::mprd::facility_join::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::facility_join::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::facility_join::' + pToVersion + '::group_key'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::facility_name_xref::' + pFromVersion + '::taxonomy'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::facility_name_xref::' + pFromVersion + '::taxonomy', '~thor_data400::key::mprd::facility_name_xref::' + pToVersion + '::taxonomy'));                  
        if (FileServices.FileExists('~thor_data400::key::mprd::group_lu::' + pFromVersion + '::code'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::group_lu::' + pFromVersion + '::code', '~thor_data400::key::mprd::group_lu::' + pToVersion + '::code'));                                
        if (FileServices.FileExists('~thor_data400::key::mprd::hospital_lu::' + pFromVersion + '::code'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::hospital_lu::' + pFromVersion + '::code', '~thor_data400::key::mprd::hospital_lu::' + pToVersion + '::code'));                             
        if (FileServices.FileExists('~thor_data400::key::mprd::ignore_term_lu::' + pFromVersion + '::code'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::ignore_term_lu::' + pFromVersion + '::code', '~thor_data400::key::mprd::ignore_term_lu::' + pToVersion + '::code'));                          
        if (FileServices.FileExists('~thor_data400::key::mprd::individual::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::individual::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::individual::' + pToVersion + '::group_key'));                         
        if (FileServices.FileExists('~thor_data400::key::mprd::individual::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::individual::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::individual::' + pToVersion + '::surrogate_key'));                     
        if (FileServices.FileExists('~thor_data400::key::mprd::individual_join::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::individual_join::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::individual_join::' + pToVersion + '::group_key'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::last_name_stats::' + pFromVersion + '::last_name'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::last_name_stats::' + pFromVersion + '::last_name', '~thor_data400::key::mprd::last_name_stats::' + pToVersion + '::last_name'));                    
        if (FileServices.FileExists('~thor_data400::key::mprd::lic_xref::' + pFromVersion + '::group_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::lic_xref::' + pFromVersion + '::group_key', '~thor_data400::key::mprd::lic_xref::' + pToVersion + '::group_key'));                           
        if (FileServices.FileExists('~thor_data400::key::mprd::nanpa::' + pFromVersion + '::npa_num'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::nanpa::' + pFromVersion + '::npa_num', '~thor_data400::key::mprd::nanpa::' + pToVersion + '::npa_num'));                                
        if (FileServices.FileExists('~thor_data400::key::mprd::npi_extension::' + pFromVersion + '::npi_num'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::npi_extension::' + pFromVersion + '::npi_num', '~thor_data400::key::mprd::npi_extension::' + pToVersion + '::npi_num'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::npi_extension_facility::' + pFromVersion + '::npi_num'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::npi_extension_facility::' + pFromVersion + '::npi_num', '~thor_data400::key::mprd::npi_extension_facility::' + pToVersion + '::npi_num'));               
        if (FileServices.FileExists('~thor_data400::key::mprd::npi_tin_xref::' + pFromVersion + '::bill_npi'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::npi_tin_xref::' + pFromVersion + '::bill_npi', '~thor_data400::key::mprd::npi_tin_xref::' + pToVersion + '::bill_npi'));                        
        if (FileServices.FileExists('~thor_data400::key::mprd::office_attributes::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::office_attributes::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::office_attributes::' + pToVersion + '::surrogate_key'));              
        if (FileServices.FileExists('~thor_data400::key::mprd::office_attributes_facility::' + pFromVersion + '::surrogate_key'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::office_attributes_facility::' + pFromVersion + '::surrogate_key', '~thor_data400::key::mprd::office_attributes_facility::' + pToVersion + '::surrogate_key'));     
        if (FileServices.FileExists('~thor_data400::key::mprd::source_confidence_lu::' + pFromVersion + '::filecode'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::source_confidence_lu::' + pFromVersion + '::filecode', '~thor_data400::key::mprd::source_confidence_lu::' + pToVersion + '::filecode'));                
        if (FileServices.FileExists('~thor_data400::key::mprd::specialty_lu::' + pFromVersion + '::specialty'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::specialty_lu::' + pFromVersion + '::specialty', '~thor_data400::key::mprd::specialty_lu::' + pToVersion + '::specialty'));                       
        if (FileServices.FileExists('~thor_data400::key::mprd::std_terms_lu::' + pFromVersion + '::code'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::std_terms_lu::' + pFromVersion + '::code', '~thor_data400::key::mprd::std_terms_lu::' + pToVersion + '::code'));                            
        if (FileServices.FileExists('~thor_data400::key::mprd::taxon_lu::' + pFromVersion + '::code'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::taxon_lu::' + pFromVersion + '::code', '~thor_data400::key::mprd::taxon_lu::' + pToVersion + '::code'));                                
        if (FileServices.FileExists('~thor_data400::key::mprd::taxonomy_equiv::' + pFromVersion + '::taxonomy'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::taxonomy_equiv::' + pFromVersion + '::taxonomy', '~thor_data400::key::mprd::taxonomy_equiv::' + pToVersion + '::taxonomy'));                      
        if (FileServices.FileExists('~thor_data400::key::mprd::taxonomy_full_lu::' + pFromVersion + '::taxonomy'), 
            FileServices.RenameLogicalFile('~thor_data400::key::mprd::taxonomy_full_lu::' + pFromVersion + '::taxonomy', '~thor_data400::key::mprd::taxonomy_full_lu::' + pToVersion + '::taxonomy'));                    
        ));

    
end;

