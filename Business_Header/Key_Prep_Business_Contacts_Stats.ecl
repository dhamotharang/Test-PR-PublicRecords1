IMPORT Data_Services, PRTE2_Business_Header;

#IF (PRTE2_Business_Header.constants.PRTE_BUILD) #WARNING(PRTE2_Business_Header.constants.PRTE_BUILD_WARN_MSG);
stats_base := PRTE2_Business_Header.File_Prep_Bus_Contacts_Stats_Plus;
#ELSE
stats_base := File_Prep_Business_Contacts_Stats_Plus;
#END;

layout_contact_stat := RECORD
	stats_base.__filepos;  // This is the filepos in the contacts file
	stats_base.bdid_per_addr;
	stats_base.apts;
	stats_base.ppl;
	stats_base.r_phone_per_addr;
	stats_base.b_phone_per_addr;
	stats_base.dnb_emps;
	stats_base.irs5500_emps;
	stats_base.domainss;
	stats_base.sources;
	stats_base.company_name_score;
	stats_base.combined_score;
  stats_base.has_gong_yp;
	stats_base.eq_emp_match;
	stats_base.current_corp;
	stats_base.global_sid;
	stats_base.record_sid;
	stats_base.__thisfilepos;  // This is the filepos in the stats file
END;


EXPORT Key_Prep_Business_Contacts_Stats := INDEX(
	stats_base,
	layout_contact_stat,
	'~thor_data400::key::business_contacts_stat' + thorlib.wuid());