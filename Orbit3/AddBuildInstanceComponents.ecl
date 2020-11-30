//*************************************************************************************************************												
//** Attribute copied from Insurance for Orbit Profile setup in PR
//*************************************************************************************************************
import _control;
export AddBuildInstanceComponents(string      pLoginToken,
                                  string      pBuildName,
                                  string      pBuildVersion,
                                  string      pBuildInstanceId,
                                  string      pEmailList,
                                  dataset(Orbit3.Layouts.OrbitBuildInstanceLayout)  pReceiveCandidates,
                                  dataset(Orbit3.Layouts.OrbitBuildInstanceLayout)  pBuildCandidates
                                 ) := 
function
/////////////////////////////////////////////////////////////////////////////
  rstuff := record
    string                arrlong                  {xpath('')};
  end;

  RcvItems  := project(pReceiveCandidates,transform(rstuff,self.arrlong := left.ID));
  BldItems  := project(pBuildCandidates,  transform(rstuff,self.arrlong := left.ID));

  rReceiveInstanceIds := record
    string                BuildInstanceId          {xpath('BuildInstanceId')}                            :=  pBuildInstanceId;
    string                BuildName                {xpath('BuildName')}                                  :=  pBuildName;
    string                BuildVersion             {xpath('BuildVersion')}                               :=  pBuildVersion;
    dataset(rstuff)       ReceiveInstanceIds       {xpath('ReceiveInstanceIds/arr:long'), maxcount(200)} :=  RcvItems;
    // dataset(rstuff)    BuildInstanceIds         {xpath('ReceiveInstanceIds/arr:long'), maxcount(200)} :=  BldItems;
    dataset(rstuff)       BuildInstanceIds         {xpath('BuildInstanceIds/arr:long'), maxcount(200)}   :=  BldItems;
  end;
  
  rRequestAddBuildInstanceComponent := record
    rReceiveInstanceIds    RecordRequestAddBuildInstanceComponent  {xpath('RecordRequestAddBuildInstanceComponent')};
  end;
  rOrbitRequest := record 
    string                             LoginToken  {xpath('Token'),      maxlength(36)}    :=  pLoginToken;
    rRequestAddBuildInstanceComponent  OrbRequest  {xpath('Request')};
  end;
  rRequestCapsule  := record
    #IF(((__ECL_VERSION_MAJOR__ = 7) AND (__ECL_VERSION_MINOR__ >= 8)) or  (__ECL_VERSION_MAJOR__ > 7)) // 7.8 Tightened up the checking of the namespace in SOAP calls, it doesn't support multiple ones so this is in as a workaround until that is available. Unfortunately the workaround doesn't work on 7.6 hence the conditional here.
       $.Layouts.AdditionalNamespacesLayout;
    #END
    rOrbitRequest            request               {xpath('request')};
  end;  
/////////////////////////////////////////////////////////////////////////////
  rString := record
    string                  a                      {xpath('a:long')};
  end;
  rBatchResults  := record
    // dataset(rstring)     BatchNumbers          {xpath('BatchNumbers')};
    string                  BuildInstanceId       {xpath('BuildInstanceId')};
    string                  BuildName             {xpath('BuildName')};
    string                  BuildVersion          {xpath('BuildVersion')};
    dataset(rstring)        ReceiveInstanceIds    {xpath('ReceiveInstanceIds')};
    dataset(rstring)        BuildInstanceIds      {xpath('BuildInstanceIds')};
  end;
  rResult2  := record
    rBatchResults           Result                 {xpath('Result')};
    string                  Status                 {xpath('Status')};
    string                  Message                {xpath('Message')};
  end;
  rRecordResponseAddBuildInstanceComponent := record
    rResult2  RecordResponseAddBuildInstanceComponent  {xpath('RecordResponseAddBuildInstanceComponent')};
  end;
  rResult  := record
    rRecordResponseAddBuildInstanceComponent  Result  {xpath('Result')};  
    string                  Status                    {xpath('Status')};
    string                  Message                   {xpath('Message')};
  end;
  rAddBuildInstanceComponentRslt  := record
    rResult  AddBuildInstanceComponentResult      {xpath('AddBuildInstanceComponentResult')};
  end;
  rFault  :=  record
    string                   FaultCode              {xpath('faultcode')};
    string                  FaultString             {xpath('faultstring')};
  end;
  rSOAPResponse  :=   record
    rFault    FaultRecord {xpath('Fault')};
    rAddBuildInstanceComponentRslt    AddBuildInstanceComponentResponse    {xpath('AddBuildInstanceComponentResponse'),     maxlength(300000)};  
  end;
