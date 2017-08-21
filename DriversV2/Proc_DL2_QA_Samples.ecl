import _control,DriversV2;

export proc_dl2_qa_samples := function  

      
			e_mail_success := FileServices.sendemail(_Control.MyInfo.EmailAddressNotify+' ;qualityassurance@seisint.com','QA Drivers License Sample Ready ','at ' + thorlib.WUID());
      e_mail_failure := FileServices.sendemail(_Control.MyInfo.EmailAddressNotify+';qualityassurance@seisint.com' ,'QA Sample generation failure',failmessage+'at ' + thorlib.WUID());

            dPrev := dataset('~thor_data400::base::DL2::dlsearch_public_father',DriversV2.Layout_Drivers,thor);
            dNew  := dataset('~thor_data400::base::DL2::dlsearch_public',DriversV2.Layout_Drivers,thor);
				
						// Remember to run this attribute on thor_200

            rSlim:=record
            typeof(dPrev.orig_state) orig_state;
            typeof(dPrev.dl_number) dl_number;
			      typeof(dPrev.did) did;
			      typeof(dPrev.name) name;
			      typeof(dPrev.addr1) addr1;
			      typeof(dPrev.city) city;
			      typeof(dPrev.state) state;
			      typeof(dPrev.zip) zip;
			      typeof(dPrev.province) province;
			      typeof(dPrev.country) country;
			      typeof(dPrev.postal_code) postal_code;
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

            a := output(choosen(dNewOnlyDedup,300),named('Samples')) : success(e_mail_success), FAILURE(e_mail_failure);
            return a;

end;
