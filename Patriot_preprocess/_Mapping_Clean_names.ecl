
import _control, mdr, nid, patriot, address, std;

EXPORT _Mapping_Clean_names(string filedate) := FUNCTION

all_sources :=  
 Patriot_preprocess.Mapping_Bank_of_England +  
 Patriot_preprocess.Mapping_Dept_of_Commerce_Unverified +  
 Patriot_preprocess.Mapping_Directorate_Defense_Trade_Controls_Debarred_Parties +  
 Patriot_preprocess.Mapping_EU_Terrorist_Org_And_Ind +  
 Patriot_preprocess.Mapping_Export_Admin_Reg_Entity_Licensing +  
 Patriot_preprocess.Mapping_Foreign_Agents_Registration +  
 Patriot_preprocess.Mapping_Innovative_OFAC_Enhanced +  
 Patriot_preprocess.Mapping_Interpol_Most_Wanted +  
 Patriot_preprocess.Mapping_OFAC_PLC_Officials +  
 Patriot_preprocess.Mapping_OFAC_Specially_Designated_Nationals +  
 Patriot_preprocess.Mapping_OSFI_Canada_Entities_of_Concern +  
 Patriot_preprocess.Mapping_State_Dept_Foreign_Terrorist_Orgs +  
 Patriot_preprocess.Mapping_State_Dept_Terrorist_Exclusions +  
 Patriot_preprocess.Mapping_US_Bureau_of_Industry_And_Security_Denied_Persons +  
 Patriot_preprocess.Mapping_Worldbank_Debarred;

all_sources_entity := all_sources(entity_flag = 'Y'); 
sources_to_company_name := all_sources_entity;

all_sources_individual :=  all_sources(entity_flag = '');
sources_to_name_cleaner := all_sources_individual(source <> 'Financial Crimes Enforcement Network Special Alert List');

///////////////************************* process individuals

// sources_to_name_cleaner_name_format_U := 
                 // sources_to_name_cleaner(source in ['European Union Designated Terrorist Individuals',
								                                    // 'US Bureau of Industry and Security - Denied Person List']);
 
// sources_to_name_cleaner_name_format_F := 
                 // sources_to_name_cleaner(source in ['Bank of England Sanctions',
								                                    // 'FBI Fugitives 10 Most Wanted', 
                                                    // 'Interpol Most Wanted',
																				            // 'Interpol Most Wanted - Red Notice',						
																								    // 'Politically Exposed Persons',		
																										// 'US Bureau of Industry and Security - Denied Entity List',
																										// 'United Nations Named Terrorists',
																										// 'World Bank Ineligible Firms']);
																										
// sources_to_name_cleaner_name_format_L := 
                 // sources_to_name_cleaner(source in ['Defense Trade Controls (DTC)Debarred Parties',
								                                    // 'Foreign Agents Registration Act',	
								                                    // 'OFAC - Palestinian Legislative Council',
																										// 'OSFI - Canada Individuals',
								                                    // 'Office of Foreign Asset Control']);
								 
// nid.Mac_CleanFullNames(sources_to_name_cleaner_name_format_U,cleanfullnames_U,orig_pty_name,includeInRepository:=false, normalizeDualNames:=true, _nameorder := 'U', _cleanBiznames := true);
// nid.Mac_CleanFullNames(sources_to_name_cleaner_name_format_F,cleanfullnames_F,orig_pty_name,includeInRepository:=false, normalizeDualNames:=true, _nameorder := 'F', _cleanBiznames := true);
// nid.Mac_CleanFullNames(sources_to_name_cleaner_name_format_L,cleanfullnames_L,orig_pty_name,includeInRepository:=false, normalizeDualNames:=true, _nameorder := 'L', _cleanBiznames := true);

// cleanNameFile := cleanfullnames_U + cleanfullnames_F + cleanfullnames_L : persist('~thor::persist::out::all_source_individual');
 
 
// distinct_nametype := TABLE(cleanNameFile,{nametype, count_1 := count(group)},nametype); 
// distinct_nametype;
 
