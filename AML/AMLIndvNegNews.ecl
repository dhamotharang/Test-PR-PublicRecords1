import iesp, Risk_Indicators, Fingerprint, ut, Gateway;


export AMLIndvNegNews( GROUPED DATASET(AML.Layouts.RelativeInLayout) idsOnly, boolean enableNews) := FUNCTION
				
		AML.AMLNegNews.AMLNegNewsInput into_inq(AML.Layouts.RelativeInLayout L) := transform
			self.query := '#AMLRISK# and ' + L.fname + ' ' + L.lname;
			self := L;
		end;
																
		iin := project(ungroup(idsOnly), into_inq(left));
																
		res := AML.AMLNegNews.AMLNegNewsRequest(iin, enableNews);
		
		newsAppend := join(idsOnly, res, left.seq=right.seq);

		return(newsAppend);												
END;

