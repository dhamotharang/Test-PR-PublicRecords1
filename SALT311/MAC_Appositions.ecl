EXPORT MAC_Appositions(deduped, uid, label, specs, P_Rat_Threshold = 1.5, R_Cnt_Threshold=0.5,Dom_Threshold=5,Always_Threshold=5.0,Min_Sample = 10) := FUNCTIONMACRO
  RETURN MODULE
	  R := RECORD
		  SALT311.StrType L;
			SALT311.StrType R;
		END;
		J := JOIN(deduped,deduped,LEFT.uid=RIGHT.uid AND LEFT.label>RIGHT.label,TRANSFORM(R,SELF.L := TRIM(LEFT.label), SELF.R := TRIM(RIGHT.label)),LOCAL);
		R1 := RECORD
		  J;
			Cnt := COUNT(GROUP);
		END;
		T := TABLE(J, R1, L, R, MERGE )(Cnt >= Min_Sample);
		P := PROJECT(T, TRANSFORM(R1, SELF.L := LEFT.R, SELF.R := LEFT.L, SELF := LEFT));
		C := T+P;
		EXPORT Raw := C;
		R := RECORD
		  Raw;
			UNSIGNED1 L_Spc;
			UNSIGNED1 R_Spc := 0;
		  UNSIGNED L_Cnt;
			UNSIGNED R_Cnt := 0;
			UNSIGNED Predict_Cnt := 0;
		  Raw;
		END;
		J1 := JOIN(Raw,specs,LEFT.L = RIGHT.label, TRANSFORM(R,SELF.L_Cnt := RIGHT.t_cnt, SELF.L_Spc := RIGHT.field_specificity, SELF := LEFT),SMART);
		J2 := JOIN(J1,specs,LEFT.R = RIGHT.label, TRANSFORM(R,SELF.R_Cnt := RIGHT.t_cnt, SELF.R_Spc := RIGHT.field_specificity, SELF.predict_cnt := LEFT.L_Cnt / POWER(2,RIGHT.field_specificity),SELF := LEFT),SMART);
		R1 := RECORD
		  J2;
			REAL8   p_rat := J2.Cnt / J2.Predict_Cnt;
			REAL8   l_pcnt := J2.Cnt * 100 / J2.L_Cnt;
			REAL8   r_pcnt := J2.Cnt * 100 / J2.R_Cnt;
			BOOLEAN Init := J2.R = J2.L[1..LENGTH(J2.R)] OR J2.L = J2.R[1..LENGTH(J2.L)];
			BOOLEAN Edit1 := SALT311.WithinEditN(J2.L,J2.R,1);
			BOOLEAN Edit2 := SALT311.WithinEditN(J2.L,J2.R,2);
			BOOLEAN Dominates := J2.L_Cnt > J2.R_Cnt * Dom_Threshold;
			BOOLEAN Subsumes := J2.Cnt * 100 > Always_Threshold * J2.R_Cnt;
		END;
		EXPORT Annotated := TABLE(J2,R1)(p_rat>P_Rat_Threshold,r_pcnt>r_cnt_threshold);
		R2 := RECORD
		  STRING Field := #TEXT(label);
		  REAL8 InitPcnt := AVE(GROUP,IF(Annotated.Init,100,0));
		  REAL8 Edit1Pcnt := AVE(GROUP,IF(Annotated.Edit1,100,0));
		  REAL8 Edit2Pcnt := AVE(GROUP,IF(Annotated.Edit2,100,0));
			REAL8 Dominated := AVE(GROUP,IF(Annotated.Dominates,100,0));
			REAL8 Subsumes := AVE(GROUP,IF(Annotated.Subsumes,100,0));
			UNSIGNED Cnt := COUNT(GROUP);
		END;
		EXPORT FuzzyStats := TABLE(Annotated,R2);
	END;
  ENDMACRO;
