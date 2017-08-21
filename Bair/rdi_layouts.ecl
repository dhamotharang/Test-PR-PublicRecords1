export rdi_layouts := module
	rUdfType	:=	RECORD
			STRING			udfString									{	XPATH('udfString'													)	}											;
			STRING			udfInteger								{	XPATH('udfInteger'												)	}											;
			STRING			udfDecimal								{	XPATH('udfDecimal'												)	}											;
			STRING			udfDateTime								{	XPATH('udfDateTime'												)	}											;
			STRING			udfBoolean								{	XPATH('udfBoolean'												)	}											;
	END;
	//-
	rMo 			:= 	RECORD
			STRING 			irNumber	          			{ XPATH('irNumber'	       									) }           					;
			STRING 			crime	          					{ XPATH('crime'														  ) }           					;
			STRING 			locationType	          	{ XPATH('locationType'	             				) }           					;
			STRING 			objectOfAttack1	          { XPATH('objectOfAttack1'	             			) }           					;
			STRING 			objectOfAttack2	          { XPATH('objectOfAttack2'	             			) }          						;
			STRING 			pointOfEntry1	          	{ XPATH('pointOfEntry1'	             				) }           					;
			STRING 			pointOfEntry2	          	{ XPATH('pointOfEntry2'	             				) }           					;
			STRING 			methodOfEntry1	          { XPATH('methodOfEntry1'	             			) }           					;
			STRING 			methodOfEntry2	          { XPATH('methodOfEntry2'	             			) }           					;
			STRING 			suspectsActionsAgainstPerson1	          { XPATH('suspectsActionsAgainstPerson1'	             	) }           ;
			STRING 			suspectsActionsAgainstPerson2	          { XPATH('suspectsActionsAgainstPerson2'	             	) }           ;
			STRING 			suspectsActionsAgainstPerson3	          { XPATH('suspectsActionsAgainstPerson3'	             	) }           ;
			STRING 			suspectsActionsAgainstPerson4	          { XPATH('suspectsActionsAgainstPerson4'	             	) }           ;
			STRING 			suspectsActionsAgainstPerson5	          { XPATH('suspectsActionsAgainstPerson5'	             	) }           ;
			STRING 			suspectsActionsAgainstProperty1	        { XPATH('suspectsActionsAgainstProperty1'							) }           ;
			STRING 			suspectsActionsAgainstProperty2	        { XPATH('suspectsActionsAgainstProperty2'	     		 		) }           ;
			STRING 			suspectsActionsAgainstProperty3	        { XPATH('suspectsActionsAgainstProperty3'	         		) }           ;
			STRING 			propertyTaken1	          { XPATH('propertyTaken1'	             			) }           					;
			STRING 			propertyTaken2	          { XPATH('propertyTaken2'	             			) }           					;
			STRING 			propertyTaken3	          { XPATH('propertyTaken3'	             			) }           					;
			STRING 			propertyValue	          	{ XPATH('propertyValue'	            				) }           					;
			STRING 			weaponType1	          		{ XPATH('weaponType1'	             					) }           					;
			STRING 			weaponType2	          		{ XPATH('weaponType2'	             					) }           					;
			STRING 			methodOfDeparture	        { XPATH('methodOfDeparture'	             		) }           					;
			STRING 			firstDateTime	          	{ XPATH('firstDateTime'	             				) }           					;
			STRING 			lastDateTime	          	{ XPATH('lastDateTime'	             				) }           					;
			STRING 			addressOfCrime	          { XPATH('addressOfCrime'            				) }           					;
			STRING 			addressName	          		{ XPATH('addressName'	             					) }           					;
			STRING 			beat	          					{ XPATH('beat'	             								) }           					;
			STRING 			rd	          						{ XPATH('rd'	             									) }           					;
			STRING 			numberOfCompanions	      { XPATH('numberOfCompanions'	             	) }           					;
			STRING 			apartmentNumber	          { XPATH('apartmentNumber'	             			) }           					;
			STRING 			coordinateX	          		{ XPATH('coordinateX'	             					) }           					;
			STRING 			coordinateY	          		{ XPATH('coordinateY'	             					) }           					;
			STRING 			synopsisOfCrime	          { XPATH('synopsisOfCrime'	             			) }           					;
			STRING 			publicSynopsis	          { XPATH('publicSynopsis'	             			) }           					;
			STRING 			reportDate	          		{ XPATH('reportDate'	             					) }           					;
			STRING 			lawEnforcementOnly	      { XPATH('lawEnforcementOnly'	             	) }           					;
			STRING 			editDate	          			{ XPATH('editDate'	             						) }           					;
			STRING 			stamp	          					{ XPATH('stamp'	             								) }           					;
			STRING 			ori	          						{ XPATH('ori'	             									) }           					;
			STRING 			partnerAgencyID	          { XPATH('partnerAgencyID'	            			) }           					;
			STRING 			action	          				{ XPATH('action'	             							) }           					;
			rUdfType 		moUdf1	          				{ XPATH('moUdf1'	             							) }           					;
			rUdfType 		moUdf2	          				{ XPATH('moUdf2'	             							) }           					;
			rUdfType 		moUdf3	          				{ XPATH('moUdf3'	             							) }           					;
			rUdfType 		moUdf4	          				{ XPATH('moUdf4'	             							) }           					;
			rUdfType 		moUdf5	          				{ XPATH('moUdf5'	             							) }           					;
			rUdfType 		moUdf6	          				{ XPATH('moUdf6'	             							) }           					;
			rUdfType 		moUdf7	          				{ XPATH('moUdf7'             								) }           					;
			rUdfType 		moUdf8	          				{ XPATH('moUdf8'	             							) }           					;
	END;	
	//-
	rPerson 	:= RECORD
		STRING			irNumber										{	XPATH('irNumber'													)	}											;
		STRING			nameType										{	XPATH('nameType'													)	}											;
		STRING			lastName										{	XPATH('lastName'													)	}											;
		STRING			firstName										{	XPATH('firstName'													)	}											;
		STRING			middleName									{	XPATH('middleName'												)	}											;
		STRING			moniker											{	XPATH('moniker'														)	}											;
		STRING			address											{	XPATH('address'														)	}											;
		STRING			dob													{	XPATH('dob'																)	}											;
		STRING			race												{	XPATH('race'															)	}											;
		STRING			sex													{	XPATH('sex'																)	}											;
		STRING			hair												{	XPATH('hair'															)	}											;
		STRING			hairLength									{	XPATH('hairLength'												)	}											;
		STRING			eyes												{	XPATH('eyes'															)	}											;
		STRING			handUse											{	XPATH('handUse'														)	}											;
		STRING			speech											{	XPATH('speech'														)	}											;
		STRING			teeth												{	XPATH('teeth'															)	}											;
		STRING			physicalCondition						{	XPATH('physicalCondition'									)	}											;
		STRING			build												{	XPATH('build'															)	}											;
		STRING			complexion									{	XPATH('complexion'												)	}											;
		STRING			facialHair									{	XPATH('facialHair'												)	}											;
		STRING			hat													{	XPATH('hat'																)	}											;
		STRING			mask												{	XPATH('mask'															)	}											;
		STRING			glasses											{	XPATH('glasses'														)	}											;
		STRING			appearance									{	XPATH('appearance'												)	}											;
		STRING			shirt												{	XPATH('shirt'															)	}											;
		STRING			pants												{	XPATH('pants'															)	}											;
		STRING			shoes												{	XPATH('shoes'															)	}											;
		STRING			jacket											{	XPATH('jacket'														)	}											;
		STRING			soundex											{	XPATH('soundex'														)	}											;
		STRING			weight1											{	XPATH('weight1'														)	}											;
		STRING			weight2											{	XPATH('weight2'														)	}											;
		STRING			height1											{	XPATH('height1'														)	}											;
		STRING			height2											{	XPATH('height2'														)	}											;
		STRING			age1												{	XPATH('age1'															)	}											;
		STRING			age2												{	XPATH('age2'															)	}											;
		STRING			sid													{	XPATH('sid'																)	}											;
		STRING			facialRecognition						{	XPATH('facialRecognition'									)	}											;
		STRING			coordinateX									{	XPATH('coordinateX'												)	}											;
		STRING			coordinateY									{	XPATH('coordinateY'												)	}											;
		STRING			notes												{	XPATH('notes'															)	}											;
		STRING			editDate										{	XPATH('editDate'													)	}											;
		STRING			stamp												{	XPATH('stamp'															)	}											;
		STRING			ori													{	XPATH('ori'																)	}											;
		STRING			partnerAgencyID							{	XPATH('partnerAgencyID'										)	}											;
		rUdfType 		personUdf1									{	XPATH('personUdf1'												)	}											;
		rUdfType 		personUdf2									{	XPATH('personUdf2'												)	}											;
		rUdfType 		personUdf3									{	XPATH('personUdf3'												)	}											;
		rUdfType 		personUdf4									{	XPATH('personUdf4'												)	}											;
	END;
	//-
	rVehicle 	:= RECORD
		STRING			irNumber										{	XPATH('ArchiveInstanceId'									)	}											;
		STRING			plate												{	XPATH('ArchiveStatus'											)	}											;
		STRING			plateState									{	XPATH('BuildInstanceId'										)	}											;
		STRING			make												{	XPATH('ExpirationDate'										)	}											;
		STRING			model												{	XPATH('FileName'													)	}											;
		STRING			style												{	XPATH('ReceivingId'												)	}											;
		STRING			color												{	XPATH('Server'														)	}											;
		STRING			year												{ XPATH('Status'														)	}											;
		STRING			type												{ XPATH('type'															)	}											;
		STRING			status											{ XPATH('status'														)	}											;
		STRING			address											{ XPATH('address'														)	}											;
		STRING			coordinateX									{ XPATH('coordinateX'												)	}											;
		STRING			coordinateY									{ XPATH('coordinateY'												)	}											;
		STRING			description									{ XPATH('description'												)	}											;
		STRING			editDate										{ XPATH('editDate'													)	}											;
		STRING			stamp												{ XPATH('stamp'															)	}											;
		STRING			ori													{ XPATH('ori'																)	}											;
		STRING			partnerAgencyID							{ XPATH('partnerAgencyID'										)	}											;
	END;
	//-
	rMos := RECORD
		rMo 				Mo													{	XPATH('Mo'																)	}											;
	END;
	//-	
	rPersons := RECORD
		rPerson 		Person											{	XPATH('Person'														)	}											;
	END;
	//-
	rVehicles := RECORD
		rVehicle 		Vehicle											{	XPATH('Vehicle'														)	}											;
	END;
	//-	
	rRaidsXML := RECORD
		rMos				Mos		 											{	XPATH('Mos'																)	}											; 
		rPersons 		Persons											{	XPATH('Persons'														)	}											;
		rVehicles 	Vehicles										{	XPATH('Vehicles'													)	}											;
	END;
	
END;