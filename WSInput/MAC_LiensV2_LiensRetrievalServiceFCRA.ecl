EXPORT MAC_LiensV2_LiensRetrievalServiceFCRA() := MACRO

#WEBSERVICE(FIELDS(
         'PublicRecordRetrievalRequest',
		 'Gateways'
));

ENDMACRO;