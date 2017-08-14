import risk_indicators, riskprocessing, models;

EXPORT get_attributes_LnJ(grouped DATASET(RiskView.Layouts.shell_NoScore) clam,
			 									boolean isPrescreen)
:= function
pre_clam := project(clam, transform(risk_indicators.layout_boca_shell, self := left));

riskview.layouts.attributes_internal_layout_noscore map_attributes(pre_clam le) := transform
			
	self.seq := le.seq;
	self.did := le.did;
	
	attr := models.Attributes_Master(le, true);
	
	//new lnj attributes
	self.LnJEvictionTotalCount        := if(not le.truedid, '-1', attr.LnJEvictionTotalCount );
	self.LnJEvictionTotalCount12Month := if(not le.truedid, '-1', attr.LnJEvictionTotalCount12Month );
	self.LnJEvictionTimeNewest        := attr.LnJEvictionTimeNewest;
	self.LnJJudgmentSmallClaimsCount  := attr.LnJJudgmentSmallClaimsCount;
	self.LnJJudgmentCourtCount        := attr.LnJJudgmentCourtCount;
	self.LnJJudgmentForeclosureCount  := attr.LnJJudgmentForeclosureCount;
															 
	self.LnJLienJudgmentSeverityIndex := attr.LnJLienJudgmentSeverityIndex ;
	self.LnJLienJudgmentCount         := attr.LnJLienJudgmentCount;
	self.LnJLienJudgmentCount12Month  := attr.LnJLienJudgmentCount12Month ;
	self.LnJLienTaxCount              := attr.LnJLienTaxCount;
	self.LnJLienJudgmentOtherCount    := attr.LnJLienJudgmentOtherCount;
	self.LnjLienJudgmentTimeNewest    := attr.LnjLienJudgmentTimeNewest;
	self.LnJLienJudgmentDollarTotal   := attr.LnJLienJudgmentDollarTotal;
	//brand new lnj attributes	
	self.LnJLienCount                  := attr.LnJLienCount                 ;
	self.LnJLienTimeNewest             := attr.LnJLienTimeNewest            ;
	self.LnJLienDollarTotal            := attr.LnJLienDollarTotal           ;
	self.LnJLienTaxTimeNewest          := attr.LnJLienTaxTimeNewest         ;
	self.LnJLienTaxDollarTotal         := attr.LnJLienTaxDollarTotal        ;
	self.LnJLienTaxStateCount          := attr.LnJLienTaxStateCount         ;
	self.LnJLienTaxStateTimeNewest     := attr.LnJLienTaxStateTimeNewest    ;
	self.LnJLienTaxStateDollarTotal    := attr.LnJLienTaxStateDollarTotal   ;
	self.LnJLienTaxFederalCount        := attr.LnJLienTaxFederalCount       ;
	self.LnJLienTaxFederalTimeNewest   := attr.LnJLienTaxFederalTimeNewest  ;
	self.LnJLienTaxFederalDollarTotal  := attr.LnJLienTaxFederalDollarTotal ;
	self.LnJJudgmentCount              := attr.LnJJudgmentCount             ;
	self.LnJJudgmentTimeNewest         := attr.LnJJudgmentTimeNewest        ;
	self.LnJJudgmentDollarTotal        := attr.LnJJudgmentDollarTotal       ;
	self.ConfirmationSubjectFound	     := attr.ConfirmationSubjectFound     ;
	self.SubjectDeceased							 := attr.SubjectDeceased							;
	self.LnJliens	:= le.LnJ_datasets.LnJLiens;
	self.LnJJudgments	:= le.LnJ_datasets.LnJJudgments;

	self := [];
end;
with_attributes_lnj := project(pre_clam, map_attributes(left));

