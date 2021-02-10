import BIPV2;
import BizLinkFull;

emptyDs := nofold(dataset([], BIPV2.IdAppendLayouts.AppendInput));

appendThor := BIPV2.IdAppendThor(emptyDs);
appendRoxie := BIPV2.IdAppendRoxie(emptyDs);
BizLinkFull.svcAppend();
search := BIPV2.IdFunctions;

evaluate('');