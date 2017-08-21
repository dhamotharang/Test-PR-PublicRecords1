export Mac_Email_Local(string filedate) := function

/* **ROXIE KEY NOTIFICATION EMAIL********************************************************************************************************** */	

email_success := fileservices.sendemail('RoxieBuilds@seisint.com;krishna.gummadi@lexisnexis.com',
										'LN propertyv2 Build Succeeded - ' + filedate,
										'keys:1)thor_data400::Key::ln_propertyv2::qa::addlfaresdeed.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::addlfaresdeed.fid), \n' +                
  '2)thor_data400::Key::ln_propertyv2::qa::addlfarestax.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::addlfarestax.fid) , \n' +                       
  '3)thor_data400::Key::ln_propertyv2::qa::addllegal.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::addllegal.fid), \n' +                         
  '4)thor_data400::Key::ln_propertyv2::qa::addlnames.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::addlnames.fid) , \n' +                 
  '5)thor_data400::Key::ln_propertyv2::qa::assessor.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::assessor.fid) , \n' +                
  '6)thor_data400::Key::ln_propertyv2::qa::assessor.parcelNum(thor_data400::Key::ln_propertyv2::'+filedate+'::assessor.parcelNum) , \n' +                     
  '7)thor_data400::Key::ln_propertyv2::qa::search.fid_county(thor_data400::Key::ln_propertyv2::'+filedate+'::search.fid_county) , \n' +          
  '8)thor_data400::Key::ln_propertyv2::qa::deed.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::deed.fid) , \n' + 
  '9)thor_data400::Key::ln_propertyv2::qa::deed.parcelNum(thor_data400::Key::ln_propertyv2::'+filedate+'::deed.parcelNum) , \n' +
  '10)thor_data400::Key::ln_propertyv2::qa::did.ownership(thor_data400::Key::ln_propertyv2::'+filedate+'::did.ownership) , \n' +
  '11)thor_data400::Key::ln_propertyv2::qa::search.did(thor_data400::Key::ln_propertyv2::'+filedate+'::search.did) , \n' +
  '12)thor_data400::Key::ln_propertyv2::qa::search.bdid(thor_data400::Key::ln_propertyv2::'+filedate+'::search.bdid) , \n' +
  '13)thor_data400::Key::ln_propertyv2::qa::search.fid(thor_data400::Key::ln_propertyv2::'+filedate+'::search.fid) , \n' +
  'have been built and ready to be deployed to QA.');
   
   return email_success;
   
   end;

												
