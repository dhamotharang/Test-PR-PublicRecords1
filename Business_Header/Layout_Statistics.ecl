export Layout_Statistics :=
module

	export addressbdid :=
	record
		string		address;
		unsigned8 countBdids;
	end;

	export layout_source_percent :=
	record
		string	source;
		real		percentage;
	end;

	export layout_source_count :=
	record
		string		source;
		unsigned8	countGroup;
	end;

	export bh_out :=
	record
		unsigned8 countGroup																											;
		set of string setSources	                                                ;
		unsigned8 countNewRecords                                                 ;
		unsigned8 countUniqueBdids                                                ;
		unsigned8 countNewUniqueBdids                                             ;
		real			countAverageRecordsPerBdid                                      ;
		unsigned8 countMaxRecordsPerBdid                                          ;
		unsigned8 countMinRecordsPerBdid                                          ;
		real			countAverageBdidsPerAddress                                     ;
		dataset(addressbdid)	top5AddressesWithMostBdids                          ;
		unsigned8 countRecordsWithoutAddressPerSource                             ;
		dataset(layout_source_percent)	PercentageRecordsWithoutAddressPerSource  ;
		unsigned8 countBdidsWithoutAddress                                        ;
		unsigned8 countBdidsWithoutAddressPhoneFein                               ;
		dataset(layout_source_count) countRecordsPerSource                        ;
		dataset(layout_source_count) countUniqueBdidsPerSource                    ;
		unsigned8 countBdidsWithOldDateLastSeen                                   ;
		unsigned8 countDeadBdids                                                  ;
		unsigned6 EarliestDateFirstSeen                                           ;
		unsigned6 LatestDateLastSeen                                              ;
		unsigned6 EarliestDateVendorFirstReported                                 ;
		unsigned6 LatestDateVendorLastReported                                    ;
		set of string setSourcesWithDeadBdids						                          ;
		set of string setSourcesWithOldBdids						                          ;
		set of string setSourcesWithBlankDateSeens			                          ;
		set of string setSourcesWithBlankDateReporteds	                          ;
		set of string setNewSources                                               ;
		unsigned8 countUniquePhones                                               ;
		unsigned8 countNewUniquePhones                                            ;
		unsigned8 countRecordsWithPhones                                          ;
		unsigned8 countUniqueFeins                                                ;
		unsigned8 countNewUniqueFeins                                             ;
		unsigned8 countRecordsWithFeins                                           ;
		set of string setSourcesWithFeins                                         ;
		unsigned8 countUniqueAddresses                                            ;
		unsigned8 countUniqueCompanynames                                         ;
		unsigned8 countDppaRecords                                                ;
		set of string setSourcesWithDppa	                                        ;
		unsigned8 countUniqueVendorIds                                            ;
		unsigned8 countBlankVendorIds                                             ;
		set of string setSourcesWithBlankVendorIds                                ;
	end;                                                                 
/*	            
Same stats for business contacts and paw as above plus:
# of unique dids
# of new unique dids
paw score distribution
paw confidence groups sample
		unsigned8 countBothGlbAndDppaRecords
		unsigned8 countGlbRecords
		unsigned8 count# of dppa records by state(dppa_state field in BC)

*/
end;