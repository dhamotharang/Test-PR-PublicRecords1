Import doxie;

EXPORT Medlic_layout := MODULE

    EXPORT layout_w_penalt := record
			Doxie.layout_inBatchMaster.acctno;
			UNSIGNED1 penalt := 0;
			doxie.ingenix_provider_module.batch_Medlic_layout;
	  END;
		

    EXPORT layout_w_penalt_plus := 
      RECORD
			  layout_w_penalt;
        doxie.layout_inBatchMaster - [acctno, did];
        DATASET(doxie.ingenix_provider_module.ingenix_addr_rpt_rec) business_address_rec;
        DATASET(doxie.ingenix_provider_module.ingenix_group_rec) group_address_rec;
        DATASET(doxie.ingenix_provider_module.ingenix_hospital_rec) hospital_address_rec;
        DATASET(doxie.ingenix_Provider_module.ingenix_taxid_Rec) taxid_rec;
			  DATASET(doxie.ingenix_provider_module.ingenix_license_rpt_rec) license_rec;
        STRING20 in_license_number := '';
			  STRING10 in_TaxID := '';
	  END;
end;