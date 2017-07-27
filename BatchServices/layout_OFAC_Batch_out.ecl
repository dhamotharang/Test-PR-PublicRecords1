
EXPORT layout_OFAC_Batch_out := RECORD
	STRING20   acctno              := '';
	STRING60   Name                := '';
	STRING120  Alt_Names           := '';
	STRING500  Address             := '';
	STRING120  USA_StreetAddress   := '';
	STRING25   USA_City            := '';
	STRING2    USA_State           := '';
	STRING10   USA_Zip             := '';
	STRING200  ForeignAddress      := '';
	STRING200  IncarceratedAddress := '';
	STRING100  Type_of_Denial      := '';
	STRING100  Program             := '';
	STRING100  SDN_Type            := '';
	STRING100  Title               := '';
	STRING2250 Remarks             := '';
	STRING12   Effective_Date      := '';
	STRING12   Expiration_Date     := '';
	STRING40   Vessel_Owner        := '';
END;