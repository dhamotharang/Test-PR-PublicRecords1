import Gong, CellPhone, header, Risk_Indicators,ut,did_add,header_slimsort,watchdog, Business_Header, Business_Header_SS, Yellowpages;

Phonesplus.proc_asPhonesplus ('targus', dTargus);
Phonesplus.proc_asPhonesplus ('cellphones', dCellphones);
Phonesplus.proc_asPhonesplus ('intrado', dIntrado);
Phonesplus.proc_asPhonesplus ('gongh', dGongH );
Phonesplus.proc_asPhonesplus ('header', dHeaders);
Phonesplus.proc_asPhonesplus ('pcnsr', dPCNSR);
Phonesplus.proc_asPhonesplus ('infutor', dInfutor);
Phonesplus.proc_asPhonesplus ('infutorcid', dInfutorcid);

ppCandidate := dCellphones
               + dIntrado
			   + dGongH
			   + dHeaders
			   + dPCNSR
			   + dInfutor
			   + dInfutorcid
			  // + dPaw
			   + dedup(dTargus(cellphone[8..10] != 'XXX'),cellphoneidkey,all);
			   
s_ppcandidate := sort(distribute(ppCandidate,hash(Phone7IDKey)),Phone7IDKey,local);

//Check for Targus nonpub matches (add additional Points)
nonPubs := dedup(sort(distribute(dTargus(cellphone[8..10] = 'XXX'),hash(Phone7IDKey)),Phone7IDKey,local),Phone7IDKey,local);
		

s_ppcandidate t_nonPubs(s_ppcandidate L ,nonPubs R) := transform
self.TargusMatch := map(R.Phone7IDKey = L.Phone7IDKey and L.vendor <> 'WP' => 6,L.TargusMatch);

self := L; 
end;

TargusMatch	:= join(s_ppcandidate,nonPubs,
				left.Phone7IDKey = right.Phone7IDKey,

			    t_nonPubs(left,right),left outer,local); 
s_TargusMatch  := sort(distribute(TargusMatch,hash(CellPhone)),CellPhone,local);

/* ************************************************************************************************** */
//Check Neustar for Ported Phones (add additional Points)
Neustar := dedup(sort(distribute(CellPhone.fileNeuStar,hash(CellPhone)),CellPhone,local),CellPhone,local);
		

s_TargusMatch t_Neustar(s_TargusMatch L ,Neustar R) := transform
self.PortMatch :=  map(R.CellPhone !='' => 10,L.PortMatch);
									

self := L;
end;

neustarPorts	:= join(s_TargusMatch,Neustar,
				left.CellPhone = right.CellPhone,

			    t_Neustar(left,right),left outer,local); 
s_neustarPorts  := sort(distribute(neustarPorts,hash(CellPhoneIDKey)),CellPhoneIDKey,lname,fname, local);

/* ************************************************************************************************** */
layout_lnamelookup := record
s_neustarPorts.CellphoneIDKey;
s_neustarPorts.lname;

total := count(group);

end;

lnameScore := table(s_neustarPorts,layout_lnamelookup,CellphoneIDKey,lname,local);
s_lnameScore := sort(distribute(lnameScore(total>1),hash(CellPhoneIDKey)),CellphoneIDKey,lname,local);


Phonesplus.layoutCommonOut t_lname(s_neustarPorts L ,s_lnameScore R) := transform
self.LnameMatch := if(R.CellPhoneIDKey = L.CellPhoneIDKey AND L.src <> 'TS' AND L.vendor <> 'IF',2,L.LnameMatch);
self := L;
end;					

j_lnameScore := join(s_neustarPorts,s_lnameScore,
						left.CellphoneIDKey = right.CellphoneIDKey and
						left.lname = right.lname,
						t_lname(left,right),left outer,local);

/* ************************************************************************************************** */
layout_lfnamelookup := record
j_lnameScore.CellphoneIDKey;
j_lnameScore.lname;
j_lnameScore.fname;

total := count(group);

end;

lfnameScore := table(j_lnameScore,layout_lfnamelookup,CellphoneIDKey,lname,fname,few);
s_lfnameScore := sort(distribute(lfnameScore(total>1),hash(CellPhoneIDKey)),CellphoneIDKey,lname,fname,local);


j_lnameScore t_lfname(j_lnameScore L ,s_lfnameScore R) := transform
self.FnameMatch := if(R.CellPhoneIDKey = L.CellPhoneIDKey AND L.src <> 'TS' AND L.vendor <> 'IF',2,L.FnameMatch);
self := L;
end;

j_lfnameScore := join(j_lnameScore,s_lfnameScore,
						left.CellphoneIDKey = right.CellphoneIDKey and 
						left.lname = right.lname and 
						left.fname = right.fname,
						t_lfname(left,right),left outer,local);

/* ************************************************************************************************** */

layout_InitScorelookup := record
j_lfnameScore.CellphoneIDKey;
totScore := sum(group,j_lfnameScore.InitScore);
totLScore := sum(group,j_lfnameScore.LnameMatch);
totLFScore := sum(group,j_lfnameScore.FnameMatch);
totTDSScore := max(group,j_lfnameScore.TDSMatch);
totPortScore := max(group,j_lfnameScore.PortMatch);
totTargusScore := max(group,j_lfnameScore.TargusMatch);

end;

score := table(j_lfnameScore,layout_InitScorelookup,CellPhoneIDKey,few);
s_score := sort(distribute(score,hash(CellPhoneIDKey)),CellphoneIDKey,local);


j_lfnameScore t_score(j_lfnameScore L ,s_score R) := transform
self.ConfidenceScore := if(R.CellPhoneIDKey = L.CellPhoneIDKey,
						   R.totScore + R.totLScore + R.totLFScore + R.totTDSScore +R.totPortScore +R.totTargusScore,
						   L.ConfidenceScore);
						  
self := L;
end;					

j_Score := join(j_lfnameScore,s_score,
						left.CellphoneIDKey = right.CellphoneIDKey,
						t_score(left,right),left outer,local);

/* ************************************************************************************************** */

layout_rollScorelookup := record
j_Score.CellphoneIDKey;
rollScore := max(group,j_Score.ConfidenceScore);

end;

rScore := table(j_Score,layout_rollScorelookup,CellPhoneIDKey,few);
s_rScore := sort(distribute(rScore,hash(CellPhoneIDKey)),CellphoneIDKey,local);


j_Score t_rScore(j_Score L ,s_rScore R) := transform
self.ConfidenceScore := if(R.CellPhoneIDKey = L.CellPhoneIDKey,R.rollScore,L.ConfidenceScore);

self := L;
end;					

j_rScore := join(j_Score,s_rScore,
						left.CellphoneIDKey = right.CellphoneIDKey,
						t_rScore(left,right),left outer,local);

/* ************************************************************************************************** */
j_rScore t_recs(dTargus L, j_rScore R) := transform
self.Initscore := 0;
self.ConfidenceScore := if(R.CellPhoneIdKey = L.CellPhoneIdKey,R.ConfidenceScore, L.ConfidenceScore);
self := L;
end;

addlRecs := join(dTargus(cellphone[8..10] != 'XXX'),j_rScore(vendor='WP'),
			left.cellphoneidkey = right.cellphoneidkey,                         

			t_recs(left,right),left only,hash) : persist('~thor_data400::persist::Phonesplus::proc_phonesplusBase::targus_addl_recs_test');
			
			
allRecsAdd := j_rScore+addlRecs;

/* *****Add 10 points to records neverseen*********************************************************** */
Phonesplus.layoutCommonOut t_upscore_neverseen(allRecsAdd le) := transform
	self.confidencescore := if(le.keycode = '2' and le.vendor = 'IC' and le.InitScoreType = Phonesplus.codes.neverseen_type,
							   11,
							   if(le.InitScoreType = Phonesplus.codes.neverseen_type and (string)le.DateLastSeen[..4] > phonesplus.codes.yr_threshold,
							   le.confidencescore + phonesplus.codes.neverseen_score,
							   le.confidencescore));
							   
	self := le;
end;

allRecs := project(allRecsAdd, t_upscore_neverseen(left));
/* *****Add 11 points to the overall confidence score for non-pub numbers**** */
nonpub:= project(allRecs(PublishCode = 'N'), 
				 transform(Phonesplus.layoutCommonOut, 
				self.ConfidenceScore := left.ConfidenceScore + Phonesplus.Codes.nonpub_score,
				self := left));

/* *****Eliminate records where a non-pub number is assigned to another individual**** */
pub   := allRecs(PublishCode <> 'N');
pub_d   := distribute(pub, hash(cellphone));
nonpub_d:= distribute(nonpub, hash(cellphone));

Phonesplus.layoutCommonOut t_del_diff_phone_nonpub(pub_d L, nonpub_d R) := transform
	self := L;
end;

pub_all := join(pub_d, nonpub_d,
				  ((left.did 	    <> right.did and
				  left.prim_range + left.prim_name + left.zip5 <> right.prim_range + right.prim_name + right.zip5 and
				    left.lname <> right.lname) or
				  (left.did =0  and right.did  = 0 and
				  left.prim_range + left.prim_name + left.zip5 <> right.prim_range + right.prim_name + right.zip5 and
				  left.lname <> right.lname))and 
			      left.cellphone  = right.cellphone,
				t_del_diff_phone_nonpub(left, right), left only, local);


allPhRecs := pub_all + nonpub;

export proc_phonesplusBase := output(allPhRecs,,'~thor_data400::out::phonesplus_did_' + Phonesplus.version,overwrite,__compressed__);