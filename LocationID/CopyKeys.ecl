import LocationID_xLink,_Control,dops,LocationID_Build,Orbit3;

export CopyKeys(boolean onProd = _Control.ThisEnvironment.Name='Prod_Thor') := function
	
	daliAddress     := if(onProd, _Control.IPAddress.aprod_thor_esp, _Control.IPAddress.adataland_dali);
	
	stateCityKeyRec := recordof(LocationID_xLink.Key_LocationId_STATECITY.DataForKey);
	zipKeyRec       := recordof(LocationID_xLink.Key_LocationId_ZIP.DataForKey);
	refsKeyRec      := recordof(LocationID_xLink.Key_LocationId_.DataForKey3);
	wordsKeyRec     := LocationID_xLink.Key_LocationId_.word_values_rec;
	meowKeyRec      := recordof(LocationID_xLink.Process_LocationID_Layouts.h);
	ridKeyRec       := recordof(LocationID_xLink.Process_LocationID_Layouts.sIDHist);
	
	stateCityKey := project(pull(LocationID_xLink.Key_LocationId_STATECITY.ForeignKey(daliAddress)), stateCityKeyRec);
	zipKey       := project(pull(LocationID_xLink.Key_LocationId_ZIP.ForeignKey(daliAddress)), zipKeyRec);
	refsKey      := project(pull(LocationID_xLink.Key_LocationId_.ForeignKey(daliAddress)), refsKeyRec );
	wordsKey     := project(pull(LocationID_xLink.Key_LocationId_.ForeignValueKey(daliAddress)), wordsKeyRec);
	meowKey      := project(pull(LocationID_xLink.Process_LocationID_Layouts.ForeignKey(daliAddress)), meowKeyRec);
	ridKey       := project(pull(LocationID_xLink.Process_LocationID_Layouts.ForeignKeyIDHistory(daliAddress)), ridKeyRec);

	update_dopsV2  := dops.updateversion('LocationIDKeys',trim(LocationID_xLink.KeyInfix,left,right),LocationID_Build.email_list,,'N') : INDEPENDENT;
	orbitUpdate    := Orbit3.proc_Orbit3_CreateBuild('LocationIDKeys',trim(LocationID_xLink.KeyInfix,left,right),'N') : INDEPENDENT;
		
     buildKeys := parallel(
		build(LocationID_xLink.Key_LocationId_STATECITY.BuildKey(stateCityKey), overwrite)
	    ,build(LocationID_xLink.Key_LocationId_ZIP.BuildKey(zipKey))
	    ,build(LocationID_xLink.Key_LocationId_.BuildKey(refsKey))
	    ,build(LocationID_xLink.Key_LocationId_.BuildValueKey(wordsKey))
	    ,build(LocationID_xLink.Process_LocationID_Layouts.BuildKey(meowKey))
	    ,build(LocationID_xLink.Process_LocationID_Layouts.BuildKeyIDHistory(ridKey))
	);
	
	goLive    := sequential(
	     buildKeys
	    ,LocationID_xLink.Proc_ClearSuperKeys
	    ,LocationID_xLink.Proc_CurrentToSuperKeys
	    ,if(_Control.ThisEnvironment.Name = 'Prod_Thor',evaluate(update_dopsV2),output('Not a prod environment'))
	    ,if(_Control.ThisEnvironment.Name = 'Prod_Thor',evaluate(orbitUpdate),output('Not a prod environment'))
	);
	
     return goLive;

end;