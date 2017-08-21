import header, ut;
inf := ln_property.Prop_Joined; //+ ln_property.Assessors_as_Deeds;

goodr_ := inf(fname <> '', lname <> '', length(trim(fname)) > 1,prim_name <> '',~(prim_range='' and zip4=''),
			  length(trim(mname)) = length(stringlib.StringFilterOut(mname, ' ')),jflag3!='P'
			 );

//Filter IRS Dummy DID's
goodr := goodr_((string12)did < ln_property.irs_dummy_cutoff);
											 
header.Layout_New_Records blankdids(inf l) := transform
	self.prim_range := header.fixPrimRange(l.prim_range);
	self.rid        := 0;
	self.did        := 0;
	
	self.jflag3     :='';
	
	self            := l;
end;

export LN_Property_As_Header := project(goodr, blankdids(left));