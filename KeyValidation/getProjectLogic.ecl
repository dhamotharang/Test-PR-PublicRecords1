export getProjectLogic(keyFieldSet, correspondingParentFieldSet):= functionmacro

	// import keyvalidation;
	// import advfiles, std, FraudDefenseNetwork;
  #uniquename(projectLogic)
  #uniquename(i)
  #set(i,1)
  #loop
    #if(%i% > count(keyFieldSet))
      #break
    #elseif(%i%=1)	
					#if(keyFieldSet[%i%] = 'self')
					   #set(projectLogic, keyFieldSet[%i%] + ':=' + correspondingParentFieldSet[%i%] )
					#else
						#set(projectLogic, 'self.' + keyFieldSet[%i%] + ':=' + correspondingParentFieldSet[%i%] )
					#end//inner if
      // #set(sort_fields, fieldSet[%i%] )
      #set(i,%i%+1)
    #else
					#if(keyFieldSet[%i%] = 'self')
						#append(projectLogic, ' , ' + keyFieldSet[%i%] + ':=' + correspondingParentFieldSet[%i%] )
					#else
						#append(projectLogic, ' , ' + 'self.' + keyFieldSet[%i%] + ':=' + correspondingParentFieldSet[%i%] )
					#end//inner if
      // #append(sort_fields, ', ' + fieldSet[%i%] )
      #set(i,%i%+1)
    #end
  #end
	
	return %'projectLogic'%;
	
endmacro;

	// parentFileFields := keyvalidation.getListOfFieldsInDataset(advfiles.FDNDS);
	// keyFileFields := keyValidation.getListOfFieldsInDataset(FraudDefenseNetwork.Keys().main.did.qa);

	// commonFields := join(keyFileFields, parentFileFields, left.fieldName = right.fieldName);
	
	// loadxml('<xml />')
	// #exportxml(commonFieldsLayoutXML, recordOf(commonFields))
	// #declare(fieldNames)
	// #set(fieldNames, '')
	// #for(commonFieldsLayoutXML)
	  // #for(Field)
		  // #if(%'{@isEnd}'% = '')
			  // #append(fieldNames, ',(string)left.' + %'{@label}'% );
  	  // #end
		// #end
	// #end

	// transform(#expand(%'fieldNames'%)))
	
	// projectLogicLayout combineRecs(projectLogicLayout L, projectLogicLayout R) := TRANSFORM
		// SELF.projectLogicIteration := L.projectLogicIteration + R.projectLogicIteration;
	// END;

	// projectLogicIterationsDS :=  iterate(projectLogicDS, combineRecs(left, right));
	
	// endmacro;
	
		// projectLogicLayout := record
		// string projectLogicIteration;
	// end;

	// projectLogicDS := project(commonFields, transform(projectLogicLayout,
																																		// self.projectLogicIteration :=  'self.' + left.fieldName + ':= left.' + left.fieldName + ','));

	// projectLogicLayout combineRecs(projectLogicLayout L, projectLogicLayout R) := TRANSFORM
		// SELF.projectLogicIteration := L.projectLogicIteration + R.projectLogicIteration;
	// END;

	// projectLogicIterationsDS :=  iterate(projectLogicDS, combineRecs(left, right));
	
  // projectLogic := projectLogicIterationsDS[count(projectLogicIterationsDS)].projectLogicIteration;
	// return projectLogic[1..length(projectLogic)-1];

// endmacro;
// projectLogicDS := project(commonFields, transform(projectLogicLayout, self.projectLogic :=  left.fieldName);

// projectLogicDS;

// (boolean)std.str.wildmatch(right.fieldname, left.fieldName, false)); 
// baseDataFields(std.str.wildmatch(fieldname, '*fdn_file_code', false))[1];
 // std.str.wildmatch( baseDataFields,'*fdn_file_code' , false);

// keyvalidation.getCommonLayoutAndProjectFiles(FraudDefenseNetwork.Keys().main.did.qa, advfiles.FDNDS);

// FraudDefenseNetwork.Keys().main.did.qa;