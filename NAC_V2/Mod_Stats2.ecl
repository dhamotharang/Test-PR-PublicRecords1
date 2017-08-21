EXPORT Mod_stats2 := MODULE

	EXPORT BenefitMonthCnt():=function

		RETURN sort(table(NAC_V2.Files().Base,{
																Case_Benefit_Month
																,AL:=sum(group,if(Case_State_Abbreviation='AL',1,0))
																,FL:=sum(group,if(Case_State_Abbreviation='FL',1,0))
																,GA:=sum(group,if(Case_State_Abbreviation='GA',1,0))
																,LA:=sum(group,if(Case_State_Abbreviation='LA',1,0))
																,MS:=sum(group,if(Case_State_Abbreviation='MS',1,0))
																}
																,Case_Benefit_Month
																,few)
																,Case_Benefit_Month)
																;
	END;
	
EXPORT colPerState(exp1='true'):=functionmacro
	d:=nac.files().Collisions(#expand(exp1));
	t1:=table(d,{
							Priority:=pri
							,Match_Set:=matchset
							,Benefit_Month:=SearchBenefitMonth
							,State1:=BenefitState
							,State2:=CaseState
							,Same_State:=BenefitState=CaseState
							,Collisions_Per_Record:=count(group)
							}
							,matchset
							,SearchSequenceNumber
							,SearchBenefitMonth
							,BenefitState
							,CaseState
							,few
					);

	tPerState:=table(t1,{
							Priority
							,Match_Set
							,State1
							,Benefit_Month
							,State2
							,Same_State
							,Collisions_Per_Record
							,Collisions_Per_State:=count(group)
							}
							,Match_Set
							,State1
							,Benefit_Month
							,State2
							,Same_State
							,Collisions_Per_Record
							,few
					);

	tPerState2:=table(tPerState,{
							Priority
							,Match_Set
							,State1
							,Benefit_Month
							,State2
							,Same_State
							,Collisions_Per_Record
							,Collisions_Per_State
							,All_Combined:=(integer)(Collisions_Per_Record * Collisions_Per_State)
							}
					);

	col_per_state:=tPerState2;

	RETURN col_per_state;
ENDMACRO;	










END;