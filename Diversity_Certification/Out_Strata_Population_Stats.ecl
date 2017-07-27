import STRATA;
export  Out_Strata_Population_Stats(String pVersion) := function

rPopulationStats_diverCert_build:=record
		files().KeyBuildSF.State;    	// field to group by
   CountGroup                   						:= count(group);						
   bdid_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.	bdid <>0,1,0));
   did_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.did <>0,1,0));
   dt_first_seen_CountNonBlank							:=sum(group,if(files().KeyBuildSF.dt_first_seen <>'',1,0));
   dt_last_seen_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.dt_last_seen <>'',1,0));
   dt_vendor_first_reported_CountNonBlank	  :=sum(group,if(files().KeyBuildSF.dt_vendor_first_reported <>'',1,0));
   dt_vendor_last_reported_CountNonBlank		:=sum(group,if(files().KeyBuildSF.dt_vendor_last_reported <>'',1,0));
   dartid_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.dartid <>'',1,0));
   dateadded_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.dateadded <>'',1,0));
   dateupdated_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.dateupdated <>'',1,0));
   website_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.website <>'',1,0));
   profilelastupdated_CountNonBlank				  :=sum(group,if(files().KeyBuildSF.profilelastupdated <>'',1,0));
   county_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.county <>'',1,0));
   servicearea_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.servicearea <>'',1,0));
   region1_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.region1 <>'',1,0));
   region2_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.region2 <>'',1,0));
   region3_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.region3 <>'',1,0));
   region4_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.region4 <>'',1,0));
   region5_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.region5 <>'',1,0));
   fname_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.fname <>'',1,0));
   lname_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.lname <>'',1,0));
   mname_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.mname <>'',1,0));
   suffix_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.suffix <>'',1,0));
   title_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.title <>'',1,0));
   ethnicity_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.ethnicity <>'',1,0));
   gender_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.gender <>'',1,0));
   address1_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.address1 <>'',1,0));
   address2_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.address2 <>'',1,0));
   addresscity_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.addresscity <>'',1,0));
   addressstate_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.addressstate <>'',1,0));
   addresszipcode_CountNonBlank							:=sum(group,if(files().KeyBuildSF.addresszipcode <>'',1,0));
   addresszip4_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.addresszip4 <>'',1,0));
   building_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.building <>'',1,0));
   contact_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.contact <>'',1,0));
   phone1_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.phone1 <>'',1,0));
   phone2_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.phone2 <>'',1,0));
   phone3_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.phone3 <>'',1,0));
   cell_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.cell <>'',1,0));
   fax_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.fax <>'',1,0));
   email1_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.email1 <>'',1,0));
   email2_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.email2 <>'',1,0));
   email3_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.email3 <>'',1,0));
   webpage1_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.webpage1 <>'',1,0));
   webpage2_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.webpage2 <>'',1,0));
   webpage3_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.webpage3 <>'',1,0));
   businessname_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.businessname <>'',1,0));
   dba_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.dba <>'',1,0));
   businessid_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.businessid <>'',1,0));
   businesstype1_CountNonBlank							:=sum(group,if(files().KeyBuildSF.businesstype1 <>'',1,0));
   businesslocation1_CountNonBlank					:=sum(group,if(files().KeyBuildSF.businesslocation1 <>'',1,0));
   businesstype2_CountNonBlank							:=sum(group,if(files().KeyBuildSF.businesstype2 <>'',1,0));
   businesslocation2_CountNonBlank					:=sum(group,if(files().KeyBuildSF.businesslocation2 <>'',1,0));
   businesstype3_CountNonBlank							:=sum(group,if(files().KeyBuildSF.businesstype3 <>'',1,0));
   businesslocation3_CountNonBlank					:=sum(group,if(files().KeyBuildSF.businesslocation3 <>'',1,0));
   businesstype4_CountNonBlank							:=sum(group,if(files().KeyBuildSF.businesstype4 <>'',1,0));
   businesslocation4_CountNonBlank					:=sum(group,if(files().KeyBuildSF.businesslocation4 <>'',1,0));
   businesstype5_CountNonBlank							:=sum(group,if(files().KeyBuildSF.businesstype5 <>'',1,0));
   businesslocation5_CountNonBlank					:=sum(group,if(files().KeyBuildSF.businesslocation5 <>'',1,0));
   industry_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.industry <>'',1,0));
   trade_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.trade <>'',1,0));
   resourcedescription_CountNonBlank				:=sum(group,if(files().KeyBuildSF.resourcedescription <>'',1,0));
   natureofbusiness_CountNonBlank						:=sum(group,if(files().KeyBuildSF.natureofbusiness <>'',1,0));
   businessdescription_CountNonBlank				:=sum(group,if(files().KeyBuildSF.businessdescription <>'',1,0));
   businessstructure_CountNonBlank					:=sum(group,if(files().KeyBuildSF.businessstructure <>'',1,0));
   totalemployees_CountNonBlank							:=sum(group,if(files().KeyBuildSF.totalemployees <>'',1,0));
   avgcontractsize_CountNonBlank						:=sum(group,if(files().KeyBuildSF.avgcontractsize <>'',1,0));
   firmid_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.firmid <>'',1,0));
   firmlocationaddress_CountNonBlank				:=sum(group,if(files().KeyBuildSF.firmlocationaddress <>'',1,0));
   firmlocationaddresscity_CountNonBlank		:=sum(group,if(files().KeyBuildSF.firmlocationaddresscity <>'',1,0));
   firmlocationaddresszip4_CountNonBlank		:=sum(group,if(files().KeyBuildSF.firmlocationaddresszip4 <>'',1,0));
   firmlocationaddresszipcode_CountNonBlank	:=sum(group,if(files().KeyBuildSF.firmlocationaddresszipcode <>'',1,0));
   firmlocationcounty_CountNonBlank					:=sum(group,if(files().KeyBuildSF.firmlocationcounty <>'',1,0));
   firmlocationstate_CountNonBlank					:=sum(group,if(files().KeyBuildSF.firmlocationstate <>'',1,0));
   certfed_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.certfed <>'',1,0));
   certstate_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.certstate <>'',1,0));
   contractsfederal_CountNonBlank						:=sum(group,if(files().KeyBuildSF.contractsfederal <>'',1,0));
   contractsva_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.contractsva <>'',1,0));
   contractscommercial_CountNonBlank				:=sum(group,if(files().KeyBuildSF.contractscommercial <>'',1,0));
   contractorgovernmentprime_CountNonBlank	:=sum(group,if(files().KeyBuildSF.contractorgovernmentprime <>'',1,0));
   contractorgovernmentsub_CountNonBlank		:=sum(group,if(files().KeyBuildSF.contractorgovernmentsub <>'',1,0));
   contractornongovernment_CountNonBlank		:=sum(group,if(files().KeyBuildSF.contractornongovernment <>'',1,0));
   registeredgovernmentbus_CountNonBlank		:=sum(group,if(files().KeyBuildSF.registeredgovernmentbus <>'',1,0));
   registerednongovernmentbus_CountNonBlank	:=sum(group,if(files().KeyBuildSF.registerednongovernmentbus <>'',1,0));
   clearancelevelpersonnel_CountNonBlank		:=sum(group,if(files().KeyBuildSF.clearancelevelpersonnel <>'',1,0));
   clearancelevelfacility_CountNonBlank			:=sum(group,if(files().KeyBuildSF.clearancelevelfacility <>'',1,0));
   certificatedatefrom1_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificatedatefrom1 <>'',1,0));
   certificatedateto1_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatedateto1 <>'',1,0));
   certificatestatus1_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatestatus1 <>'',1,0));
   certificationnumber1_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificationnumber1 <>'',1,0));
   certificationtype1_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificationtype1 <>'',1,0));
   certificatedatefrom2_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificatedatefrom2 <>'',1,0));
   certificatedateto2_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatedateto2 <>'',1,0));
   certificatestatus2_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatestatus2 <>'',1,0));
   certificationnumber2_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificationnumber2 <>'',1,0));
   certificationtype2_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificationtype2 <>'',1,0));
   certificatedatefrom3_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificatedatefrom3 <>'',1,0));
   certificatedateto3_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatedateto3 <>'',1,0));
   certificatestatus3_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatestatus3 <>'',1,0));
   certificationnumber3_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificationnumber3 <>'',1,0));
   certificationtype3_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificationtype3 <>'',1,0));
   certificatedatefrom4_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificatedatefrom4 <>'',1,0));
   certificatedateto4_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatedateto4 <>'',1,0));
   certificatestatus4_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatestatus4 <>'',1,0));
   certificationnumber4_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificationnumber4 <>'',1,0));
   certificationtype4_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificationtype4 <>'',1,0));
   certificatedatefrom5_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificatedatefrom5 <>'',1,0));
   certificatedateto5_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatedateto5 <>'',1,0));
   certificatestatus5_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatestatus5 <>'',1,0));
   certificationnumber5_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificationnumber5 <>'',1,0));
   certificationtype5_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificationtype5 <>'',1,0));
   certificatedatefrom6_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificatedatefrom6 <>'',1,0));
   certificatedateto6_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatedateto6 <>'',1,0));
   certificatestatus6_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificatestatus6 <>'',1,0));
   certificationnumber6_CountNonBlank				:=sum(group,if(files().KeyBuildSF.certificationnumber6 <>'',1,0));
   certificationtype6_CountNonBlank					:=sum(group,if(files().KeyBuildSF.certificationtype6 <>'',1,0));
   starrating_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.starrating <>'',1,0));
   assets_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.assets <>'',1,0));
   biddescription_CountNonBlank							:=sum(group,if(files().KeyBuildSF.biddescription <>'',1,0));
   competitiveadvantage_CountNonBlank				:=sum(group,if(files().KeyBuildSF.competitiveadvantage <>'',1,0));
   cagecode_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.cagecode <>'',1,0));
   capabilitiesnarrative_CountNonBlank			:=sum(group,if(files().KeyBuildSF.capabilitiesnarrative <>'',1,0));
   category_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.category <>'',1,0));
   chtrclass_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.chtrclass <>'',1,0));
   productdescription1_CountNonBlank				:=sum(group,if(files().KeyBuildSF.productdescription1 <>'',1,0));
   productdescription2_CountNonBlank				:=sum(group,if(files().KeyBuildSF.productdescription2 <>'',1,0));
   productdescription3_CountNonBlank				:=sum(group,if(files().KeyBuildSF.productdescription3 <>'',1,0));
   productdescription4_CountNonBlank				:=sum(group,if(files().KeyBuildSF.productdescription4 <>'',1,0));
   productdescription5_CountNonBlank				:=sum(group,if(files().KeyBuildSF.productdescription5 <>'',1,0));
   classdescription1_CountNonBlank					:=sum(group,if(files().KeyBuildSF.classdescription1 <>'',1,0));
   subclassdescription1_CountNonBlank				:=sum(group,if(files().KeyBuildSF.subclassdescription1 <>'',1,0));
   classdescription2_CountNonBlank					:=sum(group,if(files().KeyBuildSF.classdescription2 <>'',1,0));
   subclassdescription2_CountNonBlank				:=sum(group,if(files().KeyBuildSF.subclassdescription2 <>'',1,0));
   classdescription3_CountNonBlank					:=sum(group,if(files().KeyBuildSF.classdescription3 <>'',1,0));
   subclassdescription3_CountNonBlank				:=sum(group,if(files().KeyBuildSF.subclassdescription3 <>'',1,0));
   classdescription4_CountNonBlank					:=sum(group,if(files().KeyBuildSF.classdescription4 <>'',1,0));
   subclassdescription4_CountNonBlank				:=sum(group,if(files().KeyBuildSF.subclassdescription4 <>'',1,0));
   classdescription5_CountNonBlank					:=sum(group,if(files().KeyBuildSF.classdescription5 <>'',1,0));
   subclassdescription5_CountNonBlank				:=sum(group,if(files().KeyBuildSF.subclassdescription5 <>'',1,0));
   classifications_CountNonBlank						:=sum(group,if(files().KeyBuildSF.classifications <>'',1,0));
   commodity1_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity1 <>'',1,0));
   commodity2_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity2 <>'',1,0));
   commodity3_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity3 <>'',1,0));
   commodity4_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity4 <>'',1,0));
   commodity5_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity5 <>'',1,0));
   commodity6_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity6 <>'',1,0));
   commodity7_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity7 <>'',1,0));
   commodity8_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.commodity8 <>'',1,0));
   completedate_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.completedate <>'',1,0));
   crossreference_CountNonBlank							:=sum(group,if(files().KeyBuildSF.crossreference <>'',1,0));
   dateestablished_CountNonBlank						:=sum(group,if(files().KeyBuildSF.dateestablished <>'',1,0));
   businessage_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.businessage <>'',1,0));
   deposits_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.deposits <>'',1,0));
   dunsnumber_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.dunsnumber <>'',1,0));
   enttype_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.enttype <>'',1,0));
   expirationdate_CountNonBlank							:=sum(group,if(files().KeyBuildSF.expirationdate <>'',1,0));
   extendeddate_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.extendeddate <>'',1,0));
   issuingauthority_CountNonBlank						:=sum(group,if(files().KeyBuildSF.issuingauthority <>'',1,0));
   keywords_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.keywords <>'',1,0));
   licensenumber_CountNonBlank							:=sum(group,if(files().KeyBuildSF.licensenumber <>'',1,0));
   licensetype_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.licensetype <>'',1,0));
   mincd_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.mincd <>'',1,0));
   minorityaffiliation_CountNonBlank			  :=sum(group,if(files().KeyBuildSF.minorityaffiliation <>'',1,0));
   minorityownershipdate_CountNonBlank			:=sum(group,if(files().KeyBuildSF.minorityownershipdate <>'',1,0));
   siccode1_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode1 <>'',1,0));
   siccode2_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode2 <>'',1,0));
   siccode3_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode3 <>'',1,0));
   siccode4_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode4 <>'',1,0));
   siccode5_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode5 <>'',1,0));
   siccode6_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode6 <>'',1,0));
   siccode7_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode7 <>'',1,0));
   siccode8_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.siccode8 <>'',1,0));
   naicscode1_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode1 <>'',1,0));
   naicscode2_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode2 <>'',1,0));
   naicscode3_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode3 <>'',1,0));
   naicscode4_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode4 <>'',1,0));
   naicscode5_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode5 <>'',1,0));
   naicscode6_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode6 <>'',1,0));
   naicscode7_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode7 <>'',1,0));
   naicscode8_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.naicscode8 <>'',1,0));
   prequalify_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.prequalify <>'',1,0));
   procurementcategory1_CountNonBlank				:=sum(group,if(files().KeyBuildSF.procurementcategory1 <>'',1,0));
   subprocurementcategory1_CountNonBlank		:=sum(group,if(files().KeyBuildSF.subprocurementcategory1 <>'',1,0));
   procurementcategory2_CountNonBlank				:=sum(group,if(files().KeyBuildSF.procurementcategory2 <>'',1,0));
   subprocurementcategory2_CountNonBlank		:=sum(group,if(files().KeyBuildSF.subprocurementcategory2 <>'',1,0));
   procurementcategory3_CountNonBlank				:=sum(group,if(files().KeyBuildSF.procurementcategory3 <>'',1,0));
   subprocurementcategory3_CountNonBlank		:=sum(group,if(files().KeyBuildSF.subprocurementcategory3 <>'',1,0));
   procurementcategory4_CountNonBlank				:=sum(group,if(files().KeyBuildSF.procurementcategory4 <>'',1,0));
   subprocurementcategory4_CountNonBlank		:=sum(group,if(files().KeyBuildSF.subprocurementcategory4 <>'',1,0));
   procurementcategory5_CountNonBlank				:=sum(group,if(files().KeyBuildSF.procurementcategory5 <>'',1,0));
   subprocurementcategory5_CountNonBlank		:=sum(group,if(files().KeyBuildSF.subprocurementcategory5 <>'',1,0));
   renewal_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.renewal <>'',1,0));
   renewaldate_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.renewaldate <>'',1,0));
   unitedcertprogrampartner_CountNonBlank		:=sum(group,if(files().KeyBuildSF.unitedcertprogrampartner <>'',1,0));
   vendorkey_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.vendorkey <>'',1,0));
   vendornumber_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.vendornumber <>'',1,0));
   workcode1_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode1 <>'',1,0));
   workcode2_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode2 <>'',1,0));
   workcode3_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode3 <>'',1,0));
   workcode4_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode4 <>'',1,0));
   workcode5_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode5 <>'',1,0));
   workcode6_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode6 <>'',1,0));
   workcode7_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode7 <>'',1,0));
   workcode8_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.workcode8 <>'',1,0));
   exporter_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.exporter <>'',1,0));
   exportbusinessactivities_CountNonBlank	  :=sum(group,if(files().KeyBuildSF.exportbusinessactivities <>'',1,0));
   exportto_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.exportto <>'',1,0));
   exportbusinessrelationships_CountNonBlank:=sum(group,if(files().KeyBuildSF.exportbusinessrelationships <>'',1,0));
   exportobjectives_CountNonBlank						:=sum(group,if(files().KeyBuildSF.exportobjectives <>'',1,0));
   reference1_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.reference1 <>'',1,0));
   reference2_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.reference2 <>'',1,0));
   reference3_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.reference3 <>'',1,0));
   unique_id_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.unique_id <>0,1,0));
   append_prep_mailaddress1_CountNonBlank	  :=sum(group,if(files().KeyBuildSF.	 append_prep_mailaddress1 <>'',1,0));
   append_prep_mailaddresslast_CountNonBlank:=sum(group,if(files().KeyBuildSF.	 append_prep_mailaddresslast <>'',1,0));
   append_mailrawaid_CountNonBlank					:=sum(group,if(files().KeyBuildSF.append_mailrawaid <>0,1,0));
   append_prep_phyaddress1_CountNonBlank		:=sum(group,if(files().KeyBuildSF.	 append_prep_phyaddress1 <>'',1,0));
   append_prep_phyaddresslast_CountNonBlank	:=sum(group,if(files().KeyBuildSF.	 append_prep_phyaddresslast <>'',1,0));
   append_phyrawaid_CountNonBlank						:=sum(group,if(files().KeyBuildSF.append_phyrawaid <>0,1,0));
   phone_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.phone <>'',1,0));
   email_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.email <>'',1,0));
   m_prim_range_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.	 m_prim_range <>'',1,0));
   m_predir_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.m_predir <>'',1,0));
   m_prim_name_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.	 m_prim_name <>'',1,0));
   m_addr_suffix_CountNonBlank							:=sum(group,if(files().KeyBuildSF.m_addr_suffix <>'',1,0));
   m_postdir_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.m_postdir <>'',1,0));
   m_unit_desig_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.	 m_unit_desig <>'',1,0));
   m_sec_range_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.m_sec_range <>'',1,0));
   m_p_city_name_CountNonBlank							:=sum(group,if(files().KeyBuildSF.m_p_city_name <>'',1,0));
   m_v_city_name_CountNonBlank							:=sum(group,if(files().KeyBuildSF.m_v_city_name <>'',1,0));
   m_st_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.m_st <>'',1,0));
   m_zip_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.m_zip <>'',1,0));
   m_zip4_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.m_zip4 <>'',1,0));
   m_cart_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.m_cart <>'',1,0));
   m_cr_sort_sz_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.m_cr_sort_sz <>'',1,0));
   m_lot_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.m_lot <>'',1,0));
   m_lot_order_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.m_lot_order <>'',1,0));
   m_dbpc_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.m_dbpc <>'',1,0));
   m_chk_digit_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.m_chk_digit <>'',1,0));
   m_rec_type_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.m_rec_type <>'',1,0));
   m_fips_state_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.m_fips_state <>'',1,0));
   m_fips_county_CountNonBlank							:=sum(group,if(files().KeyBuildSF.m_fips_county <>'',1,0));
   m_geo_lat_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.m_geo_lat <>'',1,0));
   m_geo_long_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.m_geo_long <>'',1,0));
   m_msa_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.m_msa <>'',1,0));
   m_geo_blk_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.m_geo_blk <>'',1,0));
   m_geo_match_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.m_geo_match <>'',1,0));
   m_err_stat_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.m_err_stat <>'',1,0));
   p_prim_range_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_prim_range <>'',1,0));
   p_predir_CountNonBlank								    :=sum(group,if(files().KeyBuildSF.p_predir <>'',1,0));
   p_prim_name_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_prim_name <>'',1,0));
   p_addr_suffix_CountNonBlank							:=sum(group,if(files().KeyBuildSF.p_addr_suffix <>'',1,0));
   p_postdir_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.p_postdir <>'',1,0));
   p_unit_desig_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_unit_desig <>'',1,0));
   p_sec_range_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_sec_range <>'',1,0));
   p_p_city_name_CountNonBlank							:=sum(group,if(files().KeyBuildSF.p_p_city_name <>'',1,0));
   p_v_city_name_CountNonBlank							:=sum(group,if(files().KeyBuildSF.p_v_city_name <>'',1,0));
   p_st_CountNonBlank									      :=sum(group,if(files().KeyBuildSF.p_st <>'',1,0));
   p_zip_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.p_zip <>'',1,0));
   p_zip4_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.p_zip4 <>'',1,0));
   p_cart_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.p_cart <>'',1,0));
   p_cr_sort_sz_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_cr_sort_sz <>'',1,0));
   p_lot_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.p_lot <>'',1,0));
   p_lot_order_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_lot_order <>'',1,0));
   p_dbpc_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.p_dbpc <>'',1,0));
   p_chk_digit_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_chk_digit <>'',1,0));
   p_rec_type_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.p_rec_type <>'',1,0));
   p_fips_state_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_fips_state <>'',1,0));
   p_fips_county_CountNonBlank							:=sum(group,if(files().KeyBuildSF.p_fips_county <>'',1,0));
   p_geo_lat_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.p_geo_lat <>'',1,0));
   p_geo_long_CountNonBlank							  	:=sum(group,if(files().KeyBuildSF.p_geo_long <>'',1,0));
   p_msa_CountNonBlank									    :=sum(group,if(files().KeyBuildSF.p_msa <>'',1,0));
   p_geo_blk_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.p_geo_blk <>'',1,0));
   p_geo_match_CountNonBlank							  :=sum(group,if(files().KeyBuildSF.p_geo_match <>'',1,0));
   p_err_stat_CountNonBlank								  :=sum(group,if(files().KeyBuildSF.p_err_stat <>'',1,0));
