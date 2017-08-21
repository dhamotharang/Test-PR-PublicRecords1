import risk_indicators, VersionControl, cellphone, Gong, Phonesplus, ut,DayBatchPCNSR, yellowpages;

//Get PCNSR/INFOUSA PHONES FROM PHONE1 FIELDS ***************************************************************************** */

infoUSAd := DayBatchPCNSR.File_PCNSR;

tempLayout := record
string3 npa;
string3 nxx;
string1 tb;
string3 phone3;
string3 npa_2;
string3 nxx_2;
string1 tb_2;
string3 phone3_2;
DayBatchPCNSR.Layout_PCNSR;
end;

tempLayout t_pcnsr(infoUSAd input) := transform
self.npa 		:= input.area_code;
self.nxx 		:= input.phone_number[1..3];
self.tb 		:= input.phone_number[4];
self.phone3		:= input.phone_number[5..7];

self.npa_2 		:= input.phone2_number[1..3];
self.nxx_2 		:= input.phone2_number[4..6];
self.tb_2		:= input.phone2_number[7];
self.phone3_2	:= input.phone2_number[8..10];

self 			:= input;
end;

p_infoUSAd :=  project(infoUSAd, t_pcnsr(left));

	  
f_infoUSA :=p_infoUSAd (npa+nxx+tb+phone3 != '' and length(stringlib.stringfilter(npa+nxx+tb+phone3,'0123456789')) = 10 and 
			tb+phone3 != '0000' and tb+phone3 != '9999');
dist_infoUSA := distribute(f_infoUSA,hash32(npa,nxx,tb,phone3));
s_infoUSA := sort(dist_infoUSA,npa,nxx,tb,phone3,local);

f_infoUSA2 := s_infoUSA(npa_2+nxx_2+tb_2+phone3_2 != '' and length(stringlib.stringfilter(npa_2+nxx_2+tb_2+phone3_2,'0123456789')) = 10 and 
			tb_2+phone3_2 != '0000' and tb_2+phone3_2 != '9999');
f_infoUSA3 :=s_infoUSA (npa_2+nxx_2+tb_2+phone3_2 = '' or length(stringlib.stringfilter(npa_2+nxx_2+tb_2+phone3_2,'0123456789')) != 10 or
			tb_2+phone3_2 = '0000' or tb_2+phone3_2 = '9999');


f_infoUSA2 t_infoUSA(f_infoUSA2 l, unsigned1 cnt) := transform

self.npa := choose(cnt,l.npa,l.npa_2);
self.nxx := choose(cnt,l.nxx,l.nxx_2);
self.tb  := choose(cnt,l.tb,l.tb_2);

self := l;
end;

n_infoUSA1 := normalize(f_infoUSA2, 2, t_infoUSA(left, counter));

all_infoUSA := n_infoUSA1+f_infoUSA3;

DateLastReported                := VersionControl.fGetFilenameVersion('~thor_data400::base::daybatch_pcnsr')[1..6] : stored('DateLastReported');

				
Phonesplus.LayoutCommonOut t_infoUSA1(all_infoUSA input) := transform


CleanCellPhone					:= CellPhone.CleanPhones(input.npa + input.nxx + input.tb + input.phone3);


self.DateVendorFirstReported 	:= 0;
self.DateVendorLastReported 	:= (unsigned3)DateLastReported;
//self.DateVendorLastReported 	:= 200705;
self.DateFirstSeen 				:= if((unsigned3)input.telephone_acquisition_date > 0,
									  (unsigned3)input.telephone_acquisition_date,
									  if((unsigned3)input.refresh_date > 0,
									     (unsigned3)input.refresh_date, 
										 (unsigned3)input.recency_date));
self.DateLastSeen 				:= if((unsigned3)input.recency_date > 0,
									  (unsigned3)input.recency_date,
									  if((unsigned3)input.telephone_acquisition_date > 0,
									     (unsigned3)input.telephone_acquisition_date, 
										 (unsigned3)input.refresh_date));
self.dt_nonglb_last_seen 		:= 0;
self.glb_dppa_flag		 		:= '';
self.ActiveFlag					:= '';
self.CellphoneIDKey             := hashmd5((data)input.npa+(data)input.nxx+(data)input.tb+(data)input.phone3+(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.phone7IDKey             	:= hashmd5((data)input.npa+(data)input.nxx+(data)input.tb+(data)input.zip+(data)input.prim_range+(data)input.prim_name);
self.InitScore					:= 0;
self.ConfidenceScore			:= 0;
self.RecordKey					:= '';
self.Vendor						:= 'PC';
self.SourceFile					:= 'PConsumer';
self.src						:= '';
self.OrigName					:= regexreplace('  +',input.fname_orig + ' ' + input.mname_orig + ' ' + input.lname_orig, ' ');
self.NameFormat	            	:= 'F';
self.Address1 					:= regexreplace('  +',input.prim_range + ' ' + input.predir + ' ' + input.prim_name, ' ');
self.Address2 					:= regexreplace('  +',input.name_suffix + ' ' + input.postdir + ' ' + input.unit_desig, ' ');
self.Address3 					:= '';
self.OrigCity 					:= input.p_city_name;
self.OrigState 					:= input.st;
self.OrigZip 					:= input.zip + input.zip4;
self.CellPhone 					:= CleanCellPhone;

self.ListingType		 		:= '';
self.PublishCode		 		:= '';
self.state						:= input.st;
self.zip5						:= input.zip;
self.zip4						:= input.zip4;
self.ace_fips_st				:= input.rec_type;
self.ace_fips_county			:= input.county;
self.did_score					:= (string3)input.did_score;

//temp use to test area code change
self.OrigTitle					:= CleanCellPhone[..3];

self 							:= input;

end;


p_infousa1 := project(all_infoUSA, t_infoUSA1(left));

p_infousa1_dedp := dedup(
			       sort(distribute(p_infousa1(CellPhone != ''),hash32(Cellphone)),
				   Cellphone,DateFirstSeen,local),
				   Cellphone,right,local);

//Apply Area Code Change
ut.mac_phone_areacode_corrections(p_infousa1_dedp, p_infousa1_areacode, Cellphone);


export map_PCNSR_asPhonesplus := p_infousa1_areacode 
						      : PERSIST('~thor400_30::persist::Phonesplus::map_PCNSR_asPhonesplus');