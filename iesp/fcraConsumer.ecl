/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcraConsumer.xml. ***/
/*===================================================*/

import iesp;
import Insurance_iesp;

export fcraConsumer := MODULE

export t_FcraConsumerOptions := record (share_fcra.t_FcraSearchOption)
	boolean IsReseller {xpath('IsReseller')};
	boolean IncludePersonContext {xpath('IncludePersonContext')};
	dataset(iesp.share.t_StringArrayItem) DataGroup {xpath('DataGroup/Item'), MAXCOUNT(60)};
end;

export t_SearchResponse := record
	iesp.share.t_ResponseHeader _Header {xpath('Header')};
	dataset(iesp.share.t_CodeMap) Messages {xpath('Messages/Message'), MAXCOUNT(5)};
	boolean IsSuppressed {xpath('IsSuppressed')};
	dataset(share_fcra.t_ConsumerAlert) ConsumerAlerts {xpath('ConsumerAlerts/ConsumerAlert'), MAXCOUNT(iesp.Constants.MaxConsumerAlerts)};
	dataset(share_fcra.t_ConsumerStatement) ConsumerStatements {xpath('ConsumerStatements/ConsumerStatement'), MAXCOUNT(iesp.Constants.MaxConsumerStatements)};
	dataset(Insurance_iesp.personcontext.t_PersonContextRecord) PersonContexts {xpath('PersonContexts/PersonContext'), MAXCOUNT(iesp.Constants.DataService.MaxPersonContext)};
	share_fcra.t_FcraConsumer Consumer {xpath('Consumer')};
end;

export t_SearchRequest := record (iesp.share.t_BaseRequest)
	t_FcraConsumerOptions Options {xpath('Options')};
	share_fcra.t_FcraPersonSearchBy SearchBy {xpath('SearchBy')};
end;

export t_SearchResponseEx := record
	t_SearchResponse response {xpath('response')};
end;

end;

/*** Not to be hand edited (changes will be lost on re-generation) ***/
/*** ECL Interface generated by esdl2ecl version 1.0 from fcraConsumer.xml. ***/
/*===================================================*/

