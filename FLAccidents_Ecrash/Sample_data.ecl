import ut;

import doxie,FLAccidents;

export Sample_data := module
befor := distribute(pull(FLAccidents_Ecrash.key_EcrashV2_accnbr_father),hash32(l_accnbr));
 

after := distribute(pull(FLAccidents_Ecrash.key_EcrashV2_accnbr),hash32(l_accnbr));

after trecs(after L, befor R) := transform
self := L;
end;

shared jrecs := join(after,befor,
					left.l_accnbr = right.l_accnbr,
					trecs(left,right),left only,local) : persist('~thor_data400::ecrash::samples');
//Work type id [0,1] has Jurisdiction info and [2,3] comes from CRU and does not have jurisdiction 
 //  

					
export agency_data := topn(sort(jrecs(report_code = 'EA' and work_type_id in ['0','1']),-accident_date),500,-accident_date);
export cru_archive := topn(sort(jrecs(report_code not in ['EA','TM','TF']),-accident_date),500,-accident_date);

export iyetek_data := topn(sort(jrecs(report_code = 'TM' or report_code = 'TF' ),-accident_date),500,-accident_date);

export ntl_data :=   sort(pull(FLAccidents_Ecrash.key_EcrashV2_dol ( report_code = 'A' and ut.DaysApart(ut.GetDate , accident_date ) < 5)),-accident_date);

 

 export qa := Sequential(output(choosen(agency_data,500),named('Sample_EA_NewRecords'),all),
                                 output(choosen(iyetek_data,500),named('Sample_Iyetek_NewRecords'),all),
                                 output(choosen(cru_archive,500),named('Sample_CRU_FL_NewRecords'),all),
																 output(choosen(ntl_data,500),named('Sample_Ntl_Accidents'),all)
                                 );
																 
	end;