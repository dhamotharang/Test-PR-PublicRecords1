import VotersV2;
EXPORT  FN_inVotersState(STRING2 InputState,BOOLEAN isFCRA) := EXISTS(VotersV2.Key_Voters_States(isFCRA)(KEYED(state = InputState)));