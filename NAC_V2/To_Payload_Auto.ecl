EXPORT To_Payload_Auto(dataset(Layout_Base2) base) := FUNCTION

		payload := DISTRIBUTE(To_Payload(base), PrepRecSeq);
		b := DISTRIBUTE(base, PrepRecSeq);
		
		auto := JOIN(b, payload, LEFT.PrepRecSeq=RIGHT.PrepRecSeq,
					TRANSFORM(Layout_Payload_Auto,
							self := RIGHT,
							self := LEFT;
						), inner, local);
						
		return auto;
END;