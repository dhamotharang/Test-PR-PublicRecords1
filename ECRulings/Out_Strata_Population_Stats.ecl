
import STRATA;

export  Out_Strata_Population_Stats(String pVersion) := function

rPopulationStats_ECRulings_build	 :=record
		Files().Base.qa.state;			// field to group by
   CountGroup                        := count(group);
   dartid_CountNonBlank         	 :=sum(group,if(Files().Base.qa.dartid	 <>'',1,0));
   dateadded_CountNonBlank           :=sum(group,if(Files().Base.qa.dateadded	 <>'',1,0));
   dateupdated_CountNonBlank         :=sum(group,if(Files().Base.qa.dateupdated	 <>'',1,0));
   website_CountNonBlank             :=sum(group,if(Files().Base.qa.website	 <>'',1,0));
   euid_CountNonBlank         		 :=sum(group,if(Files().Base.qa.euid	 <>'',1,0));
   policyarea_CountNonBlank          :=sum(group,if(Files().Base.qa.policyarea	 <>'',1,0));
   casenumber_CountNonBlank          :=sum(group,if(Files().Base.qa.casenumber	 <>'',1,0));
   memberstate_CountNonBlank         :=sum(group,if(Files().Base.qa.memberstate	 <>'',1,0));
   lastdecisiondate_CountNonBlank    :=sum(group,if(Files().Base.qa.lastdecisiondate	 <>'',1,0));
   title_CountNonBlank         		 :=sum(group,if(Files().Base.qa.title	 <>'',1,0));
   businessname_CountNonBlank        :=sum(group,if(Files().Base.qa.businessname	 <>'',1,0));
   region_CountNonBlank         	 :=sum(group,if(Files().Base.qa.region	 <>'',1,0));
   primaryobjective_CountNonBlank    :=sum(group,if(Files().Base.qa.primaryobjective	 <>'',1,0));
   aidinstrument_CountNonBlank       :=sum(group,if(Files().Base.qa.aidinstrument	 <>'',1,0));
   casetype_CountNonBlank         	 :=sum(group,if(Files().Base.qa.casetype	 <>'',1,0));
   durationdatefrom_CountNonBlank    :=sum(group,if(Files().Base.qa.durationdatefrom	 <>'',1,0));
   durationdateto_CountNonBlank      :=sum(group,if(Files().Base.qa.durationdateto	 <>'',1,0));
   notificationregistrationdate_CountNonBlank:=sum(group,if(Files().Base.qa.notificationregistrationdate	 <>'',1,0));
   dgresponsible_CountNonBlank         		:=sum(group,if(Files().Base.qa.dgresponsible	 <>'',1,0));
   relatedcasenumber1_CountNonBlank         :=sum(group,if(Files().Base.qa.relatedcasenumber1	 <>'',1,0));
   relatedcaseinformation1_CountNonBlank    :=sum(group,if(Files().Base.qa.relatedcaseinformation1	 <>'',1,0));
   relatedcasenumber2_CountNonBlank         :=sum(group,if(Files().Base.qa.relatedcasenumber2	 <>'',1,0));
   relatedcaseinformation2_CountNonBlank    :=sum(group,if(Files().Base.qa.relatedcaseinformation2	 <>'',1,0));
   relatedcasenumber3_CountNonBlank         :=sum(group,if(Files().Base.qa.relatedcasenumber3	 <>'',1,0));
   relatedcaseinformation3_CountNonBlank    :=sum(group,if(Files().Base.qa.relatedcaseinformation3	 <>'',1,0));
   relatedcasenumber4_CountNonBlank         :=sum(group,if(Files().Base.qa.relatedcasenumber4	 <>'',1,0));
   relatedcaseinformation4_CountNonBlank    :=sum(group,if(Files().Base.qa.relatedcaseinformation4	 <>'',1,0));
   relatedcasenumber5_CountNonBlank         :=sum(group,if(Files().Base.qa.relatedcasenumber5	 <>'',1,0));
   relatedcaseinformation5_CountNonBlank    :=sum(group,if(Files().Base.qa.relatedcaseinformation5	 <>'',1,0));
   provisionaldeadlinedate_CountNonBlank    :=sum(group,if(Files().Base.qa.provisionaldeadlinedate	 <>'',1,0));
   provisionaldeadlinearticle_CountNonBlank :=sum(group,if(Files().Base.qa.provisionaldeadlinearticle	 <>'',1,0));
   provisionaldeadlinestatus_CountNonBlank  :=sum(group,if(Files().Base.qa.provisionaldeadlinestatus	 <>'',1,0));
   regulation_CountNonBlank         		:=sum(group,if(Files().Base.qa.regulation	 <>'',1,0));
   relatedlink_CountNonBlank        		:=sum(group,if(Files().Base.qa.relatedlink	 <>'',1,0));
   decpubid_CountNonBlank         			:=sum(group,if(Files().Base.qa.decpubid	 <>'',1,0));
   decisiondate_CountNonBlank         		:=sum(group,if(Files().Base.qa.decisiondate	 <>'',1,0));
   decisionarticle_CountNonBlank         	:=sum(group,if(Files().Base.qa.decisionarticle	 <>'',1,0));
   decisiondetails_CountNonBlank         	:=sum(group,if(Files().Base.qa.decisiondetails	 <>'',1,0));
   pressrelease_CountNonBlank         		:=sum(group,if(Files().Base.qa.pressrelease	 <>'',1,0));
   pressreleasedate_CountNonBlank         	:=sum(group,if(Files().Base.qa.pressreleasedate	 <>'',1,0));
   publicationjournaldate_CountNonBlank    	:=sum(group,if(Files().Base.qa.publicationjournaldate	 <>'',1,0));
   publicationjournal_CountNonBlank         :=sum(group,if(Files().Base.qa.publicationjournal	 <>'',1,0));
   publicationjournaledition_CountNonBlank  :=sum(group,if(Files().Base.qa.publicationjournaledition	 <>'',1,0));
   publicationjournalyear_CountNonBlank     :=sum(group,if(Files().Base.qa.publicationjournalyear	 <>'',1,0));
   publicationpriorjournal_CountNonBlank    :=sum(group,if(Files().Base.qa.publicationpriorjournal	 <>'',1,0));
   publicationpriorjournaldate_CountNonBlank:=sum(group,if(Files().Base.qa.publicationpriorjournaldate	 <>'',1,0));
   econactid_CountNonBlank         			:=sum(group,if(Files().Base.qa.econactid	 <>'',1,0));
   economicactivity_CountNonBlank         	:=sum(group,if(Files().Base.qa.economicactivity	 <>'',1,0));
   compeventid_CountNonBlank         		:=sum(group,if(Files().Base.qa.compeventid	 <>'',1,0));
   eventdate_CountNonBlank         			:=sum(group,if(Files().Base.qa.eventdate	 <>'',1,0));
   eventdoctype_CountNonBlank         		:=sum(group,if(Files().Base.qa.eventdoctype	 <>'',1,0));
   eventdocument_CountNonBlank         		:=sum(group,if(Files().Base.qa.eventdocument	 <>'',1,0));
   did_CountNonBlank         				:=sum(group,if(Files().Base.qa.did	 <>0,1,0));
   bdid_CountNonBlank         				:=sum(group,if(Files().Base.qa.bdid	 <>0,1,0));
   dt_vendor_first_reported_CountNonBlank   :=sum(group,if(Files().Base.qa.dt_vendor_first_reported	 <>'',1,0));
   dt_vendor_last_reported_CountNonBlank    :=sum(group,if(Files().Base.qa.dt_vendor_last_reported	 <>'',1,0));
   dt_first_seen_CountNonBlank         		:=sum(group,if(Files().Base.qa.dt_first_seen	 <>'',1,0));
   dt_last_seen_CountNonBlank         		:=sum(group,if(Files().Base.qa.dt_last_seen	 <>'',1,0));
   eu_country_code_CountNonBlank         	:=sum(group,if(Files().Base.qa.eu_country_code	 <>'',1,0));


		  end;


dPopulationStats_ECRulings_build := table(Files().Base.qa,
										   rPopulationStats_ECRulings_build,
										   few
									      );

STRATA.createXMLStats(dPopulationStats_ECRulings_build,
                       _Dataset().name,
					  'data',
					  pVersion,
					  '',
					  resultsOut,
					  'view',
					  'population'
					 );
					 
 return resultsOut;
 
 end;