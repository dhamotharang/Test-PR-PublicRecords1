Corp2_Raw_MO.Layouts.NamesLayoutIn NamesTransform(Corp2_Raw_MO.Layouts.NamesLayoutIn l):= transform
  
	/*Per CI: possible name types '0','2','5' & '9' in MO corps!
		name type field added for Scrub rules in the mapping attribute to capture new types from vendor!
    we have shifted data in the vendor names file due to inconsistency usage of commas in name field for a comma delimiter file!
    this transform only treats the records those name types are not from given valid list '0','2','5' & '9' 
    ex:shifted data samples # W20170301-112323 !! very low percentage of records have shifted data issue
    only 689 records out of 2,313,179 have shifted data issue!
	*/
	name_type_list	:=['0','2','5','9'];
	self.name       := map(trim(l.name_type) not in name_type_list		=>trim(l.name)+', '+trim(l.name_type)+ if(trim(l.name_salutation)<>'' ,', '+trim(l.name_salutation),'') + if(trim(l.name_prefix)<>'',', '+trim(l.name_prefix),''),
	                       l.name);             
	self.name_type  := map(trim(l.name_title) 		 in name_type_list	=> l.name_title,
												 trim(l.name_salutation) in name_type_list	=> l.name_salutation,
												 trim(l.name_prefix) 		 in name_type_list	=> l.name_prefix,
												 trim(l.name_last_name)  in name_type_list	=> l.name_last_name,
												 trim(l.name_title)			 in name_type_list	=> l.name_title,
												 l.name_type);                
	self						:= l;
	
end;
 
export File_names_in(dataset(Corp2_Raw_MO.Layouts.NamesLayoutIn) pInNames) := project(pInNames ,NamesTransform(LEFT));