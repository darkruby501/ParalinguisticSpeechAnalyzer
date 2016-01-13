# Paralinguistic Speech Analyser
#### *There is no index of character so sure as the voice* - Benjamin Disraeli, British Prime Minister

This repository contains the work from my undergraduate honour's thesis completed at Monash University. The code herein extracts and analyses paralinguistic/non-linguistic aspects of speech, as described in this README. I am grateful to my supervisor, Professor Tom Drummond, for his assistance with this project.

[Detailed report]
[Slide presentation]
[Poster]

## What are paralinguistics? Why should I care?
If linguistics is *what* you say, paralinguistics is *how* you say it. Paralinguistics speech features are all those aspects which go beyond the mere words, including pitch, timing, stress, speech rate, umms and ahhs. Far more than mere content, these are the aspects of speech which make the difference between an engaging, inspiring speaker and a dreary monotonic one. If you wish to deliver charismatic speeches, interviews, pitches, jokes and dinner-table stories, you'd do well to pay careful attention to *how* you sound -  your paralinguistics.

Interesting paralinguistic facts:
* For charismatic speech, the most important thing is dynamicness/variation. Usually this comes from changes in pitch, but can changes in pauses and volume can also work to keep listeners stimulated.
* The most common blunder among novice, nervous speakers is to speak too quickly and with no breaks. Slow down and pause!
* Uncharismatic speech tends to sound alike, but charismatic speech comes in many flavours! E.g. high energy enthusiastic vs. calm, collected and reassuring. 

## What does this Paralingustic Speech Analyser do?
* Uses state-of-the-art VAD (Voice Activity Detection) algorithms to detect pauses in speech and segment it into utterances.
* Uses pitch extraction algorithms to extract global and varying pitch features.
* Analyes pitch movements during speech, including High Rising Terminal (Up-talk) and Falling Intonation.
* Runs the above on a speech recording and produces a report.

* Additionally, for my honour's thesis I applied this tool recordings to highly charismatic speakers (6 TED talks) matched with less charismatic speakers (undergraduate psychology studends delivering presentations). Details in the report.

## Sounds cool! How do I try it?
1) The scripts can be run in Matlab (and possibly Octave, although I haven't tested that).
2) A web demo is planned, but that will take some time. This project was written in Matlab, one of primary languages for signal processing development alongside C/C++. Unfortunately, there are no web frameworks for Matlab and setting up this code in an online interative demo will require a port. But that is planned!
3) You can read the detailed [report] on this project or view the [poster].
