import RoxieKeyBuild,ut,standard, promoteSupers, Std;

EXPORT BuildKeys(string filedate=(string8)Std.Date.Today()) := function


RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Cortera.Key_Attributes_Link_Id,'~thor::cortera::key::attr_linkid','~thor::cortera::key::'+filedate+'::attr_linkid',B1);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Cortera.Key_Attributes_Seleid,'~thor::cortera::key::attr_seleid','~thor::cortera::key::'+filedate+'::attr_seleid',B2);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Cortera.Key_Header_Link_Id,'~thor::cortera::key::hdr_linkid','~thor::cortera::key::'+filedate+'::hdr_linkid',B3);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Cortera.Key_Header_Seleid,'~thor::cortera::key::hdr_seleid','~thor::cortera::key::'+filedate+'::hdr_seleid',B4);
RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(Cortera.Key_Header_Ultimateid,'~thor::cortera::key::hdr_ultimateid','~thor::cortera::key::'+filedate+'::hdr_ultimateid',B5);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::cortera::key::attr_linkid','~thor::cortera::key::'+filedate+'::attr_linkid',M1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::cortera::key::attr_seleid','~thor::cortera::key::'+filedate+'::attr_seleid',M2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::cortera::key::hdr_linkid','~thor::cortera::key::'+filedate+'::hdr_linkid',M3);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::cortera::key::hdr_seleid','~thor::cortera::key::'+filedate+'::hdr_seleid',M4);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::cortera::key::hdr_ultimateid','~thor::cortera::key::'+filedate+'::hdr_ultimateid',M5);

RoxieKeybuild.MAC_SK_Move_v2('~thor::cortera::key::attr_linkid','Q',MQ1,2);
RoxieKeybuild.MAC_SK_Move_v2('~thor::cortera::key::attr_seleid','Q',MQ2,2);
RoxieKeybuild.MAC_SK_Move_v2('~thor::cortera::key::hdr_linkid','Q',MQ3,2);
RoxieKeybuild.MAC_SK_Move_v2('~thor::cortera::key::hdr_seleid','Q',MQ4,2);
RoxieKeybuild.MAC_SK_Move_v2('~thor::cortera::key::hdr_ultimateid','Q',MQ5,2);

return sequential(
								parallel(B1,B2,B3,B4,B5)							//
								,parallel(M1,M2,M3,M4,M5)					//
								,parallel(MQ1,MQ2,MQ3,MQ4,MQ5)				//
			);

END;