// Patriot_preprocess.layout_patriot_common trMapCleanName(cleanNameFile l) := TRANSFORM
  // self.title := map(l.nametype = 'P' => l.cln_title,'');
  // self.fname := map(l.nametype = 'P' => l.cln_fname,'');
  // self.mname := map(l.nametype = 'P' => l.cln_mname,'');
  // self.lname := map(l.nametype = 'P' => l.cln_lname,'');
  // self.suffix := map(l.nametype = 'P' => l.cln_suffix,'');
	// self.company_name := map(l.nametype in ['I','B'] => StringLib.StringToUpperCase(l.orig_pty_name), '');
	// self := l;
// end;

// MapCleanName := PROJECT(cleanNameFile,trMapCleanName(left));  
//output(choosen(MapCleanName,500));


layout_add_clean_name := record
Patriot_preprocess.layout_patriot_common; 
//string73 pname_clean; 
end;
 
layout_add_clean_name trMapCleanName(sources_to_name_cleaner l) := TRANSFORM
  
	pname_clean := map(l.source in ['Bank of England Sanctions',
								                'FBI Fugitives 10 Most Wanted',                                 
														    'Interpol Most Wanted - Red Notice',						
														    'Politically Exposed Persons',		
														    'US Bureau of Industry and Security - Denied Entity List',														    
														    'World Bank Ineligible Firms'] => Address.CleanPersonFML73(l.orig_pty_name),	
																
                     l.source in ['Foreign Agents Registration Act',	
								                'OFAC - Palestinian Legislative Council'//,
																//'OSFI - Canada Individuals'
																   ]
								                 =>  Address.CleanPersonLFM73(l.orig_pty_name),

                     //mixed format for these sources:
										 //                   European Union Designated Terrorist Individuals and
								     //                   US Bureau of Industry and Security - Denied Person List
										 //                   Defense Trade Controls (DTC)Debarred Parties,
										 //                   Office of Foreign Asset Control
										 //                   United Nations Named Terrorists,
										 //                   Interpol Most Wanted,
										 //                   OSFI - Canada Individuals
										 STD.Str.Find(l.orig_pty_name,',',1) > 0 =>
															 Address.CleanPersonLFM73(l.orig_pty_name), Address.CleanPersonFML73(l.orig_pty_name));     

  //self.pname_clean := pname_clean;
 	self.title	:= pname_clean[1..5];
	self.fname	:= pname_clean[6..25];
	self.mname	:= pname_clean[26..45];
	self.lname	:= pname_clean[46..65];
	self.suffix	:= pname_clean[66..70];
	self.a_score := pname_clean[71..73];	
	self := l;
end;

MapCleanName := PROJECT(sources_to_name_cleaner,trMapCleanName(left))
                          : persist('~thor::persist::patriot::preprocess::clean_names');  
//output(choosen(MapCleanName,500));

 
//*************************** process company names.       
Patriot_preprocess.layout_patriot_common trMapCompanyName(sources_to_company_name l) := TRANSFORM
self.company_name := StringLib.StringToUpperCase(l.orig_pty_name);
self := l;
end;


MapCompanyName := PROJECT(sources_to_company_name,trMapCompanyName(left));   
//output(choosen(MapCompanyName,500));
 
pre_porcessed_sources := all_sources(source = 'Financial Crimes Enforcement Network Special Alert List'); 
// output(choosen(pre_porcessed_sources,all));

concat_all_sources := MapCleanName + MapCompanyName + pre_porcessed_sources;
//output(concat_all_sources);

a := concat_all_sources(orig_pty_name <> '');

