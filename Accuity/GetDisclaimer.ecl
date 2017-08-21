dsDisclaimers := DATASET([
{'ALL 1180',				// Arab League List
  'Accuity is no longer able to obtain updates to this list directly from the source. '
	+ 'This list was last updated by Accuity on 12/28/2011. '
	+ 'Until Accuity is able to regain access to the source updates, this data file will not receive updates.'},
{'ALL1180',				// Arab League List
  'Accuity is no longer able to obtain updates to this list directly from the source. '
	+ 'This list was last updated by Accuity on 12/28/2011. '
	+ 'Until Accuity is able to regain access to the source updates, this data file will not receive updates.'},
{'ESE 1158',				// Egypt Financial Supervisory Authority Prohibited List
  'Accuity is no longer able to obtain updates to this list directly from the source. '
	+ 'This list was last updated by Accuity on 12/28/2011. '
	+ 'Until Accuity is able to regain access to the source updates, this data file will not receive updates.'},
{'ESE1158',				// Egypt Financial Supervisory Authority Prohibited List
  'Accuity is no longer able to obtain updates to this list directly from the source. '
	+ 'This list was last updated by Accuity on 12/28/2011. '
	+ 'Until Accuity is able to regain access to the source updates, this data file will not receive updates.'}
], {string listname; string disclaimer});

dictDictionary := DICTIONARY(dsDisclaimers, {listname => disclaimer});

Export GetDisclaimer(string list) := IF(list in dictDictionary,
													dictDictionary[list].disclaimer, '');
