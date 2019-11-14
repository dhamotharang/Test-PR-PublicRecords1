// formerly was a part of doxie.layout_central_records
import doxie, doxie_crs, iesp; 

recshrr := doxie_crs.layout_HRI_SSN;
recdear := doxie_crs.layout_deathfile_records;
recbesr := doxie_crs.layout_best_information;
recssnr := doxie_crs.layout_ssn_records;
recaddr := doxie.Layout_Comp_Addr_Utility_Recs;
recresr := doxie_crs.layout_Resident_Links;
recnamr := doxie_crs.layout_comp_names;
recphor := doxie_crs.layout_phone_records;
recPhOld:= doxie_crs.Layout_Phones_Old;
recsslr := doxie_crs.layout_SSN_Lookups;
recrelr := doxie_crs.layout_relative_summary;
recnbrr := doxie_crs.layout_Historic_Nbr_Summary;
recnbrr2:= doxie.layout_nbr_records_slim;
recnbhr := doxie_crs.layout_Comp_NBrHds;
recfdnr := iesp.frauddefensenetwork.t_FDNSearchRecord; // Added for FDN project
recsupp := doxie_crs.layout_best_supplemental_info;

export layout_central_header := record, maxlength (doxie_crs.maxlength_report)
  dataset(recbesr) best_information_children;
  dataset(recsupp) best_supplemental_info_children;
  dataset(recssnr) ssn_children;
  dataset(recshrr) hri_ssn_children;
  dataset(recdear) deathfile_children;
  dataset(recaddr) addresses_children;
  dataset(recresr) resident_links_children;
  dataset(recnamr) names_children;
  dataset(recphor) phones_children;
  dataset(recphOld) phones_old_children;
  dataset(recsslr) ssn_lookups_children;
  dataset(recrelr) relative_summary_children;
  dataset(recrelr) associate_summary_children;
  dataset(recnbrr) nbrs_summary_children;
  dataset(recnbrr2) nbrs_summary2_children;
  dataset(recnbhr) nbrhoods_children;
  dataset(recfdnr) fdn_children {xpath('FDNRecords/FDNRecord')}; //xpath needed by ESP when iesp layouts used // Added for FDN project

  // these are auxiliary datasets to be used for fetching single-source data in central records
  dataset(doxie.layout_nameDID) subject_names;
  dataset(doxie.layout_comp_addresses) subject_addresses;
  doxie.layout_exceptions errors;
end;
