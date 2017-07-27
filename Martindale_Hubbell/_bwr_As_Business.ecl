boolean pUsingInBusinessHeader	:= true;
boolean pUseOtherEnvironment		:= Martindale_Hubbell._Dataset().IsDataland;

Martindale_Hubbell.As_Business_Header	(pUsingInBusinessHeader,pUseOtherEnvironment).all;
Martindale_Hubbell.As_Business_Contact(pUsingInBusinessHeader,pUseOtherEnvironment).all;