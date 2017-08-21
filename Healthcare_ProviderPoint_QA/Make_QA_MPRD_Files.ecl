IMPORT Healthcare_ProviderPoint_QA as QR;
IMPORT STD;

#WORKUNIT('name', 'Re-build QA MPRD');

//	string8 source_date := '20160217';

EXPORT Make_QA_MPRD_Files(string source_date) := FUNCTION
	// Remove subfiles from superfiles
	sequential(
		STD.File.StartSuperfileTransaction(),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::best_hospital::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::source_confidence_lu::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::npi_extension::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::claims_by_month::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::individual::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::group_lu::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::basc_cp::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::lic_filedate::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::basc_facility_mme::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::office_attributes_facility::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::npi_tin_xref::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::claims_addr_master::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::opi_facility::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::npi_extension_facility::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::facility::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::nanpa::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::hospital_lu::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::cms_ecp::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::basc_deceased::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::opi::qa_test'),
		STD.File.ClearSuperFile('~thor_data400::in::mprd::office_attributes::qa_test'),
	 STD.File.FinishSuperFileTransaction()
	);

	// Create the QA modified records for MPRD
	QR.MPRD_QA_Records(source_date).t_individual.write;
	QR.MPRD_QA_Records(source_date).t_facility.write;
	QR.MPRD_QA_Records(source_date).t_basc_cp.write;
	QR.MPRD_QA_Records(source_date).t_basc_deceased.write;
	QR.MPRD_QA_Records(source_date).t_basc_facility_mme.write;
	QR.MPRD_QA_Records(source_date).t_best_hospital.write;
	QR.MPRD_QA_Records(source_date).t_claims_addr_master.write;
	QR.MPRD_QA_Records(source_date).t_claims_by_month.write;
	QR.MPRD_QA_Records(source_date).t_cms_ecp.write;
	QR.MPRD_QA_Records(source_date).t_group_lu.write;
	QR.MPRD_QA_Records(source_date).t_hospital_lu.write;
	QR.MPRD_QA_Records(source_date).t_lic_filedate.write;
	QR.MPRD_QA_Records(source_date).t_nanpa.write;
	QR.MPRD_QA_Records(source_date).t_npi_extension.write;
	QR.MPRD_QA_Records(source_date).t_npi_extension_facility.write;
	QR.MPRD_QA_Records(source_date).t_npi_tin_xref.write;
	QR.MPRD_QA_Records(source_date).t_office_attributes.write;
	QR.MPRD_QA_Records(source_date).t_office_attributes_facility.write;
	QR.MPRD_QA_Records(source_date).t_opi.write;
	QR.MPRD_QA_Records(source_date).t_opi_facility.write;
	QR.MPRD_QA_Records(source_date).t_source_confidence_lu.write;

	// Re-add new files to superfiles
	sequential(
		STD.File.StartSuperfileTransaction(),
		STD.File.AddSuperFile('~thor_data400::in::mprd::best_hospital::qa_test', '~thor_data400::in::mprd::qa::best_hospital'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::source_confidence_lu::qa_test', '~thor_data400::in::mprd::qa::source_confidence_lu'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::npi_extension::qa_test', '~thor_data400::in::mprd::qa::npi_extension'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::claims_by_month::qa_test', '~thor_data400::in::mprd::qa::claims_by_month'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::individual::qa_test', '~thor_data400::in::mprd::qa::individual'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::group_lu::qa_test', '~thor_data400::in::mprd::qa::group_lu'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::basc_cp::qa_test', '~thor_data400::in::mprd::qa::basc_cp'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::lic_filedate::qa_test', '~thor_data400::in::mprd::qa::lic_filedate'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::basc_facility_mme::qa_test', '~thor_data400::in::mprd::qa::basc_facility_mme'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::office_attributes_facility::qa_test', '~thor_data400::in::mprd::qa::office_attributes_facility'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::npi_tin_xref::qa_test', '~thor_data400::in::mprd::qa::npi_tin_xref'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::claims_addr_master::qa_test', '~thor_data400::in::mprd::qa::claims_addr_master'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::opi_facility::qa_test', '~thor_data400::in::mprd::qa::opi_facility'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::npi_extension_facility::qa_test', '~thor_data400::in::mprd::qa::npi_extension_facility'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::facility::qa_test', '~thor_data400::in::mprd::qa::facility'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::nanpa::qa_test', '~thor_data400::in::mprd::qa::nanpa'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::hospital_lu::qa_test', '~thor_data400::in::mprd::qa::hospital_lu'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::cms_ecp::qa_test', '~thor_data400::in::mprd::qa::cms_ecp'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::basc_deceased::qa_test', '~thor_data400::in::mprd::qa::basc_deceased'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::opi::qa_test', '~thor_data400::in::mprd::qa::opi'),
		STD.File.AddSuperFile('~thor_data400::in::mprd::office_attributes::qa_test', '~thor_data400::in::mprd::qa::office_attributes'),
	 STD.File.FinishSuperFileTransaction()
	);


	// View only 
	/*
	output(choosen(QR.MPRD_QA_Records(source_date).t_individual.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_facility.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_basc_cp.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_basc_deceased.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_basc_facility_mme.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_best_hospital.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_claims_addr_master.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_claims_by_month.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_cms_ecp.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_group_lu.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_hospital_lu.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_lic_filedate.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_nanpa.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_npi_extension.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_npi_extension_facility.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_npi_tin_xref.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_office_attributes.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_office_attributes_facility.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_opi.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_opi_facility.view,100));
	output(choosen(QR.MPRD_QA_Records(source_date).t_source_confidence_lu.view,100));
	*/
		
		return true;
	
end;