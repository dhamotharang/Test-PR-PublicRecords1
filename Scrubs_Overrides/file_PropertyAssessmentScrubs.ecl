import Scrubs_LN_PropertyV2_Assessor,ln_propertyv2;

assessment_override_layout := record
		string20 flag_file_id;
		ln_propertyv2.layout_property_common_model_base;
	end;

dailyds_assessment := dataset ('~thor_data400::base::override::fcra::daily::qa::' + 'assessment', assessment_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

ScrubsSetup:=project(dailyds_assessment,transform(Scrubs_LN_PropertyV2_Assessor.layout_Property_Assessor,self:=Left;self:=[]));


EXPORT file_PropertyAssessmentScrubs := ScrubsSetup;