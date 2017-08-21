#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, Business_Header, acf,Business_HeaderV2;

dInput :=Business_HeaderV2.Source_Files.acf.BusinessHeader((INTEGER)name_score<3 and company_title<>'');
business_header.Layout_Business_Contact_FULL_New Tran_contact(dinput pInput)
          := Transform
		  self :=pInput;
		  end;
		  
EXPORT ACF_As_Business_contact:= dedup(project(dInput,tran_contact(left)),all
                                   ,except dt_last_seen,
									dt_first_seen)
	                               : persist(business_header._dataset().thor_cluster_Persists + 'persist::ACF_As_Business_Contact');
	