patriot.Layout_Patriot tr_remove_entity_flag(a l) := TRANSFORM
self.cname := StringLib.StringToUpperCase(l.company_name);;
self.pty_key := StringLib.StringToUpperCase(l.pty_key);
//self.source := StringLib.StringToUpperCase(l.source);
self.source := l.source;
self.orig_pty_name := StringLib.StringToUpperCase(l.orig_pty_name);
self.orig_vessel_name := StringLib.StringToUpperCase(l.orig_vessel_name);
self.country := StringLib.StringToUpperCase(l.country);
self.name_type := StringLib.StringToUpperCase(l.name_type);
self.addr_1 := StringLib.StringToUpperCase(l.addr_1);
self.addr_2 := StringLib.StringToUpperCase(l.addr_2);
self.addr_3 := StringLib.StringToUpperCase(l.addr_3);
self.addr_4 := StringLib.StringToUpperCase(l.addr_4);
self.addr_5 := StringLib.StringToUpperCase(l.addr_5);
self.addr_6 := StringLib.StringToUpperCase(l.addr_6);
self.addr_7 := StringLib.StringToUpperCase(l.addr_7);
self.addr_8 := StringLib.StringToUpperCase(l.addr_8);
self.addr_9 := StringLib.StringToUpperCase(l.addr_9);
self.addr_10 := StringLib.StringToUpperCase(l.addr_10);
self.remarks_1 := StringLib.StringToUpperCase(l.remarks_1);
self.remarks_2 := StringLib.StringToUpperCase(l.remarks_2);
self.remarks_3 := StringLib.StringToUpperCase(l.remarks_3);
self.remarks_4 := StringLib.StringToUpperCase(l.remarks_4);
self.remarks_5 := StringLib.StringToUpperCase(l.remarks_5);
self.remarks_6 := StringLib.StringToUpperCase(l.remarks_6);
self.remarks_7 := StringLib.StringToUpperCase(l.remarks_7);
self.remarks_8 := StringLib.StringToUpperCase(l.remarks_8);
self.remarks_9 := StringLib.StringToUpperCase(l.remarks_9);
self.remarks_10 := StringLib.StringToUpperCase(l.remarks_10);
self.remarks_11 := StringLib.StringToUpperCase(l.remarks_11);
self.remarks_12 := StringLib.StringToUpperCase(l.remarks_12);
self.remarks_13 := StringLib.StringToUpperCase(l.remarks_13);
self.remarks_14 := StringLib.StringToUpperCase(l.remarks_14);
self.remarks_15 := StringLib.StringToUpperCase(l.remarks_15);
self.remarks_16 := StringLib.StringToUpperCase(l.remarks_16);
self.remarks_17 := StringLib.StringToUpperCase(l.remarks_17);
self.remarks_18 := StringLib.StringToUpperCase(l.remarks_18);
self.remarks_19 := StringLib.StringToUpperCase(l.remarks_19);
self.remarks_20 := StringLib.StringToUpperCase(l.remarks_20);
self.remarks_21 := StringLib.StringToUpperCase(l.remarks_21);
self.remarks_22 := StringLib.StringToUpperCase(l.remarks_22);
self.remarks_23 := StringLib.StringToUpperCase(l.remarks_23);
self.remarks_24 := StringLib.StringToUpperCase(l.remarks_24);
self.remarks_25 := StringLib.StringToUpperCase(l.remarks_25);
self.remarks_26 := StringLib.StringToUpperCase(l.remarks_26);
self.remarks_27 := StringLib.StringToUpperCase(l.remarks_27);
self.remarks_28 := StringLib.StringToUpperCase(l.remarks_28);
self.remarks_29 := StringLib.StringToUpperCase(l.remarks_29);
self.remarks_30 := StringLib.StringToUpperCase(l.remarks_30);
self := l;
end;

remove_entity_flag := PROJECT(a,tr_remove_entity_flag(left));

addGlobalSID			 := mdr.macGetGlobalSID(remove_entity_flag, 'Patriot', 'source', 'global_sid'); //DF-26190: Populate Global_SID

ds_out := output(addGlobalSID,,'~thor_data400::in::patriot_file_' + filedate,overwrite);

RETURN  ds_out; 

END;
