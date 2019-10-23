/*
  WUAction can restore archived workunits
  <WUActionRequest>
   <Wuids>
    <Item>W20130603-104908</Item>
   </Wuids>
   <ActionType>Restore</ActionType>
   <Cluster/>
   <Owner/>
   <State/>
   <StartDate/>
   <EndDate/>
   <ECL/>
   <Jobname/>
   <Test/>
   <CurrentPage/>
   <PageSize/>
   <Sortby/>
   <Descending>0</Descending>
   <EventServer/>
   <EventName/>
   <PageFrom/>
   <BlockTillFinishTimer>0</BlockTillFinishTimer>
  </WUActionRequest>

  Possible actions:
   <ActionType>Restore</ActionType>
   <ActionType>Protect</ActionType>
   <ActionType>Unprotect</ActionType>

  Example calls:
wk_ut.do_WUAction(dataset([{'W20140116-153630'}],wk_ut.layouts.WuidItems),'Abort');
wk_ut.do_WUAction(dataset([{'W20140116-153630'}],wk_ut.layouts.WuidItems),'Protect');
wk_ut.do_WUAction(dataset([{'W20140116-153630'}],wk_ut.layouts.WuidItems),'Restore');
wk_ut.do_WUAction(dataset([{'W20140116-153630'}],wk_ut.layouts.WuidItems),'Unprotect');
wk_ut.do_WUAction(dataset([{'W20140116-153630'}],wk_ut.layouts.WuidItems),'Deschedule');
*/
import WsWorkunits;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export do_WUAction := WsWorkunits.soapcall_WUAction;