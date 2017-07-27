import tools;
export KeyPrep_Property_Assessment(
	dataset(Layout_Property.assessment.Linked) base,
	string version,
	boolean pUseOtherEnvironment = false) := function

	modified := project(base,
		transform(KeyLayouts.Property.assessment,									 
			self.date_9999 := 99999999 - (unsigned)left.assessment_date,
			self := left));
	
	tools.mac_FilesIndex('modified,{vendor, property_id, date_9999},{modified}',keynames(version,pUseOtherEnvironment).Property.Assessment,idx);
	
	return idx;

end;