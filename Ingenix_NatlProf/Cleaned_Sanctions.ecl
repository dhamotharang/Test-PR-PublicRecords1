import Address;
d := Ingenix_NatlProf.File_in_SanctionedProviders(trim(stringlib.stringtouppercase(sanc_cntry),left,right)='USA');
d_dist := distribute(d,hash(SANC_LNME,SANC_FNME,SANC_MID_I_NM));

d_sort := sort(d_dist,SANC_LNME,SANC_FNME,SANC_MID_I_NM,local);

string address_filter(string addressfield) := StringLib.stringfilter(addressfield, '0123456789');

Ingenix_NatlProf.Layout_in_Cleaned_Sanctions tfm(d InputRecord) := transform

self.sanc_busnme := stringlib.StringToUpperCase(InputRecord.sanc_busnme);
string   clean_sanc_zip := address_filter(InputRecord.sanc_zip);
string73 tempProvName := 
	stringlib.StringToUpperCase(if(trim(InputRecord.sanc_fnme,left,right) <> '' or trim(InputRecord.sanc_lnme,left,right) <> '',
	   Address.CleanPersonlfm73(trim(InputRecord.sanc_lnme,left,right)+', '+ trim(InputRecord.sanc_fnme,left,right)+' '+trim(InputRecord.sanc_mid_i_nm,left,right)) ,									
	'')
	);

	self.Prov_Clean_title						:= tempProvName[1..5]			;
	self.Prov_Clean_fname						:= tempProvName[6..25]			;
	self.Prov_Clean_mname						:= tempProvName[26..45]			;
	self.Prov_Clean_lname						:= tempProvName[46..65]			;
	self.Prov_Clean_name_suffix	   				:= tempProvName[66..70]			;
	self.Prov_Clean_cleaning_score				:= tempProvName[71..73]			;

string182 temProvCoAddressReturn 				:= stringlib.StringToUpperCase(
													if((InputRecord.sanc_street <> '' or
													   InputRecord.sanc_city	<> '' or
													   InputRecord.sanc_state   <> '' or
													   clean_sanc_zip	    <> '' or
													   InputRecord.sanc_cntry   <> '' )
													   ,
													   (Address.CleanAddress182(trim(InputRecord.sanc_street,left,right),(trim(InputRecord.sanc_city,left,right)+', '+trim(InputRecord.sanc_state,left,right)+' '+trim(clean_sanc_zip,left,right))))
													   ,''
													   )
													   );							 
self.sanc_zip := clean_sanc_zip;
self.ProvCo_Address_Clean_prim_range 			:= 		temProvCoAddressReturn[1..10]				;
self.ProvCo_Address_Clean_predir     			:=		temProvCoAddressReturn[11..12]				;
self.ProvCo_Address_Clean_prim_name				:= 		temProvCoAddressReturn[13..40]				;
self.ProvCo_Address_Clean_addr_suffix			:= 		temProvCoAddressReturn[41..44]				;
self.ProvCo_Address_Clean_postdir				:=		temProvCoAddressReturn[45..46]				;
self.ProvCo_Address_Clean_unit_desig			:= 		temProvCoAddressReturn[47..56]				;
self.ProvCo_Address_Clean_sec_range				:= 		temProvCoAddressReturn[57..64]				;
self.ProvCo_Address_Clean_p_city_name			:= 		temProvCoAddressReturn[65..89]				;
self.ProvCo_Address_Clean_v_city_name			:= 		temProvCoAddressReturn[90..114]				;
self.ProvCo_Address_Clean_st					:= 		temProvCoAddressReturn[115..116]			;
self.ProvCo_Address_Clean_zip					:=		temProvCoAddressReturn[117..121]			;
self.ProvCo_Address_Clean_zip4					:=		temProvCoAddressReturn[122..125]			;
self.ProvCo_Address_Clean_cart					:=		temProvCoAddressReturn[126..129]			;
self.ProvCo_Address_Clean_cr_sort_sz			:=		temProvCoAddressReturn[130]					;
self.ProvCo_Address_Clean_lot					:=		temProvCoAddressReturn[131..134]			;
self.ProvCo_Address_Clean_lot_order				:=		temProvCoAddressReturn[135]					;
self.ProvCo_Address_Clean_dpbc					:=		temProvCoAddressReturn[136..137]			;
self.ProvCo_Address_Clean_chk_digit				:=		temProvCoAddressReturn[138]					;
self.ProvCo_Address_Clean_record_type			:=		temProvCoAddressReturn[139..140]			;
self.ProvCo_Address_Clean_ace_fips_st			:=		temProvCoAddressReturn[141..142]			;
self.ProvCo_Address_Clean_fipscounty			:=		temProvCoAddressReturn[143..145]			;
self.ProvCo_Address_Clean_geo_lat				:=		temProvCoAddressReturn[146..155]			;
self.ProvCo_Address_Clean_geo_long				:=		temProvCoAddressReturn[156..166]			;
self.ProvCo_Address_Clean_msa					:=		temProvCoAddressReturn[167..170]			;
self.ProvCo_Address_Clean_geo_match				:=		temProvCoAddressReturn[178]					;
self.ProvCo_Address_Clean_err_stat				:=		temProvCoAddressReturn[179..182]			;
string2 sanc_mm_cov(string pInput)                            :=      map( pInput[4..6] = 'JAN' => '01',
                                                                           pInput[4..6] = 'FEB' => '02',
					                                                       pInput[4..6] = 'MAR' => '03',
					                                                       pInput[4..6] = 'APR' => '04',
					                                                       pInput[4..6] = 'MAY' => '05',
					                                                       pInput[4..6] = 'JUN' => '06',
					                                                       pInput[4..6] = 'JUL' => '07',
					                                                       pInput[4..6] = 'AUG' => '08',
					                                                       pInput[4..6] = 'SEP' => '09',
					                                                       pInput[4..6] = 'OCT' => '10',
					                                                       pInput[4..6] = 'NOV' => '11','12');
					                                                             
string2 SANC_DOB_dd								:=      if(regexfind('[A-Z]',inputrecord.sanc_dob) = true,inputrecord.sanc_dob[1..2],inputrecord.sanc_dob[4..5]);

string2 SANC_DOB_mm								:=     if(regexfind('[A-Z]',inputrecord.sanc_dob) = true,sanc_mm_cov(inputrecord.sanc_dob),inputrecord.SANC_DOB[1..2]);

string4 SANC_DOB_yyyy								:=		map(length(inputrecord.sanc_dob) = 10 => inputrecord.sanc_dob[7..10],
                                                               length(inputrecord.sanc_dob) = 8 => '19'+inputrecord.sanc_dob[7..8],'19'+inputrecord.sanc_dob[8..9]);

self.sanc_dob									:= if(trim(stringlib.stringtouppercase(inputrecord.sanc_dob),left,right)='','',sanc_dob_yyyy+sanc_dob_mm+sanc_dob_dd);
self.processdate		:= InputRecord.process_date;

self := InputRecord;
end;


export Cleaned_Sanctions := Project(d,tfm(left)):persist('~thor_data400::persist::Ingenix_Cleaned_Sanctions');