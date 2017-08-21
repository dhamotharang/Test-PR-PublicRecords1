import ut;

export Filters :=module

	export Base(dataset(VotersV2.Layouts_Voters.Layout_Voters_Base_new ) V_base) := function
	
		VotersV2.Layouts_Voters.Layout_Voters_Base_new trans_fix(VotersV2.Layouts_Voters.Layout_Voters_Base_new  l):=transform
		
			/*Bug: 174413 - Female individual being reported as Male
		    Assigning blank space for wrongly received gender value from vendor for below specific individual */				
			self.gender	:= if(ut.CleanSpacesAndUpper(l.fname) ='MALLIE' and ut.CleanSpacesAndUpper(l.mname)='M' and ut.CleanSpacesAndUpper(l.lname) ='POWE' and ut.CleanSpacesAndUpper(l.gender)='M' ,'',l.gender);
			
			// Bug 178182 - For UT only, suppress DOB after 5/12/2014
			self.dob    := if(l.source_state = 'UT' and (unsigned)l.file_acquired_date > 20140512,
			                  '',
												l.dob);

			self				:= l;			
		end;
		
		fix_base := project(V_base,trans_Fix(left));	
		
		return   fix_base;	
		
	end;
	
end;