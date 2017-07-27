import Worldcheck_Bridger;

export fProcessAddressListChildren(dataset(GSA.Layouts_GSA.layout_GSA_ID) pRawFileInput) := function

			AddressListChildRec := RECORD, MAXLENGTH(15000)
			UNSIGNED8 gsa_id;
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addr_rollup addresslist;
		END;

		// Need to assign the linking id and attach the item (which contains a dataset) we're interested in
		AddressListChildRec NewAddressListChildren(pRawFileInput L) := TRANSFORM
			SELF.gsa_id 			:= L.gsa_id;
			SELF.addresslist 	:= L.address_list;			
			SELF 							:= L;
		END;

		// an Address child dataset layout having a linking-id in each record
		AddressChildRec := RECORD, MAXLENGTH(25000)
			UNSIGNED8 gsa_id;
			Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses;
		END;

		addresses_layout := Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses;
		// normalize transform...take the Address child dataset & break into a flat file - assign a 'linking-id' to each record.
		AddressChildRec NewAddressChildren(AddressListChildRec L,addresses_layout R) := TRANSFORM
			SELF.gsa_id := L.gsa_id;
			SELF 				:= R;
		END;

		NewAddressListChilds 	:= PROJECT(pRawFileInput, NewAddressListChildren(LEFT));
		// call to normalize the Address child dataset. left parameter is the parent record, right parameter is the Address child dataset.
		NewAddressChilds 			:= normalize(NewAddressListChilds,left.addresslist.address,NewAddressChildren(left,right),local);
		grpNewAddressChilds 	:= group(NewAddressChilds,gsa_id,all,local);
		ddgrpNewAddressChilds := dedup(group(grpNewAddressChilds,local),all,local);

		return ddgrpNewAddressChilds;

end; //end fProcessAddressListChildren function