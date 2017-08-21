import Prof_License, tools, ut;

export Proc_Build_V2_base_from_V1(string fileDate) := function

    base := Prof_License.File_prof_license_base_AID;
		
		TierFile 	 := Prof_LicenseV2.File_Proflic_Category_Table;

		layout_out := Prof_LicenseV2.Layouts_ProfLic.Layout_base_with_tiers;

		layout_out trfProlicForSeq(base l) := transform
			self := l;
		end;

		FatBase 		:= project(base, trfProlicForSeq(left));		
		temp_base 	:= FatBase(Prolic_key[1..1] <>'C');
		
		layout_out joinFiles(layout_out l, Prof_LicenseV2.Layout_Proflic_Category_Table r) := TRANSFORM
			self.orbit_source	:= stringlib.StringToUpperCase(r.source);
			self.category1		:= stringlib.StringToUpperCase(r.cat1);
			self.category2		:= stringlib.StringToUpperCase(r.cat2);
			self							:= l;
		end;
    		
		JoinWithTiers			  := join(temp_base,
																TierFile,
																stringlib.StringCleanSpaces(left.source_st)=stringlib.StringCleanSpaces(right.state) and
																stringlib.StringCleanSpaces(left.profession_or_board)=stringlib.StringCleanSpaces(right.board) and
																stringlib.StringCleanSpaces(left.license_type)=stringlib.StringCleanSpaces(right.licType),
																joinFiles(LEFT,RIGHT),left outer, lookup
															 );
														
   layout_out trfProlicForCNLD(layout_out l) := transform
			self.orbit_source		:= 'CNLD';
			self.category1			:= 'MEDICAL';
			self.category2			:= l.license_type;
			self								:= l;
		end;

		CNLDBase 	:= project(FatBase(Prolic_key[1..1] = 'C'), trfProlicForCNLD(left));															

		// Adding AMIDIR (American Medical Information Directory) Records to proflic
		combined_file := JoinWithTiers + Prof_LicenseV2.Mapping_AMIDIR_To_Proflic_Base + CNLDBase;

		// generating a sequence number for "prolic_seq_id"
		ut.MAC_Sequence_Records(combined_file, prolic_seq_id, base_w_seq);
		ut.CleanFields(base_w_seq,base_w_seq_cleaned0);
		base_w_seq_cleaned:=Prof_License.fRemoveBadSource(base_w_seq_cleaned0);
	
    return sequential(tools.MAC_SF_Build_Standard(base_w_seq_cleaned, Prof_LicenseV2.Constants.Cluster+'base::Prolicv2::proflic_base::@version@',fileDate,true,,2));
end;