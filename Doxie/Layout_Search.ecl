// Cloned from 2 interim/internal record layouts in doxie.HeaderFileSearchService.
// Created during the FDN project so the layouts below could be used by both 
// doxie.HeaderFileSearchService and the new doxie.func_FdnCheckSearchRecs.
import AddressFeedback_Services, doxie, PhonesFeedback_Services;

export Layout_Search := MODULE

   export rec_with_Feedback := record
     doxie.Layout_HeaderFileSearch;
     DATASET(PhonesFeedback_Services.Layouts.feedback_report)  Feedback {MAXCOUNT(1)};
     DATASET(PhonesFeedback_Services.Layouts.feedback_report)  Listed_Feedback {MAXCOUNT(1)};
     DATASET(AddressFeedback_Services.Layouts.feedback_report) Address_Feedback;
     doxie.rid_cnt.l_ds; // ds of rids, rid_cnt, src_cnt & src_doc_cnt
     // v--- Added 7 new indicators for the FDN project
     unsigned2 fdn_did_ind   := 0;
     unsigned2 fdn_addr_ind  := 0;
     unsigned2 fdn_ssn_ind   := 0;
     unsigned2 fdn_phone_ind := 0;
	   unsigned2 fdn_listed_phone_ind := 0;
     boolean   fdn_waf_contrib_data    := false;
     boolean   fdn_results_found       := false;
	   boolean   fdn_indicators_returned := false; // Added for bug 196447
   end;

   export rec_with_Feedback_inseq := record
	    unsigned4 in_seq;
			rec_with_Feedback;
	 end;

end;