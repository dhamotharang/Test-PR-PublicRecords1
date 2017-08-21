

string lLogicalMask :='*::in::2009*::booking::*';
string lSuperFile   :='~thor_data50::in::appriss_booking_charges_raw_xml_w20090708andprior';

dLogicalFiles                             
	:=lib_fileservices.FileServices.LogicalFileList(lLogicalMask);
fAddToSuper(string pLogicalFileName)      
	:= lib_fileservices.FileServices.AddSuperFile(lSuperFile,'~' + pLogicalFileName);
 
// count(dLogicalFiles);
// output(choosen(dLogicalFiles,5000));

nothor(apply(dLogicalFiles,fAddToSuper(name)));      // Â“nameÂ” is the field in the dataset returned by LogicalFileList

 
// then copy using eclwatch, from ~thor::temp_rvh to 'thor_data50::in::appriss_booking_charges_raw_xml_w20090708andprior'

