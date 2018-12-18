import FCRA,Scrubs_Headers_Monthly,Scrubs_LN_PropertyV2_Assessor,ln_propertyv2;
EXPORT OutsideFiles := module
		shared daily_prefix_Property := '~thor_data400::base::override::fcra::daily::qa::';
		
		shared kf := FCRA.File_Header_Correct ((unsigned)head.did<>0);

		HeaderScrubs:=project(kf,transform(Scrubs_Headers_Monthly.layout_File,self:=Left.head;self:=[]));
		
		EXPORT file_HeaderScrubsInput2 := HeaderScrubs;
	
		shared assessment_override_layout := record
				string20 flag_file_id;
				ln_propertyv2.layout_property_common_model_base;
			end;

		shared dailyds_assessment := dataset (daily_prefix_Property + 'assessment', assessment_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

		PropertyAssessmentScrubs:=project(dailyds_assessment,transform(Scrubs_LN_PropertyV2_Assessor.layout_Property_Assessor,self:=Left;self:=[]));
		
		EXPORT file_PropertyAssessmentScrubs2:=PropertyAssessmentScrubs;
		
		shared deed_override_layout := record
			string20 flag_file_id;
			ln_propertyv2.layout_deed_mortgage_common_model_base;
		end;

		PropertyDeedScrubs := dataset (daily_prefix_Property + 'deed', deed_override_layout, csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

		EXPORT file_PropertyDeedScrubs	:= PropertyDeedScrubs;
end;