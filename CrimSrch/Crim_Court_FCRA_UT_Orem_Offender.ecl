import Crim_common, ArrestLogs, Address,census_data;

infile := crimSrch.File_UT_Orem_ForFCRAOnly(trim(state,left,right)<>'AL');

Crim_Common.Layout_Moxie_Crim_Offender2 tFCRA_Offender(infile input) := transform
  
	string8 fSlashedMDYtoCYMD(string pDateIn) 
	  := intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
		 + intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
		 + intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);
 
		    self.process_date			:= CrimSrch.Version.Development;
			self.offender_key			:= '99'+input.report_id+fSlashedMDYtoCYMD(input.filed_date); 
			self.vendor					:= '99'; 
			self.state_origin			:= input.state; 
			self.data_type				:= '2'; 
			self.source_file			:= 'FCRA_UT_Orem'; 
			self.case_number			:= '';
			self.case_court				:= input.court; 
			self.case_name				:= ''; 
			self.case_type				:= ''; 
			self.case_type_desc			:= ''; 
			self.case_filing_dt			:= if(fSlashedMDYtoCYMD(regexreplace('12:00:00 AM',input.filed_date,''))[1..8] < Crim_Common.Version_Development
											and fSlashedMDYtoCYMD(input.filed_date)[1..2] in ['19','20'],
											fSlashedMDYtoCYMD(regexreplace('12:00:00 AM',input.filed_date,'')),''); 
			self.pty_nm					:= regexreplace('[0-9]+|'+'\\.|'+'/|'+'`|'+'[^A-Z\\- ]',trim(stringlib.stringtouppercase(input.i_name_last),left,right),'')+', '
											+regexreplace('[0-9]+|'+'\\.|'+'/|'+'`|'+'[^A-Z\\- ]',trim(stringlib.stringtouppercase(input.i_name_first),left,right),'')+' '
											+regexreplace('[0-9]+|'+'\\.|'+'/|'+'`|'+'[^A-Z\\- ]',trim(stringlib.stringtouppercase(input.i_name_middle),left,right),''); 
			self.pty_nm_fmt				:= 'L'; 
			self.orig_lname				:= regexreplace('[0-9]+|'+'\\.|'+'/|'+'`|'+'[^A-Z\\- ]',trim(stringlib.stringtouppercase(input.i_name_last),left,right),''); 
			self.orig_fname				:= regexreplace('[0-9]+|'+'\\.|'+'/|'+'`|'+'[^A-Z\\- ]',trim(stringlib.stringtouppercase(input.i_name_first),left,right),'');  
			self.orig_mname				:= regexreplace('[0-9]+|'+'\\.|'+'/|'+'`|'+'[^A-Z\\- ]',trim(stringlib.stringtouppercase(input.i_name_middle),left,right),''); 
			self.orig_name_suffix		:= ''; 
			self.pty_typ				:= '0'; 
			self.nitro_flag				:= ''; 
			self.orig_ssn				:= ''; 
			self.dle_num				:= ''; 
			self.fbi_num				:= ''; 
			self.doc_num				:= ''; 
			self.ins_num				:= ''; 
			self.id_num					:= ''; 
			self.dl_num					:= ''; 
			self.dl_state				:= ''; 
			self.citizenship			:= ''; 
			self.dob					:= if(fSlashedMDYtoCYMD(regexreplace('12:00:00 AM',input.birth_date,''))[1..4] between '1916' and '1989',
											fSlashedMDYtoCYMD(regexreplace('12:00:00 AM',input.birth_date,'')),
											'');	
			self.dob_alias				:= ''; 
			self.place_of_birth			:= ''; 
			self.street_address_1		:= ''; 
			self.street_address_2		:= ''; 
			self.street_address_3		:= ''; 
			self.street_address_4		:= ''; 
			self.street_address_5		:= ''; 
			self.race					:= ''; 
			self.race_desc				:= ''; 
			self.sex					:= ''; 
			self.hair_color				:= ''; 
			self.hair_color_desc		:= ''; 
			self.eye_color				:= ''; 
			self.eye_color_desc			:= ''; 
			self.skin_color				:= ''; 
			self.skin_color_desc		:= ''; 
			self.height					:= ''; 
			self.weight					:= ''; 
			self.party_status			:= ''; 
			self.party_status_desc		:= ''; 
			self.prim_range				:= ''; 
			self.predir					:= ''; 
			self.prim_name				:= ''; 
			self.addr_suffix			:= ''; 
			self.postdir				:= ''; 
			self.unit_desig				:= ''; 
			self.sec_range				:= ''; 
			self.p_city_name			:= ''; 
			self.v_city_name			:= ''; 
			self.state					:= ''; 
			self.zip5					:= ''; 
			self.zip4					:= ''; 
			self.cart					:= ''; 
			self.cr_sort_sz				:= ''; 
			self.lot					:= ''; 
			self.lot_order				:= ''; 
			self.dpbc					:= ''; 
			self.chk_digit				:= ''; 
			self.rec_type				:= ''; 
			self.ace_fips_st			:= ''; 
			self.ace_fips_county		:= ''; 
			self.geo_lat				:= ''; 
			self.geo_long				:= ''; 
			self.msa					:= ''; 
			self.geo_blk				:= ''; 
			self.geo_match				:= ''; 
			self.err_stat				:= ''; 
			self.title					:= ''; 
			self.fname					:= ''; 
			self.mname					:= ''; 
			self.lname					:= ''; 
			self.name_suffix			:= ''; 
			self.cleaning_score			:= ''; 
			self.ssn					:= '';
			self.did					:= '';
			self.pgid					:= '';
			self := input;
