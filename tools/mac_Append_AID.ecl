import aid;

export mac_Append_AID(

	 pDataset
	,pRidField							= '\'rid\''	// Unique Id Field in input dataset.  If it doesn't exist, it will be created
	,psetAddress1Fields			= '[]'
	,psetAddress2Fields			= '[]'
	,psetRawAidFields				= '[]'
	,psetAceAidFields				= '[]'
	,psetCleanAddressFields	= '[]'
	,pPersistname						= '\'\''		// set this if you would like to persist the output
	,pLayout								= ''				// optional, only for interfaces where u might need to actually specify the layout
	,pOutputEcl							= 'false'		// Should output the ecl as a string(for testing) or actually run the ecl

) :=
functionmacro
	/////////////////////////////////////////////
	// -- Start XML
	/////////////////////////////////////////////
	LOADXML('<xml/>');
	#EXPORTXML(pDataset_MetaInfo						,recordof(pDataset))
	
	#uniquename(moutput											)
	#uniquename(loutput											)
	#uniquename(ldataset										)
	#uniquename(dDataset										)
	#uniquename(layoutFile									)
	#uniquename(numaddresses								)
	#uniquename(addresslayout								)
	#uniquename(tNormalizeAddress						)
	#uniquename(dAddressPrep								)
	#uniquename(HasAddress									)
	#uniquename(dWith_address								)
	#uniquename(dWithout_address						)
	#uniquename(dWith_address_dedup					)
	#uniquename(lFlags											)
	#uniquename(dwithAID										)
	#uniquename(dwithAID_full								)
	#uniquename(dStandardizeNameInput_dist	)
	#uniquename(dAddressStandardized_dist		)
	#uniquename(fReformatAceCache						)
	#uniquename(tGetStandardizedAddress			)
	#uniquename(lcounter										)
	#uniquename(dAddressAppended						)
	#uniquename(laddress1										)
	#uniquename(laddress2										)
	#uniquename(lrawaid											)
	#uniquename(laceaid											)
	#uniquename(lcleanaddress								)
	#uniquename(lRidField					      		)
	#uniquename(layoutOrigFile          		)
	#uniquename(layoutSeqFile           		)

	// if you want the ecl as a string(instead of executed), de-mangle the var names to make it readable	
	#IF(pOutputEcl = true)
		#SET(dDataset										,'pDataset'										)
		#SET(layoutFile									,'layoutFile'									)
		#SET(numaddresses								,'numaddresses'								)
		#SET(addresslayout							,'addresslayout'							)
		#SET(tNormalizeAddress					,'tNormalizeAddress'					)
		#SET(dAddressPrep								,'dAddressPrep'								)
		#SET(HasAddress									,'HasAddress'									)
		#SET(dWith_address							,'dWith_address'							)
		#SET(dWithout_address						,'dWithout_address'						)
		#SET(dWith_address_dedup				,'dWith_address_dedup'				)
		#SET(lFlags											,'lFlags'											)
		#SET(dwithAID										,'dwithAID'										)
		#SET(dwithAID_full							,'dwithAID_full'							)
		#SET(dStandardizeNameInput_dist	,'dStandardizeNameInput_dist'	)
		#SET(dAddressStandardized_dist	,'dAddressStandardized_dist'	)
		#SET(fReformatAceCache					,'fReformatAceCache'					)
		#SET(tGetStandardizedAddress		,'tGetStandardizedAddress'		)
		#SET(lcounter										,'lcounter'										)
		#SET(dAddressAppended						,'dAddressAppended'						)
		#SET(layoutOrigFile							,'layoutOrigFile'							)
		#SET(layoutSeqFile							,'layoutSeqFile'							)
		#SET(moutput										,'moutput'										)
	#END


	// -- Check if passed in RID field exists or not
	#IF(pRidField	!= '')
		tools.mac_GetFieldType(pDataset_MetaInfo		,pRidField,lRidFieldType	,true);
		#SET(lRidField	,pRidField)
	#ELSE
		#uniquename(lRidFieldType	      )
		#SET(lRidFieldType	,'unsigned8')
	#END

	#SET(moutput										,'moutput'										)

	// -- Add RID field to dataset if it doesn't already exist
	#SET(ldataset			,trim(#TEXT(pDataset),all))
	#IF(pRidField	!= '')
		#SET		(loutput	,%'dDataset'% + ' := ' + %'ldataset'% + ';\n')
	#ELSE
		#SET		(loutput	,%'dDataset'% + ' := project(' + %'ldataset'% + '	,transform({recordof(' + %'ldataset'% + '), ' + %'lRidFieldType'% + ' ' + %'lRidField'% + '}, self.' + %'lRidField'% + ' := counter; self := left)) : global;\n')
	#END

	#IF(#TEXT(pLayout) = '')
		#APPEND	(loutput	,%'layoutOrigFile'% + '		:= recordof(' + %'ldataset'% + ');\n');
	#ELSE
		#APPEND	(loutput	,%'layoutOrigFile'% + '		:= ' + #TEXT(pLayout) + ';\n');
	#END
	#APPEND	(loutput	,%'layoutSeqFile'% + '		:= recordof(' + %'dDataset'% + ');\n');

	// -- Define Slim Address Layout to pass to AID macro
	#APPEND	(loutput	,%'addresslayout'% + '	:=\nrecord\n');
	#APPEND	(loutput	,'\t' + %'lRidFieldType'% + '				unique_id			;\n');
	#APPEND	(loutput	,'\tunsigned8										rawaid				;\n');
	#APPEND	(loutput	,'\tunsigned1										addr_type			;\n');
	#APPEND	(loutput	,'\tstring100 									address1			;\n');
	#APPEND	(loutput	,'\tstring50										address2			;\n');
	#APPEND	(loutput	,'\tend;\n');

	// -- Construct Normalize Transform based on how many addresses are passed in
	#APPEND	(loutput	,%'addresslayout'% + ' ' + %'tNormalizeAddress'% + '(' + %'layoutSeqFile'% + ' l, unsigned1 cnt) :=\n');
	#APPEND	(loutput	,'transform\n');
	#APPEND	(loutput	,'\tself.unique_id							:= l.' + %'lRidField'%	+ ';\n'	);					
	#APPEND	(loutput	,'\tself.addr_type							:= cnt												;\n');

	#SET(numaddresses	,count(psetAddress1Fields));
	#SET(lcounter		,1);
	#SET(laddress1		,'choose(cnt	');
	#SET(laddress2		,'choose(cnt	');
	#SET(lrawaid			,'choose(cnt	');
	
	#LOOP
		#IF(%lcounter% > %numaddresses%)
			#BREAK
		#END
		#APPEND(laddress1	,',l.' + psetAddress1Fields	[%lcounter%]);
		#APPEND(laddress2	,',l.' + psetAddress2Fields	[%lcounter%]);
		#APPEND(lrawaid		,',l.' + psetRawAidFields		[%lcounter%]);
		#SET(lcounter	,%lcounter% + 1)
	#END
	
	#APPEND	(loutput	,'\tself.address1								:= ' + %'laddress1'% 	+ ');\n' );
	#APPEND	(loutput	,'\tself.address2								:= ' + %'laddress2'% 	+ ');\n' );        
	#APPEND	(loutput	,'\tself.rawaid									:= ' + %'lrawaid'% 		+ ');\n' );
																				 
	#APPEND	(loutput	,'end;\n');

	// -- Normalize out addresses, filter out blanks, dedup before sending to AID macro
	#APPEND	(loutput	,%'dAddressPrep'% + '	:= normalize(' + %'dDataset'% + ', ' + %'numaddresses'% + ',' + %'tNormalizeAddress'% + '(left,counter));\n');
	#APPEND	(loutput	,%'HasAddress'%	+ ':= 		trim(' + %'dAddressPrep'% + '.address1, left,right) != \'\'\n');
	#APPEND	(loutput	,'									or	trim(' + %'dAddressPrep'% + '.address2, left,right) != \'\';\n');
									
	#APPEND	(loutput	,%'dWith_address'% + '			:= ' + %'dAddressPrep'% + '(' + %'HasAddress'% + ');\n');
	#APPEND	(loutput	,%'dWithout_address'% + '	:= ' + %'dAddressPrep'% + '(not(' + %'HasAddress'% + '));\n');
	#APPEND	(loutput	,%'dWith_address_dedup'%	+ ' := dedup(' + %'dWith_address'% + ', hash64(address1,address2),hash);\n');	
	#APPEND	(loutput	,%'lFlags'% + ' := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;\n');
	#APPEND	(loutput	,'AID.MacAppendFromRaw_2Line(' + %'dWith_address_dedup'% + ', Address1, Address2, rawaid, ' + %'dwithAID'% + ',' +  %'lFlags'% + ');\n');
	
	// -- join back to dWith_Address to get rid and type back to original records because of dedup
	#APPEND(loutput		,'//join back to dWith_Address to get rid and type back to original records because of dedup\n');

	#APPEND(loutput		,%'dwithAID_full'% + ' := join(\n');
	#APPEND(loutput		,'		 ' + %'dWith_address'% + '\n');
	#APPEND(loutput		,'		,' + %'dwithAID'% + '\n');
	#APPEND(loutput		,'		,		left.address1 = right.address1\n');
	#APPEND(loutput		,'		and left.address2 = right.address2\n');
	#APPEND(loutput		,'		,transform(\n');
	#APPEND(loutput		,'			 recordof(' + %'dwithAID'% + ')\n');
	#APPEND(loutput		,'			,self.unique_id := left.unique_id	;\n');
	#APPEND(loutput		,'			 self.addr_type	:= left.addr_type	;\n');
	#APPEND(loutput		,'			 self						:= right					;\n');
	#APPEND(loutput		,'		)\n');
	#APPEND(loutput		,'	);\n');
	
	// -- match back to dStandardizedFirstPass and append address
	#APPEND(loutput		,%'dStandardizeNameInput_dist'% + ' 	:= sort(distribute(' + %'dDataset'%	+ '		,' + %'lRidField'% + ')	,' + %'lRidField'% + '	,local);\n');
	#APPEND(loutput		,%'dAddressStandardized_dist'% + '		:= sort(distribute(' + %'dwithAID_full'% + '	,unique_id)	,unique_id	,local);\n');
	#APPEND(loutput		,'Address.Layout_Clean182_fips ' + %'fReformatAceCache'% + '(AID.Layouts.rACECache	pRow) :=\n');
	#APPEND(loutput		,'transform\n');
	#APPEND(loutput		,'	self.fips_state		:= pRow.county[1..2];\n');
	#APPEND(loutput		,'	self.fips_county	:= pRow.county[3..]	;\n');
	#APPEND(loutput		,'	self.zip					:= pRow.zip5				;\n');
	#APPEND(loutput		,'	self							:= pRow							;\n');
	#APPEND(loutput		,'end;\n\n');

	#APPEND(loutput		,%'layoutSeqFile'% + ' ' + %'tGetStandardizedAddress'% + '(' + %'layoutSeqFile'% + ' l	,' + %'dAddressStandardized_dist'% + ' r) :=\n');
	#APPEND(loutput		,'transform\n');
	#APPEND(loutput		,'\taidwork_acecache := row(' + %'fReformatAceCache'% + '(r.aidwork_acecache));\n');

	#SET(lcounter					,1);
	#SET(lrawaid					,'');
	#SET(laceaid					,'');
	#SET(lcleanaddress		,'');
	
	#LOOP
		#IF(%lcounter% > %numaddresses%)
			#BREAK
		#END
		#APPEND(loutput	,'\tself.' + psetRawAidFields[%lcounter%] + '				:= if(r.addr_type = ' + %'lcounter'% + '	,r.AIDWork_RawAID							,l.' + psetRawAidFields[%lcounter%]	+ 		'	);\n');
		#APPEND(loutput	,'\tself.' + psetAceAidFields[%lcounter%] + '				:= if(r.addr_type = ' + %'lcounter'% + '	,r.aidwork_acecache.aid							,l.' + psetAceAidFields[%lcounter%]	+ 		'	);\n');
		#APPEND(loutput	,'\tself.' + psetCleanAddressFields[%lcounter%] + '				:= if(r.addr_type = ' + %'lcounter'% + '	,aidwork_acecache							,l.' + psetCleanAddressFields[%lcounter%]	+ 		'	);\n');
		#SET(lcounter	,%lcounter% + 1)
	#END
	#APPEND(loutput	,'	self 										:= l;\n');
	#APPEND(loutput	,'end;\n\n');
	
	#APPEND(loutput	,%'dAddressAppended'% + '	:= denormalize(\n');
	#APPEND(loutput	,'\t ' + %'dStandardizeNameInput_dist'% + '\n');
	#APPEND(loutput	,'\t,' + %'dAddressStandardized_dist'% + '\n');
	#APPEND(loutput	,'\t,left.' + %'lRidField'% + ' = right.unique_id \n');
	#APPEND(loutput	,'\t,' + %'tGetStandardizedAddress'% + '(left,right)\n');
	#APPEND(loutput	,'\t,local)\n');
	#IF(pPersistname != '')
		#APPEND	(loutput	,' : persist(' + trim(#TEXT(pPersistname),all) + ')')
	#END
	#APPEND	(loutput	,';\n')	

	#APPEND(loutput, %'moutput'% + ' := project(' + %'dAddressAppended'% + ',' + %'layoutOrigFile'% + ');\n');
	
	#SET(moutput	,%'loutput'% + ' return ' + %'moutput'% + ';\n')
	
	#if(pOutputEcl = true)
		return %'loutput'%;
	#ELSE
		%moutput%		
	#END
	
endmacro;