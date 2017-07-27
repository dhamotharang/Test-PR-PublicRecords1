export Fn_Next_Working_Hypothesis(dataset(layout_classify_hypothesis) so_far, dataset(layout_classify_token) this_round, unsigned this_pos, unsigned tlength) := FUNCTION
  Layout_Classify_Hypothesis Into(layout_classify_token le) := TRANSFORM
	  SELF.StartPos := this_pos;
		SELF.Len := le.TokenCount;
		SELF.Confirmed := le.TokenCount = 1;
	  SELF := le;
  END;
	NewHypothesis := PROJECT(this_round(Pos=1,TokenCount <= tlength-this_pos+1),Into(left)); // All the new hypothesis that can be made from this point forward
	CarryForward := so_far(Confirmed)+NewHypothesis;
	NeedConfirmation := so_far(~Confirmed);
	Layout_Classify_Hypothesis Next(layout_classify_hypothesis le,layout_classify_token ri) := TRANSFORM
	  SELF.Confirmed := ri.pos = ri.TokenCount;
	  SELF.Spc := MAX(le.spc,ri.spc);
	  SELF := le;
	END;
	MoreConfirmed := JOIN(NeedConfirmation,this_round,LEFT.TokenType=RIGHT.TokenType AND LEFT.Len = RIGHT.TokenCount AND this_pos-LEFT.StartPos+1 = RIGHT.Pos,Next(LEFT,RIGHT)); 
	RETURN CarryForward+MoreConfirmed;
  END;