end;

pInFile := project(infile, tFCRA_Offender(left));

CrimSrch.FCRA_Clean(pInFile,cleanFCRA_Offender);

d := cleanFCRA_Offender;
fips := Census_Data.File_Fips2County;

d trecs(d L ) := transform
self.case_court := stringlib.StringToUpperCase(L.case_court);
self            := L;
end;

p_recs := project(d,trecs(left));

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

p_recs trecs1(p_recs L ,fips R) := transform

self.case_court := map(R.county_name <> '' 
					   and L.state_origin = R.state_code 
					   and regexfind(trim(R.county_name),stringlib.StringToUpperCase(L.case_court)) => 
					       R.county_name,'');
self := L;
end;


outfile := join(p_recs,fips,
			right.county_name <> '' and 
			left.state_origin = right.state_code and
			regexfind(trim(right.county_name),left.case_court),
			trecs1(left,right), lookup);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// layout := record
// string state_origin;
// string case_court;	
// string total;	
// string translation;
// end;

// orem_NonMatches := dataset('~thor_200::in::fcra::orem_nonmatch.csv',layout,csv(terminator('\r\n'), separator(',')));

// outfile trecs2(outfile L ,orem_NonMatches R) := transform
// self.case_court := map(R.case_court <> '' and
					   // L.state_origin = R.state_origin and 
				       // L.case_court = R.case_court  => R.translation, '');
// self := L;
// end;


// out2 := join(outfile,orem_NonMatches,
			// right.case_court <> '' and 
			// right.case_court = left.case_court and 
			// left.state_origin = right.state_origin,
			// trecs2(left,right), lookup);
				
//output(out2,,'~thor_data400::out::fcra_orem',overwrite);
//combined := outfile+out2;

//export Crim_Court_FCRA_UT_Orem_Offender := dedup(sort(distribute(combined,hash(offender_key)),
export Crim_Court_FCRA_UT_Orem_Offender := dedup(sort(distribute(outfile,hash(offender_key)),
										case_number,orig_lname,orig_fname,orig_mname,case_filing_dt,local)
										,case_number,orig_lname,orig_fname,local,right): 
										PERSIST('~thor_dell400::persist::persist::Crim_Court_FCRA_UT_orem_Offender');