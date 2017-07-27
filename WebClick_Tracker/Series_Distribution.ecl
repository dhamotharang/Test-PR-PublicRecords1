/*--SOAP--
<message name="Distribution of events">
	<part name="Events" type="tns:EspStringArray"/>
	<part name="Depth" type="xsd:unsignedInt"/>
</message>
*/
/*--INFO-- This calculates the distribution of events after the input series
*/ 
export Series_Distribution:=macro
set of string20 evtlist:=[]:stored('Events');
unsigned len:=0:stored('Depth');

SID_Rec:=record
		string32 session_id;
end;

SID_Rec clip(Oleg.DSIndex L) := transform
		self:=l;
end;

SID_Rec to_left(SID_Rec L, Oleg.DSIndex R):=transform
		self:=l;
end;

match(dataset(SID_Rec) ids,integer lvl, string20 evt):=

			/*project(Oleg.DSIndex(order=lvl,
																	event=evt,
																	exists(ids(session_id=Oleg.DSIndex.session_id))),
													clip(left));*/
			join(ids,Oleg.DSIndex,
									keyed(right.order=lvl) and 
									keyed(left.session_id=right.session_id) and
									keyed(right.event=evt),to_left(left,right));


InitSIDRec:=project(Oleg.DSIndex(order=1,evtlist=[] or event=evtlist[1]),clip(left));

FinalSIDs:=loop(InitSIDRec,len,
					match(rows(left),counter,evtlist[counter]));

// PenultDSet:=join(Oleg.OrderedDS,FinalSIDs,left.session_id=right.session_id);
// FinalDSet:=PenultDSet(order=len+1);
FinalDSet:=join(FinalSIDs,Oleg.DSIndex,
 keyed(RIGHT.order=len+1) AND keyed(LEFT.session_id=RIGHT.session_id));

Oleg.MAC_Freq_Distribution(FinalDSet,event, Out);
output(sort(Out,-frequency));

endmacro;