/////////////////////////////////////////////////////////////////////////////

  rSOAPResponse  lResponse  :=  soapcall(Orbit3.EnvironmentVariables.ServiceURL,
                                       'AddBuildInstanceComponent',
                                       rRequestCapsule,
                                       rSOAPResponse,
                                       namespace(Orbit3.EnvironmentVariables.NameSpace),
                                       literal,
                                       soapaction(Orbit3.EnvironmentVariables.SoapActionPrefix +  'PR/AddBuildInstanceComponent')
                                      ):independent;

  ItemLayout := record
    string  itemText;
  END;

  dsItems  := project(pReceiveCandidates, transform(ItemLayout, self.itemtext := (string15)left.ComponentType + ': ' + (string70)left.name + ' - ' + (string15)left.Version + ', ' + left.Status)) +
              project(pBuildCandidates,   transform(ItemLayout, self.itemtext := (string15)left.ComponentType + ': ' + (string70)left.name + ' - ' + (string15)left.Version + ', ' + left.Status));
  
  ItemLayout rollupForm (ItemLayout L, ItemLayout R) := TRANSFORM
    SELF.itemText         := TRIM(L.itemText,RIGHT) + '\n'  + TRIM(R.itemText,RIGHT) +'\n'; 
  END;
  ItemList                 := ROLLUP(dsItems, rollupForm(LEFT,RIGHT), TRUE);  
  
    // xmlds := dataset([rRequestCapsule.request.OrbRequest.RecordRequestAddBuildInstanceComponent],rReceiveInstanceIds);
    // output(xmlds,,'~thor::temp::xmlds',xml,named('xmlds'),overwrite);  
    // output(lResponse,named('lResponseAddBuildInstance'));
  // return  lResponse;
  return if(orbit3.EnvironmentVariables.updateme = 'yes',
            sequential(//output(xmlds),
            if(pBuildInstanceId  <> '',
                if(trim(lResponse.AddBuildInstanceComponentResponse.AddBuildInstanceComponentResult.Status,left,right) = 'Success',
                        fileservices.sendemail
                        (
                        pEmailList,
                        _control.ThisEnvironment.Name + ': ' + 'Orbit Components Added for '+pBuildName+':'+pBuildversion+':SUCCESS',
                        'List of Components \n\n' +
                        '**********************************************************************************************************************************\n'+
                        'ComponentType    Component Nane                                                           Version          Status\n'+
                        '**********************************************************************************************************************************\n' +
                        ItemList[1].itemText
                        ,,,'Orbit3.AddBuildInstanceComponents@lexisnexisrisk.com'
                        // mail_out[1].mailstring
                        ),
                        fileservices.sendemail
                        (
                        pEmailList,
                        _control.ThisEnvironment.Name + ': ' + 'Orbit Components Added for '+pBuildName+':'+pBuildversion+':FAILED',
                        'Adding components to build failed. Reason: '+ '\n' +
                        lResponse.AddBuildInstanceComponentResponse.AddBuildInstanceComponentResult.Result.RecordResponseAddBuildInstanceComponent.Message  + '\n' +
                        '**********************************************************************************************************************************\n'+
                        'ComponentType    Component Nane                                                           Version          Status\n'+
                        '**********************************************************************************************************************************\n' +
                        ItemList[1].itemText
                        ,,,'Orbit3.AddBuildInstanceComponents@lexisnexisrisk.com'
                        )
                   ),
                     fileservices.sendemail( pEmailList,
                          _control.ThisEnvironment.Name + ': ' + 'No components added to '+pBuildName+':'+pBuildversion+':FAILED',
                          'No components were available to add'
                          ,,,'Orbit3.AddBuildInstanceComponents@lexisnexisrisk.com')))
          ,output(dataset([{'Did not run orbit update'}],{string message}),named('ORBIT_Notes'),extend)
          );
End;