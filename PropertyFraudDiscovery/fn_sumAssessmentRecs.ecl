IMPORT STD;

EXPORT fn_sumAssessmentRecs(DATASET(Layouts.batch_working_prop) ds_work_prop_recs,
														IParams.BatchParams in_mod) := FUNCTION

	// SUMMARIZE ASSESSMENTS

	Layouts.entityRec getChronologicalAssessees(Layouts.sumAssessmentsRec L) := TRANSFORM
		SELF.entities:=PROJECT(L.assessees,
		TRANSFORM(Layouts.dateDidNameRec,SELF.date:=L.date,SELF:=LEFT,SELF:=[]));
	END;

	Layouts.sumAssessmentsRec getAssessmentSummary(Layouts.assessmentsPartiesRec L) := TRANSFORM
		assessment:=L.assessments[1];// FIRST RECORD
		SELF.ln_fares_id:=L.ln_fares_id;
		SELF.date:=L.sortby_date;
		SELF.tax_year:=assessment.tax_year;
		SELF.tax_amount:=assessment.tax_amount;
		SELF.assessee:=STD.Str.CleanSpaces(assessment.assessee_name+' '+assessment.second_assessee_name);
		assesseeEntities:=PROJECT(L.parties(party_type='O').entity,TRANSFORM(Layouts.didNameRec,
			SELF.did:=(UNSIGNED6)LEFT.did,
			SELF.seleid:=(UNSIGNED6)LEFT.seleid,
			SELF.name:=STD.Str.CleanSpaces(LEFT.fname+' '+LEFT.lname+' '+LEFT.name_suffix+' '+LEFT.cname),SELF:=[]));
		SELF.assessees:=assesseeEntities;
	END;

	Layouts.sumAssessmentsVndrRec getAssessmentVndrSummary(Layouts.assessmentVndr L) := TRANSFORM
		UNSIGNED thisYear:=(UNSIGNED)StringLib.getDateYYYYMMDD()[1..4];
		STRING8 duration1:=(STRING)(thisYear-in_mod.NumberInterval1Years)+'0000';
		STRING8 duration2:=(STRING)(thisYear-in_mod.NumberInterval2Years)+'0000';

		SELF.vndrSrcFlg:=L.vndrSrcFlg;
		SELF.num_prop_yrs:=in_mod.NumberPropertyYears;
		SELF.interval_1_yrs:=in_mod.NumberInterval1Years;
		SELF.interval_2_yrs:=in_mod.NumberInterval2Years;

		assessmentSummary:=PROJECT(L.assessmentsParties,getAssessmentSummary(LEFT));
		SELF.assessment_summary:=assessmentSummary;

		normAssessees:=DEDUP(SORT(NORMALIZE(PROJECT(assessmentSummary,getChronologicalAssessees(LEFT)),LEFT.entities,
			TRANSFORM(Layouts.dateDidNameRec,SELF:=RIGHT)),-date,did),RECORD);
		// COUNT INDIVDUAL OWNERS BY DID IN TIME INTERVALS
		SELF.num_owners_interval_1:=COUNT(DEDUP(SORT(normAssessees(did!=0,date>=duration1),did),did));
		SELF.num_owners_interval_2:=COUNT(DEDUP(SORT(normAssessees(did!=0,date>=duration2),did),did));
		SELF.chronological_assessees:=normAssessees;

		SELF:=[];
	END;

	Layouts.batch_working_prop getAssessmentBatchSummary(Layouts.batch_working_prop L) := TRANSFORM
		SELF.assessment_summary_by_vendor:=PROJECT(L.assessorVndrProperties,getAssessmentVndrSummary(LEFT));
		SELF:=L;
		SELF:=[];
	END;

	// SET SOME SUMMARY VALUES

	Layouts.sumAssessmentsVndrRec setDurationSubjectOwnership(Layouts.sumAssessmentsVndrRec L,UNSIGNED subject_did) := TRANSFORM
		owners:=PROJECT(L.chronological_assessees,TRANSFORM(Layouts.dateDidNameRec,SELF.is_Subject:=(subject_did!=0) AND (LEFT.did=subject_did),SELF:=LEFT));
		ownerYears:=SET(owners(is_Subject),(UNSIGNED)date[1..4]);
		UNSIGNED duration:=MAX(ownerYears)-MIN(ownerYears);
		SELF.duration_subject_ownership:=IF(duration>0 OR COUNT(ownerYears)=1,duration+1,0);
		SELF.subject_is_a_owner:=EXISTS(owners(is_Subject));
		SELF.chronological_assessees:=owners;
		SELF:=L;
	END;

	Layouts.batch_working_prop setAssessmentBatchSummary(Layouts.batch_working_prop L) := TRANSFORM
		SELF.assessment_summary_by_vendor:=PROJECT(L.assessment_summary_by_vendor,setDurationSubjectOwnership(LEFT,L.did));
		SELF:=L;
	END;

	ds_tmp_assessment_recs := PROJECT(ds_work_prop_recs,getAssessmentBatchSummary(LEFT));
	ds_sum_Assessment_recs := PROJECT(ds_tmp_assessment_recs,setAssessmentBatchSummary(LEFT));

	RETURN ds_sum_Assessment_recs;

END;