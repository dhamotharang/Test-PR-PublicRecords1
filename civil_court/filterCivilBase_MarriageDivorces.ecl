import PromoteSupers;
//#workunit('name','Civil Court: Marriage & Divorces Filter'+ civil_court.Version_Development);

/* ************************************************************************************************************** */
//Filter Party File for vendors and Party Types

p	:= dataset('~thor_200::base::civil_party_' + civil_court.Version_Development,civil_court.Layout_Moxie_Party,flat);

pfiltered1 := p(vendor = '01' or
				vendor = '04' or
				vendor = '12' or
				vendor = '14' or
				vendor = '15' or
				vendor = '18' or
				vendor = '21' or
				vendor = '22' or
				vendor = '24' or
				vendor = '26' or
				vendor = '37' or
				vendor = '45' or
				vendor = '47' or
				vendor = '49' or
				vendor = '54' or
			    vendor = '57' or
				vendor = '60' or
				vendor = '62' or
				vendor = '64' or
				vendor = '90' ); 

pfiltered2 := pfiltered1(REGEXFIND('CONNECTICUT',StringLib.StringToUpperCase(entity_1),0) = '' and
						REGEXFIND('INSURANCE',StringLib.StringToUpperCase(entity_1),0) = '' and 
						REGEXFIND('LOS ANG CO',StringLib.StringToUpperCase(entity_1),0) = '' and
						REGEXFIND('STATE ',StringLib.StringToUpperCase(entity_1),0) = '' and 
						REGEXFIND('UNITED STATES',StringLib.StringToUpperCase(entity_1),0) = '' and
						REGEXFIND('CHILDREN',StringLib.StringToUpperCase(entity_1),0) = '' and 
						REGEXFIND('MINOR CHILD',StringLib.StringToUpperCase(entity_1),0) = '');
						
pdivorces := pfiltered2(entity_type_code_1_master = '10' or 
				entity_type_code_1_master = '11' or
				entity_type_code_1_master = '30' or
				entity_type_code_1_master = '31' or
				entity_type_code_1_master = '15' or
				entity_type_code_1_master = '16');
				

/* Filter Matter for vendor,Marr & Div ********************************************************************** */

m	:= dataset('~thor_200::base::civil_matter_' + civil_court.Version_Development,civil_court.Layout_Moxie_Matter,flat);

mfiltered1 := m(vendor = '01' or
				vendor = '04' or
				vendor = '12' or
				vendor = '14' or
				vendor = '15' or
				vendor = '18' or
				vendor = '21' or
				vendor = '22' or
				vendor = '24' or
				vendor = '26' or
				vendor = '37' or
				vendor = '45' or
				vendor = '47' or
				vendor = '49' or
				vendor = '54' or
			    vendor = '57' or
				vendor = '60' or
				vendor = '62' or
				vendor = '64' or
				vendor = '90' ); 

mdivorces := mfiltered1(not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'ADULTRY',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'ANNULMENT',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'DIVORCE',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'IRRECONCILABLE DIFFERENCES',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'MARRIAGE',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'MATRIMONIAL',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'MINOR CHILD',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'NULLITY',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'SEPERATION',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'SEPERATE',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'SPOUSE',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'UCCA',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'UCMT',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'WITH CHILDREN',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'WITHOUT CHILDREN',1) = 0) or
						 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'ADULTRY',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'ANNULMENT',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'DIVORCE',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'IRRECONCILABLE DIFFERENCES',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'MARRIAGE',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'MATRIMONIAL',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'MINOR CHILD',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'NULLITY',1) = 0) or 
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'SEPERATION',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'SEPERATE',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'SPOUSE',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'UCCA',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'UCMT',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'WITH CHILDREN',1) = 0) or
						not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'WITHOUT CHILDREN',1) = 0));
										
					
/* ************************************************************************************************************** */

mmarriages := mfiltered1(not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'MARRIAGE',1) = 0) or
						 not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'MATRIMONIAL',1) = 0) or
						 not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'MARRIAGE',1) = 0) or
						 not(StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'MATRIMONIAL',1) = 0) and 
						 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'ADULTRY',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'ANNULMENT',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'DIVORCE',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'IRRECONCILABLE DIFFERENCES',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'MINOR CHILD',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'NULLITY',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'SEPERATION',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'SEPERATE',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'SPOUSE',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'UCCA',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'UCMT',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'WITH CHILDREN',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_cause), 'WITHOUT CHILDREN',1) = 0) and
						 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'ADULTRY',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'ANNULMENT',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'DIVORCE',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'IRRECONCILABLE DIFFERENCES',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'MINOR CHILD',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'NULLITY',1) = 0) and 
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'SEPERATION',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'SEPERATE',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'SPOUSE',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'UCCA',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'UCMT',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'WITH CHILDREN',1) = 0) and
						 (StringLib.StringFind(StringLib.StringToUpperCase(mfiltered1.case_type), 'WITHOUT CHILDREN',1) = 0));
						 


/* ************************************************************************************************************** */


pdivorcesDist	:= distribute(pdivorces,hash(case_key));
pdivorcesSort	:= sort(pdivorcesDist,case_key,local);

mdivorcesDist	:= distribute(mdivorces,hash(case_key));
mdivorcesSort	:= sort(mdivorcesDist,case_key,local);

pfiltered2Dist	:= distribute(pfiltered2,hash(case_key));
pfiltered2Sort	:= sort(pfiltered2Dist,case_key,local);

mmarriagesDist	:= distribute(mmarriages,hash(case_key));
mmarriagesSort	:= sort(mmarriagesDist,case_key,local);


/* Party Records************************************************************************************************** */

civil_court.Layout_Moxie_Party tdivorces(pdivorcesSort L, mdivorcesSort R) := transform
self := L;
end;

civil_court.Layout_Moxie_Party tmarriages(pfiltered2Sort L, mmarriagesSort R) := transform
self := L;
end;

jdivorces	:= join(pdivorcesSort,mdivorcesSort,
					left.case_key = right.case_key,			
					tdivorces(left,right)
					);
					
					
jmarriages	:= join(pfiltered2Sort,mmarriagesSort,
					left.case_key = right.case_key,
					tmarriages(left,right)
					);
					
final_party := jdivorces + jmarriages;
sfinal_party := sort(final_party,case_key,record);
dfinal_party := dedup(sfinal_party,case_key,record);

/* Matter Records************************************************************************************************* */

final_matter := mdivorcesSort + mmarriagesSort;
sfinal_matter := sort(final_matter,case_key,record);
dfinal_matter := dedup(sfinal_matter,case_key,record);					

/* **ROXIE KEY NOTIFICATION EMAIL******************************************************************************** */	
email := fileservices.sendemail('kgummadi@seisint.com; cpettola@seisint.com',
								 
								'MARRIAGE & DIVORCES: FILTER SUCCESS '+ civil_court.Version_Development,
								'output files: 1) thor_data200::base::civil_court::party::marriage_divorce'  +'\n' +
						        '              2) thor_data200::base::civil_court::matter::marriage_divorce' +'\n' +
								'              have been built and ready for processing.'); 
								
PromoteSupers.MAC_SF_BuildProcess(dfinal_matter,'~thor_data200::base::civil_court::matter::marriage_divorce',build_civ_matter,2,,TRUE);
PromoteSupers.MAC_SF_BuildProcess(dfinal_party, '~thor_data200::base::civil_court::party::marriage_divorce', build_civ_party, 2,,TRUE);

/* Output Files*************************************************************************************************** */
export filterCivilBase_MarriageDivorces := sequential(build_civ_matter,build_civ_party,email);