with_attributes_lnj_noScore := join(clam, with_attributes_lnj,
	left.seq = right.seq,
	transform(riskview.layouts.attributes_internal_layout,
		self.seq := left.seq;
		self.did := left.did;	
		no_score := left.no_score;
		self.LnJEvictionTotalCount        := if(no_score, '-1', right.LnJEvictionTotalCount);
		self.LnJEvictionTotalCount12Month := if(no_score, '-1', right.LnJEvictionTotalCount12Month );
		self.LnJEvictionTimeNewest        := if(no_score, '-1', right.LnJEvictionTimeNewest);
		self.LnJJudgmentSmallClaimsCount  := if(no_score, '-1', right.LnJJudgmentSmallClaimsCount);
		self.LnJJudgmentCourtCount        := if(no_score, '-1', right.LnJJudgmentCourtCount);
		self.LnJJudgmentForeclosureCount  := if(no_score, '-1', right.LnJJudgmentForeclosureCount);
																 
		self.LnJLienJudgmentSeverityIndex := if(no_score, '-1', right.LnJLienJudgmentSeverityIndex );
		self.LnJLienJudgmentCount         := if(no_score, '-1', right.LnJLienJudgmentCount);
		self.LnJLienJudgmentCount12Month  := if(no_score, '-1', right.LnJLienJudgmentCount12Month) ;
		self.LnJLienTaxCount              := if(no_score, '-1', right.LnJLienTaxCount);
		self.LnJLienJudgmentOtherCount    := if(no_score, '-1', right.LnJLienJudgmentOtherCount);
		self.LnjLienJudgmentTimeNewest    := if(no_score, '-1', right.LnjLienJudgmentTimeNewest);
		self.LnJLienJudgmentDollarTotal   := if(no_score, '-1', right.LnJLienJudgmentDollarTotal);
		//brand new lnj attributes	
		self.LnJLienCount                  := if(no_score, '-1', right.LnJLienCount     )            ;
		self.LnJLienTimeNewest             := if(no_score, '-1', right.LnJLienTimeNewest )           ;
		self.LnJLienDollarTotal            := if(no_score, '-1', right.LnJLienDollarTotal )          ;
		self.LnJLienTaxTimeNewest          := if(no_score, '-1', right.LnJLienTaxTimeNewest   )      ;
		self.LnJLienTaxDollarTotal         := if(no_score, '-1', right.LnJLienTaxDollarTotal  )      ;
		self.LnJLienTaxStateCount          := if(no_score, '-1', right.LnJLienTaxStateCount  )       ;
		self.LnJLienTaxStateTimeNewest     := if(no_score, '-1', right.LnJLienTaxStateTimeNewest  )  ;
		self.LnJLienTaxStateDollarTotal    := if(no_score, '-1', right.LnJLienTaxStateDollarTotal )  ;
		self.LnJLienTaxFederalCount        := if(no_score, '-1', right.LnJLienTaxFederalCount   )    ;
		self.LnJLienTaxFederalTimeNewest   := if(no_score, '-1', right.LnJLienTaxFederalTimeNewest  );
		self.LnJLienTaxFederalDollarTotal  := if(no_score, '-1', right.LnJLienTaxFederalDollarTotal );
		self.LnJJudgmentCount              := if(no_score, '-1', right.LnJJudgmentCount    )         ;
		self.LnJJudgmentTimeNewest         := if(no_score, '-1', right.LnJJudgmentTimeNewest   )     ;
		self.LnJJudgmentDollarTotal        := if(no_score, '-1', right.LnJJudgmentDollarTotal     )  ;
		self.LnJliens	:= if(no_score, dataset([], Risk_Indicators.Layouts_Derog_Info.Liens), 
			project(right.LnJLiens, transform(Risk_Indicators.Layouts_Derog_Info.liens, self := left)));
		self.LnJJudgments	:= if(no_score, dataset([], Risk_Indicators.Layouts_Derog_Info.Judgments), 
			project(right.LnJJudgments, transform(Risk_Indicators.Layouts_Derog_Info.Judgments, self := left)));

		self.ConfirmationSubjectFound	     := right.ConfirmationSubjectFound     ;
		self.SubjectDeceased						   := right.SubjectDeceased								;
		self := [];//non Juli attributes
));

return with_attributes_lnj_noScore;

end;