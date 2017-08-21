

// Convert to Dcument record
// Needs to match BWR_Build_Segment_Metadata
import Text_Search,Codes,census_data;

export Convert_Voter_Func(DATASET(VotersV2.Layouts_Voters.Layout_Voters_base_new) inds) := FUNCTION


	
	codesds := codes.File_Codes_V3_In;
	fipsds := census_data.File_Fips2County;
	
	age_cvt_rec := record
		inds;
		typeof(codesds.long_desc) age_category := '';
		typeof(codesds.long_desc) political_party_desc := '';
		typeof(codesds.long_desc)	voter_status_desc := '';
		typeof(codesds.long_desc) gender_desc := '';
		typeof(codesds.long_desc) res_county_desc := '';
		typeof(codesds.long_desc) mail_county_desc := '';
	end;
	
	lookup_macro(myds,myrec,lkpds,retds,filename,fieldname,getval,codeval) := macro
		#uniquename(join_lkp)
		myrec %join_lkp%(myds l,lkpds r) := transform
			self.getval := r.long_desc;
			self := l;
		end;
	
		retds := join(myds,lkpds(file_name = filename,field_name = fieldname), 
								left.codeval = right.code,
									%join_lkp%(left,right),left outer,lookup);
	endmacro;
	
	
	fipstocounty_macro(myds,myrec,lkpds,retds,stname,ctycode,getval) := macro
		#uniquename(join_lkp1)
		myrec %join_lkp1%(myds l,lkpds r) := transform
			self.getval := r.county_name;
			self := l;
		end;
	
		retds := join(myds,lkpds, 
								trim(left.stname) = trim(right.state_code) and 
								intformat((unsigned6)left.ctycode,3,1) = right.county_fips,
									%join_lkp1%(left,right),left outer,lookup);
	endmacro;
	
	
	lookup_macro(inds,age_cvt_rec,codesds,ageds,'EMERGES_HVC','AGECATEGORY',age_category,agecat);
	lookup_macro(ageds,age_cvt_rec,codesds,polds,'EMERGES_HVC','POLITICALPARTY',political_party_desc,political_party);
	lookup_macro(polds,age_cvt_rec,codesds,stds,'EMERGES_HVC','VOTERSTATUS',voter_status_desc,voter_status);
	lookup_macro(stds,age_cvt_rec,codesds,gends,'GENERAL','GENDER',gender_desc,gender);
	fipstocounty_macro(gends,age_cvt_rec,fipsds,resds,res_state,fips_county,res_county_desc);
	fipstocounty_macro(resds,age_cvt_rec,fipsds,ds,mail_state,mail_fips_county,mail_county_desc);
	
	
 Text_Search.Layout_Document cvt(age_cvt_rec l) := TRANSFORM
		SELF.docRef.src := TRANSFER(l.source, INTEGER2);
//		SELF.docRef.doc := (unsigned6)l.vendor_id;
		SELF.docRef.doc := (unsigned6)l.vtid;		
		SELF.segs := DATASET([
			
		{1,0,l.last_name},
		{2,0,l.first_name},
		{3,0,l.middle_name},
		{4,0,l.maiden_prior},
		{5,0,l.first_name+l.middle_name+l.last_name+l.maiden_prior},
		
		
		

		{6,0,l.dob},
		{7,0,l.age_category},

		{8,0,l.place_of_birth},
		{9,0,l.occupation},
		{10,0,l.maiden_name},

		{11,0,l.regDate},

		{12,0,l.gender_desc},
		{13,0,l.political_party_desc},

		{14,0,l.phone},
		{15,0,l.work_phone},
		{16,0,l.other_phone},
		//{17,0,l.phone + '; ' + l.work_phone + '; ' + l.other_phone},

		{18,0,l.voter_status_desc},
		
		//{19,0,l.res_Addr1+' '+l.res_Addr2+' '+l.res_city+' '+l.res_state+' '+l.res_zip},
		//{20,0,l.mail_addr1+' '+l.mail_addr2+' '+l.mail_city+' '+l.mail_state+' '+l.mail_zip},
			
		{21,0,l.res_Addr1+' '+l.res_Addr2+' '+l.res_city+' '+l.res_state+' '+l.res_zip+
			'; '+l.mail_addr1+' '+l.mail_addr2+' '+l.mail_city+' '+l.mail_state+' '+l.mail_zip},
		//{22,0,l.res_city+' '+l.mail_city},
		//{23,0,l.res_state+' '+l.mail_state},
		//{24,0,l.res_zip+' '+l.mail_zip},
		{25,0,l.res_county_desc + ' ' + l.mail_county_desc},


		{26,0,l.spec_dist1},
		{27,0,l.spec_dist2},
		{28,0,l.spec_dist1+'; '+l.spec_dist2},
		{29,0,l.precinct1},
		{30,0,l.precinct2},
		{31,0,l.precinct3},
		{32,0,l.precinct1 + '; '+l.precinct2+'; '+l.precinct3},

		{33,0,l.ward},
	
		/* -- already commented
This all comes out of the history file
		{34,0,l.General2000},
		{35,0,l.PresPrimary2000},
		{36,0,l.Primary2000},
		
		{37,0,l.General2000+'; '+l.PresPrimary2000+'; '+l.Primary2000},

		{38,0,l.Primary2001},
		{39,0,l.General2001},
//		{40,0,l.Special12001},
		{41,0,l.Other2001},
		{42,0,l.Special22001},

		{43,0,l.Primary2001+'; '+l.General2001+'; '+l.Other2001+'; '+l.Special22001},

		{44,0,l.Primary2002},
		{45,0,l.Special12002},
		{46,0,l.Other2002},
		{47,0,l.Special22002},
		{48,0,l.General2002},
		
		{49,0,l.Primary2002+'; '+l.Special12002+'; '+l.Other2002+'; '+l.Special22002+'; '+l.General2002},

		{50,0,l.Primary2003},
		{51,0,l.Special12003},
		{52,0,l.Other2003},
		{53,0,l.Special22003},
		{54,0,l.General2003},

		{55,0,l.Primary2003+'; '+l.Special12003+'; '+l.Other2003+'; '+l.Special22003+'; '+l.General2003},

		{56,0,l.Primary2004},
		{57,0,l.Special12004},
		{58,0,l.Other2004},
		{59,0,l.Special22004},
		{60,0,l.General2004},
		{61,0,l.PresPrimary2004},

		{62,0,l.Primary2004+' '+l.Special12004+'; '+l.Other2004+'; '+l.Special22004+'; '+
				l.General2004+'; '+l.PresPrimary2004},

		{63,0,l.Primary2005},
		{64,0,l.Special12005},
		{65,0,l.Other2005},
		{66,0,l.Special22005},
		{67,0,l.General2005},

		{68,0,l.Primary2005+'; '+l.Special12005+'; '+l.Other2005+'; '+l.Special22005+'; '+l.General2005},

		{69,0,l.Primary2006},
		{70,0,l.Special12006},
		{71,0,l.Other2006},
		{72,0,l.Special22006},
		{73,0,l.General2006},

		{74,0,l.Primary2006+'; '+l.Special12006+'; '+l.Other2006+'; '+l.Special22006+'; '+l.General2006},

		{75,0,l.Primary2007},
		{76,0,l.Special12007},
		{77,0,l.Other2007},
		{78,0,l.Special22007},
		{79,0,l.General2007},

		{80,0,l.Primary2007+'; '+l.Special12007+'; '+l.Other2007+'; '+l.Special22007+'; '+l.General2007},
		
		{81,0,l.PresPrimary2008},
		*/ //-- already commented

		{35,0,l.LastDateVote},
		{36,0,l.ssn}
		], Text_Search.Layout_Segment);
	END;

	reslt := PROJECT(ds, cvt(LEFT));
	
	// transform to normalize this data into layout.DocSeg  see liens
	
	//call to do the normalize
	
	// returned normalized data
	
	
Text_Search.layout_DocSeg flatten(Text_Search.Layout_Document l, Text_Search.Layout_Segment r) 
	:= TRANSFORM
		SELF.docRef := l.docRef;
		SELF := r;
END;
	
norm_vote := NORMALIZE(reslt, left.segs, flatten(LEFT,RIGHT));



// now we do the history data
// join the history file to the data file to get the one key seg we are missing
//


 
votehistory := VotersV2.File_Voters_VoteHistory_base;

hist_dist := sort(distribute(votehistory,vtid),vtid,local);
main_dist := sort(distribute(inds,vtid),vtid,local); // ds was passed in as a parameter								

hist_layout := record
Layout_Voters_VoteHistory;
string7    Source;
end;

hist_layout append_source(Layout_Voters_VoteHistory l,
		VotersV2.Layouts_Voters.Layout_Voters_base_new r) := TRANSFORM
self.source := r.source;
self := l;
end;

//hist_with_source :=	join(hist_dist,main_dist,hist_dist.vtid = main_dist.vtid,append_source(left,right));
//hist_with_source :=	join(hist_dist,main_dist,1 = 1,append_source(left,right));
hist_with_source :=	join(hist_dist,main_dist,left.vtid = right.vtid,append_source(left,right));


/* -- alreade commented
export Layout_Voters_VoteHistory := record
	unsigned6 vtid        := 0;
	string4   voted_year  := '';
	string2   primary     := '';
	string2   special_1   := '';
	string2   other       := '';
	string2   special_2   := '';
	string2   general     := '';
	string2   pres        := '';
	string8   vote_date   := '';  
end;
*/

Text_Search.Layout_Document cvt_history(hist_layout l) := TRANSFORM
		SELF.docRef.src := TRANSFER(l.source, INTEGER2);
		SELF.docRef.doc := (unsigned6)l.vtid;		
		SELF.segs := DATASET([
			
		{34,0,if(l.primary = 'Y','PRIMARY ELECTION '+l.voted_year + ' VOTED','')},
		{34,0,if(l.special_1 = 'Y','SPECIAL 1 ELECTION '+l.voted_year + ' VOTED','')},
		{34,0,if(l.other = 'Y','OTHER ELECTION '+l.voted_year + ' VOTED','')},		
		{34,0,if(l.special_2 = 'Y','SPECIAL 2 ELECTION '+l.voted_year + ' VOTED','')},
		{34,0,if(l.general = 'Y','GENERAL ELECTION '+l.voted_year + ' VOTED','')},	
		{34,0,if(l.pres = 'Y','PRESIDENTIAL ELECTION '+l.voted_year + ' VOTED','')}
		], Text_Search.Layout_Segment);
END;

							


hist_recs := PROJECT(hist_with_source, cvt_history(LEFT));
norm_hist := NORMALIZE(hist_recs, left.segs, flatten(LEFT,RIGHT));
//output(choosen(norm_hist(content <> ''),10000));
dist_all := distribute(norm_vote + norm_hist(content <> ''),hash32(docref.src+docref.doc));

sort_norm_voters := sort(dist_all,docref.src,docref.doc,segment,local);

// populate document id and section
Text_Search.layout_DocSeg Iterate_doc(Text_Search.layout_DocSeg L,Text_Search.layout_DocSeg R) 
	:= Transform
		self.DocRef.doc := r.docref.doc;
												//	if(L.docref.doc = R.docref.doc, L.docref.doc,
												//	if (L.docref.doc = 0,thorlib.node()+1,L.DocRef.doc + thorlib.nodes()));
		self.sect := IF(L.docref.doc<>R.docref.doc OR L.segment<>R.segment, 0, l.sect+1);
		self.docRef.src := r.docRef.src;
		self := R;
end;

iterate_voters := iterate(sort_norm_voters,Iterate_doc(left,right),local);

// External key
	
	Text_Search.layout_DocSeg MakeKeySegs( iterate_voters l, unsigned2 segno ) := TRANSFORM

        self.docref.doc := l.docref.doc;
        self.docref.src := l.docref.src;
		self.segment := segno;
        self.content := intformat(l.docref.doc,15,1);
        self.sect := 1;
    END;

    segkeys := PROJECT(iterate_voters(trim(content) <> '' and trim(content) <> ';'),MakeKeySegs(LEFT,250));

	full_ret := iterate_voters(trim(content) <> '' and trim(content) <> ';') + segkeys;
	
	return full_ret;
	
END;