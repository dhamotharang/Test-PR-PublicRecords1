import LiensV2,CrimSrch,Crim_Common, Corrections,Life_EIR, hygenics_search;


fcra_v1 := Offender_Joined(offender_key[1..4] not in CrimSrch.Sex_Offenders_Not_Updating.SO_By_Key
           and source_file not in CrimSrch.Sex_Offenders_Not_Updating.SO_By_Source
           and vendor != '99'
					 and source_file != 'AR-DOC              '
					 and source_file != 'NJ-DOC-INMATE-OBCIS ' 
					 and source_file != 'PA STATEWIDE CRIM CT'
					 and source_file != 'PA_STATEWIDE_HIS(CV)'
					 and source_file != 'FL-DOC              '
					 and source_file != 'TX-DOC-Inmate-HIST  ');
					 //and source_file != 'NM-BernalilloCtyArr '
					 //and source_file != 'AZ-MaricopaArrest   ')
					 //and source_file != 'FL-ALACHUA-CNTY-CRIM');

/////////////////////////////////////////////////////////////////////////////////////////
//Mapping temp layout back to original fcra layout, so that existing keys are not changed
/////////////////////////////////////////////////////////////////////////////////////////
Crimsrch.Layout_Moxie_Offender trecs(fcra_v1 L) := transform

self := L;
end;

fcra_v1_as_v1 := project(fcra_v1, trecs(left));

/////////////////////////////////////////////////////////////////////////////////////////
//Mapping temp layout to nonfra layout to faciliate new key request regarding the Life EIR project
/////////////////////////////////////////////////////////////////////////////////////////
					 
hygenics_search.corrections_layout_offender trecs2(fcra_v1 L) := transform
self.ssn := L.orig_ssn;
self := L;
end;

fcra_v1_as_v2 := project(fcra_v1, trecs2(left));
					 
export Out_Offender := sequential(
																	output(fcra_v1_as_v1,,CrimSrch.Name_Moxie_Offender_Dev,overwrite, __compressed__),
																	//patch DID and other misc then 
																	//add incar flags then
																	//output
																	output(Life_EIR.proc_build_Life_EIR_offenders_flagged(Life_EIR.proc_build_Life_EIR_offenders(fcra_v1_as_v2))
																	,,'~thor_data400::base::fcra::life_eir::criminal_offenders_' + CrimSrch.Version.Development,overwrite, __compressed__)
																	);