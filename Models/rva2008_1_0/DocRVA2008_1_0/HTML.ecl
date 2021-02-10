<html><head><title>Custom Model for Auto Acceptance Corp</title></head><body>
<h1>Custom Model for Auto Acceptance Corp(RVA2008_1_0)</h1><p>
<h2>Whole Model Information</h2>
This is a single scorecard model.</p>
<p>This model uses reason method DescendingNonZeroWithInquiry.</p>
LUCI made the following notes while compiling the .CSV: <ul>
<li>Line: 76, Severity: WARNING, Message: RC [C12] used with multiple Inds</li><li>Line: 76, Severity: WARNING, Message: RC [F01] used with multiple Inds</li><li>Line: 76, Severity: WARNING, Message: RC [I60] used with multiple Inds</li>
</ul>
</body></html>
<h2>Exceptions</h2>There are also exception conditions in which the scorecards are bypassed, defined as follows:
<ul><li><b>Deceased - </b>
If <code>((REAL) ssndeceased = 1) or ((REAL) subjectdeceased = 1)</code> is true then the score is set to 200
 and a reason code of  is set.</li><li><b>No_Hit - </b>
If <code>(REAL) confirmationsubjectfound < 1</code> is true then the score is set to 222
 and a reason code of  is set.</li></ul>
<h2>ScoreCard - SCORECARD_model29</h2>
This scorecard is a linear model.
<ul><li>The weights for each variable are computed as defined below</li><li>Combined_score is then calculated by adding the individual weights together</li>
<li>Raw_point is then calculated by adding the Combined_score to the Constant -1.15797592599641</li>
<li>The score is then processed according to the formula (725 + -50 * ((Raw_point - 0 - LN(0.157809362992116)) / LN(2))).</li>
<li>The value is then rounded to the nearest integer.</li>
<li>If the value is less than 501 it is set to 501.</li>
<li>If the value is greater than 900 it is set to 900.</li>

<h3>Independant Variables</h3>
<p><b>addrchangecount03month</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.127115841774383</td><td>-0.127115841774383</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.127115841774383</td><td>-0.127115841774383</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.127115841774383</td><td>0.0</td><td>NUMBER</td><td>-0.127115841774383</td><td>-0.127115841774383</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>0.127087652224877</td><td>0.0</td><td>NUMBER</td><td>-0.127115841774383</td><td>-0.127115841774383</td><td>C14</td></tr>
</table></p>
<p><b>addrinputmatchindex</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.100830449123503</td><td>-0.100830449123503</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.100830449123503</td><td>-0.100830449123503</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>0.100955889904955</td><td>0.0</td><td>NUMBER</td><td>-0.100830449123503</td><td>-0.100830449123503</td><td>F01</td></tr><tr><td>0.5</td><td>HIGH</td><td>-0.100830449123503</td><td>0.0</td><td>NUMBER</td><td>-0.100830449123503</td><td>-0.100830449123503</td><td></td></tr>
</table></p>
<p><b>addrinputsubjectowned</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.0918809204789587</td><td>-0.0918809204789587</td><td></td></tr><tr><td>-1</td><td>-1</td><td>-0.0561726022157193</td><td>0.0</td><td>NUMBER</td><td>-0.0918809204789587</td><td>-0.0918809204789587</td><td>A44</td></tr><tr><td>-999999999</td><td>0.5</td><td>0.0930516666000292</td><td>0.0</td><td>NUMBER</td><td>-0.0918809204789587</td><td>-0.0918809204789587</td><td>A44</td></tr><tr><td>0.5</td><td>HIGH</td><td>-0.0918809204789587</td><td>0.0</td><td>NUMBER</td><td>-0.0918809204789587</td><td>-0.0918809204789587</td><td></td></tr>
</table></p>
<p><b>addrprevioustimeoldest</b> is defined in 7 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.391107019035651</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td>C12</td></tr><tr><td>-999999999</td><td>7.5</td><td>0.174250955427562</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td>C13</td></tr><tr><td>7.5</td><td>86.5</td><td>0.0490651499357637</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td>C13</td></tr><tr><td>86.5</td><td>115.5</td><td>0.0208498257296678</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td>C13</td></tr><tr><td>115.5</td><td>176.5</td><td>-0.0818484746821617</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td>C13</td></tr><tr><td>176.5</td><td>HIGH</td><td>-0.129379355322629</td><td>0.0</td><td>NUMBER</td><td>-0.129379355322629</td><td>-0.129379355322629</td><td></td></tr>
</table></p>
<p><b>assetpropevercount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.109846840713539</td><td>-0.109846840713539</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.109846840713539</td><td>-0.109846840713539</td><td>C12</td></tr><tr><td>-999999999</td><td>1.5</td><td>0.109908656388069</td><td>0.0</td><td>NUMBER</td><td>-0.109846840713539</td><td>-0.109846840713539</td><td>A45</td></tr><tr><td>1.5</td><td>HIGH</td><td>-0.109846840713539</td><td>0.0</td><td>NUMBER</td><td>-0.109846840713539</td><td>-0.109846840713539</td><td></td></tr>
</table></p>
<p><b>confirmationinputaddress</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.111168165234986</td><td>-0.111168165234986</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.111168165234986</td><td>-0.111168165234986</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>0.111181517096239</td><td>0.0</td><td>NUMBER</td><td>-0.111168165234986</td><td>-0.111168165234986</td><td>F01</td></tr><tr><td>0.5</td><td>HIGH</td><td>-0.111168165234986</td><td>0.0</td><td>NUMBER</td><td>-0.111168165234986</td><td>-0.111168165234986</td><td></td></tr>
</table></p>
<p><b>criminalfelonycount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.0856869472262584</td><td>-0.0856869472262584</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.0856869472262584</td><td>-0.0856869472262584</td><td>C12</td></tr><tr><td>-999999999</td><td>0</td><td>-0.0856869472262584</td><td>0.0</td><td>NUMBER</td><td>-0.0856869472262584</td><td>-0.0856869472262584</td><td></td></tr><tr><td>0</td><td>HIGH</td><td>0.0856212019772778</td><td>0.0</td><td>NUMBER</td><td>-0.0856869472262584</td><td>-0.0856869472262584</td><td>D32</td></tr>
</table></p>
<p><b>derogtimenewest</b> is defined in 6 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.0745719346721392</td><td>-0.0745719346721392</td><td></td></tr><tr><td>-1</td><td>-1</td><td>-0.0745719346721392</td><td>0.0</td><td>NUMBER</td><td>-0.0745719346721392</td><td>-0.0745719346721392</td><td></td></tr><tr><td>-999999999</td><td>3.5</td><td>0.221141705304125</td><td>0.0</td><td>NUMBER</td><td>-0.0745719346721392</td><td>-0.0745719346721392</td><td>D30</td></tr><tr><td>3.5</td><td>15.5</td><td>0.131207044522461</td><td>0.0</td><td>NUMBER</td><td>-0.0745719346721392</td><td>-0.0745719346721392</td><td>D30</td></tr><tr><td>15.5</td><td>41.5</td><td>-0.00251770794789452</td><td>0.0</td><td>NUMBER</td><td>-0.0745719346721392</td><td>-0.0745719346721392</td><td>D30</td></tr><tr><td>41.5</td><td>HIGH</td><td>-0.0139670805571985</td><td>0.0</td><td>NUMBER</td><td>-0.0745719346721392</td><td>-0.0745719346721392</td><td>D30</td></tr>
</table></p>
<p><b>evictioncount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.178020801968896</td><td>-0.178020801968896</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.178020801968896</td><td>-0.178020801968896</td><td>C12</td></tr><tr><td>-999999999</td><td>1</td><td>-0.178020801968896</td><td>0.0</td><td>NUMBER</td><td>-0.178020801968896</td><td>-0.178020801968896</td><td></td></tr><tr><td>1</td><td>HIGH</td><td>0.178078662403005</td><td>0.0</td><td>NUMBER</td><td>-0.178020801968896</td><td>-0.178020801968896</td><td>D33</td></tr>
</table></p>
<p><b>inquiryauto12month</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.106930143606789</td><td>-0.106930143606789</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.106930143606789</td><td>-0.106930143606789</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.106930143606789</td><td>0.0</td><td>NUMBER</td><td>-0.106930143606789</td><td>-0.106930143606789</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>0.106868749343492</td><td>0.0</td><td>NUMBER</td><td>-0.106930143606789</td><td>-0.106930143606789</td><td>I60</td></tr>
</table></p>
<p><b>inquirybanking12month</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.0447006009247188</td><td>-0.0447006009247188</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.0447006009247188</td><td>-0.0447006009247188</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.0447006009247188</td><td>0.0</td><td>NUMBER</td><td>-0.0447006009247188</td><td>-0.0447006009247188</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>0.0446544639356558</td><td>0.0</td><td>NUMBER</td><td>-0.0447006009247188</td><td>-0.0447006009247188</td><td>I60</td></tr>
</table></p>
<p><b>inquiryshortterm12month</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.145587984044509</td><td>-0.145587984044509</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.145587984044509</td><td>-0.145587984044509</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.145587984044509</td><td>0.0</td><td>NUMBER</td><td>-0.145587984044509</td><td>-0.145587984044509</td><td></td></tr><tr><td>0.5</td><td>HIGH</td><td>0.145539677615496</td><td>0.0</td><td>NUMBER</td><td>-0.145587984044509</td><td>-0.145587984044509</td><td>I60</td></tr>
</table></p>
<p><b>lienjudgmenttaxcount</b> is defined in 4 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.126193151814627</td><td>-0.126193151814627</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.126193151814627</td><td>-0.126193151814627</td><td>C12</td></tr><tr><td>-999999999</td><td>0.5</td><td>-0.126193151814627</td><td>0.0</td><td>NUMBER</td><td>-0.126193151814627</td><td>-0.126193151814627</td><td>D34</td></tr><tr><td>0.5</td><td>HIGH</td><td>0.126122335670169</td><td>0.0</td><td>NUMBER</td><td>-0.126193151814627</td><td>-0.126193151814627</td><td>D34</td></tr>
</table></p>
<p><b>sourcecredheadertimeoldest</b> is defined in 8 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td>C12</td></tr><tr><td>-999999999</td><td>135.5</td><td>0.215747425264362</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td>C20</td></tr><tr><td>135.5</td><td>164.5</td><td>0.138849500320951</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td>C20</td></tr><tr><td>164.5</td><td>264.5</td><td>0.0133221520435431</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td>C20</td></tr><tr><td>264.5</td><td>339.5</td><td>-0.0412690302862565</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td>C20</td></tr><tr><td>339.5</td><td>370.5</td><td>-0.100717876711618</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td>C20</td></tr><tr><td>370.5</td><td>HIGH</td><td>-0.231932845723712</td><td>0.0</td><td>NUMBER</td><td>-0.231932845723712</td><td>-0.231932845723712</td><td></td></tr>
</table></p>
<p><b>ssnsubjectcount</b> is defined in 5 ranges.
<table border="1"><tr><th>Low Bound</th><th>High Bound</th><th>Points</th><th>Multiplier</th><th>Method</th><th>Expected</th><th>Best</th><th>Reason Code</th></tr>
<tr><td>-998</td><td>-998</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.237420388277113</td><td>-0.237420388277113</td><td></td></tr><tr><td>-1</td><td>-1</td><td>0.0</td><td>0.0</td><td>NUMBER</td><td>-0.237420388277113</td><td>-0.237420388277113</td><td>C12</td></tr><tr><td>-999999999</td><td>0</td><td>0.450938368246577</td><td>0.0</td><td>NUMBER</td><td>-0.237420388277113</td><td>-0.237420388277113</td><td>F00</td></tr><tr><td>0</td><td>1</td><td>-0.237420388277113</td><td>0.0</td><td>NUMBER</td><td>-0.237420388277113</td><td>-0.237420388277113</td><td></td></tr><tr><td>1</td><td>HIGH</td><td>0.081589076071594</td><td>0.0</td><td>NUMBER</td><td>-0.237420388277113</td><td>-0.237420388277113</td><td>S65</td></tr>
</table></p>

</ul>
