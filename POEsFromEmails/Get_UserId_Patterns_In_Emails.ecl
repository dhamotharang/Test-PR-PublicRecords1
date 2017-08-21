import Email_Data;

export Get_UserId_Patterns_In_Emails (

	// string						    										pversion
	dataset(Email_Data.Layout_Email.base		)	pEmails		= Email_Data.File_Email_Base
	
) := function

	/*==================================================================================================
		 Get all the emails and output how many there are
	*/
	// The following is a sample of emails from Email_Data.File_Email_Base.
	emails := pEmails(did<>0); // ALL HERZBERG EMAILS EXCEPT THOSE WITH DID=0
	
	//output(count(emails),named('number_of_emails'));
	//==================================================================================================

	/*==================================================================================================
		 Use project to initialize the new record structure, see below, for each 'email' records of the 
		 above dataset of emails. The new field that is initialized is UidPatternTag.

		NEW RECORD. At the end, for each record of the emails data, there will be one record
		, with everything that is in 'emails'. Plus, we will have 1) the frequency of each
		domain, the frequency of each uid pattern tag for each domain, the portion of all
		the userids of a domain that have a give pattern. And, finally, the isPotentialPOE
		will be 'true' of there is a low percentage ofuserids that have NO pattern. Otherwise
		it will be 'false'.
	*/

	EmailWithUidPatternTagAndCountRec := POEsFromEmails.layouts.EmailWithUidPatternTagAndCount;

	EmailWithUidPatternTagAndCountRec setupEmailsWithUidPatternTag( emails r ):= TRANSFORM
		self.Uid_Pattern_Tag			:= POEsFromEmails.setUidPatternTag( r.append_email_username, r.clean_name.fname, r.clean_name.lname);
		self.pname 								:= r.clean_name;
		self.person_addr					:= r.clean_address;
		self.person_addr_geo_lat	:= r.clean_address.geo_lat;
		self.person_addr_geo_long	:= r.clean_address.geo_long;
		self 											:= r;
	END;

	// Make dataset whose records contain only enough information to determine frequency of domains &
	//  frequency of UidPatternTags
	tmp1EmailsWithUidPatternTagAndCount := 
		 dedup(
					 sort(
								distribute(
													 project( emails, setupEmailsWithUidPatternTag(LEFT) )
													 , hash64(clean_email)
								)
								, clean_email,-date_last_seen
								, local
					 )
					 , clean_email
					 , local
		 );
	//output(count(tmp1EmailsWithUidPatternTagAndCount),named('size_of_tmp1EmailsWithUidPatternTagAndCount'));
	//==================================================================================================

	/*==================================================================================================
		 The following counts the number of each uid pattern tag that each domain has.
	*/

	// This table does a local count of each append_domain/UidPatternTag combo
	temptable1a :=
		 table(distribute(tmp1EmailsWithUidPatternTagAndCount,hash64(random()))
					 ,{ email_rec_key, append_domain, Domain_Freq, Uid_Pattern_Tag, integer Uid_Pattern_Freq := count(group)}
					 , append_domain, Uid_Pattern_Tag
					 , local
					);

	// This table SUMs all the local UidPatternFreq for each append_domain/UidPatternTag across all nodes
	temptable1 :=
			table(temptable1a
					 ,{ email_rec_key,append_domain,Domain_Freq,Uid_Pattern_Tag,integer Uid_Pattern_Freq:=sum(group,Uid_Pattern_Freq)}
					 , append_domain, Uid_Pattern_Tag
					 );
	//output(count(temptable1),named('size_of_CountedUidPatternsByDomain'));
	CountedUidPatternsByDomain := temptable1;
	//==================================================================================================

	/*==================================================================================================
		The following counts the number of times each domain occurs.
	*/

	// This table does a local SUM of UidPatternFreq for each append_domain
	temptable2a := 
		 table(distribute(temptable1,hash64(random()))
					 ,{ email_rec_key,append_domain,Uid_Pattern_Freq,Uid_Pattern_Tag,integer Domain_Freq:=sum(group,Uid_Pattern_Freq)}
					 ,append_domain
					 ,local
					);

	// This table SUMs all the local DomainFreq for each append_domain across all nodes
	DomainFrequenciesDS := 
		 table(temptable2a
					 ,{email_rec_key, append_domain, Uid_Pattern_Freq, Uid_Pattern_Tag, integer Domain_Freq := sum(group,Domain_Freq)}
					 ,append_domain
					);
	//output(count(DomainFrequenciesDS),named('size_of_DomainFrequencies'));
	//==================================================================================================

	/*==================================================================================================
		Put domain frequency of DomainFrequenciesDS in each of CountedUidPatternsByDomain's records using JOIN
	*/

	recordof(CountedUidPatternsByDomain) putDomainFreqInCountedUidPatternsByDomain( recordof(CountedUidPatternsByDomain) l, recordof(DomainFrequenciesDS) r ) := TRANSFORM
		 self.Domain_Freq := r.Domain_Freq;
		 self := l;
	END;

	withDomainFreq_CountedUidPatternsByDomain :=
		 join( CountedUidPatternsByDomain, DomainFrequenciesDS
					 ,LEFT.append_domain = RIGHT.append_domain
					 ,putDomainFreqInCountedUidPatternsByDomain( LEFT, RIGHT)
		 );
	//output(count(withDomainFreq_CountedUidPatternsByDomain),named('size_of_withDomainFreq_CountedUidPatternsByDomain'));

	/*==================================================================================================
		Put uid pattern frequency and domain frequency in each of tmp1EmailsWithUidPatternTagAndCount's records, along with calculating
		UidPatternPortion. Use JOIN to do this.
	*/

	EmailWithUidPatternTagAndCountRec putUidPatternFreqInTmp1( recordof(tmp1EmailsWithUidPatternTagAndCount) l, recordof(withDomainFreq_CountedUidPatternsByDomain) r ) := TRANSFORM
		 self.Uid_Pattern_Freq := r.Uid_Pattern_Freq;
		 self.Domain_Freq := r.Domain_Freq;
		 self.Uid_Pattern_Portion := r.Uid_Pattern_Freq/r.Domain_Freq;
		 
		 self := l;
	END;

	join_tmp1EmailsWithUidPatternTagAndCount_and_withDomainFreq_CountedUidPatternsByDomain :=
		 join( distribute(tmp1EmailsWithUidPatternTagAndCount,hash32(append_domain,Uid_Pattern_Tag)), distribute(withDomainFreq_CountedUidPatternsByDomain,hash32(append_domain,Uid_Pattern_Tag))
					 ,(LEFT.append_domain=RIGHT.append_domain) and (LEFT.Uid_Pattern_Tag=RIGHT.Uid_Pattern_Tag)
					 ,putUidPatternFreqInTmp1( LEFT, RIGHT)
					 ,local
		 );
	//output(count(join_tmp1EmailsWithUidPatternTagAndCount_and_withDomainFreq_CountedUidPatternsByDomain),named('size_of_Tmp1WithDomainFreqAndUidPatternFreq'));

	/*==================================================================================================
	 Get potential POEs by 1st distributing by domain name, then sorting by domain name then UidPatternTag.
	 So, the result of this is that the blank UidPatternTags will be 1st for each domain name. Now, we can
	 do a iterate to fill BlankUidPatternPortion for every record.

	 What should work well to get potential POE domain names is to get all records where:
	 
		 BlankUidPatternPortion < 0.34 
		 and remove domain name ending with .EDU.
		 Also, remove any with a domainfreq of 1.
	*/

	tmp2EmailsWithUidPatternTagAndCount := join_tmp1EmailsWithUidPatternTagAndCount_and_withDomainFreq_CountedUidPatternsByDomain;

	BlankUidPatternPortions :=
			dedup(
						sort(distribute(tmp2EmailsWithUidPatternTagAndCount(Uid_Pattern_Tag=''),hash32(append_domain)),append_domain,local)
						, append_domain
						, local
			);

	EmailWithUidPatternTagAndCountRec setBlankUidPatternPortion( recordof(tmp2EmailsWithUidPatternTagAndCount) l, recordof(BlankUidPatternPortions) r ) := TRANSFORM
		 self.Blk_Uid_Pattern_Portion := r.Uid_Pattern_Portion;
		 self := l;
	END;

	EmailUidPatternAndDomainStatistics :=
			join(
					 tmp2EmailsWithUidPatternTagAndCount, BlankUidPatternPortions
					 , LEFT.append_domain=RIGHT.append_domain
					 , setBlankUidPatternPortion(LEFT,RIGHT)
					 , LOOKUP
					 
	 );


	EmailWithUidPatternTagAndCountRec extractPotentialPOEs( EmailWithUidPatternTagAndCountRec r ) := TRANSFORM
		 DomainContainsEDU := StringLib.StringFind(r.append_domain,'.EDU',1);
		 DomainContainsMAIL := StringLib.StringFind(r.append_domain,'MAIL',1);
		 self.Blk_Uid_Pattern_Portion := 
				 IF( (r.Blk_Uid_Pattern_Portion < 0.34) 
						 and ( r.domain_freq > 1 ) 
						 and ( DomainContainsEDU=0 )
						 and ( DomainContainsMAIL=0 )
						 , r.Blk_Uid_Pattern_Portion
						 , skip
				 );
		 self := r;
	END;

	PotentialPOEsEmailUidPatternAndDomainStatistics := 
		 project(EmailUidPatternAndDomainStatistics, extractPotentialPOEs( LEFT )): persist(persistnames().GetUidPatterns);

	//output(count(PotentialPOEsEmailUidPatternAndDomainStatistics),named('size_of_ppoe_found_with_uidpatterns'));
	//output(PotentialPOEsEmailUidPatternAndDomainStatistics, ,'~thor200_144::thumphrey::PotentialPOEsEmailUidPatternAndDomainStatisticsForAllHerzbergEmails',OVERWRITE);
	return PotentialPOEsEmailUidPatternAndDomainStatistics;
end;
