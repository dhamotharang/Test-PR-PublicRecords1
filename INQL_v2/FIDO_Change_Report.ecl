IMPORT inquiry_acclogs,STD;

EXPORT FIDO_Change_Report := MODULE

#WORKUNIT('protect',true);
#WORKUNIT('name', 'Inquiry Tracking - FIDO change Report');
curr:=dataset(inquiry_acclogs.foreign_fido_prod + 'thor::red::extract::inquiry_tracking_extract', inquiry_acclogs.Layout_FIDO.extract_in, flat);
prev:=dataset(inquiry_acclogs.foreign_fido_prod + 'thor::red::extract::father::inquiry_tracking_extract', inquiry_acclogs.Layout_FIDO.extract_in, flat);
t := table(curr,{seq:='CURR',curr}) + table(prev,{seq:='PREV',prev});
t1:=table(t,{t,cnt:=count(group)}	,vertical_market,sub_market ,industry,use,opt_out,disable_observation,hh_id,merge,few)(cnt=1);
EXPORT FIDOchangesRep := sort(t1,mbs_gc_id,-seq);
emailList := ''
+  ',Jose.bello@lexisnexisrisk.com'
+  ',Fernando.Incarnacao@lexisnexisrisk.com'
+  ',Margaret.Worob@lexisnexisrisk.com'
+  ',Vlad.Petrokas@lexisnexisrisk.com'
;
EXPORT SendFIDOchangesRep :=
sequential(
output(FIDOchangesRep,all,named('FIDOchangesRep'))
,STD.System.Email.SendEmail (
emailList
,'Daily FIDO Changes Report'
,'Attached is a link to the Daily FIDO Changes Report'
+'\n\n  ***  Includes Adds, Deletes, and Changes  ***'
+'\n\nhttp://prod_esp.br.seisint.com:8010/WsWorkunits/WUResult?Wuid='+workunit+'&Sequence=1'
,
,
,'INQTLreports@LexisNexisRisk.com'
));
END;
