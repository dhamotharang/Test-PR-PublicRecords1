export functions := module

import VersionControl;

////////////////////////////////////////////////////////////////////
export map_cardholders(dataset(recordof(Unirush.aid_files.cardholders)) CH,string8 filedate) := function

UniRush.aid_layouts.did_rec1 get_newlayout_ch(CH l) := transform
ch_filedate := VersionControl.fGetFilenameVersion('~thor_data400::in::unirush::cardholders') : stored('ch_filedate');

self.process_date:=filedate;
self.Date_first_seen:='';
self.Date_last_seen:='';
self.Date_vendor_first_reported:=(string)ch_filedate;
self.Date_vendor_last_reported:=(string)ch_filedate;
self.vendor:='UN';
self.item_id := '10042';
self.Source_file:='UNIRUSH_CARDHOLDERS';
self.lname:= l.lastname;
self.fname:= l.firstname;
self.mname:= '';
self.suffix := '';
self := l;
end; 

outfile := dedup(sort(distribute(project(CH,get_newlayout_ch(left)),hash(Clientkey)),Clientkey,Date_last_seen,local),Clientkey,local,right);
return
outfile;
end;

////////////////////////////////////////////////////////////////////
export map_transactions(dataset(recordof(Unirush.aid_files.transactions)) trans,string8 filedate) := function

UniRush.aid_layouts.did_rec2 get_newlayout_trans(TRANS l) := transform
t_filedate := VersionControl.fGetFilenameVersion('~thor_data400::in::unirush::transactions') : stored('t_filedate');

self.process_date:=filedate;
self.clean_transaction_date := l.transactiontime[1..8];
self.clean_transaction_time := l.transactiontime[9..14];
self.Date_first_seen:=self.clean_transaction_date;
self.Date_last_seen:=self.clean_transaction_date;
self.Date_vendor_first_reported:=(string)t_filedate;
self.Date_vendor_last_reported:=(string)t_filedate;
self.vendor:='UN';
self.item_id := '10042';
self.Source_file:='UNIRUSH_TRANSACTIONS';
self.lname:= l.lastname;
self.fname:= l.firstname;
self.mname:= '';
self.suffix := '';
self.mcc := (integer)l.mcc;
self.transactionid := (integer)l.transactionid;
self.amount := (integer)l.amount;
self := l;
end; 

outfile := dedup(sort(distribute(project(trans,get_newlayout_trans(left)),hash(Clientkey)),Clientkey,Date_last_seen,local),Clientkey,local,right);
return
outfile;
end;

end;