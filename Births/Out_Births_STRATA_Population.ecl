EXPORT Out_Births_STRATA_Population(pBirths
							        ,pVersion
									,zOut) := MACRO
import STRATA;


	#uniquename(rPopulationStats_Births);
	#uniquename(dPopulationStats_Births);
	#uniquename(zBirths);

// Create the Births record layout
%rPopulationStats_Births%
 :=
  record
    CountGroup                          := count(group);
	didCountNonZero						:= sum(group,if(pBirths.did<>0,1,0));
	did_scoreCountNonZero				:= sum(group,if(pBirths.did_score<>0,1,0));
	orig_name_lastCountNonBlank			:= sum(group,if(pBirths.orig_name_last<>'',1,0));
	orig_name_firstCountNonBlank		:= sum(group,if(pBirths.orig_name_first<>'',1,0));
	orig_name_middleCountNonBlank		:= sum(group,if(pBirths.orig_name_middle<>'',1,0));
	orig_dobCountNonBlank				:= sum(group,if(pBirths.orig_dob<>'',1,0));
	sexCountNonBlank					:= sum(group,if(pBirths.sex<>'',1,0));
	mothers_maidenCountNonBlank			:= sum(group,if(pBirths.mothers_maiden<>'',1,0));
	birth_countyCountNonBlank			:= sum(group,if(pBirths.birth_county<>'',1,0));
	clean_dobCountNonBlank				:= sum(group,if(pBirths.clean_dob<>'',1,0));
	titleCountNonBlank					:= sum(group,if(pBirths.title<>'',1,0));
	fnameCountNonBlank					:= sum(group,if(pBirths.fname<>'',1,0));
	mnameCountNonBlank					:= sum(group,if(pBirths.mname<>'',1,0));
	lnameCountNonBlank					:= sum(group,if(pBirths.lname<>'',1,0));
	name_suffixCountNonBlank			:= sum(group,if(pBirths.name_suffix<>'',1,0));
	name_scoreCountNonBlank				:= sum(group,if(pBirths.name_score<>'',1,0));
	pBirths.st;
  end;

// Create the Births table and run the STRATA statistics
%dPopulationStats_Births% := table(pBirths
							  	    ,%rPopulationStats_Births%
									,st
									,few);
STRATA.createXMLStats(%dPopulationStats_Births%
					 ,'Births Report'
					 ,'Births'
					 ,pVersion
					 ,''
					 ,%zBirths%);
					 
zOut := parallel(%zBirths%);

ENDMACRO;