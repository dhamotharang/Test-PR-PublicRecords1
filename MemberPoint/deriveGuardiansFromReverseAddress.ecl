/*Req 9 :
		If no head of household information is provided for a minor subject, 
the address should be used for a reverse address look up to find last name 
matches to the minorâ€™s input name.
Reverse Address (Minors):

For Minors where not HOH was provided run the minors through Reverse Address:

MaxRecordsToReturn: 10
YearsForCurrentResidency: 0

1.	Run Minors through reverse address returning up to 10 hits
2.	Compare the last name of the hit to the input last name and if any match 
    pair that name with the input address. If multiples are found unique it 
    down to 1.

BatchServices.ResidentsService

*/
import BatchServices;

EXPORT deriveGuardiansFromReverseAddress(dataset(MemberPoint.Layouts.BatchInter) pureMinors, 
																													MemberPoint.IParam.BatchParams IParam) := function 
		
		// define the module
 	  in_mod := module(project(IParam,BatchServices.Interfaces.res_config,opt))
		// MaxRecordsToReturn overrides max_currentresidents and max_priorresidents. 
			shared maxRecs := MemberPoint.Constants.MaxRecordsToReturn; //0 : STORED('MaxRecordsToReturn');
			shared integer CurrRes := 20 ;
			shared integer PriorRes := 20 ;						
			export unsigned1 MaxCurrRes := if(maxRecs=0, min(currRes,20), min(maxRecs, 10));
			export unsigned1 MaxPriorRes := if(maxRecs=0, min(PriorRes,20), 0);
			unsigned4 thrForCurRes := BatchServices.constants.Residents.ThresholdDateForCurrentResidency ;
			// YearsForCurrentResidency overrides thresholddateforcurrentresidency
			yearsForCurRes := MemberPoint.Constants.YearsForCurrentResidency; //0 : STORED('YearsForCurrentResidency');			
			yearsForCurrentResidency := (BatchServices.constants.Residents.TODAY_YYYYMM - (BatchServices.constants.Residents.ONE_YEAR * yearsForCurRes));
			// any last seen date more current than this date is considered current
			export unsigned4 ThresholdDateForCurrentResidency := if(yearsForCurRes=0, thrForCurRes, yearsForCurrentResidency);
			export boolean ReturnAddrPhone := false ;
			export boolean MultiUnitSearch := false ;
  	end;

		//rec_batch_in := BatchServices.Layouts.Resident.cln_batch_in;
		//rec_batch_out := BatchServices.Layouts.Resident.batch_out;
		
		
		PreBatchIn := project(pureMinors,transform(BatchServices.Layouts.Resident.cln_batch_in,
				self.acctno      	:= left.acctno;
				self.addr 				:= '';
				self.prim_range 	:= left.prim_range;
				self.predir 			:= left.predir;
				self.prim_name 		:= left.prim_name;
				self.addr_suffix 	:= left.addr_suffix;
				self.postdir 			:= left.postdir;
				self.sec_range 		:= left.sec_range;
				self.p_city_name 	:= left.p_city_name;
				self.st 					:= left.st;
				self.z5 					:= left.z5;
				self.unit_desig 	:= left.unit_desig;
				self.zip4 				:= left.zip4;
			  self.rec_type 		:= '';
				self.drop_ind 		:= '';
				//self.missing_sec_range := '';
				self 							:= [];			
		));
		
		FinalBatchIn := BatchServices.Residents_refineBatchIn(PreBatchIn,true);
		
		dsResidentsMultiple := BatchServices.Residents_Records(FinalBatchIn,in_mod);
			
		MemberPoint.Layouts.BatchInter xform (MemberPoint.Layouts.BatchInter l ,
																						recordof(dsResidentsMultiple) r) := transform
							isGuardian := r.lname = l.name_last;															
							self.LN_search_name_type := 	if(isGuardian,MemberPoint.Constants.LNSearchNameType.Derived,MemberPoint.Constants.LNSearchNameType.Minor);
							self.Guardian_name_first :=   if(isGuardian,r.fname,'');
							self.Guardian_name_last	 :=	  if(isGuardian,r.lname,'');
							self.Guardian_DOB				 :=	  if(isGuardian,r.dob,'');
							self.Guardian_SSN 				:=  if(isGuardian,r.ssn,'');
							self := l;
			end;
			
	   DerivedGuardiansAndMinors := join(pureMinors,dsResidentsMultiple,
																					left.acctno = right.acctno and 
																					not right.deceased and 
																					(unsigned) right.age >= MemberPoint.Constants.AdultAgeStart and 
																					not right.missing_sec_range and 
																					left.name_last = right.lname and 
																					right.lname <> ''	,
																					xform(left,right),
																					left outer,
																					keep(1)
																				);

	return(DerivedGuardiansAndMinors);
end;