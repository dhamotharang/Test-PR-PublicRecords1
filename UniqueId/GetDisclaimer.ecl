dsDisclaimers := DATASET([
{'INTERPOL MOST WANTED',
  'Interpol has removed access to this data by users other than registered law enforcement and other Interpol approved users of the data. '
	+ 'As a result, technology vendors do not have access to the complete and current Interpol data at this time. '
	+ 'LexisNexis is working to regain access for permissible users that prefer to use the Bridger Insight technology to process searches. '
	+ 'The most recent source update is May 21, 2013.'},
{'HM TREASURY INVESTMENT BAN LIST',
	'The source has officially lifted the restrictive measures against the entities on the list as of May, 2013. '
	+ 'There are no longer any prohibitions on dealing with the funds or economic resources of those persons listed previously in the Investment Ban List. '
	+ 'Therefore the Investment Ban List has been removed from the HM Treasury\'s website. '
	+ 'For further information go to '
	+ 'http://webarchive.nationalarchives.gov.uk/20130129110402/http:/www.hm-treasury.gov.uk/fin_sanctions_index.htm'},
{'RESERVE BANK OF AUSTRALIA',
	'The source content for this list is now being managed by the Australia Department of Foreign Affairs and Trade (DFAT). '
	+ 'All content for this consolidated list has been incorporated into the DFAT list within Bridger Insight.'}
], {string listname; string disclaimer});

dictDictionary := DICTIONARY(dsDisclaimers, {listname => disclaimer});

Export GetDisclaimer(string list) := IF(list in dictDictionary,
											dictDictionary[list].disclaimer, '');
