

/*--SOAP--
<message name="ShowService">
<part name="proxid" type="xsd:string"/>
</message>
*/

/*--INFO-- Show parent companies.
<p>More info here.</p>

*/



EXPORT ShowService() := 
MACRO

  import doxie, BIPv2_HRCHY,bizlinkfull;

  myproxid := 0 : stored('proxid');

  key_proxid_up     := BizLinkFull.Process_Biz_Layouts.KeyproxidUp;
  seleid_for_proxid := key_proxid_up(proxid = myproxid)[1].seleid;

  ds_seleid         := dataset([{seleid_for_proxid}] ,{unsigned6 seleid});

  GetLGID                    := BIPv2_HRCHY.FunctionsShow.GetLGID                  (myproxid );
  ShowParents                := BIPv2_HRCHY.FunctionsShow.ShowParents              (myproxid );
  ShowDirectParentsChildren  := BIPv2_HRCHY.FunctionsShow.ShowDirectParentsChildren(ds_seleid);
  ShowHrchy                  := BIPv2_HRCHY.FunctionsShow.ShowHrchy                (myproxid );


  output(myproxid                    ,named('myproxid'                  ));
  output(seleid_for_proxid           ,named('seleid_for_proxid'         ));
  output(GetLGID                     ,named('GetLGID'                   ));
  output(ShowParents                 ,named('ShowParents'               ));
  output(ShowDirectParentsChildren   ,named('ShowDirectParentsChildren' ));
  output(ShowHrchy                   ,named('ShowHrchy'                 ));

ENDMACRO;

