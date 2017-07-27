import header, ut;
inf := ln_property.Prop_Joined; //+ ln_property.Assessors_as_Deeds;

goodr := inf(fname <> '', lname <> '', length(trim(fname)) > 1,
			 dt_first_seen > 190000, 
			 prim_name <> '',
			 length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' '))
			 );

header.Layout_New_Records blankdids(inf l) := transform
	self.prim_range := header.fixPrimRange(l.prim_range);
	self.rid        := 0;
	self.did        := 0;
	self            := l;
end;

export LN_Property_As_Header := project(goodr, blankdids(left));