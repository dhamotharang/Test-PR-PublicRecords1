//replace with_did w/ this version when you want to run without ADL2
import ut,watchdog;

export With_Did := 
MODULE

//***** FILES I NEED
shared head_full  := Header_Joined;
shared wfb := watchdog.File_Best;


//***** DID RULES AND DODGY
export mod_pass1 :=	header.Fn_WithDID(head_full, wfb, '_1', includeOutsideMatches := true);
shared pass1 := 		mod_pass1.result;
shared dodgies0 := header.Mod_DodgyDids(pass1).result;
export dodgies  := dodgies0 : persist('persist::dodgy_dids');
shared for2 := 			header.Fn_ApplyDodgyDIDs(pass1, dodgies);
export mod_pass2 :=	header.Fn_WithDID(for2,	wfb, '_2', includeOutsideMatches := false);
pass2 := 						mod_pass2.result: persist('persist::with_did_mid');


//****** GENERATE AND APPLY MORE DID RULES FROM ENTROPY MATCH
header.EntropyMatch(pass2,entropy_matches,entropy_nonmatches)
Header.MAC_ApplyDid1(pass2,DID,entropy_matches,veryoutfile)

veryoutfile mark_amb(veryoutfile le, entropy_nonmatches ri) :=
TRANSFORM
	SELF.jflag2 := IF(ri.old_rid<>0,'A','');
	SELF := le;
END;
amb_marked := JOIN(veryoutfile,entropy_nonmatches,LEFT.did=RIGHT.old_rid,mark_amb(LEFT,RIGHT),LEFT OUTER,HASH);

//****** GENERATE AND SEND OUT SAMPLES FOR REVIEW
rules  := mod_pass1.DR1 + mod_pass2.DR1 + entropy_matches;
review := Header.mod_MatchSamples(head_full, rules, dodgies).DoAll;

//****** STATS
stats := 
	parallel(
		ut.fn_AddStat(count(entropy_nonmatches),'Build Stats: Entropy Records Flagged Ambiguous'),
		ut.fn_AddStat(count(entropy_matches),	'Build Stats: Data Subset (Entropy) Matches')
	);


//****** EXPORT THE DATASET AND KICK OFF REVIEW AND STATS
amb_marked_persist := amb_marked : persist('With_Did');
export result := amb_marked_persist : success(parallel(review,stats));

END;