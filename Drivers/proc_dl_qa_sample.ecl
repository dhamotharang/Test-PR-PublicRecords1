#workunit('name','DL QA Data - '+ drivers.version_development)

export proc_dl_qa_sample := function  

 

      e_mail_success := FileServices.sendemail('qualityassurance@seisint.com;faisal.humayun@lexis-nexis.com','QA DL Sample Ready ','at ' + thorlib.WUID());
      e_mail_failure := FileServices.sendemail('faisal.humayun@lexis-nexis.com','QA Sample generation failure',failmessage+'at ' + thorlib.WUID());

            dPrev := dataset(Drivers.Cluster + 'BASE::FLDL_DID' + drivers.version_production,drivers.layout_dl,flat,unsorted);
            dNew := dataset(Drivers.Cluster + 'BASE::FLDL_DID' + drivers.version_development,drivers.layout_dl,flat,unsorted);

            // Remember to run this attribute on thor_200

            rSlim:=record
            typeof(dPrev.orig_state) orig_state;
            typeof(dPrev.dl_number) dl_number;
            end;

            rSlim tSlimIt(dPrev pInput):=transform
            self := pInput;
            end;
 
            dPrevSlim := project(dPrev,tSlimIt(left));
            dNewSlim := project(dNew,tSlimIt(left));
            dPrevDist := distribute(dPrevSlim,hash(dl_number));
            dPrevSort := sort(dPrevDist,dl_number,local);
            dPrevDedup := dedup(dPrevSort,dl_number,local);
            dNewDist := distribute(dNewSlim,hash(dl_number));
            dNewSort := sort(dNewDist,dl_number,local);
            dNewDedup := dedup(dNewSort,dl_number,local);
            rSlim tNewOnly(dPrevDedup pPrev, dNewDedup pNew):=transform
            self := pNew;
            end;

            dNewOnly := join(dPrevDedup,dNewDedup,
            left.dl_number = right.dl_number,
            tNewOnly(left,right),
            right only,local);

            dNewOnlySort := sort(dNewOnly,orig_state);
 
            dNewOnlyDedup := dedup(dNewOnlySort,orig_state,keep(10));

            a := output(choosen(dNewOnlyDedup,all)) : success(e_mail_success), FAILURE(e_mail_failure);
            return a;

end;
