export Mac_Email_Local(string filedate) := module

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	


export email_success := fileservices.sendemail('RoxieBuilds@seisint.com;Julie.Ellison@lexisnexis.com;GIRI.RAJULAPALLI@lexisnexis.com;julianne.franzer@lexisnexis.com;kevin.reeder@lexisnexis.com',
										'Ingenix Build Succeeded - ' + filedate,
  'keys:   1)thor_data400::key::ing_provider_did_qa(thor_data400::key::ing_provider::' + filedate + '::did), \n' +                
  '2)thor_data400::key::ing_provider_id_qa(thor_data400::key::ing_provider::'+filedate + '::id) , \n' +                       
  '3)thor_data400::key::ing_provider_license_qa(thor_data400::key::ing_provider::' +filedate+ '::license), \n' +                         
  '4)thor_data400::key::ing_provider_search_id_qa(thor_data400::key::ing_provider::' + filedate + '::search_id) , \n' +                 
  '5)thor_data400::key::ingenix_dea_providerid_qa(thor_data400::key::ingenix_DEA::' +filedate + '::providerid) , \n' +                
  '6)thor_data400::key::ingenix_degree_providerid_qa(thor_data400::key::ingenix_degree::'+ filedate + '::providerid) , \n' +             
  '7)thor_data400::key::ingenix_group_linkids_qa(thor_data400::key::ingenix_group::'+ filedate + '::linkids) , \n' +              
  '8)thor_data400::key::ingenix_group_providerid_qa(thor_data400::key::ingenix_group::'+ filedate + '::providerid) , \n' +              
  '9)thor_data400::key::ingenix_hospital_linkids_qa(thor_data400::key::ingenix_hospital::'+ filedate + '::linkids) , \n' +
  '10)thor_data400::key::ingenix_hospital_providerid_qa(thor_data400::key::ingenix_hospital::'+ filedate + '::providerid) , \n' +           
  '11)thor_data400::key::ingenix_language_providerid_qa(thor_data400::key::ingenix_language::' + filedate + '::providerid) , \n' +          
  '12)thor_data400::key::ingenix_license_providerid_qa(thor_data400::key::ingenix_license::' + filedate +  '::providerid) , \n' +          
  '13)thor_data400::key::ingenix_medschool_linkids_qa(thor_data400::key::ingenix_medschool::'+ filedate + '::linkids) , \n' +          
  '14)thor_data400::key::ingenix_medschool_providerid_qa(thor_data400::key::ingenix_medschool::'+ filedate + '::providerid) , \n' +          
  '15)thor_data400::key::ingenix_residency_linkids_qa(thor_data400::key::ingenix_residency::'+ filedate + '::linkids) , \n' +          
  '16)thor_data400::key::ingenix_residency_providerid_qa(thor_data400::key::ingenix_residency::'+ filedate + '::providerid) , \n' +          
  '17)thor_data400::key::ingenix_speciality_providerid_qa(thor_data400::key::ingenix_speciality::'+ filedate +'::providerid) , \n' +          
  '18)thor_data400::key::ingenix_upin_providerid_qa(thor_data400::key::ingenix_UPIN::' + filedate + '::providerid) , \n' +              
  '19)thor_data400::key::ingenix_provider_taxid_qa(thor_data400::key::ingenix_provider::' + filedate + '::taxid) , \n' +                                                          
  '20)thor_data400::key::ingenix_providers_address_qa(thor_data400::key::ingenix_providers::' + filedate + '::address_auto) , \n' +                                                           
  '21)thor_data400::key::ingenix_providers_citystname_qa(thor_data400::key::ingenix_providers::' + filedate + '::citystname_auto) , \n' +                                                        
  '22)thor_data400::key::ingenix_providers_fdids_qa(thor_data400::key::ingenix_providers::' + filedate + '::fdids) , \n' +              
  '23)thor_data400::key::ingenix_providers_name_qa(thor_data400::key::ingenix_providers::' + filedate + '::name_auto) , \n' +                                                              
  '24)thor_data400::key::ingenix_providers_phone_qa(thor_data400::key::ingenix_providers::' + filedate + '::phone_auto) , \n' +                                                             
  '25)thor_data400::key::ingenix_providers_stname_qa(thor_data400::key::ingenix_providers::' + filedate + '::stname_auto) , \n' +                                                            
  '26)thor_data400::key::ingenix_providers_zip_qa(thor_data400::key::ingenix_providers::' + filedate + '::zip_auto) , \n' +                                                               
  '27)thor_data400::key::ingenix_sanctions_address_qa(thor_data400::key::ingenix_sanctions::' + filedate + '::address_auto) , \n' +                                                           
  '28)thor_data400::key::ingenix_sanctions_citystname_qa(thor_data400::key::ingenix_sanctions::' + filedate + '::citystname_auto) , \n' +                                                        
  '29)thor_data400::key::ingenix_sanctions_did_qa(thor_data400::key::ingenix_sanctions::'+ filedate + '::did) , \n' +                 
  '30)thor_data400::key::ingenix_sanctions_fdids_qa(thor_data400::key::ingenix_sanctions::' + filedate + '::fdids) , \n' +              
  '31)thor_data400::key::ingenix_sanctions_license_qa(thor_data400::key::ingenix_sanctions::'+ filedate +'::license) , \n' +              
  '32)thor_data400::key::ingenix_sanctions_linkids_qa(thor_data400::key::ingenix_sanctions::'+ filedate +'::linkids) , \n' +
  '33)thor_data400::key::ingenix_sanctions_name_qa(thor_data400::key::ingenix_sanctions::' + filedate + '::name_auto) , \n' +                                                              
  '34)thor_data400::key::ingenix_sanctions_sancid_qa(thor_data400::key::ingenix_sanctions::'+ filedate + '::sancid) , \n' +              
  '35)thor_data400::key::ingenix_sanctions_stname_qa(thor_data400::key::ingenix_sanctions::' + filedate + '::stname_auto) , \n' +                                                            
  '36)thor_data400::key::ingenix_sanctions_taxid_name_qa(thor_data400::key::ingenix_sanctions::'+ filedate +'::taxid_name) , \n' +           
  '37)thor_data400::key::ingenix_sanctions_taxid_qa(thor_data400::key::ingenix_sanctions::'+ filedate + '::taxid) , \n' +               
  '38)thor_data400::key::ingenix_sanctions_upin_qa(thor_data400::key::ingenix_sanctions::'+ filedate +'::upin) , \n' +                 
  '39)thor_data400::key::ingenix_sanctions_zip_qa(thor_data400::key::ingenix_sanctions::' + filedate + '::zip_auto) , \n' +   
  '40)thor_data400::key::ingenix_providers::autokey::qa::Payload(thor_data400::key::ingenix_providers::' + filedate + '::autokey::Payload) , \n' + 
  '41)thor_data400::key::ingenix_providers::autokey::qa::Address(thor_data400::key::ingenix_providers::' + filedate + '::autokey::Address) , \n' + 
  '42)thor_data400::key::ingenix_providers::autokey::qa::Name(thor_data400::key::ingenix_providers::' + filedate + '::autokey::Name) , \n' + 
  '43)thor_data400::key::ingenix_providers::autokey::qa::StName(thor_data400::key::ingenix_providers::' + filedate + '::autokey::StName) , \n' + 
  '44)thor_data400::key::ingenix_providers::autokey::qa::CityStName(thor_data400::key::ingenix_providers::' + filedate + '::autokey::CityStName) , \n' + 
  '45)thor_data400::key::ingenix_providers::autokey::qa::Zip(thor_data400::key::ingenix_providers::' + filedate + '::autokey::Zip) , \n' + 
  '46)thor_data400::key::ingenix_providers::autokey::qa::Phone2(thor_data400::key::ingenix_providers::' + filedate + '::autokey::Phone2) , \n' +   
  '47)thor_data400::key::ingenix_Sanctions::autokey::qa::Payload(thor_data400::key::ingenix_sanctions::' + filedate + '::autokey::Payload) , \n' + 
  '48)thor_data400::key::ingenix_Sanctions::autokey::qa::Address(thor_data400::key::ingenix_sanctions::' + filedate + '::autokey::Address) , \n' + 
  '49)thor_data400::key::ingenix_Sanctions::autokey::qa::Name(thor_data400::key::ingenix_sanctions::' + filedate + '::autokey::Name) , \n' + 
  '50)thor_data400::key::ingenix_Sanctions::autokey::qa::StName(thor_data400::key::ingenix_sanctions::' + filedate + '::autokey::StName) , \n' + 
  '51)thor_data400::key::ingenix_Sanctions::autokey::qa::CityStName(thor_data400::key::ingenix_sanctions::' + filedate + '::autokey::CityStName) , \n' + 
  '52)thor_data400::key::ingenix_Sanctions::autokey::qa::Zip(thor_data400::key::ingenix_sanctions::' + filedate + '::autokey::Zip) , \n' + 
  '53)thor_data400::key::ingenix::provider::qa::xseglist(thor_data400::key::ingenix::provider::' + filedate + '::xseglist) , \n' + 
  '54)thor_data400::key::ingenix::provider::qa::dictindx(thor_data400::key::ingenix::provider::' + filedate + '::dictindx) , \n' + 
  '55)thor_data400::key::ingenix::provider::qa::nidx(thor_data400::key::ingenix::provider::' + filedate + '::nidx) , \n' + 
  '56)thor_data400::key::ingenix::sanctions::qa::xseglist(thor_data400::key::ingenix::sanctions::' + filedate + '::xseglist) , \n' + 
  '57)thor_data400::key::ingenix::sanctions::qa::dictindx(thor_data400::key::ingenix::sanctions::' + filedate + '::dictindx) , \n' + 
  '58)thor_data400::key::ingenix::sanctions::qa::nidx(thor_data400::key::ingenix::sanctions::' + filedate + '::nidx) , \n' + 
  '59)thor_data400::key::ingenix_NPI_providerid_qa(thor_data400::key::ingenix_NPI::' + filedate + '::providerid) , \n' +
  '60)thor_data400::key::ingenix_UPIN_NPI_providerid_qa(thor_data400::key::ingenix_UPIN_NPI::' + filedate + '::providerid) , \n' +
  '61)thor_data400::key::ingenix_dea_deanumber_qa(thor_data400::key::ingenix_dea::' + filedate + '::deanumber) , \n' +    
  '62)thor_data400::key::ing_providersanctions_id_qa( thor_data400::key::ing_providersanctions::' + filedate + '::id ) , \n' +    
  'have been built and ready to be deployed to QA.');
	
	export email_failure := FileServices.sendemail('RoxieBuilds@seisint.com;Julie.Ellison@lexisnexis.com;GIRI.RAJULAPALLI@lexisnexis.com;julianne.franzer@lexisnexis.com;kevin.reeder@lexisnexis.com', 'Ingenix Build Failure -- '+ filedate, failmessage);
   
   
   end;
	 