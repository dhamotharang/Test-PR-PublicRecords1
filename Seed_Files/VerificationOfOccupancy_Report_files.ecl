EXPORT VerificationOfOccupancy_Report_files := MODULE

export get_filenameVOO(string section) := FUNCTION

fn := case(section,
	'Summary'																=> '~thor_data400::in::VOOreport::Summary', 
	'TargetSummary'										=> '~thor_data400::in::VOOreport::TargetSummary', 
	'Sources'																=> '~thor_data400::in::VOOreport::Sources', 
	'OwnedProperties'        => '~thor_data400::in::VOOreport::OwnedProperties', 
	'OwnedPropertiesAsOf'  		=> '~thor_data400::in::VOOreport::OwnedPropertiesAsOf', 
	'PhoneAndUtility'       	=> '~thor_data400::in::VOOreport::PhoneAndUtility', 
	'AssociatedIdentities'			=> '~thor_data400::in::VOOreport::AssociatedIdentities', 
		'' );
if( fn='', FAIL('Unknown Section') );
return fn;

end;


 export Summary				 := dataset(get_filenameVOO('Summary'), Seed_Files.VerificationOfOccupancy_report_layouts.Summary, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));																										 
	export TargetSummary		:= dataset(get_filenameVOO('TargetSummary'), Seed_Files.VerificationOfOccupancy_report_layouts.TargetSummary, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));																								 
	export Sources := 	dataset(get_filenameVOO('Sources'), Seed_Files.VerificationOfOccupancy_report_layouts.Sources, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000))); 																							 
	export OwnedProperties  := 	dataset(get_filenameVOO('OwnedProperties'), Seed_Files.VerificationOfOccupancy_report_layouts.OwnedProperties, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));          
	export OwnedPropertiesAsOf  := 	dataset(get_filenameVOO('OwnedPropertiesAsOf'), Seed_Files.VerificationOfOccupancy_report_layouts.OwnedPropertiesAsOf, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));  
	export PhoneAndUtility     := 	dataset(get_filenameVOO('PhoneAndUtility'), Seed_Files.VerificationOfOccupancy_report_layouts.PhoneAndUtility, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));                   
	export AssociatedIdentities := 	dataset(get_filenameVOO('AssociatedIdentities'), Seed_Files.VerificationOfOccupancy_report_layouts.AssociatedIdentities, CSV (heading(1), separator(','), QUOTE('"'), maxlength (1000)));
	
	END;
	
	