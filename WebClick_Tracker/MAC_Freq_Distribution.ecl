export MAC_Freq_Distribution(DSet, FieldName, OutAttr):= macro
		#uniquename(__FD_OutRecLayout)
		#uniquename(__FD_EventRecLayout)
		
		%__FD_OutRecLayout%:=record
		    string45 event:= DSet.FieldName;
				REAL4 frequency_percent := 0;
				unsigned6 Frequency_count := Count(Group);
		end;
		
		Dset_1 :=Group(SORT(DSet,Dset.FieldName),FieldNAme);
		OutAttr:=CHOOSEN(SORT(table(DSet_1, %__FD_OutRecLayout%,FieldName),-Frequency_count),100);

endmacro;

