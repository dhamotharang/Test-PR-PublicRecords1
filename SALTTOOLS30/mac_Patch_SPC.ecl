/*
	-----------------------------------------------------------------------------------------
	-- mac_Patch_SPC
	-- This macro patches in the real calculated specificities(and number of records) to the SPC attribute and saves(sandboxes) it.  This makes it much easier
	-- to do this work especially for datasets with many fields.  
	-- Notes:
	-- 	it does not(at least in Boca Dataland) trigger the automatic SALT code generation once it saves the new SPC attribute(soap limitation). 
	--	If you do not want this macro to save the attribute for you, you can set pUpdateSPC to false, and it will output the new SPC as a string which can be 
	-- 	copy/pasted into the SPC attribute.
	-- 	The output when saving the attribute is the error message from the soapcall.  If it is blank, it worked.
	--	One thing to keep in mind is that by default, it will pull the sandboxed version of the SPC attribute specified.  If this is not wanted, 
	-- 	pSandbox can be set to false to pull the checked in version.  Keep in mind that one of those versions could be blank(if not checked in, etc).
	-- 	If the pOutSPCAttribute is populated, it will save the new SPC file to that attribute.  If the new SPC attribute does not exist, it will create it,
	--	but at the moment it will not create it as a SALT attribute, so if that is preferred, the attribute should be created beforehand as a SALT attribute.
	-- Example of its use(in boca dataland):
mspecs 		:= test.specificities(test.In_Base);
patchspc	:= SALTTOOLS30.mac_Patch_SPC(mspecs.Specificities,'test._SPC',test.In_Base,_control.MyInfo.UserID,_control.MyInfo.Password,'10.241.3.242:8145');
OUTPUT(mspecs.Specificities	,NAMED('Specificities'	));
OUTPUT(mspecs.SpcShift			,NAMED('SpcShift'				));
output(patchspc							,NAMED('SPCPatchOutput'	));
	-----------------------------------------------------------------------------------------	
*/
EXPORT mac_Patch_SPC(
	 pInSpecificities																// Input Specificities dataset
	,pSPCAttribute																	// Input SPC attribute
	,pInputFile																			// Input file specificities are built on
	,pESP							= '\'10.241.3.242:8145\''			// ESP server & port for your environment(for soapcalls).  Boca OSS dataland is '10.241.3.242:8145'
	,pSandbox					= 'true'											// Get Sandboxed version?
	,pUpdateSPC				= 'true'											// should save the updated SPC file?  If true, saves it to repository and gives output of soapcall.  If false, outputs the updated SPC file
	,pOutSPCAttribute	= '\'\''											// use this if you want the output spc file attribute with the specificities appended to be different than the input SPC file attribute
) :=
functionmacro
	import SALTTOOLS30;
	
	//Parse In SPC file
	lindex 			:= stringlib.stringfind(pSPCAttribute,'.',1);
	lmodule 		:= pSPCAttribute[1..(lindex - 1)];
	lattribute 	:= pSPCAttribute[(lindex + 1)..];
	//Parse Out SPC file
	OutSPCAttribute := if(pOutSPCAttribute = ''	,pSPCAttribute	,pOutSPCAttribute);
	
	loutindex 			:= stringlib.stringfind(OutSPCAttribute,'.',1);
	loutmodule 			:= OutSPCAttribute[1..(loutindex - 1)];
	loutattribute 	:= OutSPCAttribute[(loutindex + 1)..];
	//Soapcall to Get SPC attribute
	datts := SALTTOOLS30.mod_Soapcalls.fFindAttributes(lmodule,lattribute,pESP,true,pIsSandbox := pSandbox);
	
	lstringextract(string pString,unsigned2 pinstance,string1 pdelim = '\n')	:= 
		map( pinstance 																			 = 1 	=> pString[1..(stringlib.stringfind(pString,pdelim,1) - 1)]
				,stringlib.stringfind(pString,pdelim,pinstance) != 0	=> pString[(stringlib.stringfind(pString,pdelim,pinstance - 1) + 1)..(stringlib.stringfind(pString,pdelim,pinstance) - 1)]
				,																												 pString[(stringlib.stringfind(pString,pdelim,pinstance - 1) + 1)..]
		);
	//Normalize SPC file to one line per record, parse out fieldname
	datts_norm := normalize(datts, stringlib.stringfindcount(left.text,'\n') + 1,transform(
	 {unsigned rid,string line,string fieldname}
	,self.rid				:= counter
	,self.line 			:= lstringextract(left.text,counter)
	,self.fieldname := stringlib.stringtolowercase(if(regexfind('^(FIELD:|NUMBERFIELD:|DATEFIELD:|CONCEPT:|ATTRIBUTEFILE:).*$',self.line,nocase) and regexfind(',',self.line)	,lstringextract(self.line,2,':'),''))
	));
	
	numrecords := count(pInputFile);
	datts_getnumrecs := project(datts_norm,transform({unsigned rid,string line,string fieldname}
		,self.line := map(regexfind('RECORDS:',left.line,nocase)	=> left.line[1..(stringlib.stringfind(left.line,':',stringlib.stringfindcount(left.line,':')))] + (string)numrecords
										 ,OutSPCAttribute != pSPCAttribute and regexfind('MODULE:' ,left.line,nocase)	=> left.line[1..(stringlib.stringfind(left.line,':',stringlib.stringfindcount(left.line,':')))] + loutmodule
										 ,left.line)
		,self 		 := left
	));
	//Normalize Specificities dataset to one field per record
	SALTTOOLS30.mac_LayoutTools(recordof(pInSpecificities),layouttools,false,true,'specificity|switch');
	layspecs := {unsigned rid,string realfield,string fieldname,string fieldvalue};
	dnorm_specs := normalize(pInSpecificities,count(layouttools.setAllFields),transform(layspecs
		,self.fieldname 	:= layouttools.fGetFieldName(counter);
		,self.fieldvalue	:= (string)layouttools.fGetFieldValue(counter,left)
		,self.rid					:= (counter + 1)/ 2
		,self.realfield		:= regexreplace('_specificity|_switch',self.fieldname,'',nocase);
	));
	
	//Rollup on rid so can concatenate the specificity and switch value
	drollup_specs := rollup(dnorm_specs,rid,transform(layspecs
		,self.fieldname 	:= left.fieldname
		,self.fieldvalue	:= trim((string)round((real8)left.fieldvalue)) + ',' + trim((string)(unsigned)round(((real8)right.fieldvalue * 1000)))
		,self.rid					:= left.rid
		,self.realfield		:= stringlib.stringtolowercase(left.realfield)
	));
	
	//join SPC file dataset to specificities dataset to replace specificities in the spc file
	djoin2 := join(
		 datts_getnumrecs
		,drollup_specs
		,left.fieldname = right.realfield
		,transform({unsigned rid,string line,string fieldname}
			,self.rid				:= left.rid
			,self.line 			:= if(left.fieldname != '' and right.fieldvalue != '',left.line[1..(stringlib.stringfind(left.line,':',stringlib.stringfindcount(left.line,':')))] + right.fieldvalue,left.line)
			,self.fieldname := left.fieldname
		)
		,left outer		
	);
	layrollup := {string line {maxlength(100000)}};
	dprep4rollup := project(sort(djoin2,rid)	,transform(layrollup,self := left));
	
	// Rollup to one record for return/saving attribute to repository
	drolluptext := rollup(dprep4rollup,true,transform(layrollup,self.line := left.line + '\n' + right.line));
	
	//Soapcall to Save attribute to repository
	updateSPC := SALTTOOLS30.mod_Soapcalls.fSaveAttribute(loutmodule,loutattribute,drolluptext[1].line,pESP);
	return iff(pUpdateSPC = true	and trim(drolluptext[1].line) != ''	, updateSPC[1].exception_msg	
   			,iff(trim(drolluptext[1].line)  = ''												, 'Your SPC File was blank.  Try setting the pSandbox parameter to ' + if(pSandbox	,'false.','true.')
   			,																												 	 		drolluptext[1].line
   	
  ));	
endmacro;
