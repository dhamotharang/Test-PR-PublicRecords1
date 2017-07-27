export FN_Tra_Penalty_Milbranch(string MilBranch_Field) := FUNCTION

string22 MilBranch_val := '' :stored('MilitaryBranch');

milBranch_value := stringlib.stringtouppercase(MilBranch_val);

military_words(string l, string r) :=
		stringlib.stringfind(l+R,'RESERVE',2) > 0 OR
		stringlib.stringfind(l+R,'MARINE',2) > 0 OR
		stringlib.stringfind(l+R,'NAV',2) > 0 OR
		stringlib.stringfind(l+R,'ARMY',2) > 0 OR		
		stringlib.stringfind(l+R,'AIR',2) > 0;			


return MAP(MilBranch_value='' or MilBranch_field=MilBranch_value => 0,
		MilBranch_field='' => 3,
		stringlib.stringfind(trim(MilBranch_field),trim(MilBranch_value),1)>0 or    
		stringlib.stringfind(trim(MilBranch_value),trim(MilBranch_field),1)>0 => 1,
		military_words(milBranch_field,milBranch_value) => 2,
		5);

END;