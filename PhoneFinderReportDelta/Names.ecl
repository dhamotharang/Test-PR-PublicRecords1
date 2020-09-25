IMPORT std,data_services,doxie,$;

EXPORT Names(STRING pversion	=	(STRING8)Std.Date.Today())	:=	MODULE
  SHARED  STRING dataset_name := 'phonefinderreportdelta';  
	SHARED  STRING prefix := data_services.Data_location.Prefix (dataset_name) + 'thor_data400::key::' + IF(pversion != '', '@version@::', '') + dataset_name + '::';
	
	EXPORT i_identities       := prefix + 'identities';
	EXPORT i_identities_lexid := prefix + 'identities_lexid';
	EXPORT i_otherphones      := prefix + 'otherphones';
	EXPORT i_riskindicators   := prefix + 'riskindicators';
  EXPORT i_transactions     := prefix + 'transactions';
	EXPORT i_sources     			:= prefix + 'sources';
	
	EXPORT i_transactions_companyid        := prefix + 'transactions_companyid';
  EXPORT i_transactions_companyrefcode   := prefix + 'transactions_companyrefcode';
	EXPORT i_transactions_date             := prefix + 'transactions_date';
	EXPORT i_transactions_phone            := prefix + 'transactions_phone';
	EXPORT i_transactions_refcode          := prefix + 'transactions_refcode';
	EXPORT i_transactions_userid           := prefix + 'transactions_userid';

 END;