//BIPV2 fields have been added for Strata
  DotID_CountNonZeros	                 			:= sum(group,if(files().KeyBuildSF.DotID<>0,1,0));
  DotScore_CountNonZeros	               	  := sum(group,if(files().KeyBuildSF.DotScore<>0,1,0));
  DotWeight_CountNonZeros	             			:= sum(group,if(files().KeyBuildSF.DotWeight<>0,1,0));
  EmpID_CountNonZeros	                   		:= sum(group,if(files().KeyBuildSF.EmpID<>0,1,0));
  EmpScore_CountNonZeros	             			:= sum(group,if(files().KeyBuildSF.EmpScore<>0,1,0));
  EmpWeight_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.EmpWeight<>0,1,0));
  POWID_CountNonZeros	                      := sum(group,if(files().KeyBuildSF.POWID<>0,1,0));
  POWScore_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.POWScore<>0,1,0));
  POWWeight_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.POWWeight<>0,1,0));
  ProxID_CountNonZeros	                    := sum(group,if(files().KeyBuildSF.ProxID<>0,1,0));
  ProxScore_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.ProxScore<>0,1,0));
  ProxWeight_CountNonZeros	                := sum(group,if(files().KeyBuildSF.ProxWeight<>0,1,0));
	SeleID_CountNonZeros	                    := sum(group,if(files().KeyBuildSF.SeleID<>0,1,0));
  SeleScore_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.SeleScore<>0,1,0));
  SeleWeight_CountNonZeros	                := sum(group,if(files().KeyBuildSF.SeleWeight<>0,1,0));
  OrgID_CountNonZeros	                      := sum(group,if(files().KeyBuildSF.OrgID<>0,1,0));
  OrgScore_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.OrgScore<>0,1,0));
  OrgWeight_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.OrgWeight<>0,1,0));
  UltID_CountNonZeros	                      := sum(group,if(files().KeyBuildSF.UltID<>0,1,0));
  UltScore_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.UltScore<>0,1,0));
  UltWeight_CountNonZeros	                  := sum(group,if(files().KeyBuildSF.UltWeight<>0,1,0));
  
end;
  

dPopulationStats_diverCert_build := table(Files().KeybuildSF,
										   rPopulationStats_diverCert_build,
										   few
									      );

STRATA.createXMLStats(dPopulationStats_diverCert_build,
                     _Dataset().name,
                    'Diversity_Cert_Base',
                    pVersion,
                    '',
                    resultsOut,
                    'view',
                  'population'
                    );
					 
 return resultsOut;
